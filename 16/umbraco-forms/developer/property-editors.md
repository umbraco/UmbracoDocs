# Property Editors

When forms are created, editors will want to add them to pages in Umbraco. To do this they need a Document Type with a property that uses a Data Type based on a Form Picker property editor.

Umbraco Forms provides three variations of a form picker.

<figure><img src="../.gitbook/assets/form-pickers.png" alt=""><figcaption><p>Form Pickers</p></figcaption></figure>

Most commonly used is **Form Picker (single)**. This will allow the editor to select a single form for display on page.

Rarely but feasibly, you will have a requirement to present multiple forms on a page. Should this be appropriate, you can use **Form Picker (multiple)**.

{% hint style="info" %}
Internally this is used for presenting the list of "Allowed forms" you can select when setting up a form picker datatype.
{% endhint %}

Finally you can provide further flexibility for the editor to select not only a form but also the theme and redirect as well. For this you will use the **Form Details Picker**.

## Configuring the Data Type

Each property editor allows you to restrict the forms that can be chosen with the Data Type. You do this by setting either or both of the list of "Allowed folders" or "Allowed forms".

<figure><img src="../.gitbook/assets/form-picker-config.png" alt=""><figcaption><p>Form Picker DataType Configuration</p></figcaption></figure>

The "Form Details Picker" also allows you to select whether a theme or redirect selection is available.

## Property Value Conversion

The type of a property based on the Form Picker presented in a Razor class library is as follows:

| Option                     | Description                                                                                                                            |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| **Form Picker (single)**   | Single GUID representing the form's identifier.                                                                                        |
| **Form Picker (multiple)** | Collection of GUIDs representing the form identifiers.                                                                                 |
| **Form Details Picker**    | Instance of the `Umbraco.Forms.Core.PropertyEditors.Models.FormDetails` object, which has properties for the form, theme and redirect. |

## Content Delivery API Expansion

Each reference to a form supports expansion via the Umbraco Content Delivery API, as described [here](ajaxforms.md#working-with-the-cms-content-delivery-api).
