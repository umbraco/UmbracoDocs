---
description: >-
  Overview of the backoffice extension points that Umbraco Forms exposes,
  including property editors, field previews, and setting value converters.
---

# Backoffice Extension Points

The Umbraco Forms backoffice is built on the [Umbraco CMS extension system](https://docs.umbraco.com/umbraco-cms/extend-your-project/backoffice-extensions/extending-overview/extension-types). You extend it by registering manifests, each with a `type` that tells Umbraco what kind of extension it is.

This article lists the extension points that Forms adds on top of the CMS. Use it as a map: each point links to the detailed guidance for that scenario.

Before you start, install and configure the `@umbraco-forms/backoffice` package as described in the [Extending](README.md#extending-the-backoffice) article.

## Overview

| Extension point        | Manifest type                                | Use it to                                                       |
| ---------------------- | -------------------------------------------- | -------------------------------------------------------------- |
| Property editor UI     | `propertyEditorUi`                           | Render the settings UI for a field type or workflow type.      |
| Field preview          | `formsFieldPreview`                          | Render a preview of a field type in the form designer.         |
| Setting value converter| `formsSettingValueConverter`                 | Convert a setting value between the editor and storage.        |

Server-side providers, such as field types and workflow types, are registered in C#. These are covered in [Adding A Type To The Provider Model](adding-a-type.md).

## Registering extensions

Forms uses the same registration mechanism as the CMS. You declare your manifests and register them through your package's entry point.

{% code title="manifests.ts" %}
```typescript
import { manifests as fieldPreviewManifests } from "./field-preview/manifests.js";
import { manifests as settingValueConverterManifests } from "./setting-value-converter/manifests.js";

const manifests = [...fieldPreviewManifests, ...settingValueConverterManifests];

export const onInit = (host, extensionRegistry) => {
  extensionRegistry.registerMany(manifests);
};
```
{% endcode %}

For the full setup, including the `umbraco-package.json` manifest that points to this entry, see the [Register an Extension](https://docs.umbraco.com/umbraco-cms/extend-your-project/backoffice-extensions/extending-overview/extension-registry/register-extensions) article.

## Property editor UIs for settings

Field types and workflow types expose their settings through a standard CMS `propertyEditorUi`. You register a property editor UI and reference its alias from the type's `EditView` or setting definition.

A common requirement is to read the open form from a settings editor. For example, to list the form's fields in a mapping grid. Consume the Form Workspace Context to do this.

{% content-ref url="working-with-the-form-workspace-context.md" %}
[working-with-the-form-workspace-context.md](working-with-the-form-workspace-context.md)
{% endcontent-ref %}

For full examples of field and setting editors, see [Adding A Field Type To Umbraco Forms](adding-a-fieldtype.md) and [Adding A Workflow Type To Umbraco Forms](adding-a-workflowtype.md).

## Field previews

A field preview renders a representation of a field type in the form designer. The preview receives the field's `settings` and `prevalues`. Extend `FormsFieldPreviewBaseElement` and read settings with `getSettingValue(alias)`.

{% code title="slider-field-preview.element.ts" %}
```typescript
import { customElement, html } from "@umbraco-cms/backoffice/external/lit";
import { FormsFieldPreviewBaseElement } from "@umbraco-forms/backoffice";

const elementName = "my-slider-field-preview";

@customElement(elementName)
export class MySliderFieldPreviewElement extends FormsFieldPreviewBaseElement {
  render() {
    return html`
      <uui-slider
        .min=${parseInt(this.getSettingValue("Min"))}
        .max=${parseInt(this.getSettingValue("Max"))}
        .value=${this.getSettingValue("DefaultValue")}
      ></uui-slider>
    `;
  }
}

export default MySliderFieldPreviewElement;

declare global {
  interface HTMLElementTagNameMap {
    [elementName]: MySliderFieldPreviewElement;
  }
}
```
{% endcode %}

Register the preview with a `formsFieldPreview` manifest:

{% code title="manifests.ts" %}
```typescript
import type { ManifestFormsFieldPreview } from "@umbraco-forms/backoffice";

const sliderPreview: ManifestFormsFieldPreview = {
  type: "formsFieldPreview",
  alias: "My.FieldPreview.Slider",
  name: "Slider Field Preview",
  element: () => import("./slider-field-preview.element.js"),
};

export const manifests = [sliderPreview];
```
{% endcode %}

{% hint style="info" %}
The manifest `alias` must match the `PreviewView` property on your C# field type. This is how Forms knows which preview to render. See [Adding A Field Type To Umbraco Forms](adding-a-fieldtype.md) for the full example.
{% endhint %}

## Setting value converters

A setting value converter converts a setting value between the format used by the editor and the format stored with the form. Implement `FormsSettingValueConverterApi` and tie it to a property editor UI through `propertyEditorUiAlias`.

{% code title="slider-setting-value-converter.api.ts" %}
```typescript
import type { FormsSettingValueConverterApi, Setting } from "@umbraco-forms/backoffice";
import type { UmbPropertyValueData } from "@umbraco-cms/backoffice/property";

export class SliderSettingValueConverter implements FormsSettingValueConverterApi {
  async getSettingValueForEditor(setting: Setting, alias: string, value: string) {
    return value;
  }

  async getSettingValueForPersistence(setting: Setting, valueData: UmbPropertyValueData) {
    return valueData.value?.toString() ?? "";
  }

  async getSettingPropertyConfig(setting: Setting, alias: string, values: Array<UmbPropertyValueData>) {
    return [];
  }

  destroy() {}
}

export default SliderSettingValueConverter;
```
{% endcode %}

{% code title="manifests.ts" %}
```typescript
import type { ManifestFormsSettingValueConverterPreview } from "@umbraco-forms/backoffice";

const sliderConverter: ManifestFormsSettingValueConverterPreview = {
  type: "formsSettingValueConverter",
  alias: "My.SettingValueConverter.Slider",
  name: "Slider Setting Value Converter",
  propertyEditorUiAlias: "My.PropertyEditorUi.Slider",
  api: () => import("./slider-setting-value-converter.api.js"),
};

export const manifests = [sliderConverter];
```
{% endcode %}

For more on settings and converters, see [Adding A Field Type To Umbraco Forms](adding-a-fieldtype.md).
