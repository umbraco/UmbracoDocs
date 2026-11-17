---
description: >-
  Learn how Umbraco UI Builder uses Entity Framework Core as its default
  repository, how it maps your models, and how queries behave.
---

# Entity Framework Core

From Umbraco UI Builder 19, Entity Framework Core (EF Core) is the default data access strategy. Collections without a custom repository use the built-in EF Core repository for querying, pagination, saving, and deleting entities.

The fluent collection API is unchanged. Most collections keep working without any changes to your configuration or models.

## Falling Back to NPoco

The NPoco-based repository is still available in version 19. To use it instead of EF Core, set `UseEFCore` to `false` in your `appsettings.json` file:

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "UIBuilder": {
      "FeatureManagement": {
        "UseEFCore": false
      }
    }
  }
}
```
{% endcode %}

Keep the following in mind when you use the setting:

* The setting is read once, when the site starts. Restart the site after you change the value.
* When `UseEFCore` is `false`, Umbraco UI Builder logs a warning at startup.
* The setting only controls the default repository. Collections with a custom repository set through `SetRepositoryType()` are not affected.

{% hint style="warning" %}

The NPoco repository is obsolete and is scheduled for removal in Umbraco UI Builder 21. Use the fallback only while you move your collections to EF Core.

{% endhint %}

## Database Setup

{% hint style="info" %}

Umbraco UI Builder does not create or migrate the tables for your collections. Provision the database schema through your own deployment or migration process before the collections are used. This requirement applies to every environment, including load-balanced setups where all nodes share a single database.

{% endhint %}

### UIBuilderDbContext

Umbraco UI Builder provides a built-in `UIBuilderDbContext` that builds its model from your collection configuration. You do not need to create your own `DbContext` for the default repository.

The model includes the collections that use EF Core:

* Collections without a custom repository.
* Collections with a custom repository that inherits from `EFCoreRepository<TEntity, TId>`.
* Any collection that calls `ConfigureEFCore()`.

For each of these collections, the model:

* Adds the entity type, and the junction type and related entity type of each related collection.
* Uses the collection's ID property as the primary key, and the parent and child properties as a junction's composite key.
* Applies the collection's `ConfigureEFCore()` callback.

If EF Core cannot map a collection, that collection is left out of the model. The collection then fails with an error that names it, and every other collection keeps working. For collections on the Umbraco database, the error is also logged when the site starts.

## Mapping Your Entity Models

The EF Core repository reads four kinds of mapping. When they disagree, the first one in the list below wins:

1. The collection's `ConfigureEFCore()` callback.
2. .NET data annotations from `System.ComponentModel.DataAnnotations` and `System.ComponentModel.DataAnnotations.Schema`, such as `[Table]`, `[Column]`, `[Key]`, `[NotMapped]`, and `[DatabaseGenerated]`.
3. NPoco attributes, such as `[TableName]`, `[PrimaryKey]`, `[Column]`, `[Ignore]`, and `[ResultColumn]`.
4. EF Core's own conventions.

### NPoco Attributes

Models written for the NPoco repository keep working on EF Core. The EF Core model reads the NPoco attributes in the same way NPoco does:

* `[TableName]` sets the table name. Without it, the class name is used.
* `[PrimaryKey]` decides whether the key is generated. A single key is generated on insert unless you set `AutoIncrement = false`. A composite key is never generated.
* `[PrimaryKey]` also sets the key columns of a type that is not a collection. A collection always uses its ID property as the key.
* `[Column("name")]` sets the column name.
* `[Ignore]`, `[ResultColumn]`, and `[Reference]` properties are not mapped.
* On a class marked `[ExplicitColumns]`, only properties with `[Column]` are mapped.
* `[ComputedColumn]` properties are read but never written.

{% hint style="info" %}

`[ResultColumn]` properties are neither read nor written by EF Core.

{% endhint %}

### Adding .NET Data Annotations

Umbraco is moving from NPoco to EF Core and plans to remove NPoco. When the site starts, Umbraco UI Builder logs a warning for each entity type that uses NPoco attributes. The warning names the .NET attribute to add for each NPoco attribute found.

Add the .NET data annotations next to the NPoco attributes. The NPoco repository reads only the NPoco attributes, and EF Core prefers the .NET ones. An entity carrying both works on both repositories. Remove the NPoco attributes only once the collection runs on EF Core.

Custom tables are often created with NPoco migrations. Create new tables with EF Core migrations instead, and plan to move existing ones. For the setup, see [Creating Custom Database Tables with Entity Framework](https://docs.umbraco.com/umbraco-cms/extend-your-project/tutorials/getting-started-with-entity-framework-core).

The following model carries both sets of attributes:

{% code title="Product.cs" %}
```csharp
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using NPocoColumn = NPoco.ColumnAttribute;

