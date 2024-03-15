---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco Deploy.
---

# Release notes

In this section we have summarised the changes to Umbraco Deploy and [Deploy Contrib](https://github.com/umbraco/Umbraco.Deploy.Contrib) released in each version. Each version is presented with a link to the [Deploy issue tracker](https://github.com/umbraco/Umbraco.Deploy.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version you can find the details about the breaking changes in the [version specific updates](upgrades/version-specific.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Deploy 12 including all changes for this version.

#### [12.2.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.2.0) (March 19th 2024)

* All items from 12.2.0-rc1
* Fixed issue with transfer of date values within Nested Content, Block List or Block Grid properties [#209](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/209)
* Fixed issue where templates could incorrectly cause schema mismatch errors when running in production mode [#187](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/187)
* Fixed issue where importing invalid variant property data would cause a not supported variation exception [#8](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/8)
* Fixed deserialization issue causing problems with the compare content feature [#212](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/212)
* Added migrator to support changes in Form field prevalues when importing from older Umbraco versions

#### [12.2.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.2.0) (March 5th 2024)

* Add `IArtifactTypeResolver` to allow custom type resolving when deserializing to `IArtifact` (used by Deploy Contrib, see PR [#60](https://github.com/umbraco/Umbraco.Deploy.Contrib/pull/61))
* Add base migrators for importing legacy artifacts (used by Deploy Contrib)
* Restored ability to overwrite content properties with empty values
* Improved error UX and messaging to only show technical detail option if available
* Require a valid license when importing
* Only validate `ApiKey` and `ApiSecret` when workspaces are configured

#### [12.1.4](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.1.4) (February 20th 2024)

* Removed the no-longer supported "live edit" feature (Deploy on Cloud only).
* Fixed issue where the removal of a master template couldn't be deployed [#201](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/201)
* Ensured configuration for behavior following a "path too long" exception is respected for handling image cropper values [#200](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/200)
* User experience and message improvements on content flow exception [#202](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/202)
* Fixed issue with transfer of empty values to overwrite non-empty ones.

#### [12.1.3](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.1.3) (January 16th 2024)

* Added configurable option to avoid overwriting of dictionary items with empty values [#191](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/191)
    * For more details see the page on [Deploy's settings](./getting-started/deploy-settings.md).
* Fixed regression issue with transfer of date values.

#### [12.1.2](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.1.2) (January 9th 2024)

* Fixed issue with transfer of content using language variants [#193](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/193)

#### [12.1.1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.1.1) (December 21th 2023)

* Fixes the display of the selected schedule date on queue for transfer.
* Fixes parsing property values within Nested Content and Block List that were previously saved by the Contrib value connectors.
* Fixed incorrectly including media files in export when 'Content files' wasn't selected.
* Add maximum file size validation to import file upload.

#### [12.1.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.1.0) (December 11th 2023)

* All items from 12.1.0-rc1.
* Fixed a regression in 12.1.0-rc1 where content restore/transfers didn't use the same JSON converters when deserializing Deploy artifacts.
* Fixed permissions not being correctly set for administrators on initial install.
* Moved permissions from the Content to a new Deploy category (only affecting the UI).
* Add support for migrating property values within Nested Content, Block List and Block Grid, and include Multi URL Picker value connector (an explicit value connector binding is used to override the ones provided in Deploy Contrib).
* Added new configuration option of `TrashedContentDeploymentOperations` to allow exporting/importing of trashed content, ensuring referenced content in the recycle bin isn't exported by default and otherwise imports back into the recycle bin.
* Changed the default value connector to use the property storage type, instead of using custom value prefixes to store the object type.

#### [12.1.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.1.0) (November 27th 2023)

* Added feature of [content import and export with migrations](deployment-workflow/import-export.md).
* Added a new configuration option of `ResolveUserInTargetEnvironment` to allow resolving of user accounts in target environments (see [Deploy Settings](getting-started/deploy-settings.md)).
* Added a new configuration option of `AllowPublicAccessDeploymentOperations` to amend the behavior of public access rule transfer (see [Deploy Settings](getting-started/deploy-settings.md)).
* Improve performance of publishing multi-language content during restore/transfer and import.

#### [12.0.5](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.5) (November 14th 2023)

* Fixed action menu for queue for transfer with list view [#185](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/185).
* Omitted automatic relations from packages from default relations included in Deploy operations.

#### [12.0.4](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.4) (October 17th 2023)

* Fixed issue with deployment of content when scheduled for a future release date.
* Prevent dictionary items from being serialized to `.uda` files on disk when configured for transfer as content [#184](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/184).

#### [12.0.3](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.3) (October 10th 2023)

* Fixed regression issue introduced in 12.0.3 with deployment of properties of content templates [#182](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/182)

#### [12.0.2](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.2) (September 19th 2023)

* Updated the transfer of user picker values to resolve the user by username in the target environment [#180](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/180)
* Also updated the logic for the member picker to ensure values representing members that don't exist in the target environment are cleared.
* Added configuration option to ignore missing languages when deploying translation items [#176](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/176)
* Ensured consistent sort of translations within dictionary items `.uda` files [#175](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/175)
* Ensured that alt text for images placed in grid cells are transferred [#174](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/174)
* Further fix to logic for creating redirects on content deployment for variant content [#170](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/170)
* Resolves issue with grid media items in a batched deployment operation.
* Increased size of database fields storing references to account for longer values used in package data [Commerce #428](https://github.com/umbraco/Umbraco.Commerce.Issues/discussions/428)
* Include published name in content transfer data to avoid overwriting with draft name if different.
* Optimized content transfers to include only draft and published versions when they exist.
* Fixed issue with partial restore of forms [#178](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/178)
* Updated to version 12.0.1 of `Umbraco.Licenses` used for Umbraco Deploy On-Premise.

#### [12.0.1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.1) (August 1st 2023)

* Ensured that schema files are updated on entity container renames [#171](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/171).
* Fixed issue with processing of marker files on Linux [#169](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/169).
* Corrected logic for creating redirects on content deployment for variant content.
* Ensured consistent rendering of trailing zeros when using the rounded decimal converter.
* Reduced some logging to debug to reduce noise in log files.
* Added the settings `IsSaaSHosted`, `HideConfigurationDetails` and `HideLocalEnvironment` for use by Umbraco Heartcore.

#### [12.0.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.0) (May 29th 2023)

* Compatibility with Umbraco 12
  * See full details of breaking changes under the [version-specific upgrade guide](upgrades/version-specific.md#version-12).

## Deploy Contrib

#### [12.1.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-12.1.0-rc1) (March 5th 2024)

* Add legacy migrators and type resolver to allow importing from Umbraco 7 in [#61](https://github.com/umbraco/Umbraco.Deploy.Contrib/pull/61)

#### [12.0.0](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-12.0.0) (May 29th 2023)

* Compatibility with Umbraco 12

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on Github](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-deploy/release-notes.md) and [Umbraco Deploy Package page.](https://our.umbraco.com/packages/developer-tools/umbraco-deploy/)
