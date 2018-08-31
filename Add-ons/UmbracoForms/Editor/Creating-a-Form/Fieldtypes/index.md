# Overview of the default fieldtypes
Umbraco Forms comes with a bunch of default fieldtypes (also known as answer types) you can choose from when adding new fields to your forms. Here is a detailed overview.

## Short Answer
Simple textbox allows up to 250 characters

![Textfield](shortanswer.png)

## Long Answer
Bigger textfield that allows multiline text and more than 250 characters

![Textarea](longanswer.png)

## Date
Will display a picker that allows to user to select a date

![Datepicker](date.png)

## Checkbox
Displays a single checkbox that can be checked or not

![Checkbox](checkbox.png)

## File upload
Allows user to select and upload a local file

![File upload](fileupload.png)

## Password
Password field (input isn't visible when typing)

![Password field](password.png)

## Multiple Choice
Will display a list of items (a checkbox for each item) where the user can select multiple options

![Checkboxlist](multiplechoice.png)

## Dropdown
Will display a list of items (in a drop down box) where the user can select a single option

![Dropdownlist](dropdown.png)

## Single Choice
Displays a list of items (a radio button for each item), where the user can select a single option

![singlechoice](singlechoice.png)

## Title and Description
Outputs a title and description that are set as prevalues.

![Radiobuttonlist](titleanddescription.png)

## Recaptcha
Displays a recaptcha field (words seen in distorted text images), where the user must input the right word in order for the form to be validated. Don't forget to make the field mandatory.

![Recaptcha](recaptcha.png)

You will need to configure your site keys adding your public and private keys in the `UmbracoForms.config` file located in `~/App_Plugins/UmbracoForms/`:

    <setting key="RecaptchaPublicKey" value="sHZZenninFziVUV9TN24FqhwZvc2b4e8BLrG" />
    <setting key="RecaptchaPrivateKey" value="sHZZenninFziVUV9TN24FqhwZvc2b4e8BLrG-" />
    
You can create your keys by [logging into your Recaptcha account](https://www.google.com/recaptcha/).

## Hidden
Hidden field, won't be visible to the user

![Hidden](hidden.png)
