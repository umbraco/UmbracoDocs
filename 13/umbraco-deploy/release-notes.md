# Release notes

In this section we have summarised the changes to Umbraco Deploy released in each version. Each version is presented with a link to the [Deploy issue tracker](https://github.com/umbraco/Umbraco.Deploy.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version you can find the details about the breaking changes in the [version specific updates](upgrades/version-specific.md) article.
{% endhint %}

We've listed here all changes going back to March 2021 for Deploy 4 and above. For details of releases prior to this date, or older versions, please refer to the [package page on our.umbraco.com](https://our.umbraco.com/packages/developer-tools/umbraco-deploy/).

## Release History

In this section, you can find release notes for each release of Umbraco Deploy.

Under each major version, you can find details about minor and patch releases for the specific major.

<details>

<summary>Version 13</summary>

[**13.0.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.1) **(December 21th 2023)**

* Fixes the display of the selected schedule date on queue for transfer.
* Fixes parsing property values within Nested Content and Block List that were previously saved by the Contrib value connectors.
* Fixed incorrectly including media files in export when 'Content files' wasn't selected.
* Add maximum file size validation to import file upload.

[**13.0.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) **(December 14th 2023)**

* All items from the 13.0.0 RCs and latest 12.2 features.

[**13.0.0-rc5**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) **(December 12th 2023)**

* Align with latest CMS RC.

[**13.0.0-rc4**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) **(December 11th 2023)**

* Add weight -100 to Deploy package migration (ensuring Deploy database tables are available before other package migrations are executed).
* Add fluent API for Deploy webhooks.

[**13.0.0-rc3**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) **(November 29th 2023)**

* Added optional deployment of webhooks as part of schema updates.
* Added Deploy specific webhook events.

[**13.0.0-rc2**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) **(November 15th 2023)**

* Exclude automatic relation type aliases (used for reference tracking) from deployment.
* Fix cyclic dependency between configuring `DeploySettings` and `ConnectionStrings`.

[**13.0.0-rc1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) **(November 6th 2023)**

* Compatibility with Umbraco 13:
  * See full details of breaking changes under the [version specific upgrade guide](upgrades/version-specific.md).
  * Update Richtext value connector to handle references in blocks.

</details>

<details>

<summary>Version 12</summary>

[**12.2.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.2.1) **(December 21th 2023)**

* Fixes the display of the selected schedule date on queue for transfer.
* Fixes parsing property values within Nested Content and Block List that were previously saved by the Contrib value connectors.
* Fixed incorrectly including media files in export when 'Content files' wasn't selected.
* Add maximum file size validation to import file upload.

[**12.1.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.1.0) **(December 11th 2023)**

* All items from 12.1.0-rc1.
* Fixed a regression in 12.1.0-rc1 where content restore/transfers didn't use the same JSON converters when deserializing Deploy artifacts.
* Fixed permissions not being correctly set for administrators on initial install.
* Moved permissions from the Content to a new Deploy category (only affecting the UI).
* Add support for migrating property values within Nested Content, Block List and Block Grid, and include Multi URL Picker value connector (an explicit value connector binding is used to override the ones provided in Deploy Contrib).
* Added new configuration option of `TrashedContentDeploymentOperations` to allow exporting/importing of trashed content, ensuring referenced content in the recycle bin isn't exported by default and otherwise imports back into the recycle bin.
* Changed the default value connector to use the property storage type, instead of using custom value prefixes to store the object type.

[**12.1.0-rc1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.1.0) **(November 27th 2023)**

* Added feature of [content import and export with migrations](./deployment-workflow/import-export.md).
* Added a new configuration option of `ResolveUserInTargetEnvironment` to allow resolving of user accounts in target environments (see [Deploy Settings](./deploy-settings.md)).
* Added a new configuration option of `AllowPublicAccessDeploymentOperations` to amend the behavior of public access rule transfer (see [Deploy Settings](./deploy-settings.md)).
* Improve performance of publishing multi-language content during restore/transfer and import.

[**12.0.5**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.5) (**November 14th 2023**)

* Fixed action menu for queue for transfer with list view [#185](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/185).
* Omitted automatic relations from packages from default relations included in Deploy operations.

[**12.0.4**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.4) **(October 17th 2023)**

* Fixed issue with deployment of content when scheduled for a future release date.
* Prevent dictionary items from being serialized to `.uda` files on disk when configured for transfer as content [#184](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/184).

[**12.0.3**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.3) **(October 10th 2023)**

* Fixed regression issue introduced in 12.0.3 with deployment of properties of content templates [#182](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/182)

[**12.0.2**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.2) **(September 19th 2023)**

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

[**12.0.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.1) **(August 1st 2023)**

* Ensured that schema files are updated on entity container renames [#171](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/171).
* Fixed issue with processing of marker files on Linux [#169](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/169).
* Corrected logic for creating redirects on content deployment for variant content.
* Ensured consistent rendering of trailing zeros when using the rounded decimal converter.
* Reduced some logging to debug to reduce noise in log files.
* Added the settings `IsSaaSHosted`, `HideConfigurationDetails` and `HideLocalEnvironment` for use by Umbraco Heartcore.

[**12.0.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.0)

* Compatibility with Umbraco 12
  * See full details of breaking changes under the [version-specific upgrade guide](upgrades/version-specific.md#version-12).

</details>

<details>

<summary>Version 11</summary>

[**11.1.7**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F11.1.7) (**November 14th 2023**)

* Fixed action menu for queue for transfer with list view [#185](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/185).

[**11.1.6**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F11.1.6) **(October 17th 2023)**

* Fixed issue with deployment of content when scheduled for a future release date.
* Prevent dictionary items from being serialized to `.uda` files on disk when configured for transfer as content [#184](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/184).

[**11.1.5**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F11.1.5) **(October 10th 2023)**

* Fixed regression issue introduced in 11.1.5 with deployment of properties of content templates [#182](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/182)

[**11.1.4**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F11.1.4) **(September 19th 2023)**

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

[**11.1.3**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F11.1.3) **(August 1st 2023)**

* Ensured that schema files are updated on entity container renames [#171](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/171).
* Fixed issue with processing of marker files on Linux [#169](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/169).
* Corrected logic for creating redirects on content deployment for variant content.
* Ensured consistent rendering of trailing zeros when using the rounded decimal converter.
* Reduced some logging to debug to reduce noise in log files.

[**11.1.2**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F11.1.2) **(May 30th 2023)**

* Resolved a low impact security issue found in internal testing when triggering a schema extraction.

[**11.1.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F11.1.1) **(May 23rd 2023)**

* Added configuration for batch package processing and omitting post operation notification handlers.
* Handled use of trailing slash in configured environment URLs.
* Added sort option for the "is up to date" column in the schema comparison [#165](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/165).
* Ensured artifacts serialized to disk are no longer processed when the entity is configured to be transferred as content.
* Handled updates to serialized document types on deletion of data types.

[**11.1.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F11.1.0) **(April 11th 2023)**

* Restricted languages available to editors when deploying variant content to those allowed via the user permissions for languages.
* Tidied up the Deploy dialogs for transfer, compare and restore to align with CMS conventions and remove redundant options.
* Added a database lock to the persistent transfer queue, removing any risk of concurrency issues when adding or removing items from the queue.
* Added support for new form properties introduced in the most recent minor release of Forms 11. [#161](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/161)
* Retained sort order introduced in Umbraco 11 for domains when deploying between environments.

[**11.0.2**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F11.0.2) **(March 21st 2023)**

* Fixed issue with transfer of form workflow's "sensitive data" property. [#159](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/159)
* Fixed issue with datatype not found on cache rebuild [#157](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/157)
* Resolved issue with progress bar initialization on partial restore dialog
* Handled file not found issue when calculating media file checksum using file metadata
* Avoided exception triggered by custom tree implementations that do not expose an alias [#160](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/160)

[**11.0.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.1.2) **(February 14th 2023)**

* Applied multiple updates to improve performance and reduce likelihood of timeouts when transferring or restoring items in bulk [#128](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/128) [#152](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/152) [#148](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/148) [#110](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/110) [#106](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/106)
  * Added a task to set signatures via the backoffice settings dashboard, ensuring these are calculated and cached before a restore is commenced.
  * Provided a configuration option to allow for use of the media file metadata instead of file contents when calculating a checksum.
  * Made a new default behaviour which can be tweaked via configuration, of loading all relations into memory once we know we are processing a lot of artifact signatures, and doing look-ups for the relations for each entity from there.
  * Optimised the retrieval of relations ensuring excluded relation types aren't retrieved and then filtered in memory.
  * Updated the default configuration to exclude the document/media "dependency" relations that were introduced in an earlier minor version of Umbraco 10, and aren't required for including in deployment operations.
  * Added a configuration value to allow skipping of "path too long" exceptions with media files (so the media item will be created, but with no file attached).
  * Providing a custom message in the case of a hosting environment hard timeout with information and links to options for resolution.
* Fixed issue with the Forms add-on that wasn't transferring conditionals on pages or workflows, nor the "contains sensitive data" flag [#158](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/158) [#154](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/154)
* Fixed display of _IgnoreBrokenDependencies_ setting in the management dashboard (10+) [#151](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/151)
* Ensured schema files are not generated for member groups when configured to not export them [#150](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/150)
* Fixed display child nodes indicator for tree picker used for selecting items in the remote environment [#146](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/146)
* Added additional logging to indicate which item and pass causes a processing failure if and when one occurs [#144](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/144)
* Tidied up initialization markers [#102](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/102)

#### [11.0.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F11.0.0)

* Compatibility with .NET 7 Umbraco 11
  * See full details of breaking changes under the [version specific upgrade guide](upgrades/version-specific.md).

</details>

<details>

<summary>Version 10</summary>

[**10.3.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.3.1) **(December 21th 2023)**

* Fixes the display of the selected schedule date on queue for transfer.
* Fixes parsing property values within Nested Content and Block List that were previously saved by the Contrib value connectors.
* Fixed incorrectly including media files in export when 'Content files' wasn't selected.
* Add maximum file size validation to import file upload.

[**10.3.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.3.0) **(December 11th 2023)**

* All items from 10.3.0-rc1.
* Fixed a regression in 10.3.0-rc1 where content restore/transfers didn't use the same JSON converters when deserializing Deploy artifacts.
* Fixed permissions not being correctly set for administrators on initial install.
* Moved permissions from the Content to a new Deploy category (only affecting the UI).
* Add support for migrating property values within Nested Content, Block List and Block Grid, and include Multi URL Picker value connector (an explicit value connector binding is used to override the ones provided in Deploy Contrib).
* Added new configuration option of `TrashedContentDeploymentOperations` to allow exporting/importing of trashed content, ensuring referenced content in the recycle bin isn't exported by default and otherwise imports back into the recycle bin.
* Changed the default value connector to use the property storage type, instead of using custom value prefixes to store the object type.

[**10.3.0-rc1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.3.0) **(November 27th 2023)**

* Added feature of [content import and export with migrations](./deployment-workflow/import-export.md).
* Added a new configuration option of `ResolveUserInTargetEnvironment` to allow resolving of user accounts in target environments (see [Deploy Settings](./deploy-settings.md)).
* Added a new configuration option of `AllowPublicAccessDeploymentOperations` to amend the behavior of public access rule transfer (see [Deploy Settings](./deploy-settings.md)).
* Improve performance of publishing multi-language content during restore/transfer and import.

[**10.2.7**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.2.7) (**November 14th 2023**)

* Fixed action menu for queue for transfer with list view [#185](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/185).

[**10.2.6**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.2.6) **(October 17th 2023)**

* Fixed issue with deployment of content when scheduled for a future release date.
* Prevent dictionary items from being serialized to `.uda` files on disk when configured for transfer as content [#184](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/184).

[**10.2.5**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.2.5) **(October 10th 2023)**

* Fixed regression issue introduced in 10.2.4 with deployment of properties of content templates [#182](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/182)

[**10.2.4**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.2.4) **(September 19th 2023)**

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

[**10.2.3**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.2.3) **(August 1st 2023)**

* Ensured that schema files are updated on entity container renames [#171](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/171).
* Fixed issue with processing of marker files on Linux [#169](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/169).
* Corrected logic for creating redirects on content deployment for variant content.
* Ensured consistent rendering of trailing zeros when using the rounded decimal converter.
* Reduced some logging to debug to reduce noise in log files.

[**10.2.2**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.2.2) **(May 30th 2023)**

* Resolved a low impact security issue found in internal testing when triggering a schema extraction.

[**10.2.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.2.1) **(May 23rd 2023)**

* Added configuration for batch package processing and omitting post operation notification handlers.
* Handled use of trailing slash in configured environment URLs.
* Added sort option for the "is up to date" column in the schema comparison [#165](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/165).
* Ensured artifacts serialized to disk are no longer processed when the entity is configured to be transferred as content.
* Handled updates to serialized document types on deletion of data types.

[**10.2.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.2.0) **(April 11th 2023)**

* Restricted languages available to editors when deploying variant content to those allowed via the user permissions for languages.
* Tidied up the Deploy dialogs for transfer, compare and restore to align with CMS conventions and remove redundant options.
* Added a database lock to the persistent transfer queue, removing any risk of concurrency issues when adding or removing items from the queue.
* Added support for new form properties introduced in the most recent minor release of Forms 11. [#161](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/161)

[**10.1.4**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.1.4) **(March 21st 2023)**

* Fixed issue with transfer of form workflow's "sensitive data" property. [#159](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/159)
* Fixed issue with datatype not found on cache rebuild [#157](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/157)
* Resolved issue with progress bar initialization on partial restore dialog
* Handled file not found issue when calculating media file checksum using file metadata
* Avoided exception triggered by custom tree implementations that do not expose an alias [#160](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/160)

[**10.1.2**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.1.2) **(November 15th 2022)**

* Added batch settings option providing resolution to large content or media transfers hitting Azure service limit [#128](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/128)

[**10.1.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.1.1) **(October 18th 2022)**

* Resolved issue with media restore when database items exist and files don't (backport fix to V4) [#123](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/123)
* Fixed issue with use of HTTP timeout setting (V9+)

[**10.1.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.1.0) **(September 7th 2022)**

* Introduced and used caching in deploy operations to improve performance.
* Increased default and added setting for disk operation timeouts [#135](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/135)
* Single language content transfers [#132](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/132)
* Scheduled content transfers.
* Corrected transfer of unpublished content status [#131](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/131)
* Improved UX and descriptions in backoffice settings dashboard [#118](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/118)
* Added ability to download Deploy artifacts (.uda files) as a zip archive from the management dashboard.
* Added sort options to the schema comparison view in the management dashboard [#115](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/115)
* Indented the JSON representation of Data Type configuration details in the .uda files for ease of review [#85](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/85)
* Fixed issue with transfer of Forms prevalue sources from text files that include captions.
* Ensured Document Type validation messages are transferred between environments [#137](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/137)
* Fixed issue with scheduled publish date being time shifted on deployments when source and target servers are running in different timezones.
* Fixed issue with transfer for members of a given type (V10 only) [#139](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/139)

[**10.0.3**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.3) **(August 16th 2022)**

* Aligned Git URL displayed in backoffice with that in Cloud Portal (V4 only) [#136](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/136)
* Fixed issue with deployment of root node value for Umbraco Forms's "save as Umbraco node" workflow [#133](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/133)
* Fixed incorrect availability of workspace restore in production environment (V9 and V10 only)
* Added close button to "Transfer now" dialog
* Resolved registration of deployable types to support configuration for "backoffice edition".

[**10.0.2**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.2) **(July 12th 2022)**

* Resolved issue with media restore when database items exist and files don't [#123](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/123)
* Added details of failed deployment to deploy dashboard [#120](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/120)
* Added copy button for deploy log in the backoffice [#121](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/121)
* Fixed typo in UI [#113](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/113)
* Ensured signature refresh on Data Type move into or out of folder [#125](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/125)
* Fixed selection of workspace for compare dialog
* Optimized existence checks in connectors
* Restore missing partial restore option in content and media tree roots (V9+)
* Fixed extract trigger URL in PowerShell script distributed with Deploy On-Premise (V9+)
* Improved deserialization of exceptions for clearer reporting (V9+)

[**10.0.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.1) **(June 29th 2022)**

* Fixed issue with deployment of content using variant properties [#126](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/126)

[**10.0.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.0) **(June 16th 2022)**

* Compatibility with .NET 6 and Umbraco 10

</details>

<details>

<summary>Version 9</summary>

[**9.6.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.6.0) **(April 11th 2023)**

* Tidied up the Deploy dialogs for transfer, compare and restore to align with CMS conventions and remove redundant options.
* Added a database lock to the persistent transfer queue, removing any risk of concurrency issues when adding or removing items from the queue.

[**9.5.4**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.5.4) **(March 21st 2023)**

* Fixed issue with transfer of form workflow's "sensitive data" property. [#159](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/159)
* Fixed issue with datatype not found on cache rebuild [#157](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/157)
* Resolved issue with progress bar initialization on partial restore dialog
* Handled file not found issue when calculating media file checksum using file metadata

[**9.5.3**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.5.3) **(February 14th 2023)**

* Applied updates to improve performance and reduce likelihood of timeouts when transferring or restoring items in bulk [#128](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/128) [#152](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/152) [#148](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/148) [#110](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/110) [#106](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/106)
  * Added a task to set signatures via the backoffice settings dashboard, ensuring these are calculated and cached before a restore is commenced.
  * Provided a configuration option to allow for use of the media file metadata instead of file contents when calculating a checksum.
  * Made a new default behaviour which can be tweaked via configuration, of loading all relations into memory once we know we are processing a lot of artifact signatures, and doing look-ups for the relations for each entity from there.
  * Optimised the retrieval of relations ensuring excluded relation types aren't retrieved and then filtered in memory.
  * Updated the default configuration to exclude the document/media "dependency" relations that were introduced in an earlier minor version of Umbraco 10, and aren't required for including in deployment operations.
  * Added a configuration value to allow skipping of "path too long" exceptions with media files (so the media item will be created, but with no file attached).
  * Providing a custom message in the case of a hosting environment hard timeout with information and links to options for resolution.
* Fixed issue with the Forms add-on that wasn't transferring conditionals on pages or workflows, nor the "contains sensitive data" flag [#158](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/158) [#154](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/154)
* Fixed display of _IgnoreBrokenDependencies_ setting in the management dashboard (10+) [#151](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/151)
* Ensured schema files are not generated for member groups when configured to not export them [#150](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/150)
* Fixed display child nodes indicator for tree picker used for selecting items in the remote environment [#146](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/146)
* Added additional logging to indicate which item and pass causes a processing failure if and when one occurs [#144](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/144)
* Tidied up initialization markers [#102](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/102)

[**9.5.2**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.5.2) **(November 15th 2022)**

* Added batch settings option providing resolution to large content or media transfers hitting Azure service limit [#128](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/128)

[**9.5.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.5.1) **(October 18th 2022)**

* Resolved issue with media restore when database items exist and files don't (backport fix to V4) [#123](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/123)
* Fixed issue with use of HTTP timeout setting (V9+)

[**9.5.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.5.0) **(September 7th 2022)**

* Introduced and used caching in deploy operations to improve performance.
* Increased default and added setting for disk operation timeouts [#135](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/135)
* Single language content transfers [#132](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/132)
* Scheduled content transfers.
* Corrected transfer of unpublished content status [#131](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/131)
* Improved UX and descriptions in backoffice settings dashboard [#118](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/118)
* Added ability to download Deploy artifacts (.uda files) as a zip archive from the management dashboard.
* Added sort options to the schema comparison view in the management dashboard [#115](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/115)
* Indented the JSON representation of Data Type configuration details in the .uda files for ease of review [#85](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/85)
* Fixed issue with transfer of Forms prevalue sources from text files that include captions.
* Ensured Document Type validation messages are transferred between environments [#137](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/137)
* Fixed issue with scheduled publish date being time shifted on deployments when source and target servers are running in different timezones.
* Fixed issue with transfer for members of a given type (V10 only) [#139](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/139)

[**9.4.2**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.4.2) **(August 16th 2022)**

* Aligned Git URL displayed in backoffice with that in Cloud Portal (V4 only) [#136](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/136)
* Fixed issue with deployment of root node value for Umbraco Forms's "save as Umbraco node" workflow [#133](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/133)
* Fixed incorrect availability of workspace restore in production environment (V9 and V10 only)
* Added close button to "Transfer now" dialog
* Resolved registration of deployable types to support configuration for "backoffice edition".

[**9.4.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.4.1) **(July 12th 2022)**

* Resolved issue with media restore when database items exist and files don't [#123](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/123)
* Added details of failed deployment to deploy dashboard [#120](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/120)
* Added copy button for deploy log in the backoffice [#121](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/121)
* Fixed typo in UI [#113](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/113)
* Ensured signature refresh on Data Type move into or out of folder [#125](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/125)
* Fixed selection of workspace for compare dialog
* Optimized existence checks in connectors
* Restore missing partial restore option in content and media tree roots (V9+)
* Fixed extract trigger URL in PowerShell script distributed with Deploy On-Premise (V9+)
* Improved deserialization of exceptions for clearer reporting (V9+)

[**9.4.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.4.0) **(April 12th 2022)**

* Enhancements to content comparison dialog [#101](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/101)
* Partial restore for Forms and third-party plugins [#100](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/100)
* Display of configuration information and schema comparison on the deploy "settings" dashboard.
* Deployment of culture & hostname details [#107](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/107)
* Optional, automated clear of memory cache
* Resolved issue with empty value deployment of content based on the tags property editor [#104](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/104)
* Resolved issue with redirect functionality when records are deployed between environments (part of CMS [#10066](https://github.com/umbraco/Umbraco-CMS/issues/10066))
* Surfaced information about configuration for the ignore of broken dependencies in the dialog that presents the error information
* Fixed a CSS rendering issue for the deploy content dashboard's workspace display, when more than four environments are available.
* Fixed issue with deployment of empty tags data [#104](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/104)
* Retained compact JSON formatting when transferring grid values

[**9.3.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.3.1) **(March 22nd 2022)\*\***

* Adds support for deploying new relation type property introduced in CMS 9.4
* Fixes layout issue on workspaces dashboard when more than 4 environments are configured.

[**9.3.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.3.0) **(February 15th 2022)**

* Content comparison dialog [#65](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/65)
* Backoffice deployment of members and member groups.
* Fixed bug with deployments of templates involving alias renames

[**9.2.3**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.2.3) **(February 15th 2022)**

* Fixed content transfer issue when public access login and error pages are created below the protected page [#99](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/99)
* Fixed issue with clashing permission letter for "queue for transfer" menu option (V4 only) [#95](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/95)

[**9.2.2**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.2.2) **(January 25th 2022)**

* Fixed ambiguous match exception when deploying forms (V4 only) [#97](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/97)
* Fixed issue with "live edit" component and scheduled publishing (V9 only) [#98](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/98)
* Amends to timing of file operation initialization to ensure third party components complete setup (V9 only).
* Added .NET 6 version of environment variable syntax for Umbraco Cloud configuration settings.

[**9.2.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.2.1) **(January 11th 2022)**

* Fixed issue with clashing permission letter for "queue for transfer" menu option [#95](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/95)
* Fixed link to open project in Cloud portal [#94](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/94)

[**9.2.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.2.0) **(December 7th 2021)**

* Fixed issue relating to deployment of image alt text within the rich text editor. [#87](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/87)
* Added support for deployment of history clean-up settings on Document Types.
* Fixes display of git clone URL in the backoffice dashboard. [#88](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/88)
* Updates connection string initialization to earlier in the pipeline to ensure it's available for external component configuration.
* Fixed casing of Deploy folder in App\Plugins referenced from the custom "no nodes" page.

[**9.0.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.0.1) **(October 12th 2021)**

* Removed import Document Type option [#73](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/73)
* Resolved globalization discrepancy leading to schema mismatch reports [#72](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/72)
* Set appropriate environment defaults for package migration schema and content installation [#74](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/74) [#75](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/75)

**9.0.0 (September 27th 2021)**

* V9 release on .NET 5 compatible with CMS V9.

</details>

<details>

<summary>Version 4</summary>

[**4.9.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.9.1) **(December 21th  2023)**

* Fixes the display of the selected schedule date on queue for transfer.
* Fixes parsing property values within Nested Content and Block List that were previously saved by the Contrib value connectors.
* Fixed incorrectly including media files in export when 'Content files' wasn't selected.
* Add maximum file size validation to import file upload.

[**4.9.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.9.0) **(December 11th  2023)**

* All items from 4.9.0-rc1.
* Fixed a regression in 4.9.0-rc1 where content restore/transfers didn't use the same JSON converters when deserializing Deploy artifacts.
* Fixed permissions not being correctly set for administrators on initial install.
* Moved permissions from the Content to a new Deploy category (only affecting the UI).
* Add support for migrating property values within Nested Content and Block List, and include Multi URL Picker value connector (an explicit value connector binding is used to override the ones provided in Deploy Contrib).
* Added new configuration option of `TrashedContentDeploymentOperations` to allow exporting/importing of trashed content, ensuring referenced content in the recycle bin isn't exported by default and otherwise imports back into the recycle bin.
* Changed the default value connector to use the property storage type, instead of using custom value prefixes to store the object type.

[**4.9.0-rc1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.9.0) **(November 27th 2023)**

* Added feature of [content import and export with migrations](./deployment-workflow/import-export.md).
* Added a new configuration option of `ResolveUserInTargetEnvironment` to allow resolving of user accounts in target environments (see [Deploy Settings](./deploy-settings.md)).
* Added a new configuration option of `AllowPublicAccessDeploymentOperations` to amend the behavior of public access rule transfer (see [Deploy Settings](./deploy-settings.md)).

[**4.8.4**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.8.4) **(October 10th 2023)**

* Fixed regression issue introduced in 4.8.3 with deployment of properties of content templates [#182](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/182)

[**4.8.3**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.8.3) **(September 19th 2023)**

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

[**4.8.2**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.8.2) **(August 1st 2023)**

* Corrected logic for creating redirects on content deployment for variant content.
* Ensured consistent rendering of trailing zeros when using the rounded decimal converter.
* Reduced some logging to debug to reduce noise in log files.

[**4.8.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.8.1) **(May 23rd 2023)**

* Added configuration for batch package processing and omitting post operation notification handlers.
* Handled use of trailing slash in configured environment URLs.
* Added sort option for the "is up to date" column in the schema comparison [#165](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/165).
* Ensured artifacts serialized to disk are no longer processed when the entity is configured to be transferred as content.
* Handled updates to serialized document types on deletion of data types.

[**4.8.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.8.0) **(April 11th 2023)**

* Tidied up the Deploy dialogs for transfer, compare and restore to align with CMS conventions and remove redundant options.
* Added a database lock to the persistent transfer queue, removing any risk of concurrency issues when adding or removing items from the queue.

[**4.7.4**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.7.4) **(March 21st 2023)**

* Fixed issue with datatype not found on cache rebuild [#157](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/157)

[**4.7.3**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.7.3) **(February 21st 2023)**

* All items listed under the 9.5.3, 10.1.3 and 11.0.1 releases (other than those indicated as only applying to higher versions).

[**4.7.2**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.7.2) **(November 15th 2022)**

* Added batch settings option providing resolution to large content or media transfers hitting Azure service limit [#128](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/128)

[**4.7.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.7.1) **(October 18th 2022)**

* Resolved issue with media restore when database items exist and files don't (backport fix to V4) [#123](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/123)
* Fixed issue with use of HTTP timeout setting (V9+)

[**4.7.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.7.0) **(September 22nd 2022)**

* Fixed issue with scheduled publish date being time shifted on deployments when source and target servers are running in different timezones.
* Fixed issue with transfer for members of a given type (V10 only) [#139](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/139)
* Introduced and used caching in deploy operations to improve performance.
* Increased default and added setting for disk operation timeouts [#135](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/135)
* Single language content transfers [#132](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/132)
* Scheduled content transfers.
* Corrected transfer of unpublished content status [#131](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/131)
* Improved UX and descriptions in backoffice settings dashboard [#118](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/118)
* Added ability to download Deploy artifacts (.uda files) as a zip archive from the management dashboard.
* Added sort options to the schema comparison view in the management dashboard [#115](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/115)
* Indented the JSON representation of Data Type configuration details in the .uda files for ease of review [#85](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/85)
* Fixed issue with transfer of Forms prevalue sources from text files that include captions.
* Ensured Document Type validation messages are transferred between environments [#137](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/137)

[**4.6.2**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.6.2) **(August 16th 2022)**

* Aligned Git URL displayed in backoffice with that in Cloud Portal (V4 only) [#136](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/136)
* Fixed issue with deployment of root node value for Umbraco Forms's "save as Umbraco node" workflow [#133](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/133)
* Fixed incorrect availability of workspace restore in production environment (V9 and V10 only)
* Added close button to "Transfer now" dialog
* Resolved registration of deployable types to support configuration for "backoffice edition".

[**4.6.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.6.1) **(July 12th 2022)**

* Resolved issue with media restore when database items exist and files don't [#123](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/123)
* Added details of failed deployment to deploy dashboard [#120](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/120)
* Added copy button for deploy log in the backoffice [#121](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/121)
* Fixed typo in UI [#113](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/113)
* Ensured signature refresh on Data Type move into or out of folder [#125](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/125)
* Fixed selection of workspace for compare dialog
* Optimized existence checks in connectors
* Restore missing partial restore option in content and media tree roots (V9+)
* Fixed extract trigger URL in PowerShell script distributed with Deploy On-Premise (V9+)
* Improved deserialization of exceptions for clearer reporting (V9+)

[**4.6.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.6.0) **(April 26th 2022)**

* Retained compact JSON formatting when transferring grid values
* Enhancements to content comparison dialog [#101](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/101)
* Partial restore for Forms and third-party plugins [#100](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/100)
* Display of configuration information and schema comparison on the deploy "settings" dashboard.
* Deployment of culture & hostname details [#107](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/107)
* Optional, automated clear of memory cache
* Resolved issue with empty value deployment of content based on the tags property editor [#104](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/104)
* Resolved issue with redirect functionality when records are deployed between environments (part of CMS [#10066](https://github.com/umbraco/Umbraco-CMS/issues/10066))
* Surfaced information about configuration for the ignore of broken dependencies in the dialog that presents the error information
* Fixed a CSS rendering issue for the deploy content dashboard's workspace display, when more than four environments are available.
* Fixed issue with deployment of empty tags data [#104](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/104)

[**4.5.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.5.0) **(February 15th 2022)**

* Content comparison dialog [#65](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/65)
* Backoffice deployment of members and member groups.
* Added support for deployment of history clean-up settings on Document Types (V4 only)
* Fixed bug with deployments of templates involving alias renames

[**4.4.4**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.4.4) **(February 15th 2022)**

* Fixed content transfer issue when public access login and error pages are created below the protected page [#99](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/99)
* Fixed issue with clashing permission letter for "queue for transfer" menu option (V4 only) [#95](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/95)

[**4.4.3**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.4.3) **(January 25th 2022)**

* Fixed ambiguous match exception when deploying forms (V4 only) [#97](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/97)
* Fixed issue with "live edit" component and scheduled publishing (V9 only) [#98](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/98)
* Amends to timing of file operation initialization to ensure third party components complete setup (V9 only).
* Added .NET 6 version of environment variable syntax for Umbraco Cloud configuration settings.

[**4.4.2**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.4.2) **(December 21st 2021)**

* Fixed issue with extractions triggered from uda files generated from older versions without property group aliases. [#92](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/92)
* Fixed timing issue for initiation of reading of file system triggers impacting third party Deploy integrations. [#91](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/91)

[**4.4.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.4.1) **(December 7th 2021)**

* Fixed issue relating to deployment of image alt text within the rich text editor. [#87](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/87)

[**4.4.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.4.0) **(November 2nd 2021)**

* Separate operations for "tree" and "workspace" restore [#66](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/66)
* Finer configuration options for ignoring broken dependencies [#81](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/81)
* Removed the redundant and misleading deploy operations available on the form "entries" menu item. [#83](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/83)
* Fixed issue with operations involving Form prevalue sources using XPath. [#69​](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/69)
* Fixed issue with restore options when Forms 8.8 is used with form definitions stored on disk. [#76](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/76)
* Improved reliability of extractions triggered from Umbraco Cloud git deployment operations by introducing a new marker file used only on start-up.
* Improved reliability of extractions on new Cloud infrastructure by wrapping and throttling the file system watcher events.
* Fixed issues with styling and scripts on the custom “no content” page displayed when Deploy is used.
* Fixed issue with language deployment when fallbacks are configured.
* Improved the error reporting when authorization fails between environments (V9 only). [#77](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/77)
* Fixed issue with restore of empty tab alias [#84](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/84)

[**4.3.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.3.0) **(October 7th 2021)**

* Added support for deployment of CMS tabs and groups
* Fixed issue with JSON detection causing issues using square brackets in grid content [#70](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/70)

[**4.2.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.2.0+) **(August 19th 2021)**

* Added support for deployment of form folders [#75 (Forms)](https://github.com/umbraco/Umbraco.Forms.Issues/issues/75)
* Added support for backoffice transfer of data from custom packages or solutions
* Provided option for deploying dictionary items "as content" [#17](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/17) [#56](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/56)
* List multiple dependency errors when deploying or restoring [#5](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/5)
* Add additional detail about deployment errors into logs [#40](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/40)
* Alter structure of .uda files to put name and alias at the top [#50](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/50)
* Fixed issue with removal of used macro parameter when restoring [#53](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/53)
* Add deep-link to deploy dashboard from transfer queue, so will be shown on click from "open transfer queue" (if CMS version supports deep dashboard links) [#57](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/57)
* Added value connector for new media picker [#58](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/58)
* Added refresh button to queue [#61](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/61)
* Fixed issue with changing casing of template aliases [#63](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/63)
* Added clear signature operation for minor updates of Deploy or CMS
* Fixed issue with forms deployment where workflows are deleted via code.
* Fixed issue with deploying Form prevalues with Forms versions < 8.5 [#23](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/23)

**4.1.4 (September 7th 2021)**

* Resolution of issue with failed extractions on vNext infrastructure.

**4.1.3 (August 3rd 2021)**

* Resolution of issue with failed extractions on vNext infrastructure.

[**4.1.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.1.1+) **(April 27th 2021)**

* Added serialization converter for control of number of decimal places - #465 (internal)
* Resolved issue with deployment of content schedule - #445 (internal) and [#31](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/31)
* Resolved issue with unnecessary empty records being created in destination database - #444 (internal)
* Resolved issue with transfer of content templates when variants are enabled - #385 (internal)
* Resolved issues with content restore progress not updating when custom dashboards are installed - [#39](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/39) and [#47](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/47)
* Resolved issue with deployment of changes to default language - [#32](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/32)
* Resolved issue with deployment of empty values not replacing previously entered content - [#1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/1)
* Removed "transfer now" button from users that don't have permission to "queue for transfer" - [#25](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/25)
* Added deployment of member only property type properties (e.g. "view on profile") - [#21](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/21)
* Cleared pre-values cache on form deployments - [#43](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/43)
* Ensured datatype move action triggered serialization and allows deployment to target environment - [#10](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/10)
* Resolve UI issue where dialog closes if not accurate on selecting node from target environment for restore - [#4](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/4)

**4.1.0 (March 25th 2021)**

* Management dashboard for triggering and viewing status of deployment operations
* Release of Deploy On-Premises

**4.0.1 (March 23rd 2021)**

* Enabling Deploy 4 to work in new Cloud infrastructure

</details>

<details>

<summary>Version 2</summary>

[**2.1.6**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F4.4.2) **(January 11th 2022)**

* Improved reliability of extractions triggered from Umbraco Cloud git deployment operations by introducing a new marker file used only on start-up (back-port from 4.4.0).

[**2.1.5**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F2.1.5) **(December 7th 2021)**

* Fixed issue relating to deployment of Data Types with prevalues on Umbraco 7. [#20](https://github.com/umbraco/Umbraco.Cloud.Issues/issues/20) [#45](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/45) [#89](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/89)

**2.1.4**

* Resolution of issue with failed extractions on vNext infrastructure.

**2.0.18 + 2.1.3 (July 6th 2021)**

* Updating Cloud vNext related configuration

</details>

## [Deploy Contrib](https://github.com/umbraco/Umbraco.Deploy.Contrib)

{% hint style="info" %}
Deploy Contrib contains community contributions for Umbraco Deploy targetted for version 8 and above.

It offers connectors for the most popular Umbraco community packages. These are used by Deploy to aid with the deployment and transferring of content/property-data between environments.
{% endhint %}

### Deploy Contrib 11.0.1 (February 14th 2023)

* Block grid editor support and fix for null reference exception (10+)
* Further caching for deploy operations.

### Deploy Contrib 10.1.1 (February 14th 2023)

* Block grid editor support and fix for null reference exception (10+)
* Further caching for deploy operations.

### Deploy Contrib 9.1.1 (February 14th 2023)

* Block grid editor support and fix for null reference exception (10+)
* Further caching for deploy operations.

### Deploy Contrib 4.2.0, 9.1.0 and 10.1.0 (September 7th 2022)

* Used caching in value connectors to improve performance.
* Fixed issue with transfer of nested content string values using item templates (for example commencing with "\{{") that were erroneously considered as JSON.

### Deploy Contrib 4.1.2, 9.0.2, 10.0.1 (July 12th 2022)

* Optimized existence checks in connectors

### Deploy Contrib 4.1.1 (April 26th 2022)

* Fixes issue with deployment of nested content properties within Document Type grid editor values. [#82](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/82)

### Deploy Contrib 4.2.1 (February 21st 2023)

* All items listed under the 9.1.1, 10.1.1 and 11.0.1 releases (other than those indicated as only applying to higher versions).
