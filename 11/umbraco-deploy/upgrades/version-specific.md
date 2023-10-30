---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco
  Deploy.
---

# Version Specific Upgrade Details

This page covers specific upgrade documentation for when migrating to a new major of Umbraco Deploy.

{% hint style="info" %}
If you are upgrading to a minor or patch of Deploy you can find the details about the changes in the [release notes](../release-notes.md) article.
{% endhint %}

<details>

<summary>Version 11</summary>

#### Version 11

Version 11 of Umbraco Deploy has a minimum dependency on Umbraco CMS core of `11.0.0`. It runs on .NET 7.

The forms deployment component has a minimum dependency on Umbraco Forms of `11.0.0`.

**Breaking changes**

Version 11 contains a number of breaking changes. We don't expect many projects to be affected by them as they are in areas that are not typical extension points. For reference though, the full details are listed here:

**Code**

* The property `PreValues` on `FormArtifact` was changed from an `IEnumerable<string>` to an `IEnumerable<FieldPrevalue>`, where `FieldPrevalue` contains a `Value` and `Caption`.
* Nullable checks were enabled in the `Umbraco.Deploy.Forms` project and issues resolved by applying appropriate nullable settings to multiple properties.
* The `TreeNodeGetter` function set as a property on `DeployTransferRegisteredEntityTypeDetail.RemoteTreeDetail` now takes a non-nullable `HttpContext` parameter.
* The `matchesRoutePath` and `matchesNodeId` parameters provided to `ITransferEntityService.RegisterTransferEntityType`, and which populate the `MatchesRoutePath` and `MatchesNodeId` properties on `DeployTransferRegisteredEntityTypeDetail`, now take an HttpContext argument.
* The `MultiNodeTreePickerPreValueConnector` was removed (as the format for Umbraco 8+ is as UDIs, and hence there is no processing to do).
* Obsolete constructors, properties, and methods on `Manifest` were removed.
* Namespace of the `Package` class was adjusted and the obsolete property `Artifacts` was removed. `ArtifactsWithOptions` was renamed to `Artifacts`.
* The signature of `EnvironmentController.BeginCreateManifestForUdis` was changed.
* The temporary interface `IUmbracoEnvironmentWithOptionsAwareManifest` was removed and elements added to `IUmbracoEnvironment`.
* The signature of `IWorkItemFactory.CreateSourceDeplo`y was changed to accommodate culture and scheduled publishing options.
* The obsolete constructor on `SourceDeployWorkItem` was removed.
* The class `UmbracoFormsCompatibility` that is no longer required has been removed.
* Obsolete constructors were removed on `NoNodesController`, `UiController`, and `UiControllerBase`.
* Temporary interfaces for connectors, introduced to avoid breaking changes with the introduction of the `IContextCache` in 10.2, were removed and the method overloads added to the original interfaces.
* The obsolete constructor was removed on `WorkItemFactory`.
* The obsolete protected methods on `DeployRestoreWorkItemBase` were removed.

</details>

<details>

<summary>Version 11</summary>

#### Version 10

Version 10 of Umbraco Deploy has a minimum dependency on Umbraco CMS core of `10.0.0`. It runs on .NET 6.

The forms deployment component has a minimum dependency on Umbraco Forms of `10.0.0`.

To migrate to version 10 you should first update to the latest minor release of version 9. This will ensure you have all the database schema changes in place.

**Breaking changes**

Version 10 includes a number of breaking changes. These changes are unlikely to affect many projects because they're not in typical extension points. For reference though, the full details are listed here.

**Database Initialization**

When using Umbraco Deploy with Umbraco Cloud, a development database is automatically created when restoring a project into a local environment for the first time. With Umbraco 9 and previous versions, SQL CE could be used for this. This database type is no longer supported in Umbraco 10, so SQLite is available instead. SQLite will be the default format used for the local database.

If you prefer to use a supported alternative, you can ensure that a connection string is in place before triggering the restore operation.

For example, to use a local SQL Server Express instance, you would place this in your `appSettings.json` configuration file:

```json
{
  "ConnectionStrings": {
    "umbracoDbDSN": "Server=.\\SQLEXPRESS;Database=UmbracoDb;Integrated Security=true",
    "umbracoDbDSN_ProviderName": "Microsoft.Data.SqlClient"
  }
}
```

If you prefer to use LocalDB, either set a connection string as above:

```json
{
  "ConnectionStrings": {
    "umbracoDbDSN": "Data Source=(localdb)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Umbraco.mdf;Integrated Security=True",
    "umbracoDbDSN_ProviderName": "Microsoft.Data.SqlClient"
  }
}
```

Or set the configuration value of `Umbraco:Deploy:Settings:PreferLocalDbConnectionString` to `true`:

```json
{
    "Umbraco": {
        "Deploy": {
            "Settings": {
                "PreferLocalDbConnectionString": true
            }
        }
    }
}
```

If you are upgrading from Umbraco 9 and already have a LocalDB instance, you can set this value to `true`. This will ensure it is used rather than a new, empty SQLite database. **Configuration**

* The boolean property `IgnoreBrokenDependencies` has been removed, and the option is now controlled only by the `IgnoreBrokenDependenciesBehavior` configuration key, which takes an enumeration value.
  * The default value has changed to `IgnoreBrokenDependenciesBehavior.Restore`, as this will most likely be what developers require (allowing broken dependencies when restoring, but not when pushing to an upstream environment).
* `CurrentWorkspaceName` has been added to the `Project` configuration section. This will be used by on-premises installations.
  * Previously this used EnvironmentName in the `Debug` configuration section, which will still be used if defined to support upgrades. We recommend using the new configuration as it's more intuitively placed (that is not really a "debug" setting for on-premises installations).

**Code**

* The following classes have altered constructors taking additional parameters.
  * `DeployScopeProvider`
  * `ArtifactRelator`
  * `RepairDictionaryIdsWorkItem`
  * `DiskWorkItemFactory`
  * `ClearSignaturesWorkItem`
  * `MemberTypeConnector`
  * `DeployManagementDashboardController`
  * `CurrentEnvironment`
* Additional methods have been added to `IUmbracoEnvironment`.
* The property `BackOfficeDeployOperation` has been added to `IWorkItem`.
* The `RelationTypeArtifact` class has been moved to the `Umbraco.Deploy.Infrastructure.Artifacts` namespace.
* `IDiskEntityService` has been moved to the `Umbraco.Deploy.Infrastructure.Disk` namespace.
* An additional method, previously provided by an extension method, has been added to the `IDiskEntityService` interface.
* `DiskReadTask` has been moved to the `Umbraco.Deploy.Infrastructure.Work.BackgroundTasks` namespace.
* `ITransferEntityService.RegisterTransferEntityType` has an additional parameter.
* `DeployRegisteredEntityTypeDetail` was renamed to `DeployTransferRegisteredEntityTypeDetail`.
* Removed unused class `SerializablePropertyValue`.

</details>