namespace MyProject.Models;

[NPoco.TableName("Products")]
[NPoco.PrimaryKey("Id")]
[Table("Products")]
public class Product
{
    [Key]
    public int Id { get; set; }

    [NPocoColumn("ProductName")]
    [Column("ProductName")]
    public string Name { get; set; } = string.Empty;

    public string? Description { get; set; }

    public decimal Price { get; set; }

    [NPoco.Ignore]
    [NotMapped]
    public string? DisplayLabel { get; set; }
}
```
{% endcode %}

{% hint style="info" %}

NPoco and .NET both define a `ColumnAttribute`. Use a `using` alias, as in the example above, to keep both on the same property.

{% endhint %}

The warning suggests these replacements:

| NPoco attribute | .NET data annotation |
| --- | --- |
| `[TableName]` | `[Table]` |
| `[PrimaryKey]` | `[Key]`, and `[DatabaseGenerated(DatabaseGeneratedOption.None)]` for `AutoIncrement = false` |
| `[ExplicitColumns]` | `[NotMapped]` on each property that is not a column |
| `[Column]` | `[Column]` |
| `[Ignore]` | `[NotMapped]` |
| `[ResultColumn]` | `[NotMapped]` |
| `[Reference]` | `[NotMapped]`, and load the related data yourself |
| `[ComputedColumn]` | `[DatabaseGenerated(DatabaseGeneratedOption.Computed)]` |

{% hint style="warning" %}

A property with both `[ComputedColumn]` and `[DatabaseGenerated]` follows `[DatabaseGenerated]`.

{% endhint %}

### Using the `ConfigureEFCore()` Method

Use `ConfigureEFCore()` to customize the EF Core model for a collection. The callback receives the EF Core `ModelBuilder` and the `CollectionConfig`. Use it for relationships, indexes, column types, or table mappings.

#### Method Syntax

```csharp
ConfigureEFCore(Action<ModelBuilder, CollectionConfig> configure) : CollectionConfigBuilder<TEntityType>
```

#### Example

{% code title="UIBuilderComposer.cs" %}
```csharp
using MyProject.Models;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.UIBuilder.Extensions;

namespace MyProject.Composers;

