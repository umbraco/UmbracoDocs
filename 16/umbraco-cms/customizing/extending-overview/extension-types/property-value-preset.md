---
description: Provide a preset value for a Property.
---

# Property Value Preset

The Property Value Preset is an Extension Type that uses an API to provide a Preset Value. The preset value is used when a user scaffolds a new set of Content.

{% hint style="info" %}
Before creating a Property Value Preset, it is recommended to read about the [Extension Registry in Umbraco](../../../customizing/extending-overview/extension-registry/register-extensions.md) to understand how extensions work.
{% endhint %}

## Manifest

The following Manifest declares a preset for the `TextBox` Property Editors:

```typescript
export const manifest = {
	type: 'propertyValuePreset',
	alias: 'my.propertyValuePreset.TextBox',
	name: 'My Property Value Preset for TextBox',
	weight: 10,
	api: () => import('./my-property-value-preset.js'),
	forPropertyEditorUiAlias: 'Umb.PropertyEditorUi.TextBox'
}
```

### Key Properties

- `weight` - Execution order (higher runs first).
- `forPropertyEditorUiAlias` - Targets specific Property Editor UI.

## Implementation

A Property Preset Value API could look like this:

{% code title="my-property-value-preset.js" %}
```typescript
import type { UmbPropertyValuePreset } from '@umbraco-cms/backoffice/property';
import type { UmbPropertyEditorConfig } from '@umbraco-cms/backoffice/property-editor';
export class MyPropertyValuePresetApi implements UmbPropertyValuePreset<string, UmbPropertyEditorConfig> {
	async processValue(value: undefined | string, config: UmbPropertyEditorConfig) {
		return value ? value : 'Hello there';
	}

	destroy(): void {}
}

export { MyPropertyValuePresetApi  as api };
```
{% endcode %}

This API will set the value to "Hello there" for all properties using the `Umb.PropertyEditorUi.TextBox` Property Editor UI and all properties based on Schema `Umbraco.TextArea`.

### Target a Property Editor Schema

You can also choose to target your Preset for a [Property Editor Schema](../../../tutorials/creating-a-property-editor/default-property-editor-schema-aliases.md).

Define `forPropertyEditorSchemaAlias` to show the Preset Value for all Properties based on that Schema.

If both `forPropertyEditorSchemaAlias` and `forPropertyEditorUiAlias` are defined, it will not limit the target. The matching is independent for each of them.

Notice that `forPropertyEditorSchemaAlias` only targets the Properties used on the Content Type based data. This could affect Documents, Media, Members, and Blocks, and not properties of a Data Type Configuration.

## Utilize the Data-Type configuration

The `processValue` method takes four arguments:

- `value` - The current value.
- `UmbPropertyEditorConfig` - The Data Type configuration.
- `UmbPropertyTypePresetModelTypeModel` - The type arguments, which contain details such as whether the property is mandatory, and how it varies by culture and segment.
- `UmbPropertyValuePresetApiCallArgs` - The call arguments, which contain details about the property and document.

The following example is the built-in Property Value Preset for the Umbraco Toggle. The Toggle Data Type has a 'preset state' configuration that is used as the value of the Toggle.

{% code title="my-property-value-preset.js" %}
```typescript
import type { UmbPropertyValuePreset, UmbPropertyValuePresetApiCallArgs, UmbPropertyTypePresetModelTypeModel } from '@umbraco-cms/backoffice/property';
import type { UmbPropertyEditorConfig } from '@umbraco-cms/backoffice/property-editor';
export class UmbTrueFalsePropertyValuePreset
	implements UmbPropertyValuePreset<UmbTogglePropertyEditorUiValue, UmbPropertyEditorConfig>
{
	async processValue(value: undefined | UmbTogglePropertyEditorUiValue, config: UmbPropertyEditorConfig, typeArgs: UmbPropertyTypePresetModelTypeModel, callArgs: UmbPropertyValuePresetApiCallArgs) {
		const initialState = (config.find((x) => x.alias === 'presetState')?.value as boolean | undefined) ?? false;
		return value !== undefined ? value : initialState;
	}

	destroy(): void {}
}

export { UmbTrueFalsePropertyValuePreset as api };
```
{% endcode %}

The `processValue` method is async. You can request the server or use the Context-API to retrieve the necessary information to construct your value.

It is recommended to use the `getContext` method for retrieving contexts. The method includes a timeout feature that prevents the preset from getting stuck if the context is unavailable during reset.

## Extend Presets

Because the `processValue` method takes a value as its first argument, you can append the value constructed by other Presets. In this way, multiple Presets can shape the preset value for a property.

In the case of multiple Property Value Presets targeting the same Property. The `weight` of the Manifest determines the order they are executed.

This opens up for you to overwrite or alter the Preset Value for Properties that use a Built-in Property Value Preset.
