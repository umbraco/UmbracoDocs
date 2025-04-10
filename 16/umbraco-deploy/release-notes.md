---
description: Get an overview of the things changed and fixed in each version of Umbraco Deploy.
---

# Release notes

In this section we have summarised the changes to Umbraco Deploy and [Deploy Contrib](https://github.com/umbraco/Umbraco.Deploy.Contrib) released in each version. Each version is presented with a link to the [Deploy issue tracker](https://github.com/umbraco/Umbraco.Deploy.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version you can find the details about the breaking changes in the [version specific updates](upgrades/version-specific.md) article.
{% endhint %}

## Release history

This section contains the release notes for Umbraco Deploy 15 including all changes for this version.

### [15.1.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.1.0) (February 6th 2025)

* All items from 15.1.0-rc1
* Add user groups to schema comparison

### [15.1.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.1.0) (January 30th 2025)

* Schema cleanup and item actions triggered from Deploy's management dashboard (create or delete UDA files and Umbraco items)
* Allow ignoring dependencies in transfer/restore operations
* Ignore `Dependencies` artifact property when calculating the checksum and fix schema comparison [#246](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/246)
* Add 'Hide up to date' toggle to schema comparison [#245](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/245)
* Fix parsing dictionary item root UDI range from node ID
* Ensure work item references/action results are deallocated (reduces overall memory usage in Deploy)
* Allow disabling warnings as errors on import
* Schema deployment of user groups

### [15.0.2](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.2) (December 23rd 2024)

* Ensure environment-to-environment actions are executed asynchronously on background job (fixes timeout issues on large deployments) [#179](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/179)
* Only require default, allowed and master templates and their associated files to exist (avoids schema mismatches on template changes) [156](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/156)

### [15.0.1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.1) (November 29th 2024)

* Update documentation links in management dashboard to include major version in the URL
* Add `ValidateDependenciesOnImport` setting to management dashboard
* Fix tree restore for custom entities [#241](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/241)
* Fix import complete heading and description (was using export complete localization keys)
* Disable import button when no file is selected

### [15.0.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.0) (November 14th 2024)

* Update CMS dependency to 15.0.0

### [15.0.0-rc4](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.0) (November 13th 2024)

* Update CMS dependency to 15.0.0-rc4
* Preview of features and bug fixes due in 13.3 and 14.2:
  * Import on startup
  * Added `ValidateDependenciesOnImport` setting to disable dependency validation on import
  * Support flexible environments on Umbraco Cloud (remove requirement for environment types to be Development, Staging or Live)

### [15.0.0-rc3](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.0) (November 7th 2024)

* Update CMS dependency to 15.0.0-rc3

### [15.0.0-rc2](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.0) (October 24th 2024)

* Update CMS dependency to 15.0.0-rc2
* Preview of features and bug fixes due in 13.3 and 14.2:
  * Add option to include all schema in a workspace export
  * Add option to export from transfer queue
  * Fix `BlockValue` obsoleted properties (set GUID keys instead of UDIs and support block level variants)
  * Combine migrated grid editor with default Block Grid block configuration (set `RowMinSpan` and `RowMaxSpan` to `1` and `EditorSize` to `medium`)
* Restructure keys and add new UI localizations

### [15.0.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.0) (October 11th 2024)

* Compatibility with Umbraco 15
  * See full details of breaking changes under the [Version-specific Upgrade Guide](upgrades/version-specific.md)
* Removed `AcceptInvalidCertificates` setting (configure `DeployHttpClient` typed client instead)
* Removed `RemoteTreeNode` model (use `RemoteTreeEntity` instead) and `TryParseEntityIdFromNodeIdDelegate` (use `TryParseUdiRangeFromNodeIdDelegate` instead) in `DeployTransferRegisteredEntityTypeDetail`
* Added `MigrateAsync(...)` method to `IPropertyTypeMigrator` and updated `PropertyTypeMigratorBase` and implementations to use async instead

## Umbraco.Deploy.Contrib

### [15.0.0](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-15.0.0) (November 14th 2024)

* Update CMS and Deploy dependencies to 15.0.0

### [15.0.0-rc4](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-15.0.0-rc4) (November 13th 2024)

* Update CMS and Deploy dependencies to 15.0.0-rc4

### [15.0.0-rc3](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-15.0.0-rc3) (November 7th 2024)

* Update CMS and Deploy dependencies to 15.0.0-rc3

### [15.0.0-rc2](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-15.0.0-rc2) (October 24th 2024)

* Update CMS and Deploy dependencies to 15.0.0-rc2

### [15.0.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-15.0.0-rc1) (October 14th 2024)

* Compatibility with Umbraco 15 and Deploy 15
* Removed obsolete (and unused) legacy `PrevaluePropertyValueArtifactMigratorBase`, `CheckBoxListPropertyValueArtifactMigrator` `DropDownListFlexiblePropertyValueArtifactMigrator` and `RadioButtonListPropertyValueArtifactMigrator` migrators, as they are replaced with `PrevalueArtifactMigrator` and property type migrators that support nested/recursive properties (see PR [#71](https://github.com/umbraco/Umbraco.Deploy.Contrib/pull/71))
* Removed `MediaPickerDataTypeArtifactMigrator`, as it is replaced with `ReplaceMediaPickerDataTypeArtifactMigrator` and `DefaultLegacyDataTypeConfigurationArtifactMigrator`
* Removed `MultiNodeTreePickerDataTypeArtifactMigrator`, as it is replaced with `DefaultLegacyDataTypeConfigurationArtifactMigrator`

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-deploy/release-notes.md) and [Umbraco Deploy Package page](https://our.umbraco.com/packages/developer-tools/umbraco-deploy/)