public class UIBuilderComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AddUIBuilder(cfg =>
        {
            cfg.AddSection("Catalog", sectionConfig => sectionConfig
                .Tree(treeConfig => treeConfig
                    .AddCollection<Product>(x => x.Id, "Product", "Products", "A list of products", "icon-box", "icon-box", collectionConfig => collectionConfig
                        .SetAlias("products")
                        .SetNameProperty(x => x.Name)
                        .ConfigureEFCore((modelBuilder, collection) =>
                        {
                            modelBuilder.Entity<Product>()
                                .Property(x => x.Price)
                                .HasPrecision(18, 2);
                        })
                        .ListView(listViewConfig => listViewConfig
                            .AddField(x => x.Price))
                        .Editor(editorConfig => editorConfig
                            .AddTab("General", tabConfig => tabConfig
                                .AddFieldset("Details", fieldsetConfig => fieldsetConfig
                                    .AddField(x => x.Name)
                                    .AddField(x => x.Price)))))));
        });
    }
}
```
{% endcode %}

A custom repository that does not inherit from `EFCoreRepository<TEntity, TId>` is not in the EF Core model. If such a repository reads its entities through `UIBuilderDbContext`, call `ConfigureEFCore()` on its collection to add it to the model.

## How Queries Behave on EF Core

Collection filters, data views, cards, searches, and filter options keep working on EF Core. Umbraco UI Builder rewrites them so they return the same rows as on NPoco.

### Umbraco Query Helpers

The Umbraco query helpers that NPoco understands also work on EF Core:

* `InvariantEquals`, `InvariantContains`, `InvariantStartsWith`, and `InvariantEndsWith`.
* `SqlEquals`, `SqlContains`, `SqlStartsWith`, `SqlEndsWith`, `SqlWildcard`, `SqlIn`, `SqlNullableEquals`, `SqlLessThan`, and `SqlGreaterThan`.

The text helpers are case-insensitive, as on NPoco. The value is not escaped, so `%` and `_` in the value act as wildcards, as on NPoco.

### String Comparisons

Plain `string` comparisons with `Contains`, `StartsWith`, `EndsWith`, and `Equals` are case-insensitive on EF Core, as on NPoco. This applies when the value does not read another property of the entity. The `StringComparison` argument is ignored on both.

The `==` and `!=` operators are not rewritten. They follow the column collation on both repositories. On SQLite, they are case-sensitive. On SQL Server, they follow the database collation.

{% hint style="info" %}

Use `==` for lookups that need an index. The case-insensitive comparisons wrap the column in `upper()`, which cannot use an index on either repository.

{% endhint %}

### Differences From NPoco

* `SqlText` is not supported on EF Core. A collection that uses `SqlText` fails with an error that names the collection.
* A negated empty `SqlIn`, such as `!emptyIds.SqlIn(x.Id)`, matches every row on EF Core. On NPoco, it matches no rows.
* The value passed to a helper must be known before the query runs. A value that reads another property of the entity fails with an error that names the collection.

When EF Core cannot translate a query, the error names the collection and, where it can, the method that EF Core cannot translate. The error leaves out the query values.

## Data Types

The EF Core repository reads and writes some values the same way as the NPoco repository, where EF Core on its own would differ:

* On SQL Server, `DateTime` and `DateTime?` values are read back with `DateTimeKind.Utc`. Values are written as they are supplied. On SQLite, `DateTime` values are unchanged.
* On SQL Server, a `decimal` property without a configured precision is sent with the precision of its value. EF Core would otherwise round it to two decimals.
* When the database generates an integer key, a key value set before an insert is ignored. The generated key is returned.

To change these rules for a property, configure it in `ConfigureEFCore()`. For example, a value conversion replaces the `DateTime` handling, and `HasPrecision()` replaces the `decimal` handling.

## Transactions and Connection Strings

A collection on the Umbraco database joins the ambient Umbraco scope. Its writes commit and roll back together with that scope. A collection with its own connection string gets its own transaction.

For more information, see the [Changing a Collection Connection String](../collections/the-basics.md#changing-a-collection-connection-string) section.

The EF Core repository also follows these rules:

* A failed write inside an ambient Umbraco scope stops that scope from committing.
* `EntitySavedNotification` and `EntityDeletedNotification` are published before the commit. A handler that throws rolls the write back.

## Repository Events

All entity lifecycle notifications work the same way on both repositories:

* `EntitySavingNotification` / `EntitySavedNotification`
* `EntityDeletingNotification` / `EntityDeletedNotification`

The EF Core repository publishes its own query notifications instead of `SqlQueryBuildingNotification` and `SqlQueryBuiltNotification`. For more information, see the [EF Core Events](efcore-events.md) article.

## Custom EF Core Repositories

For full control over data access, create a repository that inherits from `EFCoreRepository<TEntity, TId>`. For more information, see the [Custom EF Core Repositories](custom-efcore-repositories.md) article.
