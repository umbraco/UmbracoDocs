# Overview of the default fieldtypes

Umbraco Forms comes with a bunch of default fieldtypes (also known as **answer types**) you can choose from when adding new fields to your forms. Here is a detailed overview.

## Short Answer
Simple textbox allows up to 250 characters.

![Textfield](images/shortanswer.png)

## Long Answer
Bigger textfield that allows multiline text and more than 250 characters.

![Textarea](images/longanswer.png)

## Date
Will display a picker that allows to user to select a date.

![Datepicker](images/date.png)

## Checkbox
Displays a single checkbox that can be checked or not.

![Checkbox](images/checkbox.png)

## File upload
Allows user to select and upload a local file.

![File upload](images/fileupload.png)

## Password
Password field (input isn't visible when typing).

![Password field](images/password.png)

## Multiple Choice
Will display a list of items (a checkbox for each item) where the user can select multiple options.

![Checkboxlist](images/multiplechoice.png)

## Data Consent

A field for the purpose of asking for data consent. **Note**: This field is automatically added to all new forms created with Forms 6+.

![Data Consent](images/dataconsent.png)

## Dropdown
Will display a list of items (in a drop down box) where the user can select a single option.

![Dropdownlist](images/dropdown.png)

## Single Choice
Displays a list of items (a radio button for each item), where the user can select a single option.

![singlechoice](images/singlechoice.png)

## Title and Description
Outputs a title and description that are set as prevalues.

![Radiobuttonlist](images/titleanddescription.png)

## Recaptcha
The field displays a simple checkbox for the user to check in order for the form to be validated

![Recaptcha2](images/recaptcha2.png)

You will need to configure your site keys adding your public and private keys in the `UmbracoForms.config` file located in `~/App_Plugins/UmbracoForms/`:

    <setting key="RecaptchaPublicKey" value="sHZZenninFziVUV9TN24FqhwZvc2b4e8BLrG" />
    <setting key="RecaptchaPrivateKey" value="sHZZenninFziVUV9TN24FqhwZvc2b4e8BLrG-" />
    
You can create your keys by [logging into your Recaptcha account](https://www.google.com/recaptcha/).

**Note**: Don't forget to make the recatpcha field mandatory.

:::tip
As ReCaptcha v1 is shut down, we **strongly** recommend that you use the ReCaptcha2 field type.
:::

## Hidden
Hidden field, won't be visible to the user.

![Hidden](images/hidden.png)
