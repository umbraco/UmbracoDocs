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
            EditView = "Umb.PropertyEditorUi.TextBox";
            PreviewView = "Forms.FieldPreview.TextBox";
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
- `EditView` - indicates the name of a property editor UI that is used for editing the field in the backoffice. If nothing is provided, the built-in label will be used and the field won't be editable.
- `PreviewView` - indicates the name of a manifest registered client-side resource that is used for previewing the field in the backoffice. If nothing is provided, the name of the field type will be used as the preview.
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

## Umbraco backoffice components

Two aspects of the presentation and functionality of the custom field are handled by client-side components, registered via manifests:

- The preview, displayed on the form definition editor.
- The property editor UI used for editing the the submitted values via the backoffice.

These are referenced server-side using the `PreviewView` and `EditView` respectively.

For the edit view, you can use a built-in property editor UI, one from a package, or a custom one registered with your solution.

To help with creating your own preview element, the following example shows the built-in text field preview:

```javascript
import {
  html,
  customElement,
  property,
} from "@umbraco-cms/backoffice/external/lit";

const elementName = "forms-field-preview-text-box"
@customElement(elementName)
export class FormsFieldPreviewTextBox extends UmbLitElement {

  @property()
  settings: Record<string, string> = {}

  #getSettingValue(alias: string) : string {
    return this.settings[alias];
  }

  render() {
    return html`<input type="text" readonly tabindex="-1" style="width: 200px" placeholder=${this.#getSettingValue("Placeholder")} />`;
  }
}

export default FormsFieldPreviewTextBox;

declare global {
  interface HTMLElementTagNameMap {
    [elementName]: FormsFieldPreviewTextBox;
  }
}
```

It's registered using a manifest as follows:

```javascript
export const manifest: ManifestFormsFieldPreview =
  {
    type: "formsFieldPreview",
    alias: "Forms.FieldPreview.TextBox",
    name: "Text Box Field Preview",
    element: () => import('./text-box-field-preview.element.js'),
  };
```

## Field settings

Field settings that will be managed in the backoffice by editors creating forms using the custom field type can be added to the C# class as properties with a `Setting` attribute:

```csharp
[Setting("My Setting", Description = "Help text for the setting", View = "Umb.PropertyEditorUi.TextBox", SupportsPlaceholders = "true", DisplayOrder = 10)]
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

The `View` property indicates a property editor UI used for editing the setting value. You can use a built-in property editor UI, one from a package, or a custom one registered with your solution.  The default value if not provided is `Umb.PropertyEditorUi.TextBox`, which will use the standard Umbraco text box property editor UI.

You may optionally want to register a settings value converter. This is a client-side, manifest registered component, that converts between the setting value required for the editor and that persisted with the form definition.  A converter defines three methods:

- `getSettingValueForEditor` - converts the persisted string value into one suitable for the editor
- `getSettingValueForPersistence` - converts the editor value into the string needed for persistence
- `getSettingPropertyConfig` - creates the configuration needed for the property editor

As an example, the following code shows how the built-in slider setting element used for selecting a number within a range for the reCAPTCHA field is defined.

```csharp
[Setting(
    "Score threshold",
    Description = "A reCAPTCHA v3 determined score between 0 and 10, above which form submissions are accepted. A higher value will catch more spam submissions, but also increase the risk of rejections of valid entries. For most sites, 5 is a sensible choice.",
    View = "Umb.PropertyEditorUi.Slider",
    PreValues = "0.0,1.0,0.1,0.5",
    DisplayOrder = 10)]
public virtual string ScoreThreshold { get; set; } = string.Empty;
```

```javascript
import { UmbPropertyValueData } from "@umbraco-cms/backoffice/property";
import { FormsSettingValueConverterApi } from "./manifests";
import { Setting } from "@umbraco-forms/generated";
import { UmbPropertyEditorConfig } from "@umbraco-cms/backoffice/property-editor";

export class FormsSliderSettingValueConverter implements FormsSettingValueConverterApi  {
  getSettingValueForEditor(setting: Setting, alias: string, value: string) {
    // Multiply by 10 to get the integer value we need for the editor.
    const editorValue = Math.trunc(parseFloat(value) * 10);
    return { from: editorValue, to: editorValue };
  }

  getSettingValueForPersistence(valueData: UmbPropertyValueData) {
    // Divide by 10 to get the 0.0 to 1.0 range we actually want.
    return ((valueData.value ? parseInt(valueData.value["from"]) : 5) / 10).toFixed(1);
  }

  async getSettingPropertyConfig(setting: Setting, alias: string, values: UmbPropertyValueData[]) {
    const config: UmbPropertyEditorConfig = [];

    // Min, max, step and default are provided in prevalues.
    // As the slider only supports integers, we have to multiply by 10 for the UI and then divide again when we save.
    config.push({
      alias: "enableRange",
      value: false,
    });

    const settingValue = values.find(s => s.alias === alias)?.value?.toString() || "";

    if (setting.prevalues.length >= 1) {
      config.push({
        alias: "minVal",
        value: parseFloat(setting.prevalues[0]) * 10,
      });
      if (setting.prevalues.length >= 2) {
        config.push({
          alias: "maxVal",
          value: parseFloat(setting.prevalues[1]) * 10,
        });
        if (setting.prevalues.length >= 3) {
          config.push({
            alias: "step",
            value: parseFloat(setting.prevalues[2]) * 10,
          });
          if (setting.prevalues.length >= 3 && settingValue.length === 0) {
            config.push({
              alias: "initVal1",
              value: parseFloat(setting.prevalues[3]) * 10,
            });
          } else {
            config.push({
              alias: "initVal1",
              value: parseFloat(settingValue),
            });
          }
        }
      }
    }

    return Promise.resolve(config);
  }

  destroy() {
  }
}
```

It's registered using a manifest as follows. Note that we provide the `propertyEditorUiAlias` to associated the converter with the appropriate property editor UI.

```javascript
export const manifest: ManifestFormsSettingValueConverterPreview =
  {
    type: "formsSettingValueConverter",
    alias: "Forms.SettingValueConverter.Slider",
    name: "Number Slider Value Converter",
    propertyEditorUiAlias: "Umb.PropertyEditorUi.Slider",
    api: FormsSliderSettingValueConverter,
  };
```

`SupportsPlaceholders` is a flag indicating whether the setting can contain ["magic string" placeholders](../magic-strings.md) and controls whether they are parsed on rendering.

`HtmlEncodeReplacedPlaceholderValues` takes effect only if `SupportsPlaceholders` is `true`. It controls whether the replaced placeholder values should be HTML encoded (as is necessary for rendering within content from a rich text editor).

`IsMandatory` if set to `true` will provide client-side validation in the backoffice to ensure the value is completed.

### Settings when inheriting

When creating a field or other provider type, you might choose to inherit from an existing class. This could be if one of the types provided with Umbraco Forms almost meets your needs but you want to make some changes.

All setting properties for the Forms provider types are marked as `virtual`, so you can override them and change the setting values:

```csharp
[Setting("My Setting", Description = "My custom help text for the setting", View = "Umb.PropertyEditorUi.TextBox", SupportsPlaceholders = "true", DisplayOrder = 10)]
public override string MySetting { get; set; }
```

If you want to hide a setting in your derived class you can use the `IsHidden` property:

```csharp
[Setting("My Setting", IsHidden = true)]
public override string MySetting { get; set; }
```
