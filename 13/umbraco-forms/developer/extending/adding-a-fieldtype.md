# Adding A Field Type To Umbraco Forms

_This builds on the "_[_adding a type to the provider model_](adding-a-type.md)_" chapter_

## C\#

Add a new class to the Visual Studio solution, make it inherit from `Umbraco.Forms.Core.FieldType`, and fill in the constructor:

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
            Id = new Guid("08b8057f-06c9-4ca5-8a42-fd1fc2a46eff"); // Replace this!
            Name = "My Custom Field";
            Description = "Render a custom text field.";
            Icon = "icon-autofill";
            DataType = FieldDataType.String;
            SortOrder = 10;
            SupportsRegex = true;
            FieldTypeViewName = "FieldType.MyCustomField.cshtml";
        }

        // You can do custom validation in here which will occur when the form is submitted.
        // Any strings returned will cause the submission to be considered invalid.
        // Returning an empty collection of strings will indicate that it's valid to proceed.
        public override IEnumerable<string> ValidateField(Form form, Field field, IEnumerable<object> postedValues, HttpContext context, IPlaceholderParsingService placeholderParsingService, IFieldTypeStorage fieldTypeStorage)
        {
            var returnStrings = new List<string>();

            if (!postedValues.Any(value => value.ToString().ToLower().Contains("custom")))
            {
                returnStrings.Add("You need to include 'custom' in the field!");
            }

            // Also validate it against the default method (to handle mandatory fields and regular expressions)
            return base.ValidateField(form, field, postedValues, context, placeholderParsingService, fieldTypeStorage, returnStrings);
        }
    }
}
```

In the constructor, or via overridden properties, we can specify details of the field type:

- `Id` - should be set to a unique GUID.
- `Alias` - an internal alias for the field, used for localized translation keys.
- `Name` - the name of the field presented in the backoffice.
- `Description` - the description of the field presented in the backoffice.
- `Icon` - the icon of the field presented in the backoffice form builder user interface.
- `DataType` - specifies the type of data stored by the field. Options are `String`, `LongString`, `Integer`, `DataTime` or `Bit` (boolean).
- `SupportsMandatory` - indicates whether mandatory validation can be used with the field (defaults to `true`).
- `MandatoryByDefault` - indicates whether the field will be mandatory by default when added to a form (defaults to `false`).
- `SupportsRegex` - indicates whether pattern based validation using regular expressions can be used with the field (defaults to `false`).
- `SupportsPreValues` - indicates whether prevalues are supported by the field (defaults to `false`).
- `FieldTypeViewName` - indicates the name of the partial view used to render the field.
- `RenderInputType`- indicates how the field should be rendered within the theme, as defined with the `RenderInputType` enum. The default is `Single` for a single input field. `Multiple` should be used for multiple input fields such as checkbox lists. `Custom` is used for fields without visible input fields.

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

Then we will start building the view for the default theme of the Form at `Views\Partials\Forms\Themes\default\FieldTypes\FieldType.MyCustomField.cshtml`.

The file name for the partial view should match the value set on the `FieldTypeViewName` property.

```csharp
@model Umbraco.Forms.Web.Models.FieldViewModel
<input type="text" name="@Model.Name" id="@Model.Id" class="text" value="@Model.ValueAsHtmlString" maxlength="500"
        @{if (string.IsNullOrEmpty(Model.PlaceholderText) == false) { <text> placeholder="@Model.PlaceholderText" </text> }}
        @{if (Model.Mandatory || Model.Validate) { <text> data-val="true" </text> }}
        @{if (Model.Mandatory) { <text> data-val-required="@Model.RequiredErrorMessage" </text> }}
        @{if (Model.Validate) { <text> data-val-regex="@Model.InvalidErrorMessage" data-val-regex-pattern="@Html.Raw(Model.Regex)" </text> }} />
```

This will be rendered when the default theme is used.

If working with Umbraco 9 or earlier versions, you'll find the `Views\Partials\Forms\Themes\default\` folder on disk and can create the files there.

For Umbraco 10 and above, we've moved to [distributing the theme as part of a Razor Class Library](../../upgrading/version-specific.md#views-and-client-side-files) so the folder won't exist. However, you can create it for your custom field type. If you would like to reference the partial views of the default theme, you can download them as mentioned in the [Themes](../themes.md) article.

### Read-only partial view

When rendering a multi-page form, editors have the option to display a summary page where the entries can be viewed before submitting.

To support this, a read-only view of the field is necessary.

For most fields, nothing is required here, as the default read-only display defined in the built-in `ReadOnly.cshtml` file suffices.

However, if you want to provide a custom read-only display for your field, you can do so by creating a second partial view. This should be named with a `.ReadOnly` suffix. For this example, you would create `FieldType.Slider.ReadOnly.cshtml`.

## Umbraco backoffice view

The final step involves building the HTML view which will be rendered in Umbraco as an example of how our end result will look:

```html
<input
    type="text" tabindex="-1"
    class="input-block-level"
    style="max-width: 100px"
