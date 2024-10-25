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

#### [**15.0.0-rc2**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.0) **(October 18th 2024)**

* Compatibility with Umbraco 15-rc2
* Preview of features and bug fixes due in 13.3 and 14.2:
    * Permission for delete entries [#1303](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1303).
    * Configurable date format for date picker field [#1276](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1276).
    * https://github.com/umbraco/Umbraco.Forms.Issues/issues/1304
    * Fixed issue with single checkbox triggering a condition on a field on a subsequent page [#1304](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1304).
    * Improve cross-platform check when exporting to Excel.

#### [**15.0.0-rc1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.0) **(October 8th 2024)**

* Compatibility with Umbraco 15-rc1
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

#### [**15.0.0-rc2**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.0) **(October 24th 2024)**

* Update Forms and Deploy dependencies to 15.0.0-rc2

#### [**15.0.0-rc1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.0) **(October 14th 2024)**

* Compatibility with Umbraco 15 and Deploy 15

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on Github](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/12/umbraco-forms/release-notes.md) and [Umbraco Forms Package page](https://our.umbraco.com/packages/developer-tools/umbraco-forms/).
