---
description: Configuring Entity Framework Core in Umbraco UI Builder.
---

# Entity Framework Core

Umbraco UI Builder supports Entity Framework Core (EF Core) as an alternative data access strategy to the default NPoco-based repository. When enabled, collections use EF Core for all CRUD operations, including querying, pagination, saving, and deleting entities.

{% hint style="info" %}
EF Core support is available from Umbraco UI Builder 17.1.
{% endhint %}

## Configuration

EF Core support is toggled via a feature flag in your application's configuration. When enabled, all registered collections will automatically switch to the EF Core-based implementation.

To enable EF Core, add the following to your `appsettings.json`:

```json
{
  "Umbraco": {
    "UIBuilder": {
      "FeatureManagement": {
        "UseEFCore": true
      }
    }
  }
}
```

When `UseEFCore` is `true`, the custom built-in EF Core repository is used instead of the NPoco-based one. Collections with a custom repository type set via `SetRepositoryType` are not affected by this flag.

{% hint style="warning" %}
The NPoco-based repository remains the default when the feature flag is not set or is set to `false`. EF Core support is intended to become the default in a future release, at which point the NPoco implementation will be deprecated.
{% endhint %}

## Database Setup

When using EF Core, your entity models use standard data annotation attributes from `System.ComponentModel.DataAnnotations` and `System.ComponentModel.DataAnnotations.Schema` instead of NPoco attributes.

### Defining Entity Models

```csharp
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

[Table("Products")]
public class Product
{
    public int Id { get; set; }

    [Required]
    [MaxLength(200)]
    public string Name { get; set; } = string.Empty;

    [MaxLength(2000)]
    public string? Description { get; set; }

    [Column(TypeName = "decimal(18,2)")]
    public decimal Price { get; set; }

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    public DateTime? ModifiedAt { get; set; }
}

[Table("Categories")]
public class Category
{
    public int Id { get; set; }

    [Required]
    [MaxLength(100)]
    public string Name { get; set; } = string.Empty;

    [MaxLength(500)]
    public string? Description { get; set; }
}

[Table("ProductCategories")]
public class ProductCategory
{
    public int ProductId { get; set; }

    public int CategoryId { get; set; }
}

[Table("ProductReviews")]
public class ProductReview
{
    public int Id { get; set; }

    [Required]
    public int ProductId { get; set; }

    [Required]
    [MaxLength(100)]
    public string ReviewerName { get; set; } = string.Empty;

    [Range(1, 5)]
    public int Rating { get; set; }

    [MaxLength(1000)]
    public string? Comment { get; set; }

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}
```

In comparison with the NPoco-based model:

```csharp
using NPoco;
using Umbraco.Cms.Infrastructure.Persistence.DatabaseAnnotations;

[TableName("Products")]
[PrimaryKey("Id")]
public class Teacher
{
    [PrimaryKeyColumn]
    public int Id { get; set; }

    public string Name { get; set; } = string.Empty;

    public string? Description { get; set; }

    public decimal Price { get; set; }

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    public DateTime? ModifiedAt { get; set; }
}
```

### UIBuilderDbContext

Umbraco UI Builder provides a built-in `DbContext` that automatically configures entity models at runtime based on your collection configuration. This context is registered with the DI container during startup and uses Umbraco's database provider.

The `UIBuilderDbContext` automatically:

- Registers entity types from all configured collections.
- Configures primary keys based on the collection's `IdProperty`.
- Configures junction entities with composite keys for related collections.
- Applies any custom EF Core model configuration provided via `ConfigureEFCore()`.

You do not need to create your own `DbContext` for the default repository to work. The `UIBuilderDbContext` is configured for you.

## Collections Configuration

Collection configuration remains the same as with NPoco. The fluent API is unchanged:

```csharp
treeConfig.AddCollection<Product>(x => x.Id, "Product", "Products", "A list of products", "icon-article", "icon-article", collectionConfig =>
{
    collectionConfig
        .SetAlias("products")
        .SetNameProperty(x => x.Name)
        .ListView(listViewConfig =>
        {
            listViewConfig
                .AddField(x => x.Name)
                .AddField(x => x.Description)
                .AddField(x => x.Price)
        })
        .Editor(editorConfig =>
            editorConfig.AddTab("General", tabConfig =>
            {
                tabConfig.AddFieldset("Product Details", fieldsetConfig =>
                {
                    fieldsetConfig
                        .AddField(x => x.Name)
                        .AddField(x => x.Description)
                        .AddField(x => x.Price)
                        .AddField(x => x.IsActive);
                    fieldsetConfig
                          .AddRelatedCollectionPickerField<Category>("productCategories", "Categories Picker", "Categories");
                });
            })
        );
});
```

For advanced scenarios, use the `ConfigureEFCore()` method to customize the EF Core model for a collection. This gives you access to the `ModelBuilder` and the `CollectionConfig` to configure relationships, indexes, or table mappings.

#### Method Syntax

```csharp
ConfigureEFCore(Action<ModelBuilder, CollectionConfig> configure)
```

#### Example

```csharp
.ConfigureEFCore((modelBuilder, collectionConfig) =>
{
    modelBuilder.Entity<ProductCategory>(entity =>
    {
        entity.HasKey(t => new { t.ProductId, t.CategoryId });
        entity.ToTable("ProductCategories");
    });
})
```

For configuring child or related collections, the fluent configuration remains the same:

```csharp
// Child collection for Product Reviews
collectionConfig.AddChildCollection<ProductReview>(x => x.Id, x => x.ProductId,
    "Product Review", "Product Reviews", "Reviews for products",
    "icon-article", "icon-article", childCollectionConfig =>
{
    childCollectionConfig
        .SetNameProperty(x => x.ReviewerName)
        .Editor(editorConfig =>
            editorConfig.AddTab("General", tabConfig =>
            {
                tabConfig.AddFieldset("Review Details", fieldsetConfig =>
                {
                    fieldsetConfig
                        .AddField(x => x.ReviewerName)
                        .AddField(x => x.Rating)
                        .AddField(x => x.Comment);
                });
            })
        );
});

// Related collection for Categories
collectionConfig.AddRelatedCollection<Product, Category, ProductCategory>(
    x => x.Id,
    "productReview",
    "productReviews",
    relationConfig =>
        relationConfig
            .SetAlias("productCategories")
            .SetJunction<ProductCategory>(x => x.ProductId, y => y.CategoryId));
```

## Custom EF Core Repositories

For full control over data access, create a custom repository that extends `EFCoreRepository<TEntity, TId>`. This base class provides access to the `UIBuilderDbContext` and a typed `DbSet<TEntity>`, while inheriting event lifecycle, encryption, and soft-delete support from `Repository<TEntity, TId>`.

To assign your custom EF Core repository to a collection, use the `SetRepositoryType` method:

```csharp
collectionConfig.SetRepositoryType<ProductRepository>();
```

{% hint style="info" %}
Custom repositories set via `SetRepositoryType` are used regardless of the `UseEFCore` feature flag. The feature flag only controls the default repository implementation.
{% endhint %}

### Repository Events

All standard entity lifecycle events work the same way regardless of the data access strategy:

- `EntitySavingNotification` / `EntitySavedNotification`
- `EntityDeletingNotification` / `EntityDeletedNotification`

When using EF Core, UI Builder publishes EF Core-specific query notifications. See the [EF Core Events](./efcore-events.md) documentation for more details.
