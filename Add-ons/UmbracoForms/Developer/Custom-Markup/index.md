---
versionFrom: 7.0.0
meta.Title: "Umbraco Forms custom markup"
meta.Description: "With Umbraco Forms it's possible to customize the outputted markup of a form, which means you have complete control over what Forms will output."
---

# Custom markup
With Umbraco Forms it's possible to customize the outputted markup of a form, which means you have complete control over what Forms will output.

:::warning
When using Forms version 6 or higher, we strongly recommend that you use [Themes](../Themes) when you want to customize your forms.
This will ensure that nothing is overwritten when you upgrade Forms to a newer version.
:::

## Customizing the default views
The way the razor macro works is that it uses some razor views to output the form:

* 1 view for each fieldtype
* 1 view for the scripts
* 1 view for the rest of the form

You can find the default views in the `~\Views\Partials\Forms\Themes\default` folder if you are using Forms 6+, or in the `~\Views\Partials\Forms\`folder if you are using Forms 4.

To avoid your custom changes to the default views from being overwritten, you need to copy the view you want to customize into your theme folder, e.g. `~\Views\Partials\Forms\Themes\YourTheme`, and edit it there.

### Form.cshtml

This is the main view responsible for rendering the form markup.

The view is separated into two parts, one is the actual form and the other will be shown if the form is submitted.

This view can be customized, if you do so it will be customized for all your forms.

### Script.cshtml
This view renders the JavaScript that will take care of the conditional logic, customization won't be needed here.

### FieldType.*.cshtml
The rest of the views start with FieldType, like `FieldType.Textfield.cshtml` and those will output the fields. There is a view for each default fieldtype like *textfield*, *textarea*, *checkbox*, etc)

Contents of the `FieldType.Textfield.cshtml` view (from the default theme):

```csharp
@model Umbraco.Forms.Mvc.Models.FieldViewModel
@using Umbraco.Forms.Mvc

<input type="text"
    name="@Model.Name"
    id="@Model.Id"
    class="@Html.GetFormFieldClass(Model.FieldTypeName) text"
    value="@Model.ValueAsHtmlString"
    maxlength="500"
    @{if(string.IsNullOrEmpty(Model.PlaceholderText) == false){<text>placeholder="@Model.PlaceholderText"</text>}}
    @{if(Model.Mandatory || Model.Validate){<text>data-val="true"</text>}}
    @{if (Model.Mandatory) {<text> data-val-required="@Model.RequiredErrorMessage"</text>}}
    @{if (Model.Validate) {<text> data-val-regex="@Model.InvalidErrorMessage" data-regex="@Html.Raw(Model.Regex)"</text>}}
/>
```

By default the form makes use of jQuery validate and jQuery validate unobtrusive which is why you see attributes like `data-val` and `data-val-required`.

This can be customized but it's important to keep the ID of the control to `@Model.Id` since that is used to match the value to the form field.  For fields that are conditionally hidden, without an ID of `@Model.Id` the control won't be shown when the conditions to show the field are met.  An ID needs to be added to text controls such as headings and paragraphs.

### Customizing for a specific form

In Forms 4 it is also possible to customize the markup for a specific form.

You will need to create folder using the ID of the form: `~\Views\Partials\Forms\{FormId}` (find the id of the form in the URL when you are viewing the form in the backoffice.)

![Form GUID](images/form-guid.png)

As an example if your form ID is 0d3e6b2d-db8a-43e5-8f28-36241d712487 then you can overwrite the form view by adding the `Form.cshtml` file to the directory. Start by copying the default one and then making your custom changes: `~\Views\Partials\Forms\0d3e6b2d-db8a-43e5-8f28-36241d712487\Form.cshtml`.

You can also overwrite views for one or more fieldtypes by adding the views to the folder: `~\Views\Partials\Forms\0d3e6b2d-db8a-43e5-8f28-36241d712487\Fieldtype.Textfield.cshtml`.
