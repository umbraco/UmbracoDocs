# Adding A Field Type To Umbraco Forms

_This builds on the "_[_adding a type to the provider model_](adding-a-type.md)_" chapter_

In this article, we will illustrate how to add a custom form field type using server-side and client-side components. We will use the example of rendering a "slider" field type that allows the user to select a number within a specific range of values.

## Server-side Field Type Definition

Add a new class to the Visual Studio solution. Inherit from `Umbraco.Forms.Core.FieldType` and complete as follows:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Forms.Core.Attributes;
using Umbraco.Forms.Core.Enums;
using Umbraco.Forms.Core.Providers;

namespace MyProject;

public class SliderFieldType : Core.FieldType
{
    public SliderFieldType()
    {
        Id = new Guid("6dff0075-598c-4345-89d7-e0db8684c819");
        Name = "Slider";
        Alias = "slider";
        Description = "Render a UUI Slider field.";
        Icon = "icon-autofill";
        DataType = FieldDataType.String;
        SortOrder = 10;

        FieldTypeViewName = "FieldType.Slider.cshtml";
        EditView = "My.PropertyEditorUi.InputNumber";
        PreviewView = "My.FieldPreview.Slider";
    }

    [Setting("Minimum", Description = "Minimum value", View = "Umb.PropertyEditorUi.Integer", DisplayOrder = 10)]
    public virtual string? Min { get; set; } = "1";

    [Setting("Maximum", Description = "Maximum value", View = "Umb.PropertyEditorUi.Integer", DisplayOrder = 20)]
    public virtual string? Max { get; set; } = "1";

    [Setting("Step", Description = "Step size", View = "Umb.PropertyEditorUi.Integer", DisplayOrder = 30)]
    public virtual string? Step { get; set; } = "1";

    [Setting("Default Value", Description = "Default value", View = "Umb.PropertyEditorUi.Integer", DisplayOrder = 40)]
    public virtual string? DefaultValue { get; set; } = "1";

    [Setting("Hide step values", Description = "Hides the numbers representing the value of each steps. Dots will still be visible", View = "Umb.PropertyEditorUi.Toggle", DisplayOrder = 50)]
    public virtual string? HideStepValues { get; set; }

    [Setting("Background color", Description = "Background color for the input field", View = "My.PropertyEditorUi.InputColor", DisplayOrder = 60)]
    public virtual string? BgColor { get; set; } = "1";
}
```

In the constructor or via overridden properties, we can specify details of the field type:

* `Id` - should be set to a unique GUID.
* `Alias` - an internal alias for the field, used for localized translation keys.
* `Name` - the name of the field presented in the backoffice.
* `Description` - the description of the field presented in the backoffice.
* `Icon` - the icon of the field presented in the backoffice form builder user interface.
* `DataType` - specifies the type of data stored by the field. Options are `String`, `LongString`, `Integer`, `DateTime` or `Bit` (boolean).
* `SupportsMandatory` - indicates whether mandatory validation can be used with the field (defaults to `true`).
* `MandatoryByDefault` - indicates whether the field will be mandatory by default when added to a form (defaults to `false`).
* `SupportsRegex` - indicates whether pattern-based validation using regular expressions can be used with the field (defaults to `false`).
* `SupportsPreValues` - indicates whether prevalues are supported by the field (defaults to `false`).
* `RenderInputType`- indicates how the field should be rendered within the theme as defined with the `RenderInputType` enum.
  * The default is `Single` for a single input field.
  * `Multiple` should be used for multiple input fields such as checkbox lists.
  * `Custom` is used for fields without visible input fields.
* `FieldTypeViewName` - indicates the name of the partial view used to render the field on the website.
* `EditView` - indicates the name of a property editor UI that is used for editing the field in the backoffice. If nothing is provided, the built-in label will be used and the field won't be editable.
* `PreviewView` - indicates the name of a manifest registered client-side resource that is used for previewing the field in the backoffice. If nothing is provided, the name of the field type will be used as the preview.
* `IsConfigured` - indicates whether the field type is configured for use. This is derived from the `GetConfigurationErrors` method — it returns `true` when no configuration errors are reported.

### Configuration Validation

The `GetConfigurationErrors` method can be overridden to report when required configuration is missing. By default it returns an empty collection, meaning the field type is considered configured and available for use.

When the method returns one or more error messages, the field type will be shown as unavailable in the backoffice form builder until the issues are resolved. This is useful when your field type depends on external API keys or other application configuration settings.

```csharp
public override IEnumerable<string> GetConfigurationErrors()
{
    if (string.IsNullOrWhiteSpace(_myRequiredApiKey))
    {
        yield return "MyFieldType requires an API key to be configured in appsettings.json.";
    }
}
```

You now need to register this new field as a dependency:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Forms.Core.Providers;

namespace MyProject;

public class Startup : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.WithCollectionBuilder<FieldCollectionBuilder>()
            .Add<SliderFieldType>();
    }
}
```

