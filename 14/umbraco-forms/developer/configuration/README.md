---
description: >-
  In Umbraco Forms it's possible to customize the functionality with various
  configuration values.
---

# Configuration

With Umbraco Forms it's possible to customize the functionality with various configuration values.

## Editing configuration values

All configuration for Umbraco Forms is held in the `appSettings.json` file found at the root of your Umbraco website. If the configuration has been customized to use another source, then the same keys and values discussed in this article can be applied there.

The convention for Umbraco configuration is to have package based options stored as a child structure below the `Umbraco` element, and as a sibling of `CMS`. Forms configuration follows this pattern, i.e.:

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
      "DefaultTheme": "default",
      "DefaultEmailTemplate": "Forms/Emails/Example-Template.cshtml",
      "Defaults": {
        "ManualApproval": false,
        "DisableStylesheet": false,
        "MarkFieldsIndicator": "NoIndicator",
        "Indicator": "*",
        "RequiredErrorMessage": "Please provide a value for {0}",
        "InvalidErrorMessage": "Please provide a valid value for {0}",
        "ShowValidationSummary": false,
        "HideFieldValidationLabels": false,
        "NextPageButtonLabel": "Next",
        "PreviousPageButtonLabel": "Previous",
        "SubmitButtonLabel": "Submit",
        "MessageOnSubmit": "Thank you",
        "StoreRecordsLocally": true,
        "AutocompleteAttribute": "",
        "DaysToRetainSubmittedRecordsFor": 0,
        "DaysToRetainApprovedRecordsFor": 0,
        "DaysToRetainRejectedRecordsFor": 0,
        "ShowPagingOnMultiPageForms": "None",
        "PagingDetailsFormat": "Page {0} of {1}",
        "PageCaptionFormat": "Page {0}",
        "ShowSummaryPageOnMultiPageForms": false,
        "SummaryLabel": "Summary of Entry"
      },
      "RemoveProvidedEmailTemplate": false,
      "RemoveProvidedFormTemplates": false,
      "FormElementHtmlIdPrefix": "",
      "SettingsCustomization": {
        "DataSourceTypes": {},
        "FieldTypes": {},
        "PrevalueSourceTypes": {},
        "WorkflowTypes": {},
      },
      "MandatoryFieldsetLegends": false
    },
    "Options": {
      "IgnoreWorkFlowsOnEdit": "True",
      "AllowEditableFormSubmissions": false,
      "AppendQueryStringOnRedirectAfterFormSubmission": false,
      "CultureToUseWhenParsingDatesForBackOffice": "",
      "TriggerConditionsCheckOn": "change",
      "ScheduledRecordDeletion": {
        "Enabled": false,
        "FirstRunTime": "",
        "Period": "1.00:00:00"
      },
      "DisableRecordIndexing": false,
      "EnableFormsApi": false,
      "EnableRecordingOfIpWithFormSubmission": false,
      "UseSemanticFieldsetRendering": false,
      "DisableClientSideValidationDependencyCheck": false,
      "DisableRelationTracking": false,
      "TrackRenderedFormsStorageMethod": "HttpContextItems",
      "EnableMultiPageFormSettings": false
    },
    "Security": {
      "DisallowedFileUploadExtensions": "config,exe,dll,asp,aspx",
      "AllowedFileUploadExtensions": "",
      "EnableAntiForgeryToken": true,
      "SavePlainTextPasswords": false,
      "DisableFileUploadAccessProtection": false,
      "DefaultUserAccessToNewForms": "Grant",
      "ManageSecurityWithUserGroups": false,
      "GrantAccessToNewFormsForUserGroups": "admin,editor",
      "FormsApiKey": "",
      "EnableAntiForgeryTokenForFormsApi": true,
    },
    "FieldTypes": {
      "DatePicker": {
        "DatePickerYearRange": 10,
        "DatePickerFormat": "LL",
        "DatePickerFormatForValidation": ""
      },
      "Recaptcha2": {
        "PublicKey": "",
        "PrivateKey": ""
      },
      "Recaptcha3": {
        "SiteKey": "",
        "PrivateKey": "",
        "Domain": "Google",
        "VerificationUrl": "https://www.google.com/recaptcha/api/siteverify",
        "ShowFieldValidation": false
      },
      "RichText": {
        "DataTypeId": "ca90c950-0aff-4e72-b976-a30b1ac57dad"
      },
      "TitleAndDescription": {
        "AllowUnsafeHtmlRendering": false
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

### DefaultTheme

This setting allows you to configure the name of the theme to use when an editor has not specifically selected one for a form. If empty or missing, the default value of "default" is used. If a custom default theme is configured, it will be used for rendering forms where the requested file exists, and where not, will fall back to the out of the box default theme.

### DefaultEmailTemplate

When creating an empty form, a single workflow is added that will send an email to the current user's address. By default, the template shipped with Umbraco Forms is available at `Forms/Emails/Example-Template.cshtml` is used.

If you have created a custom template and would like to use that as the default instead, you can set the path here using this configuration setting.

### RemoveProvidedEmailTemplate

The provided template can be removed from the selection if you have created email templates for the "send Razor email" workflow. To do this, set this value to `true`.

### RemoveProvidedFormTemplates

Similarly, the provided form templates available from the form creation dialog can be removed from selection. To do this, set this configuration value to `true`.

### FormElementHtmlIdPrefix

By default the value of HTML `id` attribute rendered for fieldsets and fields using the default theme is the GUID associated with the form element. Although [this is valid](https://developer.mozilla.org/en-US/docs/Web/HTML/Global\_attributes/id), some browsers, particularly Safari, may report issues with this if the identifier begins with a number. To avoid such issues, the attribute values can be prefixed with the value provided in this configuration element.

For example, providing a value of `"f_"` will apply a prefix of "f\_" to each fieldset and field `id` attribute.

### SettingsCustomization

Forms introduced the ability to configure settings for the field, workflow, data source, and prevalue sources. The default behavior, when a new field or workflow is added to a form, is for each setting to be empty. The values are then completed by the editor. All settings defined on the type are displayed for entry.

In some situations, you may want to hide certain settings from entry, so they always take an empty value. In others, you may want to provide a default value that the editor can accept or amend. And lastly, you may have a requirement for a fixed, non-empty value, that's enforced by the organization and not editable. Each of these scenarios can be supported by this configuration setting.

It consists of four dictionaries, one for each type:

* `DataSourceTypes`
* `FieldTypes`
* `PrevalueSourceTypes`
* `WorkflowTypes`

Each dictionary can be identified using the GUID or alias of the type as the key. The value is set to the following structure that contains three settings:

```json
{
  "IsHidden": true|false,
  "DefaultValue": "",
  "IsReadOnly": true|false
}
```

* `IsHidden` - if provided and set to true the setting will be hidden and will always have an empty value.
* `DefaultValue` - if provided the value will be pre-filled when a type using it is created.
* `IsReadOnly` - used in conjunction with the above, if set the field won't be editable and hence whatever is set as the `DefaultValue` won't be able to be changed. If set to false (or omitted) the editor can change the value from the default.

In this example, the sender address field on a workflow for sending emails can be hidden, such that the system configured value is always used:

```json
  "SettingsCustomization": {
    "WorkflowTypes": {
      "sendEmailWithRazorTemplate": {
        "SenderEmail": {
          "IsHidden": true
        }
      }
    },
  }
```

Here an organization-approved reCAPTCHA score threshold is defined, that can't be changed by editors:

```json
  "SettingsCustomization": {
    "FieldTypes": {
      "recaptcha3": {
        "ScoreThreshold": {
          "DefaultValue": "0.8",
          "IsReadOnly": true
        }
      }
    },
  }
```

In order to configure this setting, you will need to know the GUID or alias for the type and the property name for each setting. You can find [these values for the built-in Forms types here](type-details.md).

Take care to not hide any settings that are required for the particular field or workflow type (for example, the `Subject` field for email workflows). If you do that, the item will fail validation when an editor tries to create it.

The default value and read-only settings apply to most setting types. There is an exception for complex ones where a default string value isn't appropriate. An example of one of these is the field mapper used in the "Send to URL" workflow.

### MandatoryFieldsetLegends

When creating a form with Umbraco Forms, adding captions to the groups for fields is optional. To follow accessibility best practices, these fields should be completed. When they are, the group of fields are presented within a `<fieldset>` element that has a populated `<legend>`.

If you want to ensure form creators always have to provide a caption, you can set the value of this setting to `true`.

### Form default settings configuration

The following configured values are applied to all forms as they are created. They can then be amended on a per-form basis via the Umbraco backoffice.

Once the form has been created, the values are set explicitly on the form, so subsequent changes to the defaults in configuration won't change the settings used on existing forms.

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

This setting needs to be a `true` or `false` value and will allow you to toggle if the form will display all form validation error messages in a validation summary together. Defaults to `false`.

#### HideFieldValidationLabels

This setting needs to be a `true` or `false` value and will allow you to toggle if the form will show inline validation error messages next to the form field that is invalid. Defaults to `false`.

#### NextPageButtonLabel, PreviousPageButtonLabel, SubmitButtonLabel

These settings configure the default next, previous, and submit button labels. By default, these are `Next`, `Previous`, and `Submit` respectively. These labels can be amended on a form-by-form basis via the form's **Settings** section.

#### MessageOnSubmit

This allows you to configure what text is displayed when a form is submitted and is not being redirected to a different content node. Defaults to `Thank you`.

#### StoreRecordsLocally

This setting needs to be a `True` or `False` value and will allow you to toggle if form submission data should be stored in the Umbraco Forms database tables. By default this is set to `True`.

#### AutocompleteAttribute

This setting provides a value to be used for the `autocomplete` attribute for newly created forms. By default the value is empty, but can be set to `on` or `off` to have that value applied as the attribute value used when rendering the form.

#### DaysToRetainSubmittedRecordsFor

Introduced in 10.2, this setting controls the initial value of the number of days to retain form submission records for newly created forms. By default the value is 0, which means records will not be deleted at any time and are retained forever.

If set to a positive number, a date value calculated by taking away the number of days configured from the current date is found. Records in the 'submitted' state, that are older than this date, will be flagged for removal.

#### DaysToRetainApprovedRecordsFor

Applies as per `DaysToRetainSubmittedRecordsFor` but for records in the 'approved' state.

#### DaysToRetainRejectedRecordsFor

Applies as per `DaysToRetainSubmittedRecordsFor` but for records in the 'rejected' state.

### ShowPagingOnMultiPageForms

Defines whether and where paging details are displayed for multi-page forms.

### PagingDetailsFormat

Defines the paging details format for multi-page forms.

### PageCaptionFormat

Defines the page caption format for multi-page forms.

### ShowSummaryPageOnMultiPageForms

Defines whether summary pages are on by default for multi-page forms.

### SummaryLabel

Defines the default summary label for multi-page forms.

## Package options configuration

### IgnoreWorkFlowsOnEdit

This configuration expects a `True` or `False` string value, or a comma-separated list of form names, and allows you to toggle if a form submission is edited again, that the workflows on the form will re-fire after an update to the form submission. This is used in conjunction with the `AllowEditableFormSubmissions` configuration value. Defaults to `True`.

### AllowEditableFormSubmissions

This configuration value expects a `true` or `false` value and can be used to toggle the functionality to allow a form submission to be editable and re-submitted. When the value is set to `true` it allows Form Submissions to be edited using the following querystring for the page containing the form on the site. `?recordId=GUID` Replace `GUID` with the GUID of the form submission. Defaults to `false`.

{% hint style="info" %}
There was a typo in this setting where it had been named as `AllowEditableFormSubmissions`. This is the name that needs to be used in configuration for Forms 9. In Forms 10 this was be corrected to the now documented value of `AllowEditableFormSubmissions`.
{% endhint %}

{% hint style="warning" %}
Enable this feature ONLY if you understand the security implications.
{% endhint %}

### AppendQueryStringOnRedirectAfterFormSubmission

When redirecting following a form submission, a `TempData` value is set that is used to ensure the submission message is displayed rather than the form itself. In certain situations, such as hosting pages with forms in IFRAMEs from other websites, this value is not persisted between requests.

By setting the following value to True, a querystring value of `formSubmitted=<id of submitted form>`, will be used to indicate a form submitted on the previous request.

### CultureToUseWhenParsingDatesForBackOffice

This setting has been added to help resolve an issue with multi-lingual setups.

When Umbraco Forms stores data for a record, it saves the values submitted for each field into a dedicated table for each type (string, date etc.). It also saves a second copy of the record in a JSON structure which is more suitable for fast look-up and display in the backoffice. Date values are serialized using the culture used by the front-end website when the form entry is stored.

When displaying the data in the backoffice, the date value needs to be parsed back into an actual date object for formatting. And this can cause a problem if the backoffice user is using a different language, and hence culture setting, than that used when the value was stored.

The culture used when storing the form entry is recorded, thus we can ensure the correct value is used when parsing the date. However, this doesn't help for historically stored records. To at least partially mitigate the problem, when you have editors using different languages to a single language presented on the website front-end, you can set this value to match the culture code used on the website. This ensures the date fields in the backoffice are correctly presented.

Taking an example of a website globalization culture code setting of "en-US" (and a date format of `m/d/y`), but an editor uses "en-GB" (which formats dates as of `d/m/y`). By setting the value of this configuration key to "en-US", you can ensure that the culture when parsing dates for presentation in the backoffice will match that used when the value was stored.

If no value is set, and no culture value was stored alongside the form entry, the culture based on the language associated with the current backoffice user will be used.

### TriggerConditionsCheckOn

This configuration setting provides control over the client-side event used to trigger conditions. The `change` event is the default used if this setting is empty. It can also be set to a value of `input`. The main difference seen here relates to text fields, with the "input" event firing on each key press, and the "change" only when the field loses focus.

### ScheduledRecordDeletion

Scheduled deletion of records older than a specified number of days. It uses a background task to run the cleanup operation, which can be customized with the following settings.

#### Enabled

By default this value is `false` and no data will be removed. Even if forms are configured to have submitted data cleaned up, no records will be deleted. A note will be displayed in the backoffice indicating this status.

Set to `true` to enabled the background task.

#### FirstRunTime

This will configure when the record deletion process will run for the first time. If the value is not configured the health checks will run after a short delay following the website start. The value is specified as a string in crontab format. For example, a value of `"* 4 * * *"` will first run the operation at 4 a.m.

#### Period

Defines how often the record deletion process will run. The default value is `1.00:00:00` which is equivalent to once every 24 hours. Shorter or longer periods can be set using different datetime strings.

### DisableRecordIndexing

Set this value to `true` to disable the default behavior of indexing the form submissions into the Examine index.

If indexing has already occurred, you will still need to manually remove the files (found in `App_Data\TEMP\ExamineIndexes\UmbracoFormsRecords`). They will be recreated if indexing is subsequently re-enabled.

### EnableFormsApi

Set this value to `true` to enable the Forms API supporting headless and AJAX forms.

### EnableRecordingOfIpWithFormSubmission

By default, the user's IP address is not recorded when a form is submitted and stored in the `UFRecords` database table.

To include this information in the saved data, set this value to `true`.

If recording IPs and your site is behind a proxy, load balancer or CDN, we recommend using [ASP.NET's forwarded headers middleware](https://learn.microsoft.com/en-us/aspnet/core/host-and-deploy/proxy-load-balancer?view=aspnetcore-7.0) to ensure the correct value for the client IP is resolved.

### UseSemanticFieldsetRendering

In Forms 12.1 amends were made to the default theme for Forms that improved accessibility. Specifically we provide the option to use alternative markup for rendering checkbox and radio button lists. These use the more semantically correct `fieldset` and `legend` elements, instead of the previously used `div` and `label`.

Although this semantic markup is preferred, it could be a presentational breaking change for those styling the default theme.  As such we have made this markup improvement optional. You can opt into using it by setting this configuration value to `true`.

In Umbraco 13 this configuration option will be removed and the semantic rendering made the only option.

### DisableClientSideValidationDependencyCheck

When a form is rendered on the front-end website, a check is run to ensure that client-side validation framework is available and registered.

You can disable this check by setting the value of this configuration key to `true`.

If you are rendering your forms dependency scripts using the `async` attribute, you will need to disable this check.

### DisableRelationTracking

Forms will by default track relations between forms and the content pages they are used on. This allows editors to see where forms are being used in their Umbraco website.

If you would like to enable this feature, you can set the value of this setting to `true`.

## TrackRenderedFormsStorageMethod

Forms tracks the forms rendered on a page in order that the associated scripts can be placed in a different location within the HTML. Usually this is used to [render the scripts](../rendering-scripts.md)) at the bottom of the page.

By default, `HttpContext.Items` is used as the storage mechanism for this tracking.

You can optionally revert to the legacy behavior of using `TempData` by changing this setting from the default of `HttpContextItems` to `TempData`.

## EnableMultiPageFormSettings

This setting determines whether [multi-page form settings](../../editor/creating-a-form/form-settings.md#multi-page-forms) are available to editors.

By default the value is `false`. This ensures that, in an upgrade scenario, before the feature is used the necessary styling and/or theme updates can be prepared.

To make the feature available to editors set the value to `true`.

## Security configuration

### DisallowedFileUploadExtensions

When using the File Upload field in a form, editors can choose which file extensions they want to accept. When an image is expected, they can for example specify that only `.jpg` or `.png` files are uploaded.

There are certain file extensions that in almost all cases should never be allowed, which are held in this configuration value. This means that even if an editor has selected to allow all files, any files that match the extensions listed here will be blocked.

By default, .NET related code files like `.config` and `.aspx` are included in this deny list. You can add or - if you are sure - remove values from this list to meet your needs.

### AllowedFileUploadExtensions

For further control, an "allow list" of extension can be provided via this setting. If provided, only the extensions entered as a comma separated list here will be accepted in file uploads through forms.

### EnableAntiForgeryToken

This setting needs to be a `true` or `false` value and will enable the ASP.NET Anti Forgery Token and we recommend that you enable this option. Defaults to `true`.

In certain circumstances, including hosting pages with forms in IFRAMEs from other websites, this may need to be set to `false`.

### SavePlainTextPasswords

This setting needs to be a `true` or `false` value and controls whether password fields provided in forms will be saved to the database. Defaults to `false`.

### DisableFileUploadAccessProtection

Protection was added to uploaded files to prevent users from accessing them if they aren't logged into the backoffice and have permission to manage the form for which the file was submitted. As a policy of being "secure by default", the out of the box behavior is that this access protection is in place.

If for any reason you need to revert to the previous behavior, or have other reasons where you want to permit unauthenticated users from accessing the files, you can turn off this protection by setting this configuration value to `true`.

### DefaultUserAccessToNewForms

This setting was added to add control over access to new forms. The default behavior is for all users to be granted access to newly created forms. To amend that to deny access, the setting can be updated to a value of `Deny`. A value of `Grant` or configuration with the setting absent preserves the default behavior.

### ManageSecurityWithUserGroups

Ability to administer access to Umbraco Forms using Umbraco's user groups. This can be used instead or in addition to the legacy administration which is at the level of the individual user. Set this option to `true` to enable the user group permission management functionality.

### GrantAccessToNewFormsForUserGroups

This setting takes a comma-separated list of user group aliases which will be granted access automatically to newly created forms. This setting only takes effect when `ManageSecurityWithUserGroups` is set to `true`.

There are two "special" values that can be applied within or instead of the comma-separated list.

A value of `all` will give access to the form to all user groups.

A value of `form-creator` will give access to all the user groups that the user who created the form is part of.

### FormsApiKey and EnableAntiForgeryTokenForFormsApi

Available from Forms 10.2.1, the `FormsApiKey` configuration setting can be used to secure the Forms Headless API in server-to-server integrations. When set, API calls will be rejected unless the value of this setting is provided in an HTTP header.

Setting the value of `EnableAntiForgeryTokenForFormsApi` to `false` will disable the anti-forgery protection for the Forms Headless/AJAX API. You need to do this for server-to-server integrations where it's not possible to provide a valid anti-forgery token in the request.

For more information, see the [Headless/AJAX Forms](../ajaxforms.md) article.

## Field type specific configuration

### Date picker field type configuration

#### DatePickerYearRange

This setting is used to configure the Date Picker form field range of years that is available in the date picker. By default this is a small range of 10 years.

#### DatePickerFormat

A custom date format can be provided in [momentjs format](https://momentjscom.readthedocs.io/en/latest/moment/01-parsing/03-string-format/) if you want to override the default.

#### DatePickerFormatForValidation

If a custom date format is provided it will be used on the client-side. A matching string in [C# date format](https://learn.microsoft.com/en-us/dotnet/standard/base-types/custom-date-and-time-format-strings) should be provided, so that server-side validation will match the expected format of the entry.

### reCAPTCHA v2 field type configuration

#### PublicKey & PrivateKey

Both of these configuration values are needed in order to use the "_Recaptcha2_" field type implementing legacy ReCaptcha V2 from Google. You can obtain both of these values after signing up to create a ReCaptcha key here - [https://www.google.com/recaptcha/admin](https://www.google.com/recaptcha/admin)

Google has renamed these recently and the `Site Key` refers to `RecaptchaPublicKey` and `Secret Key` is to be used for `RecaptchaPrivateKey`

### reCAPTCHA v3 field type configuration

#### SiteKey & PrivateKey

Both of these configuration values are needed in order to use the "_reCAPTCHA V3 with Score_" field type implementing ReCaptcha V3 from Google.

You can obtain both of these values after signing up to create a ReCaptcha key here: [https://www.google.com/recaptcha/admin](https://www.google.com/recaptcha/admin).

#### Domain

This setting defines the domain from which the client-side assets for using the reCAPTCHA service are requested.

Valid options are `Google` (the default) or `Recaptcha`. You may want to use the latter for control of which domains are setting cookies on your site. [Read more at the reCAPTCHA documentation](https://developers.google.com/recaptcha/docs/faq#does-recaptcha-use-cookies).

#### VerificationUrl

By default, the server-side validation of the reCAPTCHA response is sent to Google's servers at `https://www.google.com/recaptcha/api/siteverify`.

Some customers with a locked-down production environment cannot configure the firewall to allow these requests and instead use a proxy server. They can use this setting to configure the URL to their proxy server, which will relay the request to and response from Google.

#### ShowFieldValidation

By default the validation message returned from a failed reCAPTCHA 3 request will be displayed only in the form level validation summary.

To render also at a field level, set this value to `true`.

We expect to make the default value for this option `true` in Umbraco Forms 15.

### Rich text field type configuration

#### DataTypeId

Sets the Data Type Guid to use to obtain the configuration for the rich text field type. If the setting is absent, the value of the default rich text Data Type created by Umbraco on a new install is used.

### Title and description field type configuration

#### AllowUnsafeHtmlRendering

When using the "title and description" field type, if editors provide HTML in the "description" field it will be encoded when rendering on the website.

If you understand the risks and want to allow HTML to be displayed, you can set this value to `false`.
