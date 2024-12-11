---
description: Get an overview of the changes and fixes in each version of Umbraco Forms.
---

# Release Notes

In this section, we have summarized the changes to Umbraco Forms released in each version. Each version is presented with a link to the [Forms issue tracker](https://github.com/umbraco/Umbraco.Forms.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, you can find information about the breaking changes in the [Version Specific Upgrade Notes](upgrading/version-specific.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Forms 13 including all changes for this version.

#### [**13.4.0-rc1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.4.0) **(December 17th 2024)**

##### Validation rules across form fields

When creating forms you are able to add validation to individual fields, making them mandatory or applying a regular expression pattern. With the 13.4 release we are looking to make this more powerful, by allowing the addition of validation rules for the entire form. The idea is that this will allow you to validate expressions based on multiple fields. For example, "these two email fields should be the same", or "this date should be after this other one".

Crafting these rules requires use of [JSON logic](https://jsonlogic.com/) so is considered a "power user" feature. They also require an additional front-end dependency for the rendering of forms on the website. As such they are surfaced on a new "Advanced" tab and only visible and used if enabled in configuration. We don't have, and it seems difficult to provide, an intuitive user interface for rule creation taking into account all the flexibility available. Nonetheless, having the ability to use more complex validation rules seems a valuable addition.

When the form is rendered, the validation rules will be applied on the client, where we support both the `aspnet-client-validation` and `jquery.validate` libraries. They are also verified server-side. In this way you can ensure the submission is only accepted if it meets the requirements.

Feedback on this feature in particular is welcome.

Read more about [editing advanced validation rules](./editor/creating-a-form/form-advanced.md) as well as the [configuration option required to enable them](./developer/configuration/README.md#enableadvancedvalidationrules).

##### Tracking editor activity

Whilst previously we tracked and displayed the date a form was created and last edited, we didn't show who had made these updates. With 13.4 installed we will start to track this and display the information where available. You'll find this on the form, data source or prevalue source's "Info" tab [#1315](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1315).

##### Copy of workflows

Forms allow you to make a copy of a form to use as a starting point for a new one. You can choose whether or not to copy workflows along with the form. With the 13.4 release, we've made available a second dialog allowing you to copy workflows to an existing form [#1185](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1185). You can select any or all of the workflows on the current form and copy them to the selected destination form.

We've also resolved an edge case around copying a form. It's possible to [define workflows as mandatory](./developer/extending/customize-default-workflows.md#setting-a-mandatory-default-workflow). Copying the form without workflows excludes the desired workflow. You would have a form that didn't contain the workflow you wanted to be included on all. This has been tightened up now and mandatory workflows will always be assigned to the copied form [#1331](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1331).

##### Form picker enhancements

In the 14.2 release we enhanced the [form picker property editors](./developer/property-editors.md). We introduced support for restriction of which forms can be selected by folder rather than only by individual forms. This has now been backported to Forms 13 [#891](https://github.com/umbraco/Umbraco.Forms.Issues/issues/891).

##### File upload validation messages

Previously the validation messages presented on the website front end when uploading files were hardcoded and always provided in English. We've added settings now to the "File Upload" field type allowing you to customize these. Dictionary keys can be used in order to provide the information in the user's preferred language [#1327](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1327).

#### [**13.3.3**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.3.3) **(December 5th 2024)**

* Fixed regression introduced in 13.3.1 that caused issues for custom field types overriding the `ProcessSubmittedValue` method  [#1328](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1328).

#### [**13.3.2**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.3.2) **(November 28th 2024)**

* Fixed issue with case sensitive checkbox conditions across multi-page forms [#1325](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1325).

#### [**13.3.1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.3.1) **(November 21st 2024)**

* Fixed issues with multi-page forms used in conjunction with a `FormPrePopulateNotification` handler. File uploads and multi-value fields like checkbox lists now function correctly [#1317](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1317) [#1320](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1320).
* Added a couple of missing translation keys [#1316](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1316) [#1319](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1319).
* Improved accessibility and styling of close button on export dialog [#1321](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1321).

#### [**13.3.0**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.3.0) **(November 7th 2024)**

* All items detailed under release candidates for 13.3.0.
* Fixed issue with validation for invalid file extension on form submissions via the API [#1310](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1310).

#### [**13.3.0-rc1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.3.0) **(October 25th 2024)**

##### Multi-step forms

The 13.3 release of Forms contains features that can improve the user experience of completing multi-page forms.

We have added the option for [editors to choose to display paging details on the forms](./editor/creating-a-form/form-settings.md#multi-page-forms). This will allow those completing forms to get a better understanding of progress as well as see details of the pages still to be completed. [#281](https://github.com/umbraco/Umbraco.Forms.Issues/issues/281) [#648](https://github.com/umbraco/Umbraco.Forms.Issues/issues/648).

These options are enabled and configured by editors in the Forms settings section on a per-form basis. We also provide a [configuration-based toggle for the feature as a whole](./developer/configuration/README.md#enablemultipageformsettings). In this way, editors can be given access to use the feature only once the styling or theme is prepared.

##### Ship themes in Razor Class Libraries

Forms ships it's themes and email templates as part of a razor class library for ease of distribution. With this release we make that feature [available to your own custom themes and templates](./developer/themes.md#shipping-themes-in-a-razor-class-library) (or those created by package developers) [#795](https://github.com/umbraco/Umbraco.Forms.Issues/issues/795).

##### Date picker field type

We have made a couple of updates to the Date Picker field type. The format for the field can now be provided in configuration [#1276](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1276). And you can now override and localize the aria-label provided for assistive technologies such as screen readers [#1082](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1082).

##### Finer grained entries permissions

To allow finer control over editor permissions, we have introduced a "delete entries" setting for users and user groups. Thus you can now give editors explicit permissions to view, edit, or delete entries [#1303](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1303).

##### Other

Other bug fixes included in the release:

* Fixed issue with single checkbox triggering a condition on a field on a subsequent page [#1304](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1304).
* Improved cross-platform check when exporting to Excel.
* Fixed issue where sensitive data flag on a field could not be set for new fields added to a form [#1309](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1309).

#### [**13.2.5**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.2.5) **(October 3rd 2024)**

* Handled "chunked" authentication cookie in protection of file uploads saved in the media file system [#11](https://github.com/umbraco/Umbraco.Forms.Issues/issues/11#issuecomment-2376788751).

#### [**13.2.4**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.2.4) **(September 26th 2024)**

* Fixed regression in 13.2.2 that caused validation to fire on the wrong form when multiple forms are hosted on a single page [#1297](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1297).

#### [**13.2.3**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.2.3) **(September 19th 2024)**

* Fixed regression in 13.2.0 that prevented a form submission from saving if a workflow approved the entry [#1293](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1293).
* Added check to migration step that adds a property to the forms macro, such that it will avoid an exception if the property already exists [#1292](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1292).
* Added file name validation to file uploads, rejecting files with invalid colon characters [#1295](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1295).

#### [**13.2.2**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.2.2) **(September 12th 2024)**

* Used localized label for submit workflow summary heading [#1273](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1273).
* Removed autocomplete on field previews [#1271](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1273).
* Added configurable field level rendering of reCAPTCHA 3 validation result [#1277](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1277).
* Fixed validate and submit script to handle additional markup around submit buttons [#1280](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1280).
* Fixed incorrect concatenation of field CSS classes [#1284](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1284).
* Added server-side validation of configured maximum length for short and long answer fields.
* Restored provision of field values in HTTP headers in Post as XML workflow.
* Fixed issue with recording of form submissions in custom Examine indexes [#1282](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1282).
* Added ability to retrieve "slim" workflow entities from services [#1283](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1283).

#### [**13.2.1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.2.1) **(August 6th 2024)**

* Fixed issue with entries export for Windows installations without access to a component necessary for auto-fit of Excel columns [#1259](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1259).

#### [**13.2.0**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.2.0) **(July 23rd 2024)**

{% hint style="warning" %}
The 13.2.0 release contains minor changes to the mark-up in the following Razor files shipped with the product: `Form.cshtml`, `FieldType.RadioButtonList.cshtml`, and `FieldType.CheckBoxList.cshtml`. These changes were made to resolve issues [#1220](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1220) and [#1218](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1218).

Please ensure to check the rendering of these features on website forms after the upgrade. If you need to view the files to compare changes, you can download and view the [latest](https://our.umbraco.com/FileDownload?id=24342) and [previous](https://our.umbraco.com/FileDownload?id=24334) versions.
{% endhint %}

* All issues from earlier 13.2 release candidates.
* Ensured prevalues can be retrieved outside of an HTTP request context when they depend on a static root node [#1258](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1258).

#### [**13.2.0-rc2**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.2.0) **(July 17th 2024)**

* Added configuration option `AllowedFileUploadExtensions` to provide an "allow list" of extensions that will be accepted in file uploads via forms [#1252](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1252).
    * Read more about this and related settings [here](./developer/configuration/README.md#allowedfileuploadextensions).
* Allowed users without sensitive data permissions to set, but not remove, the sensitive flag on a form field [#1233](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1233).
* Ordered select list of prevalue sources when defining prevalues for a form field.
* Limited the field preview for a field containing prevalues.

#### [**13.2.0-rc1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.2.0) **(July 9th 2024)**

* Added setting option for single and multiple choice fields to allow for vertical or horizontal display [#1218](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1218).
* Added new setting type for multiple text strings [#1217](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1217)
* Added validation to prevent users defining an email workflow that allows the form's sender email to be defined as that entered by the user [#1210](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1210).
* Allowed for the provision of additional data when rendering and submitting forms. When provided it will be used as a source for ["magic string" replacements](./magic-strings.md). The data will be associated with the created record and made available for custom logic and update within workflows. [#578](https://github.com/umbraco/Umbraco.Forms.Issues/issues/578).
* Added details of workflow type to edit workflow dialog [#1183](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1183).
* Removed an inline prevalue editor that wasn't functional but could surface it's UI when creating forms from templates [#1230](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1230).
* Ensured local links are parsed when HTML fields are returned in the delivery API results for form definitions [#1227](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1227).
* Resolved duplicate approval occurring when the record is approved via a workflow [#1223](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1223).
* Updated themes such that accessibility is improved by having hidden labels remain in markup but be visually hidden [#1220](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1220).
* Fixed issue with save button UI, when save is canceled via a notification [#1219](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1219).
* Improved date format for data values when using the **Send email** workflow [#1214](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1214).
* Removed unnecessary circular checks for conditions on workflows resolving an issue where workflow would trigger when conditions were not met [#1206](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1206).
* Added setting option for the "send to URL" workflow to switch between caption and alias for the field value's XML element [#1202](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1202)
* Allowed for use of prevalue sources that customize based on the current form or field in backoffice editing and preview [#1221](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1221).
* Restored target used to generate local configuration schema information [#1226](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1226).
* Fixed issues with retrieving fields and assigning default values when using the datasource wizard.
* Ensured links to Umbraco pages within rich text fields used for emails are correctly parsed [#1208](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1208).
* Added body rich text field for send email with Razor template workflow [#1198](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1198).
* Fixed console error with blank values in the date picker field [#1241](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1241).
* Ensured placeholders are parsed for accepted entry response from the delivery API [#1238](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1238).
* Improved support for editing large, multi-page forms by retaining scroll position between views and adding a "jump to page" option [#1243](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1243).

#### [**13.1.2**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.2.4) **(April 16th 2024)**

* Corrected alignment of label `for` and input `id` attributes in the date picker field [#1200](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1200).
* Corrected permission check such that users with only "view entries" permissions can see form details on the dashboard [#1192](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1192).
* Used `requestSubmit` when submitting forms [#1199](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1199).
* Tightened path check used in middleware for restriction of access to form file uploads.

#### [**13.1.1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=label%3Arelease%2F13.1.1+is%3Aclosed) **(March 22nd 2024)**

* Fixes regression issue with form validation where two forms are rendered on a single page [#1189](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1189).

#### [**13.1.0**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.0) **(March 19th 2024)**

With the introduction of webhooks in Umbraco 13, we've made an update to Forms to allow workflow execution events to trigger webhooks. Workflows are operations that you can associate with form submission, approval, or rejection actions. You can use these where you need to notify external systems of the success or failure of a workflow. Read more on [Umbraco Forms Webhooks](./developer/webhooks.md).

We've added an update that will help customers using Forms within locked down production environments.

And there are a couple of further additions to improve the performance and accessibility of the product.

**Features implemented and issues resolved in 13.1.0**

* Added webhooks for workflow execution events [#1151](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1151).
* Added support for a proxied request when using reCAPTCHA 3 [#1159](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1159).
* Added a configurable option to ensure accessibility requirements with regard to fieldsets are adhered to [#1163](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1163).
    * Read more about this configuration setting [here](./developer/configuration/README.md#mandatoryfieldsetlegends).
* Added a cachebuster querystring based on the current product version to rendered script dependencies [#773](https://github.com/umbraco/Umbraco.Forms.Issues/issues/773).
* Ensured that client-side conditions logic correctly implements "is" with multiple values, such that the condition passes if one and only one matching value is found [#1173](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1173).
* Fixed closing of theme picker dialog [#1174](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1174).
* Fixed rendering of translated dictionary items used for form captions [#1175](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1175).
* Applied multiple click protection for form submissions for installations using the aspnet-validation library [#1182](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1182).

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

## Umbraco.Forms.Deploy

#### **13.0.1** (March 19th 2024)

* Added migrator to support changes in Form field prevalues when importing from older Umbraco versions

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-forms/release-notes.md) and [Umbraco Forms Package page](https://our.umbraco.com/packages/developer-tools/umbraco-forms/).
