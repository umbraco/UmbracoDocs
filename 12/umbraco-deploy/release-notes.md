# Release notes

In this section we have summarised the changes to Umbraco Deploy released in each version. Each version is presented with a link to the [Deploy issue tracker](https://github.com/umbraco/Umbraco.Deploy.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version you can find the details about the breaking changes in the [version specific updates](upgrades/version-specific.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Deploy 12 including all changes for this version.

#### [**12.2.2**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.2.2) **(January 9th 2023)**

* Fixed issue with transfer of content using language variants [#193](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/193)

#### [**12.2.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.2.1) **(December 21th 2023)**

* Fixes the display of the selected schedule date on queue for transfer.
* Fixes parsing property values within Nested Content and Block List that were previously saved by the Contrib value connectors.
* Fixed incorrectly including media files in export when 'Content files' wasn't selected.
* Add maximum file size validation to import file upload.

#### [**12.1.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.1.0) **(December 11th 2023)**

* All items from 12.1.0-rc1.
* Fixed a regression in 12.1.0-rc1 where content restore/transfers didn't use the same JSON converters when deserializing Deploy artifacts.
* Fixed permissions not being correctly set for administrators on initial install.
* Moved permissions from the Content to a new Deploy category (only affecting the UI).
* Add support for migrating property values within Nested Content, Block List and Block Grid, and include Multi URL Picker value connector (an explicit value connector binding is used to override the ones provided in Deploy Contrib).
* Added new configuration option of `TrashedContentDeploymentOperations` to allow exporting/importing of trashed content, ensuring referenced content in the recycle bin isn't exported by default and otherwise imports back into the recycle bin.
* Changed the default value connector to use the property storage type, instead of using custom value prefixes to store the object type.

#### [**12.1.0-rc1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.1.0) **(November 27th 2023)**

* Added feature of [content import and export with migrations](deployment-workflow/import-export.md).
* Added a new configuration option of `ResolveUserInTargetEnvironment` to allow resolving of user accounts in target environments (see [Deploy Settings](deploy-settings.md)).
* Added a new configuration option of `AllowPublicAccessDeploymentOperations` to amend the behavior of public access rule transfer (see [Deploy Settings](deploy-settings.md)).
* Improve performance of publishing multi-language content during restore/transfer and import.

#### [**12.0.5**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.5) (**November 14th 2023**)

* Fixed action menu for queue for transfer with list view [#185](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/185).
* Omitted automatic relations from packages from default relations included in Deploy operations.

#### [**12.0.4**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.4) **(October 17th 2023)**

* Fixed issue with deployment of content when scheduled for a future release date.
* Prevent dictionary items from being serialized to `.uda` files on disk when configured for transfer as content [#184](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/184).

#### [**12.0.3**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.3) **(October 10th 2023)**

* Fixed regression issue introduced in 12.0.3 with deployment of properties of content templates [#182](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/182)

#### [**12.0.2**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.2) **(September 19th 2023)**

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

#### [**12.0.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.1) **(August 1st 2023)**

* Ensured that schema files are updated on entity container renames [#171](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/171).
* Fixed issue with processing of marker files on Linux [#169](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/169).
* Corrected logic for creating redirects on content deployment for variant content.
* Ensured consistent rendering of trailing zeros when using the rounded decimal converter.
* Reduced some logging to debug to reduce noise in log files.
* Added the settings `IsSaaSHosted`, `HideConfigurationDetails` and `HideLocalEnvironment` for use by Umbraco Heartcore.

#### [**12.0.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.0)

* Compatibility with Umbraco 12
  * See full details of breaking changes under the [version-specific upgrade guide](upgrades/version-specific.md#version-12).

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation release notes ](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-deploy/release-notes.md)and[ Umbraco Deploy Package page.](https://our.umbraco.com/packages/developer-tools/umbraco-deploy/)

## [Deploy Contrib](https://github.com/umbraco/Umbraco.Deploy.Contrib)

{% hint style="info" %}
Deploy Contrib contains community contributions for Umbraco Deploy targetted for version 8 and above.

It offers connectors for the most popular Umbraco community packages. These are used by Deploy to aid with the deployment and transferring of content/property-data between environments.
{% endhint %}

#### Deploy Contrib 11.0.1 (February 14th 2023)

* Block grid editor support and fix for null reference exception (10+)
* Further caching for deploy operations.

#### Deploy Contrib 10.1.1 (February 14th 2023)

* Block grid editor support and fix for null reference exception (10+)
* Further caching for deploy operations.

#### Deploy Contrib 9.1.1 (February 14th 2023)

* Block grid editor support and fix for null reference exception (10+)
* Further caching for deploy operations.

#### Deploy Contrib 4.2.0, 9.1.0 and 10.1.0 (September 7th 2022)

* Used caching in value connectors to improve performance.
* Fixed issue with transfer of nested content string values using item templates (for example commencing with "\{{") that were erroneously considered as JSON.

#### Deploy Contrib 4.1.2, 9.0.2, 10.0.1 (July 12th 2022)

* Optimized existence checks in connectors

#### Deploy Contrib 4.1.1 (April 26th 2022)

* Fixes issue with deployment of nested content properties within Document Type grid editor values. [#82](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/82)

#### Deploy Contrib 4.2.1 (February 21st 2023)

* All items listed under the 9.1.1, 10.1.1 and 11.0.1 releases (other than those indicated as only applying to higher versions).
