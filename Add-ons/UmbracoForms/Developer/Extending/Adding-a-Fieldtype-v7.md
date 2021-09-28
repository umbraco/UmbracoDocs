---
versionFrom: 7.0.0
meta.Title: "Adding a field type to Umbraco Forms"
---

# Adding a field type to Umbraco Forms #

*This builds on the "[adding a type to the provider model](Adding-a-Type.md)" chapter*

## C#

Add a new class to the Visual Studio solution, make it inherit from Umbraco.Forms.Core.FieldType and fill in the constructor:

```csharp
using Umbraco.Forms.Core.Data.Storage;
using Umbraco.Forms.Core.Enums;
using Umbraco.Forms.Core.Models;



public class MyCustomField : Umbraco.Forms.Core.FieldType
{
    public MyCustomField()
    {
        this.Id = new Guid("08b8057f-06c9-4ca5-8a42-fd1fc2a46eff"); // Replace this!
        this.Name = "My Custom Field";
        this.Description = "Render a custom text field.";
        this.Icon = "icon-autofill";
        this.DataType = FieldDataType.String;
        this.SortOrder = 10;
        this.SupportsRegex = true;
    }

    // You can do custom validation in here which will occur when the form is submitted.
    // Any strings returned will cause the submit to be invalid!
    // Where as returning an empty ienumerable of strings will say that it's okay.
    public override IEnumerable<string> ValidateField(Form form, Field field, IEnumerable<object> postedValues, HttpContextBase context, IFormStorage formStorage)
    {
        var returnStrings = new List<string>();

        if (!postedValues.Any(value => value.ToString().ToLower().Contains("custom"))) {
            returnStrings.Add("You need to include 'custom' in the field!");
        }

        // Also validate it against the original default method.
        returnStrings.AddRange(base.ValidateField(form, field, postedValues, context, formStorage));

        return returnStrings;
    }
}
```

In the constructor, we specify the standard provider information (remember to set the ID to a unique ID).

And then we set the field type specific information. In this case a preview Icon for the form builder UI and what kind of data it will return, this can either be string, longstring, integer, datetime or boolean.

## Partial view

Then we will start building the view at `Views\Partials\Forms\Fieldtypes\FieldType.MyCustomField.cshtml`:

```csharp
@model Umbraco.Forms.Mvc.Models.FieldViewModel
<input type="text" name="@Model.Name" id="@Model.Id" class="text" value="@Model.Value" maxlength="500"
        @{if (string.IsNullOrEmpty(Model.PlaceholderText) == false) { <text> placeholder="@Model.PlaceholderText" </text> }}
        @{if (Model.Mandatory || Model.Validate) { <text> data-val="true" </text> }}
        @{if (Model.Mandatory) { <text> data-val-required="@Model.RequiredErrorMessage" </text> }}
        @{if (Model.Validate) { <text> data-val-regex="@Model.InvalidErrorMessage" data-val-regex-pattern="@Html.Raw(Model.Regex)" </text> }} />
```

The view takes care of generating the UI control and setting its value.

On the view, it is important to note that the ID attribute is fetched from `@Model.Id`. You'll also see that we are using jQuery validate unobtrusive to perform client side validation so that's why we are adding the data* attributes.

### Partial view for themes

We will also add a file for the default theme of the form at `Views\Partials\Forms\Themes\default\FieldTypes\FieldType.MyCustomField.cshtml` 

```csharp
@model Umbraco.Forms.Mvc.Models.FieldViewModel
<input type="text" name="@Model.Name" id="@Model.Id" class="text" value="@Model.ValueAsHtmlString" maxlength="500"
        @{if (string.IsNullOrEmpty(Model.PlaceholderText) == false) { <text> placeholder="@Model.PlaceholderText" </text> }}
        @{if (Model.Mandatory || Model.Validate) { <text> data-val="true" </text> }}
        @{if (Model.Mandatory) { <text> data-val-required="@Model.RequiredErrorMessage" </text> }}
        @{if (Model.Validate) { <text> data-val-regex="@Model.InvalidErrorMessage" data-val-regex-pattern="@Html.Raw(Model.Regex)" </text> }} />
```

This will be rendered when the default theme is used. For example purposes, it can be identical to the previous partial view.

## Umbraco backoffice view

The final step involves building the HTML view which will be rendered in Umbraco as an example of how our end result will look. We will create a file at `App_Plugins\UmbracoForms\Backoffice\Common\FieldTypes\mycustomfield.html` which will contain the following:

```html
<input
    type="text" tabindex="-1"
    class="input-block-level"
    style="max-width: 100px"
/>
```
