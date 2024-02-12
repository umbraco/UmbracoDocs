---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco Forms.
---

# Release Notes

In this section, we have summarized the changes to Umbraco Forms released in each version. Each version is presented with a link to the [Forms issue tracker](https://github.com/umbraco/Umbraco.Forms.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, you can find information about the breaking changes in the [Version Specific Upgrade Notes](./upgrading/version-specific.md) article
{% endhint %}

## Release History

This section contains the release notes for Umbraco Forms 12 including all changes for this version.

#### [**12.2.3**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.2.3) **(February 20th 2024)**

* Ensured UI for the upload of a text file for a prevalue source only allows selection of expected .txt files.
* Handled potential null value for prevalues for a form definition following an upgrade [#1157](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1157)
* Fixed handling of API and traditional form posts in reCAPTCHA 3 checks [#1150](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1150)
* Fixed display of validation error when a duplicate form field alias is created [#1150](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1152)
* Fixed issue where file uploads weren't removed as records were deleted.
* Updated Microsoft.Data.SqlClient dependency due to reported security advisory.

#### [**12.2.2**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.2.2) **(January 16th 2024)**

* Added configuration value `TitleAndDescription:AllowUnsafeHtmlRendering` to allow tighter security for HTML rendering of text entered in the "Title and description" field type.
    * See further details on the [configuration page](./developer/configuration/README.md#AllowUnsafeHtmlRendering).
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

#### [**12.2.1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.2.1) **(December 19th 2023)**

* Fixed a regression issue with the use of the `SetFormFieldClass` method [#1127](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1127).
* Fixed an issue loading the new form's info tab [#1128](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1128)
* Fixed a caching issue causing problems with use of form relations after initial install.

#### [**12.2.0**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.2.0) **(December 7th 2023)**

* All updates listed under 12.2.0-rc1
* Resolved an issue where a workflow wasn't executed when conditionally based on a checkbox value [#1124](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1124).
* Added a missing language key for the Forms dashboard [#1125](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1125).
* Added details of the current record (form entry) to the workflow notification [#1042](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1042).
* Update the copy form dialog to use standard CMS patterns for button state and disabling after click [#1121](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1121).
* Added sortable column headers on the list of forms displayed in the user and user group security screens [#1122](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1122).

#### [**12.2.0-rc1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.2.0) **(November 23rd 2023)**

* Added an overload to the `RenderUmbracoFormDependencies` HTML helper method to allow provision of a dictionary parameter containing attributes to use when rendering script references. Also a new configuration option `DisableClientSideValidationDependencyCheck` to disable the client-side validation framework check. This is necessary when using the overload to provide an `async` attribute. [#1074](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1074).
* Added further conditional operators, for inverse and case insensitive checks [#1081](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1081).
* Provided option for setting a custom field to be mandatory by default [#928](https://github.com/umbraco/Umbraco.Forms.Issues/issues/928).
* Added a caption property for display adjacent to the input field when using the checkbox field type [#816](https://github.com/umbraco/Umbraco.Forms.Issues/issues/816).
* Added a new setting type that allows entry of text or selection of a field from the current form [#1071](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1071).
* Added a response object to the headless API providing details of post submission behavior for the form [#1104](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1104).
* Tracked relations between forms and content and displayed in new "Info" content app [#937](https://github.com/umbraco/Umbraco.Forms.Issues/issues/937).
* Added an mandatory option for field and workflow type settings [#1108](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1108).
* Added a "select/deselect all" toggle for the user security list of forms [#1092](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1092).
* Added an additional button allowing a form editor to add a new page at the top or bottom of the form [#1029](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1029).
* Added a parameter to set the "go to page" for different instances of forms are used on multiple pages [#331](https://github.com/umbraco/Umbraco.Forms.Issues/issues/331).
* Added a "reject" state to forms and the ability to associate workflows [#716](https://github.com/umbraco/Umbraco.Forms.Issues/issues/716).
* Made the Forms client-side validation service available globally for use in custom code [#1099](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1099).
* Fixed issue with styling of hidden fields in the "bootstrap" theme [#1120](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1120).
* Implemented routing for form entries allowing direct links to an entry in the backoffice [#7](https://github.com/umbraco/Umbraco.Forms.Issues/issues/7).

#### [**12.1.2**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.1.2) **(November 14th 2023)**

* Ensured validation pattern's saved for a field are cleared when changing the field type [#1083](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1083).
* Included input of type time in condition evaluation [#1084](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1084).
* Fixed issue with "ends with" condition [#1098](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1098).
* Fixed issue with the display of selected records in the entries list view [#1100](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1100).
* Fixed issue with display of newly created forms in the tree where permissions are managed with user groups and user specific override exists [#1102](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1102).
* Fixed issue magic string replacement in email field names [#1107](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1107).
* Fixed broken link in magic string notice [#1109](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1109).
* Replaced save success message with a failed notification when cancelling form save via notifications [#1002](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1002).
* Removed usage of inline styles from the form's default theme [#1110](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1110).
* Ensured an index exists on the `UFForms.FolderKey` column.
* Ensured that the Umbraco hooks for server-side sanitization are called when saving form field's input from a rich text editor.
* Fixed issue with prevalue caching [#1101](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1101).

#### [**12.1.1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.1.1) **(September 19th 2023)**

* Ensured uploaded file protection is based on permission to view rather than edit entries [#1058](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1058)
* Improved markup for screen reader access when creating a form [#1067](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1067)
* Styled the workflow name field to be full width to avoid cut-off of the text [#1079](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1079)
* Fixed field icon styling [#1065](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1065)
* Ensured the default theme supports anchoring to the post submission message [#1066](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1066)
* Fixed serialization of field settings via the Forms API such that they are camel-cased [#1068](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1068)

#### [**12.1.0**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.1.0) **(August 17th 2023)**

* All items listed under 10.5.0-rc1.
* Removed the unnecessary set of global JavaScript variable that could trigger a console error under certain conditions [#1056](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1056)
* Ensured that files in form submissions are accessible without the "Manage Forms" permission [#1058](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1058)
* Further updated the dependency on `aspnet-client-validation` to correct an issue with validating mandatory dropdown questions, [#1059](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1059)
* Fixed issue where a race condition in creating a user security record on first access could lead to a one-off exception.

#### [**12.1.0-rc1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.1.0) **(August 1st 2023)**

* Added cache options to prevalue sources.
* Added the option to use the `www.recaptcha.net` domain for the reCAPTCHA 3 field type.
* Applied accessibility improvements to markup in the Forms default theme [#1038](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1038)
* Added behavior to scroll to the form when navigating multiple page forms [#1037](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1037)
* Added a setting for the files selected label text for the file upload field type [#1039](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1039)
* Fixed a casing issue with the form picker [#1040](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1040)
* Ensured custom field settings applied to the data consent field type are used in the creation of new forms [#1034](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1034)
* Fixed issue related to conditions applied to radio button or checkbox lists when a custom field ID prefix is configured [#1043](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1043)
* Fixed a second issue related to conditions found when hiding a field based on a non-visible field [#1045](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1045)
* Clarified the labeling on selecting to include attachments in email workflows [#1044](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1044)
* Fixed issue with Umbraco Documents prevalue source retrieving unpublished nodes [#1030](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1030)
* Updated naming of primary keys to match database conventions [#1049](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1049)
* Fixed issue with retrieving forms for a user with start folders defined [#1050](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1050)
* Updated dependency on `aspnet-client-validation` to correct the rendering of the validation summary when validating mandatory single and multiple choice answers, [#1053](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1053)

#### [**12.0.0**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.0)

* Compatibility with Umbraco 12
  * See full details of breaking changes under the [version specific upgrade guide](upgrading/version-specific.md#version-12).

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on Github](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-forms/release-notes.md) and [Umbraco Forms Package page](https://our.umbraco.com/packages/developer-tools/umbraco-forms/).
