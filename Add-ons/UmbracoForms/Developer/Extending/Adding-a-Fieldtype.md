---
versionFrom: 9.0.0
versionTo: 10.0.0
meta.Title: "Adding a field type to Umbraco Forms"
---

# Adding a field type to Umbraco Forms #

*This builds on the "[adding a type to the provider model](Adding-a-Type.md)" chapter*

## C#

Add a new class to the Visual Studio solution, make it inherit from `Umbraco.Forms.Core.FieldType` and fill in the constructor:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Http;
using Umbraco.Forms.Core.Enums;
using Umbraco.Forms.Core.Models;
using Umbraco.Forms.Core.Services;

namespace MyFormsExtensions
{
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
            this.FieldTypeViewName = "FieldType.MyCustomField.cshtml";
        }

        // You can do custom validation in here which will occur when the form is submitted.
        // Any strings returned will cause the submit to be invalid!
        // Where as returning an empty ienumerable of strings will say that it's okay.
        public override IEnumerable<string> ValidateField(Form form, Field field, IEnumerable<object> postedValues, HttpContext context, IPlaceholderParsingService placeholderParsingService)
        {
            var returnStrings = new List<string>();

            if (!postedValues.Any(value => value.ToString().ToLower().Contains("custom")))
            {
                returnStrings.Add("You need to include 'custom' in the field!");
            }

            // Also validate it against the original default method.
            returnStrings.AddRange(base.ValidateField(form, field, postedValues, context, placeholderParsingService));

            return returnStrings;
        }
    }
}

```

In the constructor, we specify the standard provider information (remember to set the ID to a unique ID).

And then we set the field type specific information. In this case a preview Icon for the form builder UI and what kind of data it will return, this can either be string, longstring, integer, datetime or boolean.

You will then need to register this new field as a dependency.

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Forms.Core.Providers;

namespace MyFormsExtensions
{
    public class Startup : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.WithCollectionBuilder<FieldCollectionBuilder>()
                .Add<MyCustomField>();
        }
    }
}
```

## Partial view

Then we will start building the view for the default theme of the form at `Views\Partials\Forms\Themes\default\FieldTypes\FieldType.MyCustomField.cshtml`.

The file name for the partial view should match the value set on the `FieldTypeViewName` property.

```csharp
@model Umbraco.Forms.Mvc.Models.FieldViewModel
<input type="text" name="@Model.Name" id="@Model.Id" class="text" value="@Model.ValueAsHtmlString" maxlength="500"
        @{if (string.IsNullOrEmpty(Model.PlaceholderText) == false) { <text> placeholder="@Model.PlaceholderText" </text> }}
        @{if (Model.Mandatory || Model.Validate) { <text> data-val="true" </text> }}
        @{if (Model.Mandatory) { <text> data-val-required="@Model.RequiredErrorMessage" </text> }}
        @{if (Model.Validate) { <text> data-val-regex="@Model.InvalidErrorMessage" data-val-regex-pattern="@Html.Raw(Model.Regex)" </text> }} />
```

This will be rendered when the default theme is used.

## Umbraco backoffice view

The final step involves building the HTML view which will be rendered in Umbraco as an example of how our end result will look:

```html
<input
    type="text" tabindex="-1"
    class="input-block-level"
    style="max-width: 100px"
/>
```

For built-in field types, Umbraco Forms look for this file in the folder:  `App_Plugins\UmbracoForms\backoffice\Common\FieldTypes\` and will expect to find a file with a name matching the class's name, i.e. `mycustomfield.html`.

As this location is cleared following a `dotnet clean` command, it's better to host the files for custom field types in a different location, such as `App_Plugins\UmbracoFormsCustomFields\backoffice\Common\FieldTypes\mycustomfield.html`.

With a file in that location, you can apply the following override to the custom field type's C# representation:

```csharp
public override string GetDesignView() =>
    "~/App_Plugins/UmbracoFormsCustomFields/backoffice/Common/FieldTypes/mycustomfield.html";

```

## Field settings

Field settings that will be managed in the backoffice by editors creating forms using the custom field type can be added to the C# class as properties with a `Setting` attribute:

```csharp
    [Setting("My Setting", Description = "Help text for the setting", View = "TextField", DisplayOrder=10)]
    public string MySetting { get; set; }
```

The `View` attribute defines the client-side view used when rendering a preview of the field in the form's designer.  Umbraco Forms ships with a number of these, found in `App_Plugins\UmbracoForms\backoffice\Common\SettingTypes\`.

Again though, as this location is cleared following a `dotnet clean` command, if you require a custom setting type view, it's better to host them in different location, such as `App_Plugins\UmbracoFormsCustomFields\backoffice\Common\SettingTypes\mycustomsettingfield.html`.

To reference the file the setting should be configured with a full path to the view, e.g.:

```csharp
    [Setting("My Setting",
        Description = "Help text for the setting",
        View = "~/App_Plugins/UmbracoFormsCustomFields/backoffice/Common/SettingTypes/mycustomsettingfield.html",
        DisplayOrder=10)]
    public string MySetting { get; set; }
