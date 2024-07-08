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

This section contains the release notes for Umbraco Forms 14 including all changes for this version.

#### [**14.1.0-rc1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.0) **(July 9th 2024)**

* Added setting option for multiple and choice choice fields to allow for vertical or horizontal display [#1218](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1218)
* Added new setting type for multiple text strings [#1217](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1217)
* Added validation to prevent users defining an email workflow that allows the form's sender email to be defined as that entered by the user [#1210](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1210)
* Allowed for the provision of additional data when rendering and submitting forms. When provided it will be used as a source for ["magic string" replacements](./magic-strings.md). The data will be associated with the created record and made available for custom logic and update within workflows. [#578](https://github.com/umbraco/Umbraco.Forms.Issues/issues/578)
* Added details of workflow type to edit workflow dialog [#1183](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1183)
* Allowed for use of prevalue sources that customize based on the current form or field in backoffice editing and preview [#1221](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1221)
* Ensured links to Umbraco pages within rich text fields used for emails are correctly parsed [#1208](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1208).
* Added body rich text field for send email with Razor template workflow [#1198](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1198).
* Fixed console error with blank values in data picker fields [#1241](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1241).
* Ensured placeholders are parsed for accepted entry response from the delivery API [#1238](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1238).
* Resolved issues with intermittent failures of the form entries table display [#1239](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1239).

#### [**14.0.2**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.0.2) **(June 11th 2024)**

* Fixed issue with upload of text file for the prevalue source based on file contents.

#### [**14.0.1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.0.1) **(June 6th 2024)**

* Ensured local links are parsed when HTML fields are returned in the delivery API results for form definitions [#1227](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1227).
* Restored target used to generate local configuration schema information [#1226](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1226).
* Resolved duplicate approval occurring when the record is approved via a workflow [#1223](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1223).
* Added some missing localization keys and translations.
* Fixed description of management API on Swagger UI.
* Fixed display of specific form access list for user and group security.

#### [**14.0.0**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.0.0) **(May 30th 2024)**

* Compatibility with Umbraco 14
  * See full details of breaking changes under the [Version-specific Upgrade Guide](upgrading/version-specific.md).

## Umbraco.Forms.Deploy

#### **14.0.0** **(May 30th 2024)**

* Compatibility with Umbraco 14, Forms 14 and Deploy 14.

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on Github](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-forms/release-notes.md) and [Umbraco Forms Package page](https://our.umbraco.com/packages/developer-tools/umbraco-forms/).
