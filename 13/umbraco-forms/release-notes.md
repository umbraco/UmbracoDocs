---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco Forms.
---

# Release Notes

In this section, we have summarized the changes to Umbraco Forms released in each version. Each version is presented with a link to the [Forms issue tracker](https://github.com/umbraco/Umbraco.Forms.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, you can find information about the breaking changes in the [Version Specific Upgrade Notes](upgrading/version-specific.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Forms 13 including all changes for this version.

#### [**13.0.2**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.2) **(February 20th 2024)**

* Ensured UI for the upload of a text file for a prevalue source only allows the selection of expected .txt files.
* Handled potential null value for prevalues for a form definition following an upgrade [#1157](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1157)
* Fixed handling of API and traditional form posts in reCAPTCHA 3 checks [#1150](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1150)
* Fixed display of validation error when a duplicate form field alias is created [#1152](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1152)
* Fixed issue where file uploads weren't removed as records were deleted.
* Updated Microsoft.Data.SqlClient dependency due to reported security advisory.

#### [**13.0.1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.1) **(January 16th 2024)**

* Added configuration value `TitleAndDescription:AllowUnsafeHtmlRendering` to allow tighter security for HTML rendering of text entered in the "Title and description" field type.
    * See further details on the [configuration page](./developer/configuration/README.md#AllowUnsafeHtmlRendering).
* Rendered dictionary translations of field captions in backoffice entries view [#1131](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1131).
* Ensured valid format string before rendering validation methods with placeholders [#1132](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1132).
* Ensured the creation of the forms to content relation type is idempotent and created with consistent GUID [#1137](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1137).
* Ensured Examine re-index user interface completes when no records are available for indexing [#1137](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1137).
* Fixed issue where use of a custom field HTML ID attribute prefix breaks conditional logic in multi-page forms [#1138](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1138).
* Added support for record based magic string replacement in the post-submission message [#1133](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1133).
* Tightens up the null checks when reading form definition JSON for prevalue captions [#1140](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1140).
* Added configuration value `DisableRelationTracking` to allow relation tracking between forms and content to be disabled.
    * See further details on the [configuration page](./developer/configuration/README.md#DisableRelationTracking).
* Added configuration value `TrackRenderedFormsStorageMethod` to allow use of `HttpContext.Items` over `TempData` when tracking rendered forms [#1144](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1144).
    * See further details on the [configuration page](./developer/configuration/README.md#TrackRenderedFormsStorageMethod) and the [rendering scripts page](./developer//rendering-scripts.md).
* Resolved an out of range exception when a condition hides all fields on the final page of a multi-page form.
* Fixed issue with swapping between plain and rich text when configuring the post-submission message [#1145](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1145).

#### [**13.0.0**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) **(December 14th 2023)**

* Compatibility with Umbraco 13
  * See full details of breaking changes under the [version specific upgrade guide](upgrading/version-specific.md#version-13).
* Ran registered server-side file validators on file uploads.

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on Github](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-forms/release-notes.md) and [Umbraco Forms Package page](https://our.umbraco.com/packages/developer-tools/umbraco-forms/).