## Partial View

We will start building the view for the default theme of the Form at `Views\Partials\Forms\Themes\default\FieldTypes\FieldType.Slider.cshtml`.

The file name for the partial view should match the value set on the `FieldTypeViewName` property.

```csharp
@using Umbraco.Forms.Web
@model Umbraco.Forms.Web.Models.FieldViewModel
@{
    var min = Model.GetSettingValue<int>("Min", 1);
    var max = Model.GetSettingValue<int>("Max", 10);
    var step = Model.GetSettingValue<int>("Step", 1);
    var bgColor = Model.GetSettingValue<string>("BgColor", "#fff");
}
<div>This is a custom "slider" field type. We'll just use an input to mock this up.</div>
<input name="@Model.Name"
    style="background-color: @bgColor"
    id="@Model.Id"
    class="text @Html.GetFormFieldClass(Model.FieldTypeName)"
    value="@Model.ValueAsHtmlString"
    type="number"
    min="@min"
    max="@max"
    step="@step" />
```

This will be rendered when the default theme is used.

The theme is distributed as part of a Razor Class Library, so the folder won't exist on disk. However, you can create it for your custom field type. If you would like to reference the partial views of the default theme, you can download them as mentioned in the [Themes](../themes.md) article.

### Read-only partial view

When rendering a multi-page form, editors have the option to display a summary page where the entries can be viewed before submitting.

To support this, a read-only view of the field is necessary.

For most fields, nothing is required here, as the default read-only display defined in the built-in `ReadOnly.cshtml` file suffices.

However, if you want to provide a custom read-only display for your field, you can do so by creating a second partial view. This should be named with a `.ReadOnly` suffix. For this example, you would create `FieldType.Slider.ReadOnly.cshtml`.

## Field Settings

Field settings will be managed in the backoffice by editors who will create forms using the custom field type. These settings can be added to the C# class as properties with a `Setting` attribute:

```csharp
[Setting("Minimum", Description = "Minimum value", View = "Umb.PropertyEditorUi.Integer", DisplayOrder = 10)]
public virtual string? Min { get; set; } = "1";
```

The property `Name` names the setting in the backoffice with the `Description` providing the help text. Both of these can be translated, as discussed in the backoffice components section below.

The `View` property indicates a property editor UI used for editing the setting value. You can use a built-in property editor UI, one from a package, or a custom one registered with your solution. The default value if not provided is `Umb.PropertyEditorUi.TextBox`, which will use the standard Umbraco text box property editor UI.

`SupportsPlaceholders` is a flag indicating whether the setting can contain ["magic string" placeholders](../magic-strings.md) and controls whether they are parsed on rendering.

`HtmlEncodeReplacedPlaceholderValues` takes effect only if `SupportsPlaceholders` is `true`. It controls whether the replaced placeholder values should be HTML encoded (as is necessary for rendering within content from a rich text editor).

`SupportsHtml` is a flag indicating whether the setting can contain HTML content. When set to `true` it will be treated as HTML content when the value is read from the Forms delivery API.

`IsMandatory` if set to `true` will provide client-side validation in the backoffice to ensure the value is completed.

Default values for settings can be defined in code using one of two approaches.

Using a property initializer:

```csharp
[Setting("Minimum")]
public virtual string? Min { get; set; } = "1";
```

Using the `DefaultValue` attribute property:

```csharp
[Setting("Minimum", DefaultValue = "1")]
public virtual string? Min { get; set; }
```

