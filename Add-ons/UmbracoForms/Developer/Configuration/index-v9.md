---
versionFrom: 9.0.0
meta.Title: "Umbraco Forms configuration"
meta.Description: "In Umbraco Forms it's possible to customize the functionality with various configuration values."
state: complete
verified-against: beta001
---

# Configuration
With Umbraco Forms it's possible to customize the functionality with various configuration values.  

## Editing configuration values

All configuration for your Umbraco Forms is held in an `appSettings.json` file found at the root of your Umbraco website.  If the configuration has been customized to use another source, then the same keys and values discussed in this article can be applied there.

The convention for Umbraco configuration is to have package based options stored as a child structure below the `Umbraco` element, and as a sibling of `CMS`.  Forms configuration follows this pattern, i.e.:

```json
{
  ...
  "Umbraco": {
    "CMS": {
        ...
    },
    "Forms": {
        ...
    }
  }
}
```

All configuration for Forms is optional. In other words, all values have defaults that will be applied if no configuration is available for a particular key.

For illustration purposes, the following structure represents the full set of options for configuration of Forms, along with the default values. This will help when you need to provide a different setting to understand where it should be applied.

```json
  "Forms": {
    "FormDesign": {
      "DisableAutomaticAdditionOfDataConsentField": false,
      "DisableDefaultWorkflow": false,
      "MaxNumberOfColumnsInFormGroup": 12,
      "Defaults": {
        "ManualApproval": false,
        "DisableStylesheet": false,
        "MarkFieldsIndicator": "NoIndicator",
        "Indicator": "*",
        "RequiredErrorMessage": "Please provide a value for {0}",
        "InvalidErrorMessage": "Please provide a valid value for {0}",
        "ShowValidationSummary": false,
        "HideFieldValidationLabels": false,
        "MessageOnSubmit": "Thank you",
        "StoreRecordsLocally": true
      }      
    },
    "PackageOptions": {
      "IgnoreWorkFlowsOnEdit": "True",
      "ExecuteWorkflowAsync": "False",
      "AllowEditableFormSubmisisons": false
    },
    "Security": {
      "DisallowedFileUploadExtensions": "config,exe,dll,asp,aspx",
      "EnableAntiForgeryToken": true,
      "SavePlainTextPasswords": false
    },
    "FieldTypes": {
      "DatePicker": {
        "DatePickerYearRange": 10
      },
      "Recaptcha2": {
        "PublicKey": "",
        "PrivateKey": ""
      },
      "Recaptcha3": {
        "SiteKey": "",
        "PrivateKey": ""
      }            
    }
  }
```

## Form design configuration

### DisableAutomaticAdditionOfDataConsentField

This configuration value expects a `true` or `false` value and can be used to disable the feature where all new forms are provided with a default "Consent for storing submitted data" field on creation. Defaults to `false`.

### DisableDefaultWorkflow

This configuration value expects a `true` or `false` value and can be used to toggle if new forms that are created adds an email workflow to send the result of the form to the current user who created the form. Defaults to `false`.

### MaxNumberOfColumnsInFormGroup

This setting controls the maximum number of columns that can be created by editors when they configure groups within a form. The default value used if the setting value is not provided is 12.

### Form default settings configuration

The following configured values are applied to all forms as they are created. They can then be amended on a per-form basis via the Umbraco backoffice.

#### ManualApproval

This setting needs to be a `true` or `false` value and will allow you to toggle if a form allows submissions to be post moderated. Most use cases are for publicly shown entries such as blog post comments or submissions for a social campaign. Defaults to `false`.

#### DisableStylesheet

This setting needs to be a `true` or `false` value and will allow you to toggle if the form will include some default styling with the Umbraco Forms CSS stylesheet. Defaults to `false`.

#### MarkFieldsIndicator

This setting can have the following values to allow you to toggle the mode of marking mandatory or optional fields:

* `NoIndicator` (default)
* `MarkMandatoryFields`
* `MarkOptionalFields`

