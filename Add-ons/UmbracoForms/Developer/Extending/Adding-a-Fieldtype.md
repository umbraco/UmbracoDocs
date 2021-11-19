---
versionFrom: 9.0.0
meta.Title: "Adding a field type to Umbraco Forms"
state: complete
verified-against: beta-1
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

Then we will start building the view for the default theme of the form at `Views\Partials\Forms\Themes\default\FieldTypes\FieldType.MyCustomField.cshtml` 

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

The final step involves building the HTML view which will be rendered in Umbraco as an example of how our end result will look. We will create a file at `App_Plugins\UmbracoForms\Backoffice\Common\FieldTypes\mycustomfield.html` which will contain the following:

```html
<input
    type="text" tabindex="-1"
    class="input-block-level"
    style="max-width: 100px"
/>
```
