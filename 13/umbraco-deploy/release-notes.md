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

This section contains the release notes for Umbraco Deploy 13 including all changes for this version.

#### [**13.0.4**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.4) **(February 20th 2024)**

* Removed the no-longer supported "live edit" feature (Deploy on Cloud only).
* Fixed issue where the removal of a master template couldn't be deployed [#201](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/201)
* Ensured configuration for behavior following a "path too long" exception is respected for handling image cropper values [#200](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/200)
* Added configuration setting to allow hiding of version details on the settings dashboard.

#### [**13.0.3**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.3) **(January 16th 2024)**

* Added configurable option to avoid overwriting of dictionary items with empty values [#191](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/191)
    * For more details see the page on [Deploy's settings](./getting-started/deploy-settings.md).
* Fixed regression issue with transfer of date values.

#### [**13.0.2**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.2) **(January 9th 2024)**

* Fixed issue with transfer of content using language variants [#193](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/193)

#### [**13.0.1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.1) **(December 21th 2023)**

* Fixes the display of the selected schedule date on queue for transfer.
* Fixes parsing property values within Nested Content and Block List that were previously saved by the Contrib value connectors.
* Fixed incorrectly including media files in export when 'Content files' wasn't selected.
* Add maximum file size validation to import file upload.

#### [**13.0.0**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) **(December 14th 2023)**

* All items from the 13.0.0 RCs and latest 12.2 features.

#### [**13.0.0-rc5**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) **(December 12th 2023)**

* Align with latest CMS RC.

#### [**13.0.0-rc4**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) **(December 11th 2023)**

* Add weight -100 to Deploy package migration (ensuring Deploy database tables are available before other package migrations are executed).
* Add fluent API for Deploy webhooks.

#### [**13.0.0-rc3**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) **(November 29th 2023)**

* Added optional deployment of webhooks as part of schema updates.
* Added Deploy specific webhook events.

#### [**13.0.0-rc2**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) **(November 15th 2023)**

* Exclude automatic relation type aliases (used for reference tracking) from deployment.
* Fix cyclic dependency between configuring `DeploySettings` and `ConnectionStrings`.

#### [**13.0.0-rc1**](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) **(November 6th 2023)**

* Compatibility with Umbraco 13:
  * See full details of breaking changes under the [version specific upgrade guide](upgrades/version-specific.md).
  * Update Richtext value connector to handle references in blocks.

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on Github](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-deploy/release-notes.md) and [Umbraco Deploy Package page](https://our.umbraco.com/packages/developer-tools/umbraco-deploy/)
