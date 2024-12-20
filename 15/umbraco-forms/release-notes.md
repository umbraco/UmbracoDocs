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

#### [**15.1.0-rc2**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.1.0) **(December 20th 2024)**

* Used the name and description defined on the setting attribute for backoffice labels when no client-side localization is available [#1336](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1336).
* Resolved minor backoffice issues when creating and saving prevalue and data sources.
* Resolve issue where maxlength check on input fields was applied to incorrect field [#1342](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1342).

#### [**15.1.0-rc1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.1.0) **(December 17th 2024)**

##### Validation rules across form fields

When creating forms you are able to add validation to individual fields, making them mandatory or applying a regular expression pattern. With the 13.4 release we are looking to make this more powerful, by allowing the addition of validation rules for the entire form. The idea is that this will allow you to validate expressions based on multiple fields. For example, "these two email fields should be the same", or "this date should be after this other one".

Crafting these rules requires use of [JSON logic](https://jsonlogic.com/) so is considered a "power user" feature. They also require an additional front-end dependency for the rendering of forms on the website. As such they are surfaced on a new "Advanced" tab and only visible and used if enabled in configuration. We don't have, and it seems difficult to provide, an intuitive user interface for rule creation taking into account all the flexibility available. Nonetheless, having the ability to use more complex validation rules seems a valuable addition.

When the form is rendered, the validation rules will be applied on the client, where we support both the `aspnet-client-validation` and `jquery.validate` libraries. They are also verified server-side. In this way you can ensure the submission is only accepted if it meets the requirements.

Feedback on this feature in particular is welcome.

Read more about [editing advanced validation rules](./editor/creating-a-form/form-advanced.md) as well as the [configuration option required to enable them](./developer/configuration/README.md#enableadvancedvalidationrules).

##### Tracking editor activity

Whilst previously we tracked and displayed the date a form was created and last edited, we didn't show who had made these updates. With 15.1 installed we will start to track this and display the information where available. You'll find this on the form, data source or prevalue source's "Info" tab [#1315](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1315).

##### Copy of workflows

Forms allows you to make a copy of a form to use as a starting point for a new one. You can choose whether or not to copy workflows along with the form. With the 15.1 release, we've made available a second dialog allowing you to copy workflows to an existing form [#1185](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1185). You can select any or all of the workflows on the current form and copy them to the selected destination form.

We've also resolved an edge case around copying a form. It's possible to [define workflows as mandatory](./developer/extending/customize-default-workflows.md#setting-a-mandatory-default-workflow). Copying the form without workflows excludes the desired workflow. You would have a form that didn't contain the workflow you wanted to be included on all. This has been tightened up now and mandatory workflows will always be assigned to the copied form [#1331](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1331).

##### File upload validation messages

Previously the validation messages presented on the website front end when uploading files were hardcoded and always provided in English. We've added settings now to the "File Upload" field type allowing you to customize these. Dictionary keys can be used in order to provide the information in the user's preferred language [#1327](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1327).

##### Other

Other bug fixes included in the release:

* Fixed issue with applying links to rich text settings on custom field or workflow types [#1329](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1329).

#### [**15.0.3**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.3) **(December 5th 2024)**

* Fixed regression introduced in 15.0.1 that caused issues for custom field types overriding the `ProcessSubmittedValue` method  [#1328](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1328).

#### [**15.0.2**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.2) **(November 28th 2024)**

* Fixed issue with case sensitive checkbox conditions across multi-page forms [#1325](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1325).
* Fixed Forms dashboard form title and icon alignment.
* Migrated rich text features to use the CMS's Tiptap editor [#1326](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1326).
* Fixed issue with creation of folder for forms.

#### [**15.0.1**](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.1) **(November 21st 2024)**

* Fixed issues with multi-page forms used in conjunction with a `FormPrePopulateNotification` handler. File uploads and multi-value fields like checkbox lists now function correctly [#1317](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1317) [#1320](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1320).
* Added a couple of missing translation keys [#1316](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1316) [#1319](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1319).
* Rendered file upload previews in the backoffice.
* Fixed issue with saving the "Hide field validation labels" value when editing form settings.
* Fixed issue with selection of Document Type on the "Save as Umbraco node" workflow type.
* Used correct labels for conditions when used on fields, fieldsets, pages or workflows [#1323](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1323).

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

You can find the release notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/12/umbraco-forms/release-notes.md) and [Umbraco Forms Package page](https://our.umbraco.com/packages/developer-tools/umbraco-forms/).
