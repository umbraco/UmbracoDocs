---
versionFrom: 10.0.0
meta.Title: "Breaking changes going from Umbraco 9 to 10"
meta.Description: "In this article we list the breaking changes between Umbraco 9 and 10"
---

# Breaking changes

Below it is possible to read about the breaking changes between Umbraco 9 and 10.
The article is subject to change, the closer we get to the launch of Umbraco 10.

## Update 'diff' from 3.5.0 to 5.0.0

diff library used in the Backoffice client is outdated by two major versions. Updating this will be a breaking change since the exposed global object has been renamed from JsDiff to Diff.

## V10/feature/content schedule performance

Removes mutable ContentSchedule property from IContent/Content to read/write content schedules please make use of _IContentService.GetContentScheduleByContentId && IContentService.PersistContentSchedule_ or the optional _contentSchedule parameter_ on _IContentService.Save_

## v10 misc - Removed some redundant event handling code

- Removed public methods: _Dispose_, _Dispose(bool)_ and _Initialize_
- Removed public ctor.

## v10 scope provider cleanup

- Some public classes in the _Cms.Core.Services_ namespace have moved assembly from **_Umbraco.Cms.Infrastructure_** to **_Umbraco.Cms.Core_**

- These same public classes have changed namespace from **_Umbraco.Cms.Core.Services.Implement_** to **_Umbraco.Cms.Core.Services_**.

## v10 update to npoco5

NPoco types and interfaces are part of our public interface and there are changes upstream.

## v10 SQLite support + distributed locking abstractions

- Removed support for Microsoft SQL Server Compact (SQL CE)

- Removed ReadLock & WriteLock methods from _ISqlSyntaxProvider_ interface, please instead make use of - _IDistributedLockingMechanism_ (or IScope which delegates to _IDistributedLockingMechanism_).

- Constants for SQL Server provider name moved+consolidated from _Core.Constants.DatabaseProviders_ & _Core.Constants.-DbProviderNames_ to _Umbraco.Cms.Persistence.SqlServer.Constants_

- Various SQL Server related services moved from the Umbraco.Infrastructure project to the new Umbraco.Cms.
Persistence.- SqlServer project with altered namespaces e.g.

- _SqlServerSyntaxProvider_, _SqlServerBulkSqlInsertProvider_, _SqlServerDatabaseCreator_

**Added various methods / properties to ISqlSyntaxProvider, these must be implemented in any downstream implementation e.g:**

- _ISqlSyntaxProvider.HandleCreateTable(IDatabase,TableDefinition,Boolean)_
- _ISqlSyntaxProvider.GetFieldNameForUpdate()_
- _ISqlSyntaxProvider.GetColumn(DatabaseType,String,String,String,String,Boolean)_
- _ISqlSyntaxProvider.InsertForUpdateHint(Sql)_
- _ISqlSyntaxProvider.AppendForUpdateHint(Sql)_
- _ISqlSyntaxProvider.LeftJoinWithNestedJoin(Sql,Func<Sql,Sql>,String)_

## v10: Update to ImageSharp v2

**Update dependency versions**:

- _SixLabors.ImageSharp from 1.0.4 to 2.1.1 (see breaking changes in v2.0.0 release notes);_

- _SixLabors.ImageSharp.Web from 1.0.5 to 2.0.0 (see breaking changed in release notes);_

Renamed CachedNameLength property to CacheHashLength on ImagingCacheSettings.

Moved ImageSharpImageUrlGenerator from project Umbraco.Infrastructure to Umbraco.Web.Common and updated the corresponding namespace and DI registration (from AddCoreInitialServices() to AddUmbracoImageSharp());

Moved ImageSharp configuration from the _AddUmbracoImageSharp()_ extension method into separate _IConfigureOptions<>_ implementations:

- _The middleware is configured in ConfigureImageSharpMiddlewareOptions (which also replaces ImageSharpConfigurationOptions that previously only set the default ImageSharp configuration);_

- _The default physical cache is configured in ConfigurePhysicalFileSystemCacheOptions._

## V10: Migrate member properties to columns on the member table

This is breaking because it is no longer possible access the properties listed below through the _IMember.Properties_ collection, you must now access them through their specific properties I.E. _IMember.IsLockedOut_.

- _umbracoMemberFailedPasswordAttempts_
- _umbracoMemberApproved_
- _umbracoMemberLockedOut_
- _umbracoMemberLastLockoutDate_
- _umbracoMemberLastLogin_
- _umbracoMemberLastPasswordChangeDate_

Additionally, when previously you resolved a member as published content, all the default properties would be there twice, for instance, _IsLockedOut_ would be there both as a property with the alias umbracoMemberLockedOut and with the alias _IsLockedOut_, now it'll only be there once, with the alias being the name of the property, so _IsLockedOut_ in this instance.

Lastly the nullable dates on a user, I.E. _LastLoginLate_ will now be null instead of _DateTime.MinValue_ when getting a user with the user service.

## Update examine to version 3

**Examine 3 breaking changes:**

- _ValueSet immutable._
- _ValueSetValidationResult is renamed to ValueSetValidationStatus and ValueSetValidationResult is now a type._

## v10: Async support for content finders. Improve logging performance

```CSharp
bool TryFindContent(IPublishedRequestBuilder request);
```

Has changed to:

```CSharp
Task<bool> TryFindContent(IPublishedRequestBuilder request)
```

## v10: Improve redirect content finder scalability

- Added more methods to **_IRedirectUrlRepository_** and **_IRedirectUrlService.cs_**

## v10: Fix Block List settings exception and optimize PVCs

- Added a new method on _IPublishedModelFactory: Type GetModelType(string? alias);_
- The generic types of a _BlockListItem<TContent, TSettings>_ instance in the _BlockListModel_ returned by _BlockListPropertyValueConverter_ are now determined by calling this new method, which can be different and cause a _ModelBindingException_ in your views.

## v10: Async tree search

```CSharp
IEnumerable<SearchResultEntity?> Search(string query, int pageSize, long pageIndex, out long totalFound, string? searchFrom 
= null)
```

Has changed to:

```CSharp
Task<EntitySearchResults> SearchAsync(string query, int pageSize, long pageIndex, string? searchFrom = null);
```

## Moved StackQueue to correct namespace

StackQueue has been moved from **_Umbraco.Core.Collections_** to the **_Umbraco.Cms.Core.Collections_** namespace.

<!--
Missing information about the breaking changes:

## Implement IOptionsMonitor or IOptionsSnapshot instead of IOptions

## 11269: Make sure TemplateId is set correctly from cache

## v10: Make language name editable

## Dependancy Update: Switch to Serilog.Expressions away from deprecated Serilog.Filters.Expressions

## V10: Move core services to core project 
## Update to .NET6 and ASP.NET Core 6

-->