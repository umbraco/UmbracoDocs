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

This section contains the release notes for Umbraco Deploy 14 including all changes for this version.

### [14.3.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.3.0) (February 6th 2025)

* All items from 14.3.0-rc1

### [14.3.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.3.0) (January 30th 2025)

* Schema cleanup and item actions triggered from Deploy's management dashboard (create or delete UDA files and Umbraco items)
* Allow ignoring dependencies in transfer/restore operations
* Ignore `Dependencies` artifact property when calculating the checksum and fix schema comparison [#246](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/246)
* Add 'Hide up to date' toggle to schema comparison [#245](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/245)
* Fix parsing dictionary item root UDI range from node ID
* Ensure work item references/action results are deallocated (reduces overall memory usage in Deploy)
* Allow disabling warnings as errors on import

### [14.2.2](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.2.2) (December 23rd 2024)

* Ensure environment-to-environment actions are executed asynchronously on background job (fixes timeout issues on large deployments) [#179](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/179)
* Only require default, allowed and master templates and their associated files to exist (avoids schema mismatches on template changes) [156](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/156)

### [14.2.1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.2.1) (November 29th 2024)

* Update documentation links in management dashboard to include major version in the URL
* Add `ValidateDependenciesOnImport` setting to management dashboard
* Fix tree restore for custom entities [#241](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/241)
* Disable import button when no file is selected

### [14.2.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.2.0) (November 21st 2024)

* All items from 14.2.0-rc1

### [14.2.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.2.0) (November 13th 2024)

* Add option to include all schema in a workspace export
* Add option to export from transfer queue
* Combine migrated grid editor with default Block Grid block configuration (set `RowMinSpan` and `RowMaxSpan` to `1` and `EditorSize` to `medium`)
* Import on startup
* Added `ValidateDependenciesOnImport` setting to disable dependency validation on import
* Fixed issue where content was not saved when transferring variant content with a release date
* Support flexible environments on Umbraco Cloud (remove requirement for environment types to be Development, Staging or Live)

### [14.1.4](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.4) (October 3rd 2024)

* Support migrating legacy Grid editor settings (config/styles) using JSON object pre-values
* Fix parsing JSON serialized legacy Grid editor control values

### [14.1.3](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.3) (September 19th 2024)

* Resolved forbidden API requests on content section display when the user does not have access to the settings section.

### [14.1.2](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.2) (September 17th 2024)

* Fix document blueprint connector and add support for containers
* Fix tree export of members by member type
* Ensure release date of invariant content is correctly transferred [#233](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/233)
* Parse nested JSON property values from artifact values [#234](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/234)

### [14.1.1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.1) (August 20th 2024)

* Support getting artifacts from exploded/expanded `NamedUdiRange` with different entity types
* Fixed typo in `DefaultLegacyDataTypeConfigurationArtifactMigrator` when migrating Color Picker items in v8 format

### [14.1.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.0) (August 15th 2024)

* All items from 14.1.0-rc1
* Fixed `Could not create Udi node: {Id} and entity type {EntityType}` exception when exporting tree nodes without children
* Fixed deploy signatures not getting cleared when members are deleted [#230](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/230)
* Allow members to be deployed when selected as items in a multi-node tree picker [#231](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/231)
* Apply `ExcludedEntityTypes` configuration to disk operations [#232](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/232)
* Fixed issues with partial restore from an external tree that contains more than one entity
* Fixed formatting of trial expiry days and added missing translations [#229](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/229)
* Fixed `Could not get physical path for "umb://template-file/".` exception when deploying/exporting template without physical file on disk

### [14.1.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.0) (July 19th 2024)

* Add migrators to support legacy Grid layout to Block Grid migration
* Fix schema mismatch when saving templates in production runtime mode [#228](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/228)
* Add default migrator to add missing editor UI aliases and update when replacing editor
* Add default migrator to update Data Type configuration
* Support processing Document/Media Type list view keys and add migrator

### [14.0.2](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.0.2) (July 11th 2024)

* Set trashed state when processing content [#223](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/223)
* Improve exception message when parent can't be found when getting artifact [#216](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/216)
* Add `MaxRequestLength` Deploy setting to break file upload into multiple requests
* Set variant names when creating new content [#222](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/222)

### [14.0.1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.0.1) (June 6th 2024)

* Ensure remote tree uses correct entity type (if multiple entities like folders and items are present in a tree):
  * `ITransferEntityService.RegisterTransferEntityType(...)` accepts an optional `RemoteTreeDetail` that now exposes the entity type when getting remote entities;
* Fix `GetMaxRequestLength` endpoint (misaligned HTTP method) preventing file transfers/uploads from local environments;
* Fix Data Type deployment due to missing `EditorUiAlias` (requires a schema extraction/Data Type save to fix);
* Fix JSON serialization errors in trigger endpoints (extract and status report);
* Obsolete and hide `NestedContentValueConnector` and add import migrators for unsupported legacy editors by default:
  * Adds `ReplaceMediaPickerDataTypeArtifactMigrator` and `ReplaceNestedContentDataTypeArtifactMigrator` artifact migrators to replace the Data Types with the Media Picker v3 and Block List respectively;
  * Adds `MediaPickerPropertyTypeMigrator` and `NestedContentPropertyTypeMigrator` property type migrators to ensure content (property data) is migrated as well;
* Support import with unknown UDI types (like macro, macroscript and partial-view-macro);
* Fix JSON serialization error in value connectors for `BlockValue`.

### [14.0.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.0.0) (May 30th 2024)

* Compatibility with Umbraco 14
  * See full details of breaking changes under the [Version-specific Upgrade Guide](upgrades/version-specific.md).

## Umbraco.Deploy.Contrib

### [14.2.0](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-14.2.0) (October 3rd 2024)

* Migrate nested/recursive legacy pre-value property values [#71](https://github.com/umbraco/Umbraco.Deploy.Contrib/pull/71)

### [14.1.0](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-14.1.0) (August 15th 2024)

* All items from 14.1.0-rc1

### [14.1.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-14.1.0-rc1) (July 19th 2024)

* Add Matryoshka Group Separator artifact migrator [#67](https://github.com/umbraco/Umbraco.Deploy.Contrib/pull/67)
* Add migrators to support DocTypeGridEditor to Block Grid migration [#66](https://github.com/umbraco/Umbraco.Deploy.Contrib/pull/66)
* Fix and enable remaining legacy artifact migrators [#68](https://github.com/umbraco/Umbraco.Deploy.Contrib/pull/68)

### [14.0.0](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-14.0.0) (May 30th 2024)

* Compatibility with Umbraco 14 and Deploy 14.

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-deploy/release-notes.md) and [Umbraco Deploy Package page](https://our.umbraco.com/packages/developer-tools/umbraco-deploy/)