```

## Backoffice entry rendering

The third and final client-side view file used for settings is in the rendering of the submitted values for the field in the "Entries" section of the backoffice.

These are defined by the `RenderView` property of a field type and are found in `App_Plugins\UmbracoForms\backoffice\Common\RenderTypes\`.

As for the other files, if you require a custom render type view, it's better to host them in different location, such as `App_Plugins\UmbracoFormsCustomFields\backoffice\Common\RenderTypes\mycustomrenderfield.html`.

To reference the file you should override the `RenderView` property, e.g.:

```csharp
public override string RenderView => "~/App_Plugins/UmbracoFormsCustomFields/backoffice/Common/RenderTypes/mycustomrenderfield.html";
```

## Validation

If using [jQuery validate](https://jqueryvalidation.org/) it is possible to use various methods in a custom field type, e.g. `equalTo`, `digits` or `remote`.

For example a Compare field type to compare another field.

```csharp
public class CompareField : Umbraco.Forms.Core.FieldType
{
    public CompareField()
    {
        this.Id = new Guid("b83dddc2-bdf3-4a0b-b9ad-f7bba83080df");
        this.Name = "Compare Field";
        this.Description = "Compare input to another field.";
        this.Icon = "icon-autofill";
        this.FieldTypeViewName = "FieldType.Compare.cshtml";
        this.DataType = FieldDataType.String;
        this.SortOrder = 10;
        this.SupportsRegex = true;
    }

    [Setting("Compare Field",
        Description = "Compare field",
        View = "textfield")]
    public string CompareField { get; set; }

    /// <summary>
    /// Gets or sets a value indicating whether the field label should be shown.
    /// PreValues are a single element, a boolean indicating whether the default for the the checkbox is "checked".
    /// </summary>
    [Setting("Show Label", Description = "Indicate whether the the field's label should be shown when rendering the form.", View = "checkbox", PreValues = "true", DisplayOrder = 20)]
    public string ShowLabel { get; set; } = string.Empty;

    /// <inheritdoc/>
    public override bool HideLabel => ShowLabel == "False"; // Checking explicitly for false so the backward compatible default is to show the label.

    public override string GetDesignView() =>
        "~/App_Plugins/UmbracoForms/backoffice/Common/FieldTypes/Textfield.html";

    public override IEnumerable<string> ValidateField(Form form, Field field, IEnumerable<object> postedValues, HttpContext context, IPlaceholderParsingService placeholderParsingService)
    {
        var baseValidation = base.ValidateField(form, field, postedValues, context, placeholderParsingService);
        var value = postedValues.FirstOrDefault();

        var compareField = GetPostFieldValue(form, context, CompareField);

        if (compareField == null)
            return baseValidation;

        if (value != null && value.ToString() == compareField)
        {
            return baseValidation;
        }

        var custom = new List<string>();
        custom.AddRange(baseValidation);
        custom.Add("Email does not match.");

        return custom;
    }

    private static string GetPostFieldValue(Form form, HttpContext context, string key)
    {
        Field? field = GetPostField(form, key);
        if (field == null)
        {
            return string.Empty;
        }

        return context.Request.HasFormContentType && context.Request.Form.Keys.Contains(field.Id.ToString())
            ? context.Request.Form[field.Id.ToString()].ToString().Trim()
            : string.Empty;
    }

    private static Field? GetPostField(Form form, string key) => form.AllFields.SingleOrDefault(f => f.Alias == key);
}
```

```csharp
@using Umbraco.Forms.Web
@model Umbraco.Forms.Web.Models.FieldViewModel

@inject Umbraco.Forms.Web.Services.IFormRenderingService FormRenderingService

@{
    var maxLength = Model.GetSettingValue<int>("MaximumLength", 255);
    var fieldType = Model.GetSettingValue<string>("FieldType", "text");
    var autocompleteAttribute = Model.GetSettingValue<string>("AutocompleteAttribute", string.Empty);
    var compareField = Model.GetSettingValue<string>("CompareField", string.Empty);
    
    var form = FormRenderingService.GetForm(Guid.Parse("0638c6f0-f6db-460d-b462-6dc393a8ae0c"));
    var field = form?.AllFields.SingleOrDefault(x => x.Alias == compareField);
}

<input type="@fieldType" name="@Model.Name" id="@Model.Id" data-umb="@Model.Id" class="@Html.GetFormFieldClass(Model.FieldTypeName)" value="@Model.ValueAsHtmlString" maxlength="@maxLength"
       @{if (string.IsNullOrEmpty(Model.PlaceholderText) == false) { <text> placeholder="@Model.PlaceholderText" </text> }}
       @{if (string.IsNullOrEmpty(autocompleteAttribute) == false) { <text> autocomplete="@autocompleteAttribute" </text> }}
       @{if (string.IsNullOrEmpty(compareField) == false) { <text> data-val-equalto="Not equal to @field?.Caption" data-val-equalto-other="@field?.Id" </text> }}
       @{if (Model.Mandatory || Model.Validate) { <text> data-val="true" </text> }}
       @{if (Model.Mandatory) { <text> data-val-required="@Model.RequiredErrorMessage" </text> }}
       @{if (Model.Validate) { <text> data-val-regex="@Model.InvalidErrorMessage" data-val-regex-pattern="@Html.Raw(Model.Regex)" </text> }} />
```
