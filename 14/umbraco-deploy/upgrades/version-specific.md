---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco Deploy.
---

# Version Specific Upgrade Details
This article provides specific upgrade documentation for migrating to Umbraco Deploy version 14.

{% hint style="info" %}
If you are upgrading to a minor or patch version, you can find the details about the changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History
Version 14 of Umbraco Deploy has a minimum dependency on Umbraco CMS core of `14.0.0`. It runs on .NET 8.

### **Breaking changes**
Version 14 contains some breaking changes. Not many projects are expected to be affected by them, as they are in relevant areas when extending Deploy to support additional entities and/or property editors. For reference though, the full details are listed here:

#### Async methods
Asynchronous methods have been added to the following interfaces (in the CMS `Umbraco.Cms.Core.Deploy` namespace):
- `IContextCache`:
  - `GetOrCreateAsync(...)`
- `IDataTypeConfigurationConnector`, `IImageSourceParser`, `ILocalLinkParser` and `IValueConnector`:
  - `ToArtifactAsync(...)`
  - `FromArtifactAsync(...)`
- `IServiceConnector`:
  - `GetArtifactAsync(...)`
  - `ProcessInitAsync(...)`
  - `ProcessAsync(...)`
  - `ExpandRangeAsync(...)`
  - `GetRangeAsync(...)`

These methods all have a default implementation that forwards the calls to the synchronous methods (to maintain backwards compatibility). The synchronous methods have been obsoleted and Deploy will now always call the new asynchronous methods. Implementations should be updated to start using those instead.

Within Deploy, the following base classes and methods have been updated to take advantage of the asynchronous methods:
- `ValueConnectorBase`, `RecursiveValueConnectorBase`, `DataTypeConfigurationConnectorBase` and `ServiceConnectorBase`: all synchronous methods are obsoleted and cause compiler errors when directly invoked (to avoid potential deadlocks, because they all forward to the asynchronous methods using `GetAwaiter().GetResult()`);
- All service and value connector implementations inheriting from the above base classes have been updated to use the asynchronous methods as well;
- `builder.DeployDataTypeConfigurationConnectors().AddCustom(...)`: both `toArtifact` and `fromArtifact` parameters now align with the `ToArtifactAsync(...)` and `FromArtifactAsync(...)` method signatures;
- `IArtifactImportExportService.ExportArtifactsAsync(...)`: the artifacts parameter is updated to `IAsyncEnumerable<IArtifact>`, so artifacts are asynchronously created when iterating;
- `IServiceConnector.GetArtifactsAsync(...)` and `IServiceConnectorFactory.GetArtifactsAsync(...)`: these new extension methods call `GetArtifactAsync(...)` on the relevant service connectors and returns `IAsyncEnumerable<IArtifact>`.

#### Signature notification handling
Deploy stores artifact signatures (hashes) in the database to avoid creating the artifact to for example compare them between disk/database or environments. To ensure the signatures are always up-to-date, the `ISignatureService` used custom notification handling via the `RegisterHandler(...)` and `HandleExternalNotification(...)` methods (because Deploy suppresses notifications during deployment). CMS version 12 introduced the `IDistributedCacheNotificationHandler` marker interface and Deploy 12 the `IDeployRefresherNotificationHandler` that will still handle the notifications during deployments. The following methods are therefore removed:
- `RegisterHandler(...)`: register your handler using the standard `builder.AddNotificationHandler<>()` or `builder.AddNotificationAsyncHandler()` method;
- `HandleExternalNotification(...)`: implement your handler using `IDeployRefresherNotificationHandler<TNotification>` or `IDeployRefresherNotificationAsyncHandler<TNotification>`.

#### Return type of Data Type configuration has changed to a dictionary
The return type of `IDataTypeConfigurationConnector.FromArtifact()/FromArtifactAsync()` has changed from `object` to `IDictionary<string, object>` to align with the Data Type configuration changes in the CMS (see [PR #13605](https://github.com/umbraco/Umbraco-CMS/pull/13605)). Also, obsoleted methods and default interface implementations on Deploy interfaces have been removed (see [PR #15965](https://github.com/umbraco/Umbraco-CMS/pull/15965)).

#### Removed code due to changes in the CMS
The CMS removed support for the legacy Media Picker, Grid layout, Nested Content editors and macros, which means Deploy doesn't provide support for transferring these editors. The following related code has been removed:
- `IGridCellValueConnector`, `IGridCellValueConnector2` and `IGridCellValueConnectorFactory`: including all Grid cell value connector implementations;
- `GridDataTypeConfigurationConnector`, `NestedContentDataTypeConfigurationConnector`;
- `IMacroParser` (in the CMS), `MacroParserBase` and `MacroParser`;
- `MediaPickerValueConnector` and `MacroConnector`.

#### Backoffice related code/Deploy Management API
Due to the new backoffice, all code related to sections, trees, actions, dashboards and models have been removed or updated. The new backoffice components now also use the Deploy Management API for all operations.

#### Permissions
Version 14 now uses permission verbs (instead of single characters/action letters) and upgrading will automatically migrate any existing permissions:

| Letter | Verb                      |
| -------| --------------------------|
| Q      | Deploy.EnvironmentRestore |
| Ψ      | Deploy.TreeRestore        |
| Ø      | Deploy.PartialRestore     |
| T      | Deploy.QueueForTransfer   |
| П      | Deploy.Export             |
| Џ      | Deploy.Import             |

##### JSON artifact migrators
The `IArtifactJsonMigrator.Migrate(...)` method now accepts/returns a `JsonNode` value (instead of `JToken`) due to the change from Newtonsoft.Json to System.Text.Json.

### **Behavior**

#### JSON serialization
Deploy artifacts are serialized as JSON, either stored as schema on disk (UDA files in `umbraco\Deploy\Revision`), exported into a ZIP archive or when being transferred between environments. We aligned with the CMS and migrated to use System.Text.Json (instead of Newtonsoft.Json). Although we've not changed the artifacts themselves, these libraries have [differences in default behavior](https://learn.microsoft.com/en-us/dotnet/standard/serialization/system-text-json/migrate-from-newtonsoft?pivots=dotnet-8-0).

#### No-nodes page environment restore
An empty local environment previously had the option to do an environment restore without logging in to the backoffice. This option now redirects you to the backoffice and once logged in, will show a modal to deploy the schema and restore all content from the upstream environment.

#### Uploaded files for import
Deploy now uses the `ITemporaryFileService` from the CMS to temporarily store the uploaded ZIP archive to import. This also means the cleanup is handled by the CMS and the 'Delete import archives' Deploy operation and support for the `deploy-deleteimportarchives` trigger file are removed.

### **Configuration**

#### Deploy On-prem license key
For Deploy On-premise, configuring the license key has slightly changed, as we introduced additional options for license validation. The product license keys should be moved to the following structure:

```json
{
  "Umbraco": {
    "Licenses": {
      "Products": {
        "Umbraco.Deploy.OnPrem": "<LICENSE KEY>"
      },

    }
  }
}
```

#### Transfer forms as content
The setting `TransferFormsAsContent` has moved to `FormsDeploySettings` in the Forms Deploy package. It is still bound to the `Umbraco:Deploy:Settings:TransferFormsAsContent` configuration key (used in previous versions), so it only affects configuration via code.

### **Dependencies**
* Umbraco CMS dependency was updated to `14.0.0`.

## Legacy version specific upgrade notes
You can find the version specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-deploy/upgrades/version-specific.md).