/>
```

In the HTML you can access settings via `field.settings`, e.g. `{{field.settings.Caption}}` to render a "Caption" setting. It is also possible to access prevalues via `field.$preValues`.

For built-in field types, Umbraco Forms look for this file in the virtual folder: `App_Plugins\UmbracoForms\backoffice\Common\FieldTypes\`. It will expect to find a file with a name matching the class's name, i.e. `mycustomfield.html`. To add custom fields and themes, **create a folder at the specified path** (also known as the virtual folder). This is because the client-side code is included in the Razor Class Library. As a result, these files are available as if they're stored at a specific location on disk.

To store in a different location, you can apply the following override to the custom field type's C# representation:

```csharp
public override string GetDesignView() =>
    "~/App_Plugins/UmbracoFormsCustomFields/backoffice/Common/FieldTypes/mycustomfield.html";
```

## Field settings

Field settings that will be managed in the backoffice by editors creating forms using the custom field type can be added to the C# class. These settings can be added as properties with a `Setting` attribute.

```csharp
[Setting("My Setting", Description = "Help text for the setting", View = "TextField", SupportsPlaceholders = "true", DisplayOrder = 10)]
public virtual string MySetting { get; set; }
```

The property `Name` names the setting in the backoffice with the `Description` providing the help text.  Both of these are translatable by providing a [user or package language file](../../../umbraco-cms/extending/language-files.md) containing appropriate keys:

```xml
<area alias="formProviderFieldTypes">
    <key alias="mySettingName">My Setting</key>
    <key alias="mySettingDescription">Help text for the setting</key>
</area>
```

The area aliases for the other provider types are as follows:

- Data sources - `formProviderDataSources`
- Export types - `formProviderExportTypes`
- Prevalue sources - `formProviderPrevalueSources`
- Recordset actions - `formRecordSetActions`
- Workflows - `formProviderWorkflows`

The `View` attribute defines the client-side view used when rendering a preview of the field in the form's designer. Umbraco Forms ships with a number of these, found in a virtual path of `App_Plugins\UmbracoForms\backoffice\Common\SettingTypes\`.

Again though, you can use your own location, and configure with a full path to the view, e.g.:

To reference the file the setting should be configured with a full path to the view, e.g.:

```csharp
[Setting("My Setting",
    Description = "Help text for the setting",
    View = "~/App_Plugins/UmbracoFormsCustomFields/backoffice/Common/SettingTypes/mycustomsettingfield.html",
    SupportsPlaceholders = true,
    DisplayOrder = 10)]
public virtual string MySetting { get; set; }
```

`SupportsPlaceholders` is a flag indicating whether the setting can contain ["magic string" placeholders](../magic-strings.md) and controls whether they are parsed on rendering.

`HtmlEncodeReplacedPlaceholderValues` takes effect only if `SupportsPlaceholders` is `true`. It controls whether the replaced placeholder values should be HTML encoded (as is necessary for rendering within content from a rich text editor).

`SupportsHtml` is a flag indicating whether the setting can contain HTML content. When set to `true` it will be treated as HTML content when the value is read from the Forms delivery API.

`IsMandatory` if set to `true` will provide client-side validation in the backoffice to ensure the value is completed.

### Settings when inheriting

When creating a field or other provider type, you might choose to inherit from an existing class. This could be if one of the types provided with Umbraco Forms almost meets your needs but you want to make some changes.

All setting properties for the Forms provider types are marked as `virtual`, so you can override them and change the setting values:

```csharp
[Setting("My Setting", Description = "My custom help text for the setting", View = "TextField", SupportsPlaceholders = "true", DisplayOrder = 10)]
public override string MySetting { get; set; }
```

If you want to hide a setting in your derived class you can use the `IsHidden` property:

```csharp
[Setting("My Setting", IsHidden = true)]
public override string MySetting { get; set; }
```

## Backoffice entry rendering

The third and final client-side view file used for settings is in the rendering of the submitted values for the field. This rendering takes place in the "Entries" section of the backoffice.

These are defined by the `RenderView` property of a field type and are found in `App_Plugins\UmbracoForms\backoffice\Common\RenderTypes\`.

As for the other files, if you require a custom render type view, it's better to host them in a different location, such as `App_Plugins\UmbracoFormsCustomFields\backoffice\Common\RenderTypes\mycustomrenderfield.html`.

To reference the file you should override the `RenderView` property, e.g.:

```csharp
public override string RenderView => "~/App_Plugins/UmbracoFormsCustomFields/backoffice/Common/RenderTypes/mycustomrenderfield.html";
```
