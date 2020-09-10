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

### AllowEditableFormSubmissions
This configuration value expects a `True/False` value and can be used to toggle the functionality to allow a form submission to be editable and re-submitted. When the value is set to `True` it allows Form Submissions to be edited using the following querystring for the page containing the form on the site. `?recordId=GUID` Replace `GUID` with the GUID of the form submission.

:::warning
Enable this feature ONLY if you do understand the security implications.
:::

### RecaptchaPublicKey & RecaptchaPrivateKey
Both of these configuration values are needed in order to use ReCaptcha V2 from Google. You can obtain both of these values after signing up to create a ReCaptcha key here - https://www.google.com/recaptcha/admin

Google has renamed these recently and the `Site Key` refers to `RecaptchaPublicKey` and `Secret Key` is to be used for `RecaptchaPrivateKey`


### DatePickerYearRange
This setting is used to configure the Date Picker form field range of years that is available in the date picker. By default this is a small range of 10 years.

### EnableAntiForgeryToken
This setting needs to be a `True` or `False` value and will enable the ASP.NET Anti Forgery Token and we recommend that you enable this and set this to `True`. Due to older versions of Umbraco Forms not containing this, it has become an optional config setting and due to upgrade reasons we do not automatically set this to `True` for you.

If you do set this to `True` then you need to add `@Html.AntiForgeryToken()` to your forms. The default template for Forms can be found in `~/Views/Partials/Forms/Form.cshtml` and should have `@Html.AntiForgeryToken()` in the `@using (Html.BeginUmbracoForm [...]` block.

### StoreUmbracoFormsInDb

This setting needs to be set to `True` if you want your Forms data to be stored in the database instead of the .json files in the `App_Data/UmbracoForms` directory in the file system.

For more information on this, read the [Forms in the Database](../Forms-in-the-Database) article.

## Default Settings
There are several configuration keys that start with `Default`. This allows you to configure the values for when a new form is created.

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