If both are provided, the `DefaultValue` attribute property takes precedence over the property initializer.

These code-based defaults provide an alternative to [configuring default values via `appsettings.json`](../configuration/#settingscustomization). If a value is configured in `appsettings.json`, it takes precedence over any code-based default.

When creating a field or other provider type, you might choose to inherit from an existing class. This could be if one of the types provided with Umbraco Forms almost meets your needs but you want to make some changes.

All setting properties for the Forms provider types are marked as `virtual`, so you can override them and change the setting values:

## Umbraco Backoffice Components

With Forms 14+, aspects of the presentation and functionality of the custom field are handled by client-side components, registered via manifests:

* The preview, displayed on the form definition editor.
* The property editor UI used for editing the the submitted values via the backoffice.
* The property editor UI used for editing settings.
* A settings converter, that handles configuring the property editor and translating between the editor and persisted values.
* Translations for setting labels and descriptions.

To create custom backoffice components for Umbraco 14, it's recommended to use a front-end build setup using Vite, TypeScript, and Lit. For more information, see the [Extension with Vite, TypeScript, and Lit](https://docs.umbraco.com/umbraco-cms/tutorials/creating-your-first-extension#extension-with-vite-typescript-and-lit) article.

The examples here are using the `@umbraco-forms/backoffice` package to get access to Forms-specific types and contexts. It is recommended to install this package as a development dependency in your project.

{% hint style="warning" %}
Ensure that you install the version of the Backoffice package that is compatible with your Umbraco Forms installation. You can find the appropriate version on the [`@umbraco-forms/backoffice` npm page](https://www.npmjs.com/package/@umbraco-forms/backoffice).
{% endhint %}

```bash
npm install -D @umbraco-forms/backoffice@x.x.x
```

This will add a package to your devDependencies containing the TypeScript definitions for Umbraco Forms.

To display a name and description on a custom field, you need to register a JavaScript file as shown in the [Localization](https://app.gitbook.com/s/7MBVdnTbFiAgWuRsHpNS/customizing/extending-overview/extension-types/localization) article.

### Field Preview

The alias of the preview to use is defined on the field type via the `PreviewView` property.

A preview for our slider, representing the selected setting values could look as follows:

```javascript
import {
  LitElement,
  css,
  customElement,
  html,
  property,
} from "@umbraco-cms/backoffice/external/lit";
import { FormsFieldPreviewBaseElement } from "@umbraco-forms/backoffice";

const elementName = "my-field-preview-slider";

@customElement(elementName)
export class MyFieldPreviewSliderElement extends FormsFieldPreviewBaseElement {
  @property()
  settings = {};

  @property({ type: Array })
  prevalues = [];

  render() {
    return html`<div
      style="background-color:${this.getSettingValue("BgColor")}"
    >
      <uui-slider
        .min=${parseInt(this.getSettingValue("Min"))}
        .max=${parseInt(this.getSettingValue("Max"))}
        .step=${this.getSettingValue("Step")}
        .value=${this.getSettingValue("DefaultValue")}
        ?hide-step-values=${this.getSettingValue("HideStepValues") === "True"}
      ></uui-slider>
    </div>`;
  }

  static styles = css`
    div {
      padding: var(--uui-size-4);
    }
  `;
}

export default MyFieldPreviewSliderElement;

declare global {
  interface HTMLElementTagNameMap {
    [elementName]: MyFieldPreviewSliderElement;
  }
}
```

And it is registered via a manifest:

```javascript
import MyFieldPreviewSliderElement from './slider-preview.element.js';
import { ManifestFormsFieldPreview } from '@umbraco-forms/backoffice';

const sliderPreviewManifest: ManifestFormsFieldPreview = {
  type: "formsFieldPreview",
  alias: "My.FieldPreview.Slider",
  name: "Forms UUI Slider Field Preview",
  element: MyFieldPreviewSliderElement
};

export const manifests = [sliderPreviewManifest];
```

### Field Editor

Umbraco Forms supports editing of the entries submitted by website visitors via the backoffice. The property editor interface to use for this is defined in the field type's `EditView` property.

If not using a built-in property editor, you can create your own. The following example shows how the numerical entries could be edited using an input control.

```javascript
import {
  html,
  customElement,
} from "@umbraco-cms/backoffice/external/lit";
import type { UmbPropertyEditorUiElement } from "@umbraco-cms/backoffice/property-editor";
import { UmbLitElement } from "@umbraco-cms/backoffice/lit-element";
import {
  UmbChangeEvent,
} from "@umbraco-cms/backoffice/event";
import { UmbFormControlMixin } from "@umbraco-cms/backoffice/validation";

const elementName = "my-property-editor-ui-number";

@customElement(elementName)
export class MyPropertyEditorUINumberElement
  extends UmbFormControlMixin<string, typeof UmbLitElement, undefined>(UmbLitElement, undefined)
  implements UmbPropertyEditorUiElement
{
  private onChange(e: Event) {
    const newValue = (e.target as HTMLInputElement).value;
    if (newValue === this.value) return;
    this.value = newValue;
    this.dispatchEvent(new UmbChangeEvent());
  }

  override render() {
    return html`<uui-input
      .value=${this.value ?? ""}
      type="number"
      @input=${this.onChange}
    ></uui-input>`;
  }
}

export default MyPropertyEditorUINumberElement;

declare global {
  interface HTMLElementTagNameMap {
    [elementName]: MyPropertyEditorUINumberElement;
  }
}
```

Again, it's registered via a manifest.

```javascript
const numberPropertyEditorManifest = {
    type: 'propertyEditorUi',
    alias: 'My.PropertyEditorUi.InputNumber',
    name: 'Number Input Property Editor UI',
    element: () => import('./property-editor-ui-number.element.js'),
    meta: {
        label: 'Number Input',
        icon: 'icon-autofill',
    },
};
export const manifests = [numberPropertyEditorManifest];
```

### Setting Value Editor

Field type settings also use a property editor UI for editing the values in the backoffice. The one to use is defined via the `View` property on the `Setting` attribute.

In our example we use a custom one, allowing the value for the background color to the field to be selected via an input control.

```javascript
import {
  html,
  customElement,
  type PropertyValueMap,
} from "@umbraco-cms/backoffice/external/lit";
import type { UmbPropertyEditorUiElement } from "@umbraco-cms/backoffice/property-editor";
import { UmbLitElement } from "@umbraco-cms/backoffice/lit-element";
import {
  UmbChangeEvent,
} from "@umbraco-cms/backoffice/event";
import { UmbFormControlMixin } from "@umbraco-cms/backoffice/validation";

const elementName = "my-property-editor-ui-color";

@customElement(elementName)
export class MyPropertyEditorUIColorElement
  extends UmbFormControlMixin<string>(UmbLitElement, undefined)
  implements UmbPropertyEditorUiElement
{
  protected firstUpdated(
    _changedProperties: PropertyValueMap<any> | Map<PropertyKey, unknown>
  ): void {
    super.firstUpdated(_changedProperties);
    this.addFormControlElement(this.shadowRoot!.querySelector("input")!);
  }

  private onChange(e: Event) {
    const newValue = (e.target as HTMLInputElement).value;
    if (newValue === this.value) return;
    this.value = newValue;
    this.dispatchEvent(new UmbChangeEvent());
  }

  override render() {
    return html`<input
      .value=${this.value ?? ""}
      type="color"
      @input=${this.onChange}
    />`;
  }
}

export default MyPropertyEditorUIColorElement;

declare global {
  interface HTMLElementTagNameMap {
    [elementName]: MyPropertyEditorUIColorElement;
  }
}
```

And register it via a manifest:

```javascript
const colorPropertyEditorManifest = {
    type: 'propertyEditorUi',
    alias: 'My.PropertyEditorUi.InputColor',
    name: 'Color Input Property Editor UI',
    element: () => import('./property-editor-ui-color.element.js'),
    meta: {
        label: 'Color Input',
        icon: 'icon-autofill',
    },
};

export const manifests = [colorPropertyEditorManifest];
```

### Setting Value Converter

You may want to consider registering a settings value converter. This is another client-side component that is registered in a manifest. It converts between the setting value required for the editor and the value persisted with the form definition. A converter defines three methods:

* `getSettingValueForEditor` - converts the persisted string value into one suitable for the editor
* `getSettingValueForPersistence` - converts the editor value into the string needed for persistence
* `getSettingPropertyConfig` - creates the configuration needed for the property editor

The following code shows the structure for these converter elements.

```javascript
import type { UmbPropertyValueData } from "@umbraco-cms/backoffice/property";
import type { FormsSettingValueConverterApi, Setting } from "@umbraco-forms/backoffice";

export class SliderSettingValueConverter
  implements FormsSettingValueConverterApi {
  async getSettingValueForEditor(setting: Setting, alias: string, value: string) {
    return Promise.resolve(value);
  }

  async getSettingValueForPersistence(setting: Setting, valueData: UmbPropertyValueData) {
    return Promise.resolve(valueData.value?.toString() || "");
  }

  async getSettingPropertyConfig(setting: Setting, alias: string, values: UmbPropertyValueData[]) {
    return Promise.resolve([]);
  }

  destroy(): void { }
}
```

It's registered as follows. The `propertyEditorUiAlias` matches with the property editor UI that requires the conversions.

```javascript
import { SliderSettingValueConverter } from "./slider-setting-value-converter.api";
import { ManifestFormsSettingValueConverterPreview } from "@umbraco-forms/backoffice";

const sliderValueConverterManifest: ManifestFormsSettingValueConverterPreview = {
  type: "formsSettingValueConverter",
  alias: "My.SettingValueConverter.Slider",
  name: "Slider Value Converter",
  propertyEditorUiAlias: "My.PropertyEditorUi.Slider",
  api: SliderSettingValueConverter,
};

export const manifests = [sliderValueConverterManifest];
```

### Language Files

Setting labels and descriptions can be translated via language files. If no client-side localization is provided, the values provided server-side in the `Setting` attribute's `Name` and `Description` properties will be used.

The following example shows how this is created for the settings on our example field type:

```javascript
import type { UmbLocalizationDictionary } from "@umbraco-cms/backoffice/localization-api";

export default {
  formProviderFieldTypes: {
    sliderMinLabel: `Minimum`,
    sliderMinDescription: `Minimum value`,
    sliderMaxLabel: `Maximum`,
    sliderMaxDescription: `Maximum value`,
    sliderStepLabel: `Step`,
    sliderStepDescription: `Step size`,
    sliderDefaultValueLabel: `Default Value`,
    sliderDefaultValueDescription: `Default value shown when the slider is displayed`,
    sliderHideStepValuesLabel: `Hide step values`,
    sliderHideStepValuesDescription: `Indicate whether the the field's label should be shown when rendering the form`,
    sliderBgColorLabel: `Background color`,
    sliderBgColorDescription: `Background color for the field`,
  },
}
```

Each different type of extension for Forms uses a different root value:

* Data sources - `formProviderDataSources`
* Export types - `formProviderExportTypes`
* Field types - `formProviderFieldTypes`
* Prevalue sources - `formProviderPrevalueSources`
* Recordset actions - `formRecordSetActions`
* Workflows - `formProviderWorkflows`

The language files are registered with:

```javascript
import type { ManifestLocalization } from '@umbraco-cms/backoffice/localization';

const localizationManifests: Array<ManifestLocalization> = [
  {
    type: "localization",
    alias: "My.Localization.En_US",
    weight: -100,
    name: "English (US)",
    meta: {
      culture: "en-us",
    },
    js: () => import("./en-us.js"),
  },
];
export const manifests = [...localizationManifests];
```

### Registering the Components

Finally, you will need an entry point to your client-side components that will register the manifests with Umbraco's extension registry. For example:

```javascript
import { manifests as propertyEditorManifests } from "./property-editor/manifests.js";
import { manifests as fieldPreviewManifests } from "./field-preview/manifests.js";
import { manifests as settingValueConverterManifests } from "./setting-value-converter/manifests.js";
import { manifests as localizationManifests } from "./lang/manifests.js";

const manifests = [
  ...propertyEditorManifests,
  ...fieldPreviewManifests,
  ...settingValueConverterManifests,
  ...localizationManifests
];

export const onInit = async (host, extensionRegistry) => {
  extensionRegistry.registerMany(manifests);
};
```
