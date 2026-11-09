---
description: >-
  Version specific documentation for upgrading to major versions of Umbraco UI Builder.
---

# Version Specific Upgrade Notes

This article provides upgrade instructions for major versions of Umbraco UI Builder.

{% hint style="info" %}

For minor or patch upgrades, check the [Release Notes](../release-notes.md) for breaking changes.

{% endhint %}

## Version 19

Umbraco UI Builder 19 requires **.NET 11** and **Umbraco CMS 19**. For more information, see the [Requirements](../getting-started/requirements.md) article.

### Entity Framework Core is the default repository

Collections without a custom repository now use the Entity Framework Core (EF Core) repository instead of the NPoco repository. Collections with a custom repository set through `SetRepositoryType()` keep using that repository.

To keep using the NPoco repository, set `Umbraco:UIBuilder:FeatureManagement:UseEFCore` to `false`. Keep the following in mind:

* The NPoco repository is obsolete and is scheduled for removal in Umbraco UI Builder 21.
* A site that uses the NPoco repository logs a warning at startup.
* The setting is read once, when the site starts. In earlier versions, the repository switched while the site ran. Restart the site after you change the value.

For more information, see the [Entity Framework Core](../advanced/efcore-repositories.md) article.

### Entity models and NPoco attributes

The EF Core repository reads NPoco attributes, such as `[TableName]`, `[PrimaryKey]`, `[Column]`, and `[Ignore]`. Models written for the NPoco repository keep working.

When the site starts, Umbraco UI Builder logs a warning for each entity type that uses NPoco attributes. Add the matching .NET data annotations next to the NPoco attributes. The warning names the annotation to add for each NPoco attribute.

The EF Core model applies mapping in this order of precedence:

1. The collection's `ConfigureEFCore()` callback.
2. .NET data annotations.
3. NPoco attributes.
4. EF Core conventions.

A property with both `[ComputedColumn]` and `[DatabaseGenerated]` now follows `[DatabaseGenerated]`.

### NPoco query notifications

`SqlQueryBuildingNotification` and `SqlQueryBuiltNotification` are only published by the NPoco repository. Handlers for these notifications no longer run for collections on EF Core, and a warning listing them is logged at startup.

Move these handlers to `EFCoreQueryBuildingNotification` and `EFCoreQueryBuiltNotification`. For an example, see the [EF Core Events](../advanced/efcore-events.md) article.

### Query behavior on EF Core

Collection filters, data views, cards, searches, and filter options return the same rows as on NPoco, with these exceptions:

* `SqlText` is not supported on EF Core.
* A negated empty `SqlIn` matches every row on EF Core. On NPoco, it matches no rows.

