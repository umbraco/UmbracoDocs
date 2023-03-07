# Release Notes

In this section, we have summarized the changes to Umbraco Forms released in each version. Each version is presented with a link to the [Forms issue tracker](https://github.com/umbraco/Umbraco.Forms.Issues/issues) showing a list of issues resolved in the release.  We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

We've listed here all changes going back to March 2021 for Forms 8 and above. For details of releases prior to this date, or older versions, please refer to the [package page on our.umbraco.com](https://our.umbraco.com/packages/developer-tools/umbraco-forms/).

## Release History

### [10.3.0-rc001](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.3.0) and [11.1.0-rc001](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F11.1.0) (March 9th 2023)

*   Added form settings to allow for the configuration of which fields are shown in the entries view per form [#336](https://github.com/umbraco/Umbraco.Forms.Issues/issues/336)
*   Added rich text header and footer fields to Razor email workflow [#853](https://github.com/umbraco/Umbraco.Forms.Issues/issues/853)
*   Added option for rich text formatting in the message shown after form submission [#873](https://github.com/umbraco/Umbraco.Forms.Issues/issues/873)
*   Added support for loading workflows from form templates [#909](https://github.com/umbraco/Umbraco.Forms.Issues/issues/909)
*   Added show/hide label option to all relevant field types [#925](https://github.com/umbraco/Umbraco.Forms.Issues/issues/925)
*   Added ability for developers to configure the options for text field validation via regular expression [#936](https://github.com/umbraco/Umbraco.Forms.Issues/issues/936)
*   Provided access to the send Razor email workflow settings via the view model used for the email template [#973](https://github.com/umbraco/Umbraco.Forms.Issues/issues/973)
*   Added configuration to provide default values for form button labels [#985](https://github.com/umbraco/Umbraco.Forms.Issues/issues/985)

### [8.13.7](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.13.7), [9.5.7](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.5.7), [10.2.4](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.2.4) and [11.0.3](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F11.0.3) (March 7th 2023)

*   Improved labeling of workflows [#977](https://github.com/umbraco/Umbraco.Forms.Issues/issues/977)
*   Removed initial brief visibility of fieldset hidden by conditions [#970](https://github.com/umbraco/Umbraco.Forms.Issues/issues/970)
*   Fixed display of "automatic" label associated with workflows when manual approval is not enabled
*   Updated workflow processing to take account of the `IgnoreWorkFlowsOnEdit` setting
*   Fixed issue with empty member properties in the "send to URL" workflow [#984](https://github.com/umbraco/Umbraco.Forms.Issues/issues/984​)
*   Fixed load of XSLT file in send email workflow (V9+) [#974](https://github.com/umbraco/Umbraco.Forms.Issues/issues/974)
*   Added detail of container widths in headless/AJAX API (V10+) [#981](https://github.com/umbraco/Umbraco.Forms.Issues/issues/981)
*   Fixed authorization error after marking a field as non sensitive data (V10+) [#976](https://github.com/umbraco/Umbraco.Forms.Issues/issues/976)
*   Fixed link rendering following use of URL picker from rich text field (V10+) [#972](https://github.com/umbraco/Umbraco.Forms.Issues/issues/972)
*   Fixed issue with magic string replacement for member properties in "sent to URL" workflow (V10+) [#969](https://github.com/umbraco/Umbraco.Forms.Issues/issues/969)
*   Fixed issue with culture specific encoding leading to error with adding user security record (V10+) [#966](https://github.com/umbraco/Umbraco.Forms.Issues/issues/966)
*   Fixed issue where template is not pre-selected in default workflows applied to empty form (V10+)

### [8.13.6](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.13.6), [9.5.6](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.5.6), [10.2.3](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.2.3) and [11.0.2](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F11.0.2) (February 7th 2023)

*   Fixed error with saving form in backoffice that uses a conditionally shown checkbox [#960](https://github.com/umbraco/Umbraco.Forms.Issues/issues/960) [#961](https://github.com/umbraco/Umbraco.Forms.Issues/issues/961)
*   Fixed editing issue with "include sensitive data" flag for workflow [#958](https://github.com/umbraco/Umbraco.Forms.Issues/issues/958)
*   Fixed issue with backoffice editing of conditionally shown mandatory field [#956](https://github.com/umbraco/Umbraco.Forms.Issues/issues/956)
*   Fixed casing regression issue with client-side file names (V9+) [#962](https://github.com/umbraco/Umbraco.Forms.Issues/issues/962)
*   Fixed regression issue with "allowed forms" selection on form picker Data Type (V10+) [#957](https://github.com/umbraco/Umbraco.Forms.Issues/issues/957)
*   Fixed regression issue with saving of reCAPTCHA score (V10+) [#955](https://github.com/umbraco/Umbraco.Forms.Issues/issues/955)
*   Fixed issue with sending of attachments in emails with non-default media storage (V10+) [#952](https://github.com/umbraco/Umbraco.Forms.Issues/issues/952)
*   Fixed reference to incorrect configuration key for scheduled record deletion (V10+) [#951](https://github.com/umbraco/Umbraco.Forms.Issues/issues/951)
*   Fixed issue with magic string replacement in "sent to URL" workflow [#948](https://github.com/umbraco/Umbraco.Forms.Issues/issues/948)

### [8.13.5](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.13.5), [9.5.5](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.5.5), [10.2.2](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.2.2) and [11.0.1](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F11.0.1) (January 17th 2023)

*   Restored ability to theme a specific form [#860](https://github.com/umbraco/Umbraco.Forms.Issues/issues/860)
*   Minified client-side assets shipped for use in themes and field types [#913](https://github.com/umbraco/Umbraco.Forms.Issues/issues/913)
*   Displayed path to selected post form submission page on picker [#931](https://github.com/umbraco/Umbraco.Forms.Issues/issues/931)
*   Added logging to honeypot capture [#911](https://github.com/umbraco/Umbraco.Forms.Issues/issues/911)
*   Fixed CSS validation errors [#932](https://github.com/umbraco/Umbraco.Forms.Issues/issues/932)
*   Fixed issue where an invalid value stored via file upload could lead to media directory removal [#933](https://github.com/umbraco/Umbraco.Forms.Issues/issues/933)
*   Improved performance of backoffice forms search [#940](https://github.com/umbraco/Umbraco.Forms.Issues/issues/940)
*   Added extension method for retrieval of selected prevalues in workflow, resolving issue with delimiter clash and multiple selections [#941](https://github.com/umbraco/Umbraco.Forms.Issues/issues/941)
*   Added support for file uploads via the headless/AJAX API (V10+ only) [#922](https://github.com/umbraco/Umbraco.Forms.Issues/issues/922)
*   Ensured versioning and documentation for headless/AJAX API is scoped only to Forms API controllers (V10+ only)
*   Ensured record values changed in approval workflows are persisted
*   Ensured reference to Configuration class in insert form macro partial view is globally specified to ensure it doesn't clash with other usings (V8 only)
*   Fixed issue with processing of magic string replacements following server-side validation failure [#872](https://github.com/umbraco/Umbraco.Forms.Issues/issues/872)
*   Fixed issue with editing legacy forms in the backoffice that have fieldsets without unique Ids [#944](https://github.com/umbraco/Umbraco.Forms.Issues/issues/944)

### [10.2.1](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.2.1) (November 25th 2022)

*   Fixed issue with conditions and check box lists [#910](https://github.com/umbraco/Umbraco.Forms.Issues/issues/910)[](https://github.com/umbraco/Umbraco.Forms.Issues/issues/899)
*   Fixed regression issue with send to URL email workflow [#912](https://github.com/umbraco/Umbraco.Forms.Issues/issues/912)
*   Ensured newly created field and workflow settings based on checkbox values have an explicit true or false (not empty) setting [#916](https://github.com/umbraco/Umbraco.Forms.Issues/issues/916)
*   Resolved issue with placeholders based on the current page or HTTP context not working on later pages of multi-page forms [#918](https://github.com/umbraco/Umbraco.Forms.Issues/issues/918)
*   Resolved issues with use of reCAPTCHA and file upload fields with the headless API [#920](https://github.com/umbraco/Umbraco.Forms.Issues/issues/920) [#923](https://github.com/umbraco/Umbraco.Forms.Issues/issues/923)
*   Added API key security and the option to disable the anti-forgery token validation for the headless API, for use in server-to-server integrations [#915](https://github.com/umbraco/Umbraco.Forms.Issues/issues/915)
*   Fixed translations and updated links to the new documentation platform [#926](https://github.com/umbraco/Umbraco.Forms.Issues/issues/926)

### [8.13.4](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.13.4) and [9.5.4](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.5.4) (November 15th 2022)

*   Resolved issue with removed field type preventing edit of form [#899](https://github.com/umbraco/Umbraco.Forms.Issues/issues/899)
*   Fixed mandatory data consent not being validated correctly where conditions are set. [#897](https://github.com/umbraco/Umbraco.Forms.Issues/issues/897)
*   Fixed error on export of entries when there are many records to export [#864](https://github.com/umbraco/Umbraco.Forms.Issues/issues/864)
*   Added documentation and base class to allow users to change the location of prevalue source text files. [#789](https://github.com/umbraco/Umbraco.Forms.Issues/issues/789)

### [10.2.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.2.0) (November 8th 2022)

*   All changes listed under 10.2.0-rc001
*   Resolved issue with removed field type preventing edit of form [#899](https://github.com/umbraco/Umbraco.Forms.Issues/issues/899)
*   Added functionality to replace magic strings within the rich text field content [#903](https://github.com/umbraco/Umbraco.Forms.Issues/issues/903)

### [10.2.0-rc001](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.2.0) (October 25th 2022)

*   Headless/AJAX forms API [#730](https://github.com/umbraco/Umbraco.Forms.Issues/issues/730)
*   Automatic removal of entries after configured period [#656](https://github.com/umbraco/Umbraco.Forms.Issues/issues/656)
*   Magic string formatters [#828](https://github.com/umbraco/Umbraco.Forms.Issues/issues/828)
*   Block list and nested content title filter [#170](https://github.com/umbraco/Umbraco.Forms.Issues/issues/170) [#879](https://github.com/umbraco/Umbraco.Forms.Issues/issues/879)
*   Configuration of field and workflow settings [#139](https://github.com/umbraco/Umbraco.Forms.Issues/issues/139) [#134](https://github.com/umbraco/Umbraco.Forms.Issues/issues/134)
*   Improved the messaging displayed to the editor when applying a condition on an empty value. [#886](https://github.com/umbraco/Umbraco.Forms.Issues/issues/886)
*   Set HTML field type for email fields in the provided form templates. [#880](https://github.com/umbraco/Umbraco.Forms.Issues/issues/880)
*   Added support for custom icons for custom field types. [#863](https://github.com/umbraco/Umbraco.Forms.Issues/issues/863)
*   Added configuration to remove the provided email and form templates from selection. [#849](https://github.com/umbraco/Umbraco.Forms.Issues/issues/849)
*   Added the option for a drop-down prompt. [#843](https://github.com/umbraco/Umbraco.Forms.Issues/issues/843)
*   Added details of the current form to the field's view model. [#837](https://github.com/umbraco/Umbraco.Forms.Issues/issues/837)
*   For multi-page forms, skip pages that contain no visible fields due to conditions. [#38](https://github.com/umbraco/Umbraco.Forms.Issues/issues/38)
*   A member key has been added to the RecordFilter object, used when programmatically retrieving a filtered set of form entries.
*   Fixed mandatory data consent not being validated correctly where conditions are set. [#897](https://github.com/umbraco/Umbraco.Forms.Issues/issues/897)
*   Fixed error on export of entries when there are many records to export [#864](https://github.com/umbraco/Umbraco.Forms.Issues/issues/864)
*   Improved condition label display when matching on an empty value. [#886](https://github.com/umbraco/Umbraco.Forms.Issues/issues/886)
*   Added documentation and base class to allow users to change the location of prevalue source text files. [#789](https://github.com/umbraco/Umbraco.Forms.Issues/issues/789)
*   Added configurable prefix for form element Ids.

### [8.13.3](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.13.3), [9.5.3](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.5.3) and [10.1.3](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.1.3) (October 18th 2022)

*   Fixed issue with page button conditions on non-default theme [#893](https://github.com/umbraco/Umbraco.Forms.Issues/issues/893)
*   Handled migration case when switching to store form definitions in the database after install or upgrade to 8.13 [#888](https://github.com/umbraco/Umbraco.Forms.Issues/issues/888)
*   Aligned client and server-side case sensitivity for conditions based on checkbox fields [#875](https://github.com/umbraco/Umbraco.Forms.Issues/issues/875)
*   Ensured duplicate prevalues are handled without error when replacing values with captions in export or email sending [#874](https://github.com/umbraco/Umbraco.Forms.Issues/issues/874)
*   Fixed approve icon display [#870](https://github.com/umbraco/Umbraco.Forms.Issues/issues/870)
*   Fixed menu styling for data source reload [#869](https://github.com/umbraco/Umbraco.Forms.Issues/issues/869)
*   [](https://github.com/umbraco/Umbraco.Forms.Issues/issues/864)Ensured field CSS values are generated without duplicates.
*   Fixed issue with rendering the create menu icon (V10)
*   Disabled spellcheck on password fields.
*   Fixed issue where default workflow when removed on a newly created form is added back on save.
*   Prevented hidden field for record Id from being populated if the feature for editable records is not enabled.

### [8.13.2](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.13.2), [9.5.2](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.5.2) and [10.1.2](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.1.2) (September 13th 2022)

*   Resolved issue with form/theme picker when used with CMS 10.2 by migrating from usage of the umb-overlay directive (V10 only) [#381](https://github.com/umbraco/Umbraco.Forms.Issues/issues/381) [#867](https://github.com/umbraco/Umbraco.Forms.Issues/issues/867)
*   [](https://github.com/umbraco/Umbraco.Forms.Issues/issues/864)Removed rendering of antiforgery token when check is disabled (V8 only) [#859](https://github.com/umbraco/Umbraco.Forms.Issues/issues/859)
*   Restored member details display on entry details view
*   Fixed formatting of default form validation messages
*   Fixed potential null reference when re-indexing form entries (V10 only)
*   Fixed incorrect storage of values posted from forms that were hidden within conditional fieldsets

### [8.13.1](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.13.1), [9.5.1](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.5.1) and [10.1.1](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.1.1) (September 6th 2022)

*   Restored ability to set workflows on approved status even when moderation not used (allowing retrieval of record Id in workflows) [#835](https://github.com/umbraco/Umbraco.Forms.Issues/issues/835)
*   Allowed for workflow retry regardless of result [#838](https://github.com/umbraco/Umbraco.Forms.Issues/issues/838)
*   Fixed display of form state and member details on workflow entries listing [#842](https://github.com/umbraco/Umbraco.Forms.Issues/issues/842​)
*   Fixed issue with date rendering on entry details view [#848](https://github.com/umbraco/Umbraco.Forms.Issues/issues/848)
*   Ensured culture used for workflow re-try is the same as that used when the form was submitted [#851](https://github.com/umbraco/Umbraco.Forms.Issues/issues/851)
*   Cleaned up parameter passing in form field backoffice render and edit views [#854](https://github.com/umbraco/Umbraco.Forms.Issues/issues/854)
*   Fixed case sensitive file issue with Recaptcha V2 field type [#846](https://github.com/umbraco/Umbraco.Forms.Issues/issues/846) (V9+ only)
*   Exposed target object in notifications where not available as a public field (V9+ only)
*   Fixed issue when using conditions based on select lists and prevalues with captions

### [8.13.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.13.0), [9.5.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.5.0) and [10.1.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.1.0) (August 9th 2022)

*   All changes listed under 8.13.0-rc001, 9.5.0-rc001 and 10.1.0-rc001
*   Styling improvements to form and theme picker [#107](https://github.com/umbraco/Umbraco.Forms.Issues/issues/107)[](https://github.com/umbraco/Umbraco.Forms.Issues/issues/814)
*   Mark-up changes for accessibility of button elements [#383](https://github.com/umbraco/Umbraco.Forms.Issues/issues/383)
*   Removed elements types from prevalue source options [#805](https://github.com/umbraco/Umbraco.Forms.Issues/issues/805)
*   Fixed styling and colour of confirm overlay for fieldsets and fields [#808](https://github.com/umbraco/Umbraco.Forms.Issues/issues/808)
*   Added show/hide label option to data consent and text/description fields [#810](https://github.com/umbraco/Umbraco.Forms.Issues/issues/810) [#823](https://github.com/mbraco/Umbraco.Forms.Issues/issues/823)[](https://github.com/umbraco/Umbraco.Forms.Issues/issues/810)
*   Fixed issue with duplication of magic string replacement [#811](https://github.com/umbraco/Umbraco.Forms.Issues/issues/811)
*   Ensured field references in copied forms are updated to the new fields [#815](https://github.com/umbraco/Umbraco.Forms.Issues/issues/815)
*   Fixed validation of mandatory date field [#817](https://github.com/umbraco/Umbraco.Forms.Issues/issues/817)
*   Added tag option for text/description field type [#821](https://github.com/umbraco/Umbraco.Forms.Issues/issues/821)
*   Added additional input type options to text field type [#825](https://github.com/umbraco/Umbraco.Forms.Issues/issues/825)
*   Restored open/edit options to form picker preview [#832](https://github.com/umbraco/Umbraco.Forms.Issues/issues/827)
*   Improved performance of permission related queries [#832](https://github.com/umbraco/Umbraco.Forms.Issues/issues/827) (raised in discussion)

### [10.0.5](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.5) (July 14th 2022)

*   Fixed macro partial view tree so Razor Class Library (RCL) shipped partials from Forms are only shown in the "picker" dialog. [#814](https://github.com/umbraco/Umbraco.Forms.Issues/issues/814)
*   Removed false positive report of missing indexes on tables. [#803](https://github.com/umbraco/Umbraco.Forms.Issues/issues/803)
*   Fixed issue with saving forms in upgrade scenarios, when workflows that have settings introduced after the form was created (and hence null values) [#813](https://github.com/umbraco/Umbraco.Forms.Issues/issues/813)

### [8.13.0-rc001](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.13.0), [9.5.0-rc001](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.5.0) and [10.1.0-rc001](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.1.0) (July 12th 2022)

*   Added workflow audit trail.
*   Added workflow retry option.
*   Added option to customize behaviour of default workflows, including mandatory workflows [#654](https://github.com/umbraco/Umbraco.Forms.Issues/issues/654)
*   Added conditional workflows [#370](https://github.com/umbraco/Umbraco.Forms.Issues/issues/370)
*   Added ability to redirect to an external site from workflows, after all have completed.
*   Extended the form picker to use folder structure [#729](https://github.com/umbraco/Umbraco.Forms.Issues/issues/729​)
*   Added option for prevalue captions [#84](https://github.com/umbraco/Umbraco.Forms.Issues/issues/84​)
*   Ensured user group start folder aggregation for user's permissions doesn't include user groups that don't have access to Forms [#772](https://github.com/umbraco/Umbraco.Forms.Issues/issues/772)
*   Added option for creating permissions on form for user groups to all groups, or all groups the creating user is part of.
*   Provided fixes for issues with rendering localized dates in the backoffice entries view [#777](https://github.com/umbraco/Umbraco.Forms.Issues/issues/777)
*   Added read-only, rich text Data Type (V9 and 10).
*   Friendlier extensions for registering custom types (V10).
*   Added details of page where form was submitted to Excel download [#768](https://github.com/umbraco/Umbraco.Forms.Issues/issues/768​)
*   Added indication of options for "magic strings" when adding fields and workflows to forms. [#765](https://github.com/umbraco/Umbraco.Forms.Issues/issues/765)
*   Ensured order of fields retrieved for a record from the database matches the field order defined on the form. [#661](https://github.com/umbraco/Umbraco.Forms.Issues/issues/661)
*   The trigger for client-side conditions checked can now be configured between "change" (the default) and "input". [#784](https://github.com/umbraco/Umbraco.Forms.Issues/issues/784)
*   Fixed issue with displaying entries where a member's Id was stored as a Guid via a custom membership provider. [#798](https://github.com/umbraco/Umbraco.Forms.Issues/issues/798)
*   Fixed issue with console request for client validation script source map. [#796](https://github.com/umbraco/Umbraco.Forms.Issues/issues/796)
*   Fixed issue with reCAPTCHA V3 field type. [#799](https://github.com/umbraco/Umbraco.Forms.Issues/issues/799)
*   Added a missing translation [#804](https://github.com/umbraco/Umbraco.Forms.Issues/issues/804​)

### [10.0.4](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.4) (July 7th 2022)

*   Fixed issue with incorrect identity setting on user group permission records [#800](https://github.com/umbraco/Umbraco.Forms.Issues/issues/800)
*   Restored partial views shipped in RCL to macro partial view picker.

### [10.0.3](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.3) (July 1st 2022)

*   Fixed issues with send razor workflows related to out of the box template shipping as a razor class library.
    [](https://github.com/umbraco/Umbraco.Forms.Issues/issues/794)

### [10.0.2](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.2) (June 29th 2022)

*   Fixed issue creating user group permission records [#793](https://github.com/umbraco/Umbraco.Forms.Issues/issues/793)[](https://github.com/umbraco/Umbraco.Forms.Issues/issues/794)

### [10.0.1](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.1) (June 28th 2022)

*   Fixed issue with deletes when using SQLite [#792](https://github.com/umbraco/Umbraco.Forms.Issues/issues/792)
*   Fixed nullability issue with prevalues on data consent field [#794](https://github.com/umbraco/Umbraco.Forms.Issues/issues/794)

### [10.0.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.0) (June 16th 2022)

*   Compatibility with .NET 6 and Umbraco 10

### [8.12.2](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.12.2) and [9.4.2](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.4.2) (June 7th 2022)

*   Fixed issue with delete of records in background task (V9 only) [#779](https://github.com/umbraco/Umbraco.Forms.Issues/issues/779)
*   Updated logic for start folder evaluation for user groups to exclude groups that don't have access or permissions for forms [#772](https://github.com/umbraco/Umbraco.Forms.Issues/issues/772)
*   Update built in email workflows to include attachments from all fields that support file uploads [#770](https://github.com/umbraco/Umbraco.Forms.Issues/issues/770)
*   Fixed wrapping for long conditional expressions [#767](https://github.com/umbraco/Umbraco.Forms.Issues/issues/767)
*   Fixed issue with re-presentation of workflow "include sensitive data" setting (V9 only) [#780](https://github.com/umbraco/Umbraco.Forms.Issues/issues/780​)

### [8.12.1](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.12.1) and [9.4.1](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.4.1) (May 10th 2022)

*   Fixed issue with immediate edit of form created by non-admin user [#764](https://github.com/umbraco/Umbraco.Forms.Issues/issues/764)

### [8.12.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.12.0) and [9.4.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.4.0) (April 26th 2022)

*   All changes listed under 8.12.0-rc001 and 9.4.0-rc001
*   Fix issue with using the export to Excel feature on Linux [#761](https://github.com/umbraco/Umbraco.Forms.Issues/issues/761)
*   Fixed issue with saving forms when storing definitions on disk [#762](https://github.com/umbraco/Umbraco.Forms.Issues/issues/762)

### [](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F7.5.8)[8.12.0-rc001](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.12.0) and [9.4.0-rc001](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.4.0) (April 12th 2022)

*   Added support for start folder configuration at user group level [#749](https://github.com/umbraco/Umbraco.Forms.Issues/issues/749)
*   Import/export of forms (V9 only) [#576](https://github.com/umbraco/Umbraco.Forms.Issues/issues/576)
*   Added support for greater than/less than conditions using dates [#506](https://github.com/umbraco/Umbraco.Forms.Issues/issues/506)
*   Added default logging for write and delete operations on forms, datasources and prevalue sources [#731](https://github.com/umbraco/Umbraco.Forms.Issues/issues/731)
*   Removed the links to uploaded files from the default email template (which no longer work by default, given protection is now in place to prevent access from non-authenticated users) [#736](https://github.com/umbraco/Umbraco.Forms.Issues/issues/736)[](https://github.com/umbraco/Umbraco.Forms.Issues/issues/741)
*   Prevented the previous button on multi-page forms from triggering validation (which involved an update to the client-side validation library we have a dependency on, when the website is not referencing jQuery) [#741](https://github.com/umbraco/Umbraco.Forms.Issues/issues/741)​
*   Removed reliance on class names for multi-page form navigation to allow removal in custom themes [#740](https://github.com/umbraco/Umbraco.Forms.Issues/issues/740)
*   Added details of file upload supported extensions to the view model (that can be used in custom themes or field types) [#744](https://github.com/umbraco/Umbraco.Forms.Issues/issues/744)
*   Remove inline scripts from the reCAPTCHA field type (completing the removal of all inline scripts started in the previous release and allowing for the setting of a stricter content security policy) [#745](https://github.com/umbraco/Umbraco.Forms.Issues/issues/745)
*   Fixed issue with date display in the backoffice when localized date formats are in use [#747](https://github.com/umbraco/Umbraco.Forms.Issues/issues/747)
*   Re-added support for some request context magic strings (V9 only) [#750](https://github.com/umbraco/Umbraco.Forms.Issues/issues/750)
*   Restored default permissions for new installs for users to be able to view entries [#753](https://github.com/umbraco/Umbraco.Forms.Issues/issues/753)
*   Added configuration for a default email template to use when a new form is created
*   Removed the Lato Google font from the shipped default email template due to reported privacy concerns
*   Fixed issue with rebuild when razor files are set to be compiled (V9 only) [#738](https://github.com/umbraco/Umbraco.Forms.Issues/issues/738)
*   Fixed issue with integer parsing using Swedish culture settings (V9 only) [#757](https://github.com/umbraco/Umbraco.Forms.Issues/issues/757)
*   Amended the post as XML workflow to no longer throw if the page name can't be determined (as it can't in a Heartcore setup)​​
*   Added option for querystring to indicate form submission which will better support the use of Umbraco pages with forms hosted in IFRAMEs from remote sites [#758](https://github.com/umbraco/Umbraco.Forms.Issues/issues/758).
*   Fixed issue with use of back button returning to form and displaying submission message when previously having redirected to a new page.
*   Fixed issue with access to forms in folders for users with a single start folder defined. [#759](https://github.com/umbraco/Umbraco.Forms.Issues/issues/759)
*   Fixed issue with access to previously created forms for non-admin users. [#764](https://github.com/umbraco/Umbraco.Forms.Issues/issues/764)
*   Resolves issue where an authenticated user with access to Forms can enumerate permissions related to forms access for other users.

### [8.11.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.11.0) and [9.3.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.3.0) (March 8th 2022)

*   All changes listed under 8.11.0-rc001 and 9.3.0-rc001
*   Fixed issue with clean on already cleaned project (V9 only) [#732](https://github.com/umbraco/Umbraco.Forms.Issues/issues/732)
*   Resolved client-side error when just the jquery unobtrusive dependency is missing [#734](https://github.com/umbraco/Umbraco.Forms.Issues/issues/734)
*   Fixed two typos in labels [#727](https://github.com/umbraco/Umbraco.Forms.Issues/issues/727)

### [8.11.0-rc001](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.11.0) and [9.3.0-rc001](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.3.0) (February 15th 2022)

*   Config for control over user access to new forms [#12](https://github.com/umbraco/Umbraco.Forms.Issues/issues/12)
*   Management of form permissions by user group [#19](https://github.com/umbraco/Umbraco.Forms.Issues/issues/19)
*   Separated permissions for form "design" and "entry viewer" [#3](https://github.com/umbraco/Umbraco.Forms.Issues/issues/3)
*   Setting of start folders for users
*   Added permission and feature for editing entries via the back-office [#498](https://github.com/umbraco/Umbraco.Forms.Issues/issues/498)
*   Added migration and healthcheck for missing index following V7 upgrade [#713](https://github.com/umbraco/Umbraco.Forms.Issues/issues/713)
*   Allow tracking of calculated score in reCAPTCHA checks [#664](https://github.com/umbraco/Umbraco.Forms.Issues/issues/664)
*   Removed use of inline scripts allowing setting of a stricter content security policy [#677](https://github.com/umbraco/Umbraco.Forms.Issues/issues/677)
*   Fixed typos in setting description (V9 only) [#710](https://github.com/umbraco/Umbraco.Forms.Issues/issues/710)
*   Fixed timezone conversion on entries viewer [#723](https://github.com/umbraco/Umbraco.Forms.Issues/issues/723)
*   Fixed null reference in back-office user check for retrieving records outside of a back-office request [#724](https://github.com/umbraco/Umbraco.Forms.Issues/issues/724)
*   Fixed case insensitive view name under forms security (V9 only) [#725](https://github.com/umbraco/Umbraco.Forms.Issues/issues/725)
*   Additional translations for localized back-office: Czech and Danish.

### [8.10.3](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.10.3) and [9.2.2](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.2.2) (February 15th 2022)

*   Removed rendering of content apps within the Forms section for older versions of CMS that don't support content apps in sections other than content and media (V8 only) [#714](https://github.com/umbraco/Umbraco.Forms.Issues/issues/714)
*   Fixed issue with XSLT file selection from media when media isn't using the local folder system [#715](https://github.com/umbraco/Umbraco.Forms.Issues/issues/715)
*   Removed duplicate slash in form tree URL to allow opening in new window [#717](https://github.com/umbraco/Umbraco.Forms.Issues/issues/717)
*   Ensured reCAPTCHA v3 score is updated when clicking on slider labels [#720](https://github.com/umbraco/Umbraco.Forms.Issues/issues/720)
*   Fixed casing issues with field type partial views (V9 only) [#718](https://github.com/umbraco/Umbraco.Forms.Issues/issues/718)
*   Fixed issue with distributed cache refreshing (V9 only) [#712](https://github.com/umbraco/Umbraco.Forms.Issues/issues/712)

### [8.10.2](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.10.2) (February 1st 2022)

*   Reverted change to default config introduced in 8.10.0 [#711](https://github.com/umbraco/Umbraco.Forms.Issues/issues/711)
*   Fixed typos in setting description [#710](https://github.com/umbraco/Umbraco.Forms.Issues/issues/710)
*   Removed unnecessary display of license restrictions in Umbraco Cloud

### [8.10.1](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.10.1) and [9.2.1](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.2.1) (January 25th 2022)

*   Specified serialization settings used by Forms avoiding issues with changes to global defaults [#264](https://github.com/umbraco/Umbraco.Forms.Issues/issues/264)
*   Resolved various issues related to conditional form logic [#623](https://github.com/umbraco/Umbraco.Forms.Issues/issues/623) [#686](https://github.com/umbraco/Umbraco.Forms.Issues/issues/686) [#689](https://github.com/umbraco/Umbraco.Forms.Issues/issues/689) [#693](https://github.com/umbraco/Umbraco.Forms.Issues/issues/693) [#695](https://github.com/umbraco/Umbraco.Forms.Issues/issues/695)
*   Updated email template to support multiple file upload fields [#691](https://github.com/umbraco/Umbraco.Forms.Issues/issues/691)
*   Fixed issue introduced by localization of workflow details [#692](https://github.com/umbraco/Umbraco.Forms.Issues/issues/692)
*   Ensured list of licensed domains on dashboard includes the full set allocated to the license [#697](https://github.com/umbraco/Umbraco.Forms.Issues/issues/697)
*   Fixed rendering of HTML entities in form titles in the back-office [#699](https://github.com/umbraco/Umbraco.Forms.Issues/issues/699)
*   Fixed issue with back-office delete of form with > 2000 associated entries [#700](https://github.com/umbraco/Umbraco.Forms.Issues/issues/700)
*   Removed duplicate type attribute from rendered form scripts [#690](https://github.com/umbraco/Umbraco.Forms.Issues/issues/690)
*   Fixed issue with distributed cache refreshing (V9 only) [#687](https://github.com/umbraco/Umbraco.Forms.Issues/issues/687)

### [8.10.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.10.0) and [9.2.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.2.0) (December 21st 2021)

*   All updates listed under 8.10.0-rc001 and 9.2.0-rc001.
*   Fixed casing issues causing issues with running on Linux [#680](https://github.com/umbraco/Umbraco.Forms.Issues/issues/680) [#682](https://github.com/umbraco/Umbraco.Forms.Issues/issues/682)
*   Added support for V8 syntax for the remote address placeholder [#685](https://github.com/umbraco/Umbraco.Forms.Issues/issues/685)

### [8.10.0-rc001](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.10.0) and [9.2.0-rc001](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.2.0) (December 7th 2021)

*   Localized backoffice for the Forms section [#267](https://github.com/umbraco/Umbraco.Forms.Issues/issues/267)
*   Added support for content apps alongside forms [#653](https://github.com/umbraco/Umbraco.Forms.Issues/issues/653)
*   Additional settings for text fields
*   Enhanced security for file uploads [#11](https://github.com/umbraco/Umbraco.Forms.Issues/issues/11)
*   Fixed issues relating to the Umbraco Documents prevalue source [#638](https://github.com/umbraco/Umbraco.Forms.Issues/issues/638)
*   Added details available in save events to detect and act on forms or folders being moved [#667](https://github.com/umbraco/Umbraco.Forms.Issues/issues/667)
*   Applied dictionary translations to form fields displayed in backoffice entries viewer. [#672](https://github.com/umbraco/Umbraco.Forms.Issues/issues/672)
*   Resolved issue with field type script rendering when multiple forms are displayed on a page. [#670](https://github.com/umbraco/Umbraco.Forms.Issues/issues/670)
*   Completed support for client-side views to be created outside of the _App\_Plugins_ folder, thus being retained following a _dotnet clean_ (V9 only). [#13](https://github.com/umbraco/Umbraco.Forms.Issues/issues/13)
*   Added fallback to default configured SMTP sender address (V9 only). [#676](https://github.com/umbraco/Umbraco.Forms.Issues/issues/676)
*   Fixed casing issue referencing default theme stylesheet (V9 only) [#680](https://github.com/umbraco/Umbraco.Forms.Issues/issues/680)

### [8.9.1](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.9.1) and [9.1.1](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.1.1) (November 23rd 2021)

*   Fixed issue with use of conditions dependent on dictionary item values [#671](https://github.com/umbraco/Umbraco.Forms.Issues/issues/671)
*   Fixed issue with member field replacements (V9 only) [#674](https://github.com/umbraco/Umbraco.Forms.Issues/issues/674)

### [8.9.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.9.0) and [9.1.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.1.0) (November 16th 2021)

*   All updates listed under 8.9.0-rc001 and 9.1.0-rc001.
*   Fixed copy form dialog (v9) [#669](https://github.com/umbraco/Umbraco.Forms.Issues/issues/669)

### [8.9.0-rc001](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.9.0) and [9.1.0-rc001](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.1.0) (November 2nd 2021)

*   Conditional display of "submit" or "next/previous" buttons [#18](https://github.com/umbraco/Umbraco.Forms.Issues/issues/18)
*   Include form details in "Sent to URL" workflow [#569](https://github.com/umbraco/Umbraco.Forms.Issues/issues/569)
*   Download submitted files organised by entry [#626](https://github.com/umbraco/Umbraco.Forms.Issues/issues/626)
*   Ensured first field with validation error gets focus [#602](https://github.com/umbraco/Umbraco.Forms.Issues/issues/602)
*   [](https://github.com/umbraco/Umbraco.Forms.Issues/issues/18)Fixed null reference exception when deleting records within workflows. [#100](https://github.com/umbraco/Umbraco.Forms.Issues/issues/100)
*   Fixed issue where check-boxes are used in conditions. [#192](https://github.com/umbraco/Umbraco.Forms.Issues/issues/192)
*   Added missing custom CMS class to text field template. [#484](https://github.com/umbraco/Umbraco.Forms.Issues/issues/484)
*   Show list of licensed domains in the back-office. [#629](https://github.com/umbraco/Umbraco.Forms.Issues/issues/629)
*   Restored behaviour of excluding scripts when rendering forms to only do so when explicitly requested to. [#634](https://github.com/umbraco/Umbraco.Forms.Issues/issues/634)
*   Added a new event to support hooking into form entry display in the back-office. [#639](https://github.com/umbraco/Umbraco.Forms.Issues/issues/639)
*   Ensured when forms are created from templates that they have unique page, fieldset and field Ids. [#647](https://github.com/umbraco/Umbraco.Forms.Issues/issues/647)
*   Fixed issue with saving of forms with sensitive data by editors not in the sensitive data user group. [#652](https://github.com/umbraco/Umbraco.Forms.Issues/issues/652)
*   Removed display of fields in email template that have no expected user input. [#659](https://github.com/umbraco/Umbraco.Forms.Issues/issues/659)
*   Amended the “-ing” events (e.g. “Saving”) to be cancellable and allow changes to the object being saved. [#663](https://github.com/umbraco/Umbraco.Forms.Issues/issues/663)
*   Added a field type property to hide the mandatory option where it’s not appropriate (i.e. where there’s no expected user input). [#665](https://github.com/umbraco/Umbraco.Forms.Issues/issues/665)
*   Ensured consistent ordering of setting fields [#649](https://github.com/umbraco/Umbraco.Forms.Issues/issues/649) (V9 only)
*   Avoid clash of constants in field type views [#657](https://github.com/umbraco/Umbraco.Forms.Issues/issues/657)

### [9.0.1](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F9.0.1) (October 12th 2021)

*   Updates templates to load partials asynchronously [#645](https://github.com/umbraco/Umbraco.Forms.Issues/issues/645)

### 9.0.0 (September 27th 2021)

*   V9 release on .NET 5 compatible with CMS V9.

### [8.8.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.8.0) (September 14th 2021)

*   All updates listed for 8.8.0-rc001
*   Better handle deleted form when content linked to that form [#635](https://github.com/umbraco/Umbraco.Forms.Issues/issues/635)
*   Fixed issue with re-submitted edited form records that include file uploads [#632](https://github.com/umbraco/Umbraco.Forms.Issues/issues/632)
*   Added validation message when a file upload is configured to accept no file types [#631](https://github.com/umbraco/Umbraco.Forms.Issues/issues/631)
*   Updated styling of form page and group titles to better indicate that they are editable [#636](https://github.com/umbraco/Umbraco.Forms.Issues/issues/636)
*   Fix for incorrect validation of mandatory file upload fields [#110](https://github.com/umbraco/Umbraco.Forms.Issues/issues/110)

### [8.8.0-rc001](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F8.8.0) (August 19th 2021)

*   Structure forms in folders [#75](https://github.com/umbraco/Umbraco.Forms.Issues/issues/75)
*   Fixed conditional field value being recorded when conditions not met [#292](https://github.com/umbraco/Umbraco.Forms.Issues/issues/292)
*   Autocomplete attributes for forms and fields [#322](https://github.com/umbraco/Umbraco.Forms.Issues/issues/322)
*   Workflow UX tidy-up [#334](https://github.com/umbraco/Umbraco.Forms.Issues/issues/334)
*   Fixed prevalue sources not finding grandchildren [#365](https://github.com/umbraco/Umbraco.Forms.Issues/issues/365)
*   Configuration of a default theme [#398](https://github.com/umbraco/Umbraco.Forms.Issues/issues/398)
*   Added busy indicator when exporting to Excel and performing record set operations [#419](https://github.com/umbraco/Umbraco.Forms.Issues/issues/419) [#575](https://github.com/umbraco/Umbraco.Forms.Issues/issues/575)
*   Ensured form submissions with message display follow post/redirect/get pattern [#485](https://github.com/umbraco/Umbraco.Forms.Issues/issues/485) [#572](https://github.com/umbraco/Umbraco.Forms.Issues/issues/572) [#593](https://github.com/umbraco/Umbraco.Forms.Issues/issues/593)
*   Added ability to toggle field labels [#530](https://github.com/umbraco/Umbraco.Forms.Issues/issues/530)
*   Added link to page where form was submitted from back-office entry screen [#607](https://github.com/umbraco/Umbraco.Forms.Issues/issues/607)
*   Fixed icons for answer types display [#610](https://github.com/umbraco/Umbraco.Forms.Issues/issues/610)
*   Fixed display of grid picker form preview [#612](https://github.com/umbraco/Umbraco.Forms.Issues/issues/612)
*   Ensured workflow settings updates saved only when submitting and not closing dialog [#613](https://github.com/umbraco/Umbraco.Forms.Issues/issues/613)
*   Fixed issue with conditional fields when forms are copied [#624](https://github.com/umbraco/Umbraco.Forms.Issues/issues/624)
*   Fixed issue with settings validation of prevalues with custom field types [#627](https://github.com/umbraco/Umbraco.Forms.Issues/issues/627)

### 4.4.9, 6.1.0 (August 3rd 2021)

*   Resolved regression issue introduced by security patch for uploaded media paths.

### 4.4.8, 6.0.9, 7.0.7, 7.1.4, 7.2.1, 7.3.2, 7.4.3, 7.5.4, 8.0.2, 8.1.6, 8.2.3, 8.3.4, 8.4.4, 8.5.7, 8.6.2, 8.7.6 (July 20th 2021)

*   Resolution of security vulnerability (see [blog post](https://umbraco.com/blog/security-advisory-20th-of-july-2021-patch-is-now-available/)).

### [8.7.5](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=label%3Arelease%2F8.7.5+is%3Aclosed) (July 6th 2021)

*   Resolved JavaScript incompatibility issues with IE11 [#601](https://github.com/umbraco/Umbraco.Forms.Issues/issues/601)
*   Fixed bug with sending static values in "Send to URL" workflow [#597](https://github.com/umbraco/Umbraco.Forms.Issues/issues/597)
*   Displayed visual indicator of conditions applied to form groups] [#590](https://github.com/umbraco/Umbraco.Forms.Issues/issues/590)
*   Handled escaping of pre-values with apostrophes when used in conditions [#456](https://github.com/umbraco/Umbraco.Forms.Issues/issues/456)
    *   _Note that this change has required a minor amend to the Script.cshtml partial view, so if you've modified this in your installation and don't simply copy over from the update, you should review to ensure you apply the update._
*   Added script attributes to avoid incompatibility issues with vuejs [#311](https://github.com/umbraco/Umbraco.Forms.Issues/issues/311)
*   Fixed reCAPTCHA v3 slider issue when score threshold set to value of 0
*   Confirmed resolution of duplicate form name exception caused when copying forms [#425](https://github.com/umbraco/Umbraco.Forms.Issues/issues/425)

### [8.7.4](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=label%3Arelease%2F8.7.4+is%3Aclosed) (June 15th 2021)

*   Resolved exception thrown when editing a form entry via an invalid ID or with an ID for a different form [#584](https://github.com/umbraco/Umbraco.Forms.Issues/issues/584)
*   Fixed issue where editing a form entry with a deleted field generates an exception [#583](https://github.com/umbraco/Umbraco.Forms.Issues/issues/583)
*   Fixed issue with non-active workflows being processed [#582](https://github.com/umbraco/Umbraco.Forms.Issues/issues/582)
*   Fixed error triggered by form containing no fields that store data [#580](https://github.com/umbraco/Umbraco.Forms.Issues/issues/580)
*   Reduced level of log messages related to reCAPTCHA field type [#573](https://github.com/umbraco/Umbraco.Forms.Issues/issues/573)
*   Resolved issue with use of reCAPTCHA field type on multiple forms on the same page [#571](https://github.com/umbraco/Umbraco.Forms.Issues/issues/571)
*   Resolved issue with copy form function when form storage configuration key is missing [#567](https://github.com/umbraco/Umbraco.Forms.Issues/issues/567)
*   Resolved bug with back-office data filter in non-English locales - [#560](https://github.com/umbraco/Umbraco.Forms.Issues/issues/560)
*   Removed use of obsolete methods in reCAPTCHA field type [#557](https://github.com/umbraco/Umbraco.Forms.Issues/issues/557)
*   Added cache invalidation for member properties when used for "magic strings" [#534](https://github.com/umbraco/Umbraco.Forms.Issues/issues/534)

### [8.7.3](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=label%3Arelease%2F8.7.3+is%3Aclosed) (May 18th 2021)

*   Fixed issue with migrations using SQL CE [#559](https://github.com/umbraco/Umbraco.Forms.Issues/issues/559)
*   Aligned text field maxlength attribute with database field size [#563](https://github.com/umbraco/Umbraco.Forms.Issues/issues/563)
*   Removed unnecessary rendering of validation framework requirement when form previewed in a rich text editor [#562](https://github.com/umbraco/Umbraco.Forms.Issues/issues/562)
*   Optimised loading of form record counts in the backoffice dashboard [#561](https://github.com/umbraco/Umbraco.Forms.Issues/issues/561)
*   Added support for multiple forms on one page using recaptchaV3 [#556](https://github.com/umbraco/Umbraco.Forms.Issues/issues/556)
*   Resolved JavaScript console errors found on the backoffice security settings page [#505](https://github.com/umbraco/Umbraco.Forms.Issues/issues/505)
*   Restored create datasource based on webservice functionality [#265](https://github.com/umbraco/Umbraco.Forms.Issues/issues/265)
*   Resolved issue with save of uploaded files when a pre-populate event is registered [#177](https://github.com/umbraco/Umbraco.Forms.Issues/issues/177)

### [8.7.2](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=label%3Arelease%2F8.7.2+is%3Aclosed) (May 11th 2021)

*   Style backoffice preview for Recaptcha3 field type [#552](https://github.com/umbraco/Umbraco.Forms.Issues/issues/552)
*   Fixed issue with validation retained when answer type changed [#548](https://github.com/umbraco/Umbraco.Forms.Issues/issues/548)
*   Fixed issue with previous button link in multi-page forms [#547](https://github.com/umbraco/Umbraco.Forms.Issues/issues/547)
*   Fixed issue with save of text area number of rows setting [#544](https://github.com/umbraco/Umbraco.Forms.Issues/issues/544)
*   Fixed issue with copy of workflows when copying form, and added user selection for this operation [#543](https://github.com/umbraco/Umbraco.Forms.Issues/issues/543)
*   Added placeholder to datepicker field type [#537](https://github.com/umbraco/Umbraco.Forms.Issues/issues/537)
*   Fixed issue with Examine component registration [#535](https://github.com/umbraco/Umbraco.Forms.Issues/issues/535)
*   Aligned styling of delete button with core [#528](https://github.com/umbraco/Umbraco.Forms.Issues/issues/528)
*   Updated styling of copy form dialog [#527](https://github.com/umbraco/Umbraco.Forms.Issues/issues/527)
*   Updated styling of disabled add column button for form groups [#526](https://github.com/umbraco/Umbraco.Forms.Issues/issues/526)
*   Added option for creating a multi-select select list [#473](https://github.com/umbraco/Umbraco.Forms.Issues/issues/473)
*   Added missing default form setting configuration entry [#369](https://github.com/umbraco/Umbraco.Forms.Issues/issues/369)
*   Made the body text component of the "title and description" field type a text area [#326](https://github.com/umbraco/Umbraco.Forms.Issues/issues/326)
*   Fixed issue with conditional field rendering [#207](https://github.com/umbraco/Umbraco.Forms.Issues/issues/207)
*   Removed some legacy, commented-out code from backoffice JavaScript [#148](https://github.com/umbraco/Umbraco.Forms.Issues/issues/148)

### [8.7.1](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=label%3Arelease%2F8.7.1+is%3Aclosed) (Apr 13th 2021)

*   Resolves error loading form record totals in dashboard [#525](https://github.com/umbraco/Umbraco.Forms.Issues/issues/525)
*   Resolves error with conditional form fields [#531](https://github.com/umbraco/Umbraco.Forms.Issues/issues/531)

### [8.7.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=label%3Arelease%2F8.7.0+is%3Aclosed) (Apr 6th 2021)

*   Changes from 8.7.0 RC
*   Use range slider component in reCAPTCHA v3 [#507](https://github.com/umbraco/Umbraco.Forms.Issues/issues/507)
*   Use toggle for enabled/disabled settings [#508](https://github.com/umbraco/Umbraco.Forms.Issues/issues/508)
*   Ensure overlays close with Esc key [#509](https://github.com/umbraco/Umbraco.Forms.Issues/issues/509)
*   Aligned caret in conditions overlay [#510](https://github.com/umbraco/Umbraco.Forms.Issues/issues/510)
*   Removed use of turquoise colour [#511](https://github.com/umbraco/Umbraco.Forms.Issues/issues/511)
*   Added clear line between conditions [#512](https://github.com/umbraco/Umbraco.Forms.Issues/issues/512)
*   Prevented addition of empty file extension on file upload [#516](https://github.com/umbraco/Umbraco.Forms.Issues/issues/516)
*   Improved UI for file upload types [#517](https://github.com/umbraco/Umbraco.Forms.Issues/issues/517)
*   Prevented password managers acting on form group and page name fields [#518](https://github.com/umbraco/Umbraco.Forms.Issues/issues/518)
*   Updated styling on re-order button [#519](https://github.com/umbraco/Umbraco.Forms.Issues/issues/519)
*   Set upper limit on number of columns in form group [#520](https://github.com/umbraco/Umbraco.Forms.Issues/issues/520)
*   Updated reCAPTCHA v3 to function on submut buttons as well as inputs [#521](https://github.com/umbraco/Umbraco.Forms.Issues/issues/521)
*   Sanitise for field names when the sort option is provided in the backoffice record filter request.
*   Applied fix for issue with conditionals that are not on the first page [#462](https://github.com/umbraco/Umbraco.Forms.Issues/issues/462)
*   Resolved issue with conditional logic - [#273](https://github.com/umbraco/Umbraco.Forms.Issues/issues/273) and [#522](https://github.com/umbraco/Umbraco.Forms.Issues/issues/522)

### [8.7.0 (RC)](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=label%3Arelease%2F8.7.0+is%3Aclosed) (Mar 23rd 2021)

*   Addition of database integrity constraints and introduction of healthcheck for verification [#475](https://github.com/umbraco/Umbraco.Forms.Issues/issues/475)
*   Created a new Recaptcha3 field type [#455](https://github.com/umbraco/Umbraco.Forms.Issues/issues/455)
*   Added a new Slack workflow type using the currently supported method for integration [#482](https://github.com/umbraco/Umbraco.Forms.Issues/issues/482)
*   Configuration of file upload to support single or multiple file uploads, and fixed validation to ensure that all files uploaded are checked for permitted file extensions [#499](https://github.com/umbraco/Umbraco.Forms.Issues/issues/499)
*   Added configuration to remove the automatic addition of the data consent field if it’s not required [#318](https://github.com/umbraco/Umbraco.Forms.Issues/issues/318)
*   Support editing of prevalues (without having to delete and re-add) [#193](https://github.com/umbraco/Umbraco.Forms.Issues/issues/193)
*   Added additional properties to the view model used for the Razor email workflow, allowing reference to the page URlL, form name and submitted date [#379](https://github.com/umbraco/Umbraco.Forms.Issues/issues/379)
*   Improved performance of form rendering by avoidance of use of IContentService [#400](https://github.com/umbraco/Umbraco.Forms.Issues/issues/400)
*   Copying of form fields [#200](https://github.com/umbraco/Umbraco.Forms.Issues/issues/200)
*   Copying of form field groups [#324](https://github.com/umbraco/Umbraco.Forms.Issues/issues/324)
*   Add links from form picker through to form edit and entries screens [#368](https://github.com/umbraco/Umbraco.Forms.Issues/issues/368)
*   Added support for “magic string” replacement in settings (in particular, the “accept” copy in the data content field type [#242](https://github.com/umbraco/Umbraco.Forms.Issues/issues/242)
*   Add options for CC and BCC addresses in workflow emails [#457](https://github.com/umbraco/Umbraco.Forms.Issues/issues/457)
*   Added configuration for the number of rows to render the long answer text area field [#113](https://github.com/umbraco/Umbraco.Forms.Issues/issues/113)
*   Removed “approve” actions when they aren’t relevant for a form [#304](https://github.com/umbraco/Umbraco.Forms.Issues/issues/304)
*   Tightened email address validation [#474](https://github.com/umbraco/Umbraco.Forms.Issues/issues/474)
*   Added styling indicating when a workflow is inactive [#464](https://github.com/umbraco/Umbraco.Forms.Issues/issues/464)
*   Fixed error with saving of datasource [#497](https://github.com/umbraco/Umbraco.Forms.Issues/issues/497)
*   Fixed error with creating a new form with duplicate aliases [#172](https://github.com/umbraco/Umbraco.Forms.Issues/issues/172)
*   Ensured field settings are validated server-side when fields are added to forms [#433](https://github.com/umbraco/Umbraco.Forms.Issues/issues/433)
*   Resolved an incorrect namespace [#488](https://github.com/umbraco/Umbraco.Forms.Issues/issues/488)
*   Ensured mandatory radio-buttons are validated client-side [#487](https://github.com/umbraco/Umbraco.Forms.Issues/issues/487)
*   Ensured currently configured media system is used for email attachments [#477](https://github.com/umbraco/Umbraco.Forms.Issues/issues/477)
*   Removed erroneous email send logging [#439](https://github.com/umbraco/Umbraco.Forms.Issues/issues/439)
*   Ensured that values changed in custom workflows are retained [#431](https://github.com/umbraco/Umbraco.Forms.Issues/issues/431)
*   Added support to the save as Umbraco node workflow to be able to save to properties defined on a composition [#463](https://github.com/umbraco/Umbraco.Forms.Issues/issues/463)
*   Removed (unnecessary but broken) reload button from form entries
*   Fixed issue with selection of XSLT file in Razor email workflow [#348](https://github.com/umbraco/Umbraco.Forms.Issues/issues/348)
*   Fixed issues with saving of all fields in the field mapper [#350](https://github.com/umbraco/Umbraco.Forms.Issues/issues/350) and [#414](https://github.com/umbraco/Umbraco.Forms.Issues/issues/414)
*   Ensured that a copied form has new generated unique Ids for fields [#476](https://github.com/umbraco/Umbraco.Forms.Issues/issues/476)
*   Fixed issue with saving a workflow as inactive.
*   Fixed issue where “message on submit” for a form gets cleared after editing workflows [#502](https://github.com/umbraco/Umbraco.Forms.Issues/issues/502)
*   Tidied up field re-ordering interface.
*   Aligned check and radio button rendering with CMS [#382](https://github.com/umbraco/Umbraco.Forms.Issues/issues/382)
*   Render placeholders in field previews [#483](https://github.com/umbraco/Umbraco.Forms.Issues/issues/483)
*   Workflow picker and form create dialog styling tidy up [#303](https://github.com/umbraco/Umbraco.Forms.Issues/issues/303)
*   Replaced use of standard JavaScript confirmation for deletes with Umbraco standard overlay or confirmation prompts [#197](https://github.com/umbraco/Umbraco.Forms.Issues/issues/197)
*   Tidied up styling on the prevalues editor [#218](https://github.com/umbraco/Umbraco.Forms.Issues/issues/218)
*   Tidied up styling on the form entry screen [#135](https://github.com/umbraco/Umbraco.Forms.Issues/issues/135)
*   Tidied up styling on the form picker [#219](https://github.com/umbraco/Umbraco.Forms.Issues/issues/219)
*   Tidied up styling on the form security page [#380](https://github.com/umbraco/Umbraco.Forms.Issues/issues/380)
*   Better error messaging on unsupported migrations [#401](https://github.com/umbraco/Umbraco.Forms.Issues/issues/455)

Breaking changes:

*   In introducing CC and BCC email addresses for workflow based email sending (#457), we've needed to add a new method to _IWorkflowEmailService_. If anyone has a custom implementation of this interface, it will need to be amended to implement this new method.