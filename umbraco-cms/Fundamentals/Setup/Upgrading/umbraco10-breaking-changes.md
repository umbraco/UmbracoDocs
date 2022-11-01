---
versionFrom: 10.0.0
meta.Title: "Breaking changes going from Umbraco 9 to 10"
meta.Description: "In this article we list the breaking changes between Umbraco 9 and 10"
---

# Breaking changes

In this article you will find a list of breaking changes made between Umbraco 9 and 10.

The article is subject to change, the closer we get to the launch of Umbraco 10.

## [Update 'diff' from 3.5.0 to 5.0.0](https://github.com/umbraco/Umbraco-CMS/issues/12337)

The `diff`library used in the Backoffice client has been updated and introduces a breaking change since the exposed global object has been renamed from `JsDiff` to `Diff`.

## [Content Schedule performance](https://github.com/umbraco/Umbraco-CMS/pull/11398)

Removes mutable ContentSchedule property from `IContent/Content` to `read/write` content schedules. 

Use _IContentService.GetContentScheduleByContentId && IContentService.PersistContentSchedule_ or the optional _contentSchedule parameter_ on _IContentService.Save_ instead.

## [Removed redundant event handling code](https://github.com/umbraco/Umbraco-CMS/pull/11842)

- Removed public methods: `PublishedSnapshotServiceEventHandler.Dispose`, `PublishedSnapshotServiceEventHandler.Dispose(bool)`, and `.PublishedSnapshotServiceEventHandler.Initialize`.
- Removed public `ctor`.

## [Scope provider cleanup](https://github.com/umbraco/Umbraco-CMS/pull/11859)

- Some public classes in the `Cms.Core.Services` namespace has moved assembly from **`Umbraco.Cms.Infrastructure`** to **`Umbraco.Cms.Core`**.

- These same public classes have changed namespace from **`Umbraco.Cms.Core.Services.Implement`** to **`Umbraco.Cms.Core.Services`**.

## [Update to NPoco5](https://github.com/umbraco/Umbraco-CMS/pull/11880)

NPoco types and interfaces are part of our public interface which means that this upgrade imposes breaking changes.

## [SQLite support](https://github.com/umbraco/Umbraco-CMS/pull/11922)

- Removed support for Microsoft SQL Server Compact (SQL CE).

- Removed `ReadLock` and `WriteLock` methods from `ISqlSyntaxProvider` interface. Use  `IDistributedLockingMechanism` (or IScope which delegates to `IDistributedLockingMechanism`) instead.

- Constants for SQL Server provider name moved+consolidated from `Core.Constants.DatabaseProviders` and `Core.Constants.-DbProviderNames` to `Umbraco.Cms.Persistence.SqlServer.Constants`

- Various SQL Server related services moved from the `Umbraco.Infrastructure` project to the new `Umbraco.Cms.Persistence`.

- SqlServer project with altered namespaces e.g. `SqlServerSyntaxProvider`, `SqlServerBulkSqlInsertProvider`, `SqlServerDatabaseCreator`.

**Added the following methods/properties to ISqlSyntaxProvider. These must be implemented in any downstream implementation e.g:**

- `ISqlSyntaxProvider.HandleCreateTable(IDatabase,TableDefinition,Boolean)`
- `ISqlSyntaxProvider.GetFieldNameForUpdate()`
- `ISqlSyntaxProvider.GetColumn(DatabaseType,String,String,String,String,Boolean)`
- `ISqlSyntaxProvider.InsertForUpdateHint(Sql)`
- `ISqlSyntaxProvider.AppendForUpdateHint(Sql)`
- `ISqlSyntaxProvider.LeftJoinWithNestedJoin(Sql,Func<Sql,Sql>,String)`

## [Update to ImageSharp v2](https://github.com/umbraco/Umbraco-CMS/pull/12185)

**Update dependency versions**:

