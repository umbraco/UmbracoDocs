---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco
  Forms.
---

# Release Notes

In this section, we have summarized the changes to Umbraco Forms released in each version. Each version is presented with a link to the [Forms issue tracker](https://github.com/umbraco/Umbraco.Forms.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, you can find information about the breaking changes in the [Version Specific Upgrade Notes](upgrading/version-specific.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Forms 14 including all changes for this version.

#### [**14.2.0**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.2.0) **(November 7th 2024)**

* All items details under release candidates for 14.2.0.
* Fixed issue with validation for invalid file extension on form submissions via the API [#1310](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1310).

#### [**14.2.0-rc2**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.2.0) **November 3rd 2024**

* Updated dependency on Umbraco CMS to 14.3.0.
* Added a replacement for the AngularJS [block list label filter we provide for Forms 13](../../13/umbraco-forms/developer/blocklistfilters.md). The new implementations use [Umbraco Flavored Markdown (UFM)](https://docs.umbraco.com/umbraco-cms/reference/umbraco-flavored-markdown) and are [documented here](./developer/blocklistfilters.md).

#### [**14.2.0-rc1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.2.0) **October 25th 2024**

##### Multi-step forms

The 14.2 release of Forms contains features that can improve the user experience of completing multi-page forms.

We have added the option for [editors to choose to display paging details on the forms](./editor/creating-a-form/form-settings.md#multi-page-forms). This will allow those completing forms to get a better understanding of progress as well as see details of the pages still to be completed. [#281](https://github.com/umbraco/Umbraco.Forms.Issues/issues/281) [#648](https://github.com/umbraco/Umbraco.Forms.Issues/issues/648).

These options are enabled and configured by editors in the Forms settings section on a per-form basis. We also provide a [configuration-based toggle for the feature as a whole](./developer/configuration/README.md#enablemultipageformsettings). In this way, editors can be given access to use the feature only once the styling or theme is prepared.

##### Form picker enhancements

Another improvement is found in the [form picker property editors](./developer/property-editors.md). We now support restriction of which forms can be selected by folder rather than only by individual forms.

A second "form details picker" is also available, allowing editors the option of selecting the form, theme and redirect via a single property editor.

##### Ship themes in Razor Class Libraries

Forms ships it's themes and email templates as part of a razor class library for ease of distribution. With this release we make that feature [available to your own custom themes and templates](./developer/themes.md#shipping-themes-in-a-razor-class-library) (or those created by package developers) [#795](https://github.com/umbraco/Umbraco.Forms.Issues/issues/795).

##### Date picker field type

We have made a couple of updates to the Date Picker field type. The format for the field can now be provided in configuration [#1276](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1276). And you can now override and localize the aria label provided for assistive technologies such as screen readers [#1082](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1082).

##### Umbraco documents prevalue source type

When creating a prevalue source based on Umbraco documents, you can now select custom properties for the value or caption. Previously you had a choice of the content item's `Id`, `Key` or `Name`. We've extended this to allow the selection of any properties defined on the selected Document Type [#1195](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1195).

##### Finer grained entries permissions

To allow finer control over editor permissions, we have introduced a "delete entries" setting for users and user groups. Thus you can now give editors explicit permissions to view, edit, or delete entries [#1303](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1303).

##### Backoffice localization

Finally thanks to a kind contribution from [Erik-Jan Westendorp](https://github.com/erikjanwestendorp) the backoffice is now translated into Dutch [#1264](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1264).

##### Other

Other bug fixes included in the release:

* Reverted entry list to display most recent first.
* Fixed issue with display of prevalue captions in the entry list.
* Fixed issue on restoring values of checkbox and radio lists when navigating backward on multi-page forms.
* Fixed issue with single checkbox triggering a condition on a field on a subsequent page [#1304](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1304).
* Improved cross-platform check when exporting to Excel.

#### [**14.1.5**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.5) **(October 3rd 2024)**

* Handled "chunked" authentication cookie in protection of file uploads saved in the media file system [#11](https://github.com/umbraco/Umbraco.Forms.Issues/issues/11#issuecomment-2376788751).
* Ensured field list for condition rules updates as new fields are added to the form [#1301](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1301).
* Resolved issues with requesting management API endpoints for forms from content without access to the Forms section [#1244](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1244).
* Fixed button labels on form copy dialog.
* Fixed localization of SQL prevalue source labels.

#### [**14.1.4**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.2.4) **(September 26th 2024)**

* Fixed regression in 14.1.2 that caused validation to fire on the wrong form when multiple forms are hosted on a single page [#1297](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1297).
* Fixed issue with line breaks in form submissions breaking the entries view [#1296](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1296).

#### [**14.1.3**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.3) **(September 19th 2024)**

* Fixed regression in 13.2.0 that prevented a form submission from saving if a workflow approved the entry [#1293](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1293).
* Added file name validation to file uploads, rejecting files with invalid colon characters [#1295](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1295).

#### [**14.1.2**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.2) **(September 12th 2024)**

* Added configurable field level rendering of reCAPTCHA 3 validation result [#1277](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1277).
* Fixed validate and submit script to handle additional markup around submit buttons [#1280](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1280).
* Fixed incorrect concatenation of field CSS classes [#1284](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1284).
* Added server-side validation of configured maximum length for short and long answer fields.
* Restored provision of field values in HTTP headers in Post as XML workflow.
* Fixed issue with recording of form submissions in custom Examine indexes [#1282](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1282).
* Added ability to retrieve "slim" workflow entities from services [#1283](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1283).
* Fixed the following backoffice user interface issues [#1291](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1291), [#1290](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1290), [#1288](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1288), [#1287](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1287), [#1286](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1286), [#1278](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1278) and [#1275](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1275).

#### [**14.1.1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.1) **(August 6th 2024)**

* Fixed issues with entries export for Windows installations without access to a component necessary for auto-fit of Excel columns [#1259](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1259).
* Resolved intermittent issues with display of entries list [#1256](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1256).
* Restored access to setting option for sensitive data handling in workflows [#1262](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1262).
* Fixed validation on saving a form without a name [#1263](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1263).
* Fixed fallback of the localized user interface for English (GB) to English (US) [#1267](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1267).
* Fixed issue with form block rendering from rich text content [#1268](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1268).
* Restored the `ValueAsString` extension method on `Record`.

#### [**14.1.0**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.0) **(July 23rd 2024)**

{% hint style="warning" %}
The 14.1.0 release contains minor changes to the mark-up in the following Razor files shipped with the product: `Form.cshtml`, `FieldType.RadioButtonList.cshtml`, and `FieldType.CheckBoxList.cshtml`. These changes were made to resolve issues [#1220](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1220) and [#1218](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1218).

Please ensure to check the rendering of these features on website forms after the upgrade. If you need to view the files to compare changes, you can download and view the [latest](https://our.umbraco.com/FileDownload?id=24343) and [previous](https://our.umbraco.com/FileDownload?id=24339) versions.
{% endhint %}

* All issues from earlier 14.1 release candidates.
* Ensured prevalues can be retrieved outside of an HTTP request context when they depend on a static root node [#1258](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1258).

#### [**14.1.0-rc2**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.0) **(July 18th 2024)**

* Added configuration option `AllowedFileUploadExtensions` to provide an "allow list" of extensions that will be accepted in file uploads via forms [#1252](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1252).
  * Read more about this and related settings [here](developer/configuration/#allowedfileuploadextensions).
* Allowed users without sensitive data permissions to set, but not remove, the sensitive flag on a form field [#1233](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1233).
* Ordered select list of prevalue sources when defining prevalues for a form field.
* Limited the field preview for a field containing prevalues.
* Improved support for editing large, multi-page forms by retaining scroll position between views and adding a "jump to page" option [#1243](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1243).

#### [**14.1.0-rc1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.0) **(July 9th 2024)**

* Added setting option for single and multiple choice fields to allow for vertical or horizontal display [#1218](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1218)
* Updated themes such that accessibility is improved by having hidden labels remain in markup but be visually hidden [#1220](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1220).
* Added new setting type for multiple text strings [#1217](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1217)
* Added validation to prevent users defining an email workflow that allows the form's sender email to be defined as that entered by the user [#1210](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1210)
* Allowed for the provision of additional data when rendering and submitting forms. When provided it will be used as a source for ["magic string" replacements](magic-strings.md). The data will be associated with the created record and made available for custom logic and update within workflows. [#578](https://github.com/umbraco/Umbraco.Forms.Issues/issues/578)
* Added details of workflow type to edit workflow dialog [#1183](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1183)
* Allowed for use of prevalue sources that customize based on the current form or field in backoffice editing and preview [#1221](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1221)
* Ensured links to Umbraco pages within rich text fields used for emails are correctly parsed [#1208](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1208).
* Added body rich text field for send email with Razor template workflow [#1198](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1198).
* Fixed console error with blank values in the date picker field [#1241](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1241).
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

#### 14.1.1 (October 3rd 2024)

* Add migrator to add missing Forms editor UI aliases

#### 14.1.0 (August 16th 2024)

* Add check for keyed services before examining the registered services implementation type (workaround for https://github.com/dotnet/runtime/issues/95789)
* Request tree items for forms-folder entity

#### 14.0.0 (May 30th 2024)

* Compatibility with Umbraco 14, Forms 14 and Deploy 14.

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on Github](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-forms/release-notes.md) and [Umbraco Forms Package page](https://our.umbraco.com/packages/developer-tools/umbraco-forms/).
