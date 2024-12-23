---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco
  Deploy.
---

# Release notes

In this section we have summarised the changes to Umbraco Deploy and [Deploy Contrib](https://github.com/umbraco/Umbraco.Deploy.Contrib) released in each version. Each version is presented with a link to the [Deploy issue tracker](https://github.com/umbraco/Umbraco.Deploy.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version you can find the details about the breaking changes in the [version specific updates](upgrades/version-specific.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Deploy 13 including all changes for this version.

#### [13.3.2](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.3.2) (December 23rd 2024)

* Ensure environment-to-environment actions are executed asynchronously on background job (fixes timeout issues on large deployments) [#179](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/179)
* Only require default, allowed and master templates and their associated files to exist (avoids schema mismatches on template changes) [156](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/156)

#### [13.3.1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.3.1) (November 29th 2024)

* Update documentation links in management dashboard to include major version in the URL
* Add `ValidateDependenciesOnImport` setting to management dashboard

#### [13.3.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.3.0) (November 21st 2024)

* All items from 13.3.0-rc1

#### [13.3.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.3.0) (November 13rd 2024)

* Add option to include all schema in a workspace export
* Add option to export from transfer queue
* Combine migrated grid editor with default Block Grid block configuration (set `RowMinSpan` and `RowMaxSpan` to `1` and `EditorSize` to `medium`)
* Import on startup
* Added `ValidateDependenciesOnImport` setting to disable dependency validation on import
* Fixed issue where content was not saved when transferring variant content with a release date
* Support flexible environments on Umbraco Cloud (remove requirement for environment types to be Development, Staging or Live)

#### [13.2.2](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.2.2) (October 3rd 2024)

* Support migrating legacy Grid editor settings (config/styles) using JSON object pre-values

#### [13.2.1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.2.1) (September 17th 2024)

* Fix tree export of members by member type
* Ensure release date of invariant content is correctly transferred [#233](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/233)
* Parse nested JSON property values from artifact values [#234](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/234)

#### [13.2.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.2.0) (August 15th 2024)

* All items from 13.2.0-rc1
* Fixed `Could not create Udi node: {Id} and entity type {EntityType}` exception when exporting tree nodes without children
* Fixed deploy signatures not getting cleared when members are deleted [#230](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/230)
* Allow members to be deployed when selected as items in a multi-node tree picker [#231](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/231)
* Apply `ExcludedEntityTypes` configuration to disk operations [#232](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/232)

#### [13.2.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.2.0) (July 19th 2024)

* Add migrators to support legacy Grid layout to Block Grid migration

#### [13.1.1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.1) (July 11th 2024)

* Add `[DisableRequestSizeLimit]` attribute to `UploadForImport` endpoint to remove application request size limit (server/infrastructure restrictions may still apply)
* Determine missing `routePath` based on `$routeParams` to fix Export, Queue for transfer, and Partial Restore actions on items with children in a list view
* Set trashed state when processing content [#223](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/223)
* Improve exception message when parent cannot be found when getting artifact [#216](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/216)

#### [13.1.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.0) (March 19th 2024)

* All items from 13.1.0-rc1
* Fixed issue with transfer of date values within Nested Content, Block List, or Block Grid properties [#209](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/209)
* Fixed issue where templates could incorrectly cause schema mismatch errors when running in production mode [#187](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/187)
* Fixed issue where importing invalid variant property data would cause a not supported variation exception [#8](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/8)
* Fixed deserialization issue causing problems with the compare content feature [#212](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/212)
* Add configuration to allow control over suspension and resumption of Examine and document cache events during Deploy operation [#211](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/211)

#### [13.1.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.0) (March 5th 2024)

* Add `IArtifactTypeResolver` to allow custom type resolving when deserializing to `IArtifact` (used by Deploy Contrib, see PR [#60](https://github.com/umbraco/Umbraco.Deploy.Contrib/pull/61))
* Add base migrators for importing legacy artifacts (used by Deploy Contrib)
* Restored ability to overwrite content properties with empty values
* Improved error UX and messaging to only show technical detail option if available
* Require a valid license when importing
* Only validate `ApiKey` and `ApiSecret` when workspaces are configured
* Explicitly register API controller endpoints

#### [13.0.4](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.4) (February 20th 2024)

* Removed the no-longer supported "live edit" feature (Deploy on Cloud only).
* Fixed issue where the removal of a master template couldn't be deployed [#201](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/201)
* Ensured configuration for behavior following a "path too long" exception is respected for handling image cropper values [#200](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/200)
* Added configuration setting to allow hiding of version details on the settings dashboard.
* User experience and message improvements on content flow exception [#202](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/202)
* Fixed issue with transfer of empty values to overwrite non-empty ones.

#### [13.0.3](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.3) (January 16th 2024)

* Added configurable option to avoid overwriting of dictionary items with empty values [#191](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/191)
  * For more details see the page on [Deploy's settings](getting-started/deploy-settings.md).
* Fixed regression issue with transfer of date values.

#### [13.0.2](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.2) (January 9th 2024)

* Fixed issue with transfer of content using language variants [#193](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/193)

#### [13.0.1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.1) (December 21th 2023)

* Fixes the display of the selected schedule date on queue for transfer.
* Fixes parsing property values within Nested Content and Block List that were previously saved by the Contrib value connectors.
* Fixed incorrectly including media files in export when 'Content files' wasn't selected.
* Add maximum file size validation to import file upload.

#### [13.0.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) (December 14th 2023)

* All items from the 13.0.0 RCs and latest 12.2 features.

#### [13.0.0-rc5](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) (December 12th 2023)

* Align with latest CMS RC.

#### [13.0.0-rc4](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) (December 11th 2023)

* Add weight -100 to Deploy package migration (ensuring Deploy database tables are available before other package migrations are executed).
* Add fluent API for Deploy webhooks.

#### [13.0.0-rc3](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) (November 29th 2023)

* Added optional deployment of webhooks as part of schema updates.
* Added Deploy specific webhook events.

#### [13.0.0-rc2](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) (November 15th 2023)

* Exclude automatic relation type aliases (used for reference tracking) from deployment.
* Fix cyclic dependency between configuring `DeploySettings` and `ConnectionStrings`.

#### [13.0.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) (November 6th 2023)

* Compatibility with Umbraco 13:
  * See full details of breaking changes under the [version specific upgrade guide](upgrades/version-specific.md).
  * Update Richtext value connector to handle references in blocks.

## Deploy Contrib

#### [13.3.0](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-13.3.0) (October 3rd 2024)

* Migrate nested/recursive legacy pre-value property values [#71](https://github.com/umbraco/Umbraco.Deploy.Contrib/pull/71)

#### [13.2.0](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-13.2.0) (August 15th 2024)

* All items from 13.2.0-rc1

#### [13.2.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-13.2.0-rc1) (July 19th 2024)

* Skip empty pre-values [#63](https://github.com/umbraco/Umbraco.Deploy.Contrib/pull/63)
* Add Matryoshka Group Separator artifact migrator [#67](https://github.com/umbraco/Umbraco.Deploy.Contrib/pull/67)
* Add migrators to support DocTypeGridEditor to Block Grid migration [#66](https://github.com/umbraco/Umbraco.Deploy.Contrib/pull/66)

#### [13.1.0](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-13.1.0) (March 19th 2024)

* All items from 10.2.0-rc1

#### [13.1.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-13.1.0-rc1) (March 5th 2024)

* Add legacy migrators and type resolver to allow importing from Umbraco 7 in [#61](https://github.com/umbraco/Umbraco.Deploy.Contrib/pull/61)

#### [13.0.0](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-13.0.0) (December 14th 2023)

* Compatibility with Umbraco 13

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-deploy/release-notes.md) and [Umbraco Deploy Package page](https://our.umbraco.com/packages/developer-tools/umbraco-deploy/)