#### Indicator

This setting is used to mark the mandatory or optional fields based on the setting above. By default this is an asterisk `*`.

#### RequiredErrorMessage

This allows you to configure the required error validation message. By default this is `Please provide a value for {0}` where the `{0}` is used to replace the name of the field that is required.

#### InvalidErrorMessage

This allows you to configure the invalid error validation message. By default this is `Please provide a valid value for {0}` where the `{0}` is used to replace the name of the field that is invalid.

#### ShowValidationSummary

This setting needs to be a `true` or `false` value and will allow you to toggle if the form will display all form validation error messages in a validation summary together.  Defaults to `false`.

#### HideFieldValidationLabels

This setting needs to be a `true` or `false` value and will allow you to toggle if the form will show inline validation error messages next to the form field that is invalid.  Defaults to `false`.

#### MessageOnSubmit

This allows you to configure what text is displayed when a form is submitted and is not being redirected to a different content node. Defaults to `Thank you`.

#### StoreRecordsLocally

This setting needs to be a `True` or `False` value and will allow you to toggle if form submission data should be stored in the Umbraco Forms database tables. By default this is set to `True`.

## Package options configuration

### IgnoreWorkFlowsOnEdit

This configuration expects a `True` or `False` string value, or a comma-separated list of form names, and allows you to toggle if a form submission is edited again, that the workflows on the form will re-fire after an update to the form submission. This is used in conjunction with the `AllowEditableFormSubmissions` configuration value. Defaults to `True`.

### ExecuteWorkflowAsync

This configuration key is *experimental* and will allow Workflows to be executed in an asynchronous manner. The value can be a `True` or `False` string value, or a comma-separated list of form names. Defaults to `False`.

### AllowEditableFormSubmissions

This configuration value expects a `true` or `false` value and can be used to toggle the functionality to allow a form submission to be editable and re-submitted. When the value is set to `true` it allows Form Submissions to be edited using the following querystring for the page containing the form on the site. `?recordId=GUID` Replace `GUID` with the GUID of the form submission. Defaults to `false`.

:::warning
Enable this feature ONLY if you understand the security implications.
:::

## Security configuration

### DisallowedFileUploadExtensions

When using the File Upload field in a form, editors can choose which file extensions they want to accept. When an image is expected, they can for example specify that only `.jpg` or `.png` files are uploaded.

There are certain file extensions that in almost all cases should never be allowed, which are held in this configuration value. This means that even if an editor has selected to allow all files, any files that match the extensions listed here will be blocked.

By default, .NET related code files like `.config` and `.aspx` are included in this deny list. You can add or - if you are sure - remove values from this list to meet your needs.

### EnableAntiForgeryToken

This setting needs to be a `true` or `false` value and will enable the ASP.NET Anti Forgery Token and we recommend that you enable this option. Defaults to `true`.

### SavePlainTextPasswords

This setting needs to be a `true` or `false` value and controls whether password fields provided in forms will be saved to the database. Defaults to `false`.

## Field type specific configuration 

### Date picker field type configuration 

#### DatePickerYearRange

This setting is used to configure the Date Picker form field range of years that is available in the date picker. By default this is a small range of 10 years.

### reCAPTCHA v2 field type configuration 

#### PublicKey & PrivateKey

Both of these configuration values are needed in order to use the "*Recaptcha2*" field type implementing legacy ReCaptcha V2 from Google. You can obtain both of these values after signing up to create a ReCaptcha key here - https://www.google.com/recaptcha/admin

Google has renamed these recently and the `Site Key` refers to `RecaptchaPublicKey` and `Secret Key` is to be used for `RecaptchaPrivateKey`

### reCAPTCHA v3 field type configuration 

#### SiteKey & PrivateKey

Both of these configuration values are needed in order to use the "*reCAPTCHA V3 with Score*" field type implementing ReCaptcha V3 from Google.

You can obtain both of these values after signing up to create a ReCaptcha key here:  https://www.google.com/recaptcha/admin.
