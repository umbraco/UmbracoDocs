---
versionFrom: 7.0.0
meta.Title: "Umbraco Forms configuration"
meta.Description: "In Umbraco Forms it's possible to customize the functionality with various configuration values."
---

# Configuration
With Umbraco Forms it's possible to customize the functionality with various configuration values.

## Editing configuration values
The configuration for Umbraco Forms can be changed by modifying the XML based config file found at `/App_Plugins/UmbracoForms/UmbracoForms.config`

### UploadStorageDirectory
This is *legacy and is no longer in use* - Forms that use an upload field will use the same IFileSystem as the [media section](../IFileSystem/#forms-containing-upload-fields)

### IgnoreWorkFlowsOnEdit
This configuration expects `True` or `False` and allows you to toggle if a form submission is edited again, that the workflows on the form will re-fire after an update to the form submission. This is used in conjunction with the `AllowEditableFormSubmissions` configuration value.

### ExecuteWorkflowAsync
This configuration key is *experimental* and will allow Workflows to be executed in an async manner<br/>
The value can be `True/False` or a list of form names that ignore workflows that are comma separated `form name,contact form`

### DisableFormCaching
This configuration value expects a `True/False` value and can be used to toggle if Forms should be read from the JSON representation on disk or from the relevant Forms IFileSystem. Forms are cached for 10 minutes.

### DisableDefaultWorkflow
This configuration value expects a `True/False` value and can be used to toggle if new forms that are created adds an email workflow to send the result of the form to the current user who created the form.

### DisableAutomaticAdditionOfDataConsentField
This configuration value expects a `True/False` value and can be used to disable the feature where all new forms are provided with a default "Consent for storing submitted data" field on creation.

### DisableFileUploadAccessProtection
In Umbraco Forms 8.10.0, protection was added to uploaded files to prevent users from accessing them if they aren't logged into the backoffice and have permission to manage the form for which the file was submitted. As a policy of being "secure by default", the out of the box behavior is that this access protection is in place.

If for any reason you need to revert to the previous behavior, or have other reasons where you want to permit unauthenticated users from accessing the files, you can turn off this protection by setting this configuration value to `true`.

### DisableRecordIndexing
Set this value to `true` to disable the default behavior of indexing the form submissions into the Examine index.

If indexing has already occurred, you will still need to manually remove the files (found in `App_Data\TEMP\ExamineIndexes\UmbracoFormsRecords`). They will be recreated if indexing is subsequently re-enabled.

### DefaultUserAccessToNewForms
In Umbraco Forms 8.11.0, this setting was added to add control over access to new forms.  The default behavior is for all users to be granted access to newly created forms. To amend that to deny access,
the setting can be updated to a value of `Deny`.  A value of `Grant` or a configuration file with the setting absent preserves the default behavior.

### ManageSecurityWithUserGroups
Umbraco Forms 8.11.0 introduced the ability to administer access to Umbraco Forms using Umbraco's user groups. This can be used instead or in addition to the legacy administration which is at the level of the individual user.  Set this option to `true` to enable the user group permission management functionality.

### GrantAccessToNewFormsForUserGroups
Also introduced in Umbraco Forms 8.11.0, this setting takes a comma-separated list of user group aliases which will be granted access automatically to newly created forms.  This setting only takes effect when `ManageSecurityWithUserGroups` is set to `true`.

There are two "special" values that can be applied within or instead of the comma-separated list.

A value of `all` will give access to the form to all user groups.

A value of `form-creator` will give access to all the user groups that the user who created the form is part of.

### AllowEditableFormSubmissions
This configuration value expects a `True/False` value and can be used to toggle the functionality to allow a form submission to be editable and re-submitted. When the value is set to `True` it allows Form Submissions to be edited using the following querystring for the page containing the form on the site. `?recordId=GUID` Replace `GUID` with the GUID of the form submission.

:::warning
Enable this feature ONLY if you do understand the security implications.
:::

### RecaptchaPublicKey & RecaptchaPrivateKey
Both of these configuration values are needed in order to use the "*Recaptcha2*" field type implementing legacy ReCaptcha V2 from Google. You can obtain both of these values after signing up to create a ReCaptcha key here - https://www.google.com/recaptcha/admin

Google has renamed these recently and the `Site Key` refers to `RecaptchaPublicKey` and `Secret Key` is to be used for `RecaptchaPrivateKey`

### RecaptchaV3SiteKey & RecaptchaV3PrivateKey
Both of these configuration values are needed in order to use the "*reCAPTCHA V3 with Score*" field type implementing ReCaptcha V3 from Google. This field type is available in Umbraco Forms from v8.7+.

You can obtain both of these values after signing up to create a ReCaptcha key here:  https://www.google.com/recaptcha/admin.

### DatePickerYearRange
This setting is used to configure the Date Picker form field range of years that is available in the date picker. By default this is a small range of 10 years.

### TitleAndDescriptionAllowUnsafeHtmlRendering

When using the "title and description" field type, editors can provide HTML in the "description" field and have that rendered on the website.

As a tightened security measure, you can set this value to `false`` which will ensure HTML is no longer rendered.

As some installations may be relying on HTML rendering, to preserve backward compatible behavior the default value of this setting is `true`.

### EnableAntiForgeryToken
This setting needs to be a `True` or `False` value and will enable the ASP.NET Anti Forgery Token and we recommend that you enable this and set this to `True`.

If set to `True` then you need to ensure to add `@Html.AntiForgeryToken()` to your forms. The default template for Forms can be found in `~/Views/Partials/Forms/Form.cshtml` and has `@Html.AntiForgeryToken()` in the `@using (Html.BeginUmbracoForm [...]` block.

In certain circumstances, including hosting pages with forms in IFRAMEs from other websites, this may need to be set to `False`.

### AppendQueryStringOnRedirectAfterFormSubmission

When redirecting following a form submission, a `TempData` value is set that is used to ensure the submission message is displayed rather than the form itself. In certain situations, such as hosting pages with forms in IFRAMEs from other websites, this value is not persisted between requests.

By settting the following value to True, a querystring value of `formSubmitted=<id of submitted form>`, will be used to indicate a form submitted on the previous request.

### StoreUmbracoFormsInDb
This setting needs to be set to `True` if you want your Forms data to be stored in the database instead of the .json files in the `App_Data/UmbracoForms` directory in the file system.

For more information on this, read the [Forms in the Database](../Forms-in-the-Database) article.

### UseLegacyPageService
In Umbraco Forms 8.7 an update was made to improve the performance of the service responsible for retrieving the content of the Umbraco page where a form is hosted. This service is used to populate the string placeholders - or "magic strings" - with the values of properties from the page.

By setting the value of the `UseLegacyPageService` to `True` the old service can be reinstated.

### DisallowedFileUploadExtensions
When using the File Upload field in a form, editors can choose which file extensions they want to accept. When an image is expected, they can for example specify that only `.jpg` or `.png` files are uploaded.

There are certain file extensions that in almost all cases should never be allowed, which are held in this configuration value. This means that even if an editor has selected to allow all files, any files that match the extensions listed here will be blocked.

By default, .NET related code files like `.config` and `.aspx` are included in this deny list. You can add or - if you are sure - remove values from this list to meet your needs.

### MaxNumberOfColumnsInFormGroup
Added in 8.7.0, this setting controls the maximum number of columns that can be created by editors when they configure groups within a form.  The default value used if the setting value is not provided is 12.

### CultureToUseWhenParsingDatesForBackOffice
This setting has been added in 8.13, to help resolve an issue with multi-lingual setups.

When Umbraco Forms stores data for a record, it saves the values submitted for each field into a dedicated table for each type (string, date etc.). It also saves a second copy of the record in a JSON structure which is more suitable for fast look-up and display in the backoffice. Date values are serialized using the culture used by the front-end website when the form entry is stored.

When displaying the data in the backoffice, the date value needs to be parsed back into an actual date object for formatting. And this can cause a problem if the backoffice user is using a different language, and hence culture setting, than that used when the value was stored.

From 8.13 onwards, the culture used when storing the form entry is recorded, thus we can ensure the correct value is used when parsing the date. However, this doesn't help for historically stored records. To at least partially mitigate the problem, when you have editors using different languages to a single language presented on the website front-end, you can set this value to match the culture code used on the website. This ensures the date fields in the backoffice are correctly presented.

Taking an example of a website globalization culture code setting of "en-US" (and a date format of `m/d/y`), but an editor uses "en-GB" (which formats dates as of `d/m/y`). By setting the value of this configuration key to "en-US", you can ensure that the culture when parsing dates for presentation in the backoffice will match that used when the value was stored.

If no value is set, and no culture value was stored alongside the form entry, the culture based on the language associated with the current backoffice user will be used.

### TriggerConditionsCheckOn

This configuration setting provides control over the client-side event used to trigger conditions. The `change` event is the default used if this setting is empty. It can also be set to a value of `input`. The main difference seen here relates to text fields, with the "input" event firing on each key press, and the "change" only when the field loses focus.

### DefaultTheme
Added in 8.8.0, this setting allows you to configure the name of the theme to use when an editor has not specifically selected one for a form.  If empty or missing, the default value of "default" is used.  If a custom default theme is configured, it will be used for rendering forms where the requested file exists, and where not, will fall back to the out of the box default theme.

### DefaultEmailTemplate
When creating an empty form, a single workflow is added that will send an email to the current user's address. By default, the template shipped with Umbraco Forms is available at `Forms/Emails/Example-Template.cshtml` is used.

If you have created a custom template and would like to use that as the default instead, you can set the path here using this configuration setting.

## Default Settings
There are several configuration keys that start with `Default`. This allows you to configure the values for when a new form is created.

Once the form has been created, the values are set explicitly on the form, so subsequent changes to the defaults in configuration won't change the settings used on existing forms.

### DefaultManualApproval
This setting needs to be a `True` or `False` value and will allow you to toggle if a form allows submissions to be post moderated. Most use cases are for publicly shown entries such as blog post comments or submissions for a social campaign.

### DefaultDisableStylesheet
This setting needs to be a `True` or `False` value and will allow you to toggle if the form will include some default styling with the Umbraco Forms CSS stylesheet.

### DefaultMarkFieldsIndicator
This setting can have the following values to allow you to toggle the mode of marking mandatory or optional fields
* `NoIndicator`
* `MarkMandatoryFields`
* `MarkOptionalFields`

### DefaultIndicator
This setting is used to mark the mandatory or optional fields based on the setting above. By default this is an asterisk `*`

### DefaultRequiredErrorMessage
This allows you to configure the required error validation message. By default this is `Please provide a value for {0}` where the `{0}` is used to replace the name of the field that is required.

### DefaultInvalidErrorMessage
This allows you to configure the invalid error validation message. By default this is `Please provide a valid value for {0}` where the `{0}` is used to replace the name of the field that is invalid.

### DefaultShowValidationSummary
This setting needs to be a `True` or `False` value and will allow you to toggle if the form will display all form validation error messages in a validation summary together.

### DefaultHideFieldValidationLabels
This setting needs to be a `True` or `False` value and will allow you to toggle if the form will show inline validation error messages next to the form field that is invalid.

### DefaultMessageOnSubmit
This allows you to configure what text is displayed when a form is submitted and is not being redirected to a different content node.

### DefaultStoreRecordsLocally
This setting needs to be a `True` or `False` value and will allow you to toggle if form submission data will be stored in the Umbraco Forms database tables.  By default this is set to `True`.

### DefaultAutocompleteAttribute
Added in 8.8.0, this setting provides a value to be used for the `autocomplete` attribute for newly created forms.  By default the value is empty, but can be set to `on` or `off` to have that value applied as the attribute value used when rendering the form.