- `SixLabors.ImageSharp` from 1.0.4 to 2.1.1

- `SixLabors.ImageSharp.Web` from 1.0.5 to 2.0.0

Renamed `CachedNameLength` property to `CacheHashLength` on **ImagingCacheSettings**.

Moved **ImageSharpImageUrlGenerator** from project `Umbraco.Infrastructure` to `Umbraco.Web.Common` and updated the corresponding namespace and DI registration (from `AddCoreInitialServices()` to `AddUmbracoImageSharp()`);

Moved **ImageSharp** configuration from the `AddUmbracoImageSharp()` extension method into separate `IConfigureOptions<>` implementations:

- The middleware is configured in ConfigureImageSharpMiddlewareOptions (which also replaces ImageSharpConfigurationOptions that previously only set the default ImageSharp configuration);

- The default physical cache is configured in ConfigurePhysicalFileSystemCacheOptions.

## [Migrate Member properties to columns on the Member table](https://github.com/umbraco/Umbraco-CMS/pull/12205)

This is breaking because it is no longer possible to access the properties listed below through the _IMember.Properties_ collection. You must now access them through their specific properties i.e. _IMember.IsLockedOut_.

- `umbracoMemberFailedPasswordAttempts`
- `umbracoMemberApproved`
- `umbracoMemberLockedOut`
- `umbracoMemberLastLockoutDate`
- `umbracoMemberLastLogin`
- `umbracoMemberLastPasswordChangeDate`

Additionally, when previously you resolved a Member as published content, all the default properties would be there twice. For instance, `IsLockedOut` would be there both as a property with the alias `umbracoMemberLockedOut` and with the alias `IsLockedOut`. Now it'll only be there once, with the alias being the name of the property, so `IsLockedOut` in this instance.

Lastly the nullable dates on a user, i.e. `LastLoginLate` will now be null instead of `DateTime.MinValue` when getting a user with the UserService.

## [Update examine to version 3](https://github.com/umbraco/Umbraco-CMS/pull/12307)

**Examine 3 breaking changes:**

- `ValueSet` immutable.
- `ValueSetValidationResult` is renamed to `ValueSetValidationStatus` and `ValueSetValidationResult` is now a type.

## [Async support for content finders](https://github.com/umbraco/Umbraco-CMS/pull/12340)

```CSharp
bool TryFindContent(IPublishedRequestBuilder request);
```

Has changed to:

```CSharp
Task<bool> TryFindContent(IPublishedRequestBuilder request);
```

## [Improve redirect Content finder scalability](https://github.com/umbraco/Umbraco-CMS/pull/12341)

- Added more methods to `IRedirectUrlRepository` and `IRedirectUrlService.cs`.

## [Fix Block List settings exception and optimize PVCs](https://github.com/umbraco/Umbraco-CMS/pull/12342)

- Added a new method on `IPublishedModelFactory`: Type `GetModelType(string? alias)`;
- The generic types of a `BlockListItem<TContent`, TSettings>` instance in the `BlockListModel` returned by `BlockListPropertyValueConverter` is now determined by calling this new method, which can be different and cause a `ModelBindingException` in your views.

## [Async tree search](https://github.com/umbraco/Umbraco-CMS/pull/12344)

```CSharp
IEnumerable<SearchResultEntity?> Search(string query, int pageSize, long pageIndex, out long totalFound, string? searchFrom 
= null)
```

Has changed to:

```CSharp
Task<EntitySearchResults> SearchAsync(string query, int pageSize, long pageIndex, string? searchFrom = null);
```

## [Moved StackQueue to correct namespace](https://github.com/umbraco/Umbraco-CMS/pull/12347)

StackQueue has been moved from `Umbraco.Core.Collections` to the `Umbraco.Cms.Core.Collections` namespace.

## Globalsetting SqlWriteLockTimeOut has been removed

This setting has been superseeded by `DistributedLockingWriteLockDefaultTimeout`.