For more information, see the [How Queries Behave on EF Core](../advanced/efcore-repositories.md#how-queries-behave-on-ef-core) section.

### Collections on the Umbraco database join the Umbraco scope

The following change applies to both the EF Core and the NPoco repository. A collection joins the ambient Umbraco scope and rolls back with it when it is on the Umbraco database. The collection is on the Umbraco database when one of the following is true:

* The collection has no connection string set.
* The connection string name is `umbracoDbDSN`.
* The connection string name points at a connection string equivalent to Umbraco's.

In Umbraco UI Builder 18, a collection with a named connection string always committed on its own. Inside an ambient scope, the NPoco repository no longer raises `DatabaseCreatedNotification` for these collections.

Other changes:

* To commit a collection independently, call the new `DisableUmbracoScopeSharing()` method on its configuration.
* An unknown connection string name now fails with an error that names the connection string.
* The EF Core repository now uses the connection string set with `SetConnectionString()`.
* A failed EF Core write inside an ambient Umbraco scope stops that scope from committing.
* On EF Core, `EntitySavedNotification` and `EntityDeletedNotification` are published before the commit. A handler that throws rolls the write back.

For more information, see the [Transactions and the Umbraco Scope](../collections/the-basics.md#transactions-and-the-umbraco-scope) section.

{% hint style="info" %}

`ICollectionConfigBuilder<TBuilder, TEntityType>` has a new `DisableUmbracoScopeSharing()` member. The change only breaks code that implements the interface itself.

{% endhint %}

### Synchronous repository and service APIs removed

The synchronous members of `IRepository`, `Repository<TEntity, TId>`, and `EntityService` are removed. Use the `*Async` members instead.

Custom repositories that inherit from `Repository<TEntity, TId>` must delete their synchronous `*Impl` overrides and implement the `*ImplAsync` methods. For more information, see the [Async APIs](../advanced/async-apis.md) article.

The results of `GetAllImplAsync` and `GetPagedImplAsync` are now read before the operation returns. A query that fails while it runs returns a failed `OperationResult` instead of throwing in the caller's code. A `null` value for `Items` from `GetPagedImplAsync` becomes an empty list.

### Custom EF Core repositories

Repositories that inherit from `EFCoreRepository<TEntity, TId>` have these changes:

* The public operations, `PerformSaveAsync`, and `PerformRelationSaveAsync` are sealed. Move overridden logic into the `*ImplAsync` methods or notification handlers.
* Replace a `DeleteRelationAsync` override with a `DeleteRelationImplAsync` override.
* Without `DeleteRelationImplAsync`, deleting a relation returns a failed `OperationResult` instead of throwing a `NotSupportedException`.
* Entities your `*ImplAsync` methods read or return are no longer tracked afterwards. Attach them again before you save them.
* Changes your `*ImplAsync` methods leave unsaved are dropped. Call `SaveChangesAsync` yourself.
* The where clause and order-by arrive already rewritten for EF Core. Apply them as lambdas, and do not compile them or run them in memory.
* An operation nested in another opens a nested scope. A failed nested write stops the outer operation from committing.
* A failing read no longer stops an ambient Umbraco scope from committing.
* `DbContext` is only available while an operation runs, and only for the repository's own database.

The `EFCoreRepository(RepositoryContext, UIBuilderDbContext)` constructor is obsolete and is scheduled for removal in Umbraco UI Builder 21. Use the `EFCoreRepository(RepositoryContext)` constructor. A repository built with the obsolete constructor now disposes the `UIBuilderDbContext` passed to it.

For more information, see the [Custom EF Core Repositories](../advanced/custom-efcore-repositories.md) article.

### EF Core extension points

* The `UIBuilderDbContext(options, collections)` constructor is removed. `UIBuilderDbContext` has a single constructor that takes only its options.
* `IUIBuilderDbContextAccessor` is obsolete and is scheduled for removal in Umbraco UI Builder 21.
* The `DefaultRepositoryFactory` constructor that takes an `IUIBuilderDbContextAccessor` is obsolete and is scheduled for removal in Umbraco UI Builder 21.
* The EF Core model only includes collections that use EF Core. A custom repository that does not inherit from `EFCoreRepository<TEntity, TId>` must call `ConfigureEFCore()` to read its entity through `UIBuilderDbContext`.
* A collection that EF Core cannot map now fails on its own with an error that names it. Other collections keep working.

### EF Core data types

The EF Core repository now handles these values the same way as the NPoco repository:

* On SQL Server, `DateTime` values are read back as UTC. Values are written as they are supplied. SQLite is unchanged.
* On SQL Server, a `decimal` property without a configured precision is no longer rounded to two decimals when it is saved or filtered.
* A value set on a database-generated identity key is ignored on insert, and the generated ID is returned.

To change the `DateTime` or `decimal` handling, configure the property in `ConfigureEFCore()`. For more information, see the [Data Types](../advanced/efcore-repositories.md#data-types) section.

### Saving entities and their relations

* Relations are only saved when the entity save succeeds. A failed or canceled save no longer writes or deletes relation rows.
* When an editor saves an entity, failures to save or delete its relations are now reported in the backoffice. In earlier versions, the failures were ignored.
* Encrypted properties are now stored encrypted once. Values that earlier versions stored encrypted twice still load. They are stored encrypted once the next time they are saved. No migration is needed.

### CSV import and export

The import and export actions now use CsvHelper 34:

* Use `[CsvIgnore]` and `[CsvColumn]` instead of the CsvHelper 31 attributes, such as `[Ignore]` and `[Name]`.
* Properties that hold nested objects are no longer flattened into extra columns.

The import now reports rows that it could not import, with the message **Import partly completed** and the row numbers. The other rows are still imported. After an action from the collection menu runs, such as the import, the list refreshes.

For more information, see the [Inbuilt Actions](../actions/inbuilt-actions.md) article.

### Management API limits

The entity endpoints of the Management API accept at most 1000 IDs per request and 1000 values per filter. Larger requests return a `400 Bad Request` response.

### Removed configuration API

The following members were obsolete since Umbraco UI Builder 10 or 12 and are now removed:

| Removed | Use instead |
| --- | --- |
| `AddContextApp`, `AddContextAppBefore`, and `AddContextAppAfter` on `UIBuilderConfigBuilder` | The same methods on `WithTree()`, inside `WithSection()` |
| `AddDashboard`, `AddDashboardBefore`, and `AddDashboardAfter` on `UIBuilderConfigBuilder` | The same methods on `AddSection()` or `WithSection()` |
| `AddVirtualSubTree`, `AddVirtualSubTreeBefore`, and `AddVirtualSubTreeAfter` on `UIBuilderConfigBuilder` | No replacement. Virtual subtrees are not available from version 14. |
| `DashboardVisibilityConfigBuilder.ShowInSection()` | Add the dashboard to the section it belongs to. |
| `TreeCollectionConfigBuilder<TEntityType>.ShowOnDashboard()` | `ShowOnSummaryDashboard()` |
| `PropertyFilterHandler` | `PropertyFilterHandlerBase`, which has the same constructor and members. |
| `IDataViewsBuilder` | `DataViewsBuilder<TEntityType>`, registered with `SetDataViewsBuilder()`. `IDataViewsBuilder` and `CollectionConfig.DataViewsBuilder` are no longer public. |

### Extending a section or tree more than once

`WithSection()` and `WithTree()` can now be called more than once with the same alias. Later calls continue the configuration of the first call. In earlier versions, the second call threw an error. Passing a pre-built `WithSectionConfigBuilder` or `WithTreeConfigBuilder` for an alias that is already in use still throws.

### Dashboard and context app positions

The `Before` and `After` methods for dashboards and context apps work again. In versions 14 to 18, the positions had no effect. A dashboard or context app with a position can now appear in a different place than in those versions.

The target alias can be an alias from Umbraco 13, such as `umbContent` or `contentRedirectManager`. Umbraco UI Builder maps it to the matching Umbraco 19 alias. For more information, see the [Dashboards](../areas/dashboards.md) and [Context Apps](../areas/context-apps.md) articles.

### Asynchronous actions, cards, data views, and filter options

Actions, cards, data views builders, and filter options builders have new asynchronous methods. Umbraco UI Builder only calls the asynchronous methods. By default, each one calls your existing synchronous method, so existing code keeps working.

| Type | New method | Existing method |
| --- | --- | --- |
| `Action<TResult>` and `Action<TSettings, TResult>` | `ExecuteAsync` | `Execute` |
| `Card` | `GetValueAsync` | `GetValue` |
| `DataViewsBuilder<TEntityType>` | `GetDataViewsAsync` | `GetDataViews` |
| `FilterOptionsBuilder<TValueType>` | `GetOptionsAsync` | `GetOptions` |

The existing methods are now `virtual` instead of `abstract`. Override one of the two methods:

* A class that overrides neither method compiles, and throws a `NotImplementedException` when it is used.
* A class that only overrides the asynchronous method throws a `NotImplementedException` when code calls the synchronous method.

Umbraco UI Builder runs actions through `ExecuteAsync`. The following overrides are no longer called:

* An override of the `Execute(string, object[], object)` overload on `Action<TResult>` or `Action<TSettings, TResult>`.
* An override of the synchronous `Execute` method on a class that inherits from `DeleteEntityAction`, `ExportEntityAction`, or `ImportEntityAction`. These methods are obsolete and are scheduled for removal in Umbraco UI Builder 20.

Override `ExecuteAsync` instead.

Custom cards now receive the parent ID in `GetValue` and `GetValueAsync`, or `null` when there is no parent. In earlier versions, custom cards always received `null`.

`CollectionMapper.ToDisplayModel()`, `EntityMapper.ToDisplayModel()`, and `ViewComponentRenderer.Render()` are obsolete and are scheduled for removal in Umbraco UI Builder 20. Use `ToDisplayModelAsync()` and `RenderAsync()` instead.

For more information, see the [Async APIs](../advanced/async-apis.md) article.

## Version 14

### Virtual subtrees are no longer available

Virtual subtrees are not available in Umbraco UI Builder version 14 and later. The new backoffice does not support the hooks that virtual subtrees depend on.

## Legacy Version Upgrade Notes

For out-of-support versions, see the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/tree/umbraco-eol-versions).
