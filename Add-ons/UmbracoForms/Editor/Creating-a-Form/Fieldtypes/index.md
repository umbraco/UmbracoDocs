---
versionFrom: 7.0.0
version To: 9.0.0
---

# Overview of the Field Types

Umbraco Forms comes with a bunch of default Field Types (also known as **Answer Types**) you can choose from when adding new fields to your Forms.

By default, the following Field Types are available:

- **Short Answer**
    A textbox allows up to 250 characters.

    ![Textfield](images/shortanswer.png)

- **Long Answer**
    A bigger text field that allows multiline text and more than 250 characters.

    ![Textarea](images/longanswer.png)

- [**Date**](Date)
    Displays a picker that allows the user to select a date.

    ![Datepicker](images/date.png)

- **Checkbox**
    Displays a single checkbox that can be checked or not.

    ![Checkbox](images/checkbox.png)

- [**File Upload**](FileUpload)
    Allows user to select and upload a local file.

    ![File upload](images/fileupload.png)

- **Password**
    Allows to type a password. The input is not visible when typing.

    ![Password field](images/password.png)

- **Multiple Choice**
    Displays a list of items with a checkbox for each item where the user can select multiple options.

    ![Checkboxlist](images/multiplechoice.png)

- **Data Consent**

    A field for the purpose of asking for data consent.

    :::note
    By default, this field is added to all new forms created with Forms version 6+.
    :::

    ![Data Consent](images/dataconsent.png)

- **Dropdown**
    Displays a list of items in a drop down box where the user can select a single option.

    ![Dropdownlist](images/dropdown.png)

- **Single Choice**
    Displays a list of items with a radio button for each item where the user can select a single option.

    ![singlechoice](images/singlechoice.png)

- **Title and Description**
    Displays a title and description that are set as default values.

    ![Radiobuttonlist](images/titleanddescription.png)

- **Hidden**
    A hidden field allows developers to include data that cannot be seen or modified by users when a Form is submitted.

    ![Hidden](images/hidden.png)

- [**Recaptcha V2**](Recaptcha2)
    The field displays a single checkbox for the user to select in order to validate the Form.

    ![reCAPTCHA v2](images/recaptcha2.png)

- [**Recaptcha V3 with Score**](Recaptcha3)
    Available in Umbraco Forms from v8.7.0. This field returns a score for each request without user interaction. The score is based on user interactions with the site and enables you to take an appropriate action for your site based on the score.

---

Prev: [Form settings](../Form-Settings/index.md) &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; Next: [Setting-up conditional logic on fields](../Conditional-Logic/index.md)
