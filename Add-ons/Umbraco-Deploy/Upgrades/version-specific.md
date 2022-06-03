---
versionFrom: 9.0.0
versionTo: 10.0.0
meta.Title: "Version specific upgrades"
meta.Description: "Version specific documentation for upgrading to new major versions of Umbraco Deploy."
---

# Version Specific Upgrade Details

This page covers specific upgrade documentation for when migrating to a new major of Umbraco Deploy.

## Version 10

Version 10 of Umbraco Deploy has a minimum dependency on Umbraco CMS core of `10.0.0`. It runs on .NET 6.

The forms deployment component has a minimum dependency on Umbraco Forms of `10.0.0`.

To migrate to version 10 you should first update to the latest minor release of version 9. This will ensure you have all the database schema changes in place.

### Breaking changes

Version 10 contains a number of breaking changes but we won't expect many projects to be affected by them as they are in areas that are not typical extension points.  For reference though, the full details are listed here.

#### Database Initialization

When using Umbraco Deploy with Umbraco Cloud, a development database is automatically created when restoring a project into a local environment for the first time. With Umbraco 9 and previous versions, SQL CE could be used for this.  This database version is no longer supported in Umbraco 10, so SQLlite is available instead.  SQLlite will be the default format used for the local database.

If you prefer to use a supported alternative, i.e. LocalDb or SQL Server, ensure that a connection string is in place before triggering the restore operation.

For example, to use LocalDb, you would place this in your `appSettings.json` configuration file:

```json
{
  "ConnectionStrings": {
    "umbracoDbDSN": "Data Source=(localdb)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Umbraco.mdf;Integrated Security=True",
    "umbracoDbDSN_ProviderName": "Microsoft.Data.SqlClient"
  }
}
```

#### Configuration

- The boolean property `IgnoreBrokenDependencies` has been removed, and the option is now controlled only by the `IgnoreBrokenDependenciesBehavior` configuration key, which takes an enumeration value.
  - The default value has changed to `IgnoreBrokenDependenciesBehavior.Restore`, as this will most likely be what developers require (allowing broken dependencies when restoring, but not when pushing to an upstream environment).
- `CurrentWorkspaceName` has been added to the `Project` configuration section.  This will be used by on-premises installations.
  - Previously this used EnvironmentName in the `Debug` configuration section, which will still be used if defined to support upgrades. We recommend using the new configuration as it's more intuitively placed (i.e. it's not really a "debug" setting for on-premises installations).

#### Code

- The following classes have altered constructors taking additional parameters.
  - `DeployScopeProvider`
  - `ArtifactRelator`
  - `RepairDictionaryIdsWorkItem`
  - `DiskWorkItemFactory`
  - `ClearSignaturesWorkItem`
  - `MemberTypeConnector`
  - `DeployManagementDashboardController`
  - `CurrentEnvironment`
- Additional methods have been added to `IUmbracoEnvironment`.
- The property `BackOfficeDeployOperation` has been added to `IWorkItem`.
- The `RelationTypeArtifact` class has been moved to the `Umbraco.Deploy.Infrastructure.Artifacts` namespace.
- `IDiskEntityService` has been moved to the `Umbraco.Deploy.Infrastructure.Disk` namespace.
- An additional method, previously provided by an extension method, has been added to the `IDiskEntityService` interface.
- `DiskReadTask` has been moved to the `Umbraco.Deploy.Infrastructure.Work.BackgroundTasks` namespace.
- `ITransferEntityService.RegisterTransferEntityType` has an additional parameter.
- `DeployRegisteredEntityTypeDetail` was renamed to `DeployTransferRegisteredEntityTypeDetail`.
- Removed unused class `SerializablePropertyValue`.