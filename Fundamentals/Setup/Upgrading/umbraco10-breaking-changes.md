---
versionFrom: 10.0.0
meta.Title: "Breaking changes going from Umbraco 9 to 10"
meta.Description: "In this article we list the breaking changes between Umbraco 9 and 10"
---

# Breaking changes

Below is the breaking changes going from Umbraco 9 to 10.

## Update 'diff' from 3.5.0 to 5.0.0

## Implement IOptionsMonitor or IOptionsSnapshot instead of IOptions

## 11269: Make sure TemplateId is set correctly from cache

## V10/feature/content schedule performance

## Update to .NET6 and ASP.NET Core 6

## v10 misc - Removed some redundant event handling code

- Removed public methods Dispose, Dispose(bool) and Initialize
- Removed public ctor.

## v10 scope provider cleanup

- Some public classes in the Cms.Core.Services namespace have moved assembly from Umbraco.Cms.Infrastructure -> Umbraco.Cms.Core

- These same public classes have changed namespace from Umbraco.Cms.Core.Services.Implement to Umbraco.Cms.Core.Services.

## v10 update to npoco5

## v10 SQLite support + distributed locking abstractions

- Removed support for Microsoft SQL Server Compact (SQL CE)

- Removed ReadLock & WriteLock methods from ISqlSyntaxProvider interface, please instead make use of - IDistributedLockingMechanism (or IScope which delegates to IDistributedLockingMechanism).

- Constants for SQL Server provider name moved+consolidated from Core.Constants.DatabaseProviders & Core.Constants.- DbProviderNames to Umbraco.Cms.Persistence.SqlServer.Constants

- Various SQL Server related services moved from the Umbraco.Infrastructure project to the new Umbraco.Cms.
Persistence.- SqlServer project with altered namespaces e.g.

- SqlServerSyntaxProvider, SqlServerBulkSqlInsertProvider, SqlServerDatabaseCreator

**Added various methods / properties to ISqlSyntaxProvider, these must be implemented in any downstream implementation e.g:**

- ISqlSyntaxProvider.HandleCreateTable(IDatabase,TableDefinition,Boolean)
- ISqlSyntaxProvider.GetFieldNameForUpdate()
- ISqlSyntaxProvider.GetColumn(DatabaseType,String,String,String,String,Boolean)
- ISqlSyntaxProvider.InsertForUpdateHint(Sql)
- ISqlSyntaxProvider.AppendForUpdateHint(Sql)
- ISqlSyntaxProvider.LeftJoinWithNestedJoin(Sql,Func<Sql,Sql>,String)

## Dependancy Update: Switch to Serilog.Expressions away from deprecated Serilog.Filters.Expressions

## v10: Update to ImageSharp v2

**Update dependency versions**:

- _SixLabors.ImageSharp from 1.0.4 to 2.1.1 (see breaking changes in v2.0.0 release notes);_

- _SixLabors.ImageSharp.Web from 1.0.5 to 2.0.0 (see breaking changed in release notes);_

**Renamed CachedNameLength property to CacheHashLength on ImagingCacheSettings**

**Moved ImageSharpImageUrlGenerator from project Umbraco.Infrastructure to Umbraco.Web.Common and updated the corresponding namespace and DI registration (from AddCoreInitialServices() to AddUmbracoImageSharp());**

**Moved ImageSharp configuration from the AddUmbracoImageSharp() extension method into separate IConfigureOptions<> implementations:**

- _The middleware is configured in ConfigureImageSharpMiddlewareOptions (which also replaces ImageSharpConfigurationOptions that previously only set the default ImageSharp configuration);_

- _The default physical cache is configured in ConfigurePhysicalFileSystemCacheOptions._

## V10: Migrate member properties to columns on the member table

This is breaking because it is no longer possible access the properties listed below through the IMember.Properties, collection, you must now access them through their specific properties I.E. IMember.IsLockedOut.

- _umbracoMemberFailedPasswordAttempts_
- _umbracoMemberApproved_
- _umbracoMemberLockedOut_
- _umbracoMemberLastLockoutDate_
- _umbracoMemberLastLogin_
- _umbracoMemberLastPasswordChangeDate_

Additionally, when previously you resolved a member as published content, all the default properties would be there twice, for instance, IsLockedOut would be there both as a property with the alias umbracoMemberLockedOut and with the alias IsLockedOut, now it'll only be there once, with the alias being the name of the property, so IsLockedOut in this instance.

Lastly the nullable dates on a user, I.E. LastLoginLate will now be null instead of DateTime.MinValue when getting a user with the user service.

## v10: Clean-up migrations and initial state

## v10: Make language name editable

## Update examine to version 3

## V10: Move core services to core project

## v10: Async support for content finders. Improve loging performance

## v10: Improve redirect content finder scalability

## v10: Fix Block List settings exception and optimize PVCs

## v10: Async tree search

## Moved StackQueue to correct namespace
