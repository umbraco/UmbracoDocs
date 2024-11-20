---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco
  Forms.
---

# Release Notes

In this section, we have summarized the changes to Umbraco Forms released in each version. Each version is presented with a link to the [Forms issue tracker](https://github.com/umbraco/Umbraco.Forms.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, you can find information about the breaking changes in the [Version Specific Upgrade Notes](upgrading/version-specific/) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Forms 15 including all changes for this version.

#### [**15.0.1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.1) **(November 21st 2024)**

* Fixed issues with multi-page forms used in conjunction with a `FormPrePopulateNotification` handler. File uploads and multi-value fields like checkbox lists now function correctly [#1317](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1317) [#1320](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1320).
* Added a couple of missing translation keys [#1316](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1316) [#1319](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1319).
* Rendered file upload previews in the backoffice.
* Fixed issue with saving the "Hide field validation labels" value when editing form settings.
* Fixed issue with selection of Document Type on the "Save as Umbraco node" workflow type.

#### [**15.0.0**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.0) **(November 14th 2024)**

* Compatibility with Umbraco 15.0.0

#### [**15.0.0-rc4**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.0) **(November 13th 2024)**

* Compatibility with Umbraco 15.0.0-rc4

#### [**15.0.0-rc3**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.0) **(November 6th 2024)**

* Compatibility with Umbraco 15.0.0-rc3
* Preview of features and bug fixes due in 13.3 and 14.2:
  * Fixed issue where sensitive data flag on a field could not be set for new fields added to a form [#1309](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1309)
  * Added date picker setting to set the text for the aria-label [#1082](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1082)
  * Allow selection of custom fields for values and captions for pre-value sources based on Umbraco documents [#1195](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1195)
  * Added Umbraco Flavoured Markdown component for the rendering of form names within a block list
  * Added validation message when submitting a form via the API with an invalid file extension [#1310](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1310)

#### [**15.0.0-rc2**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.0) **(October 18th 2024)**

* Compatibility with Umbraco 15.0.0-rc2
* Preview of features and bug fixes due in 13.3 and 14.2:
  * Permission for delete entries [#1303](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1303).
  * Configurable date format for date picker field [#1276](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1276).
  * https://github.com/umbraco/Umbraco.Forms.Issues/issues/1304
  * Fixed issue with single checkbox triggering a condition on a field on a subsequent page [#1304](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1304).
  * Improve cross-platform check when exporting to Excel.

#### [**15.0.0-rc1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.0) **(October 8th 2024)**

* Compatibility with Umbraco 15.0.0-rc1
  * See full details of breaking changes under the [Version-specific Upgrade Guide](upgrading/version-specific/).
* Made retrieval of prevalue source values and execution of record exports asynchronous [#1285](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1285).
* Preview of features due in 13.3 and 14.2:
  * Option to display paging details for multi-page forms.
  * Form picker with allowed forms managed via folders.
  * New "form details picker" providing a single property editor for the selection of form, theme, and redirect.
  * Ability to provide custom themes and email templates via razor class libraries [#795](https://github.com/umbraco/Umbraco.Forms.Issues/issues/795).
  * Backoffice translations for Dutch [#1264](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1264).

## Forms Deploy

This Deploy add-on adds support for transferring, restoring, exporting and importing (including migrating between major versions) of Umbraco Forms data.

#### [**15.0.0**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.0) **(November 14th 2024)**

* Update Forms and Deploy dependencies to 15.0.0

#### [**15.0.0-rc4**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.0) **(November 13th 2024)**

* Update Forms and Deploy dependencies to 15.0.0-rc4

#### [**15.0.0-rc3**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.0) **(November 7th 2024)**

* Update Forms and Deploy dependencies to 15.0.0-rc3

#### [**15.0.0-rc2**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.0) **(October 24th 2024)**

* Update Forms and Deploy dependencies to 15.0.0-rc2

#### [**15.0.0-rc1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.0) **(October 14th 2024)**

* Update Forms and Deploy dependencies to 15.0.0-rc1

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on Github](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/12/umbraco-forms/release-notes.md) and [Umbraco Forms Package page](https://our.umbraco.com/packages/developer-tools/umbraco-forms/).
