---
description: Provide a preset value for a Property.
---

# Property Value Preset

The Property Value Preset is an Extension Type that uses an API to provide a Preset Value. The preset value is used when a user scaffolds a new set of Content.

The following Manifest declares a preset for the `Umb.PropertyEditorUi.TextBox` Property Editor UI:

```typescript
export const manifest = {
    type: 'propertyValuePreset';
    alias: 'my.propertyValuePreset.TextBox',
    name: 'My Property Value Preset for TextBox',
    api: () => import('./my-property-value-preset.js'),
    forPropertyEditorUiAlias: 'Umb.PropertyEditorUi.TextBox'
}
```

Such Property Preset Value API could look like this:

{% code title="my-property-value-preset.js" %}
```typescript
export class MyPropertyValuePresetApi implements UmbPropertyValuePreset<string, UmbPropertyEditorConfig> {
	async processValue(value: undefined | string, config: UmbPropertyEditorConfig) {
		return value ? value : 'Hello there';
	}

	destroy(): void {}
}

export { UmbTrueFalsePropertyValuePreset as api };
```
{% endcode %}

This API will set the value to "Hello there" for all properties using the   `Umb.PropertyEditorUi.TextBox` Property Editor UI.

### Target a Property Editor Schema

You can also choose to target your Preset for a Property Editor Schema.\
\
Define `forPropertyEditorSchemaAlias` to show the Preset Value for all Properties based on that Schema.

If both `forPropertyEditorSchemaAlias` and `forPropertyEditorUiAlias` are defined, it will not limit the target. The matching is independently for each of them.

Notice that `forPropertyEditorSchemaAlias` only targets the Properties used on the Content Type based data. This could affect Documents, Media, Members, and Blocks, and not properties of a Data Type Configuration.

## Utilize the Data-Type configuration

The `processValue` method takes two arguments, the current value of the Preset and the Data-Type Configuration.

The following example is the built-in Property Value Preset for the Umbraco Toggle. The Toggle Data Type has a 'preset state' configuration that is used as the value of the Toggle.

{% code title="my-property-value-preset.js" %}
```typescript
export class UmbTrueFalsePropertyValuePreset
	implements UmbPropertyValuePreset<UmbTogglePropertyEditorUiValue, UmbPropertyEditorConfig>
{
	async processValue(value: undefined | UmbTogglePropertyEditorUiValue, config: UmbPropertyEditorConfig) {
		const initialState = (config.find((x) => x.alias === 'presetState')?.value as boolean | undefined) ?? false;
		return value !== undefined ? value : initialState;
	}

	destroy(): void {}
}

export { UmbTrueFalsePropertyValuePreset as api };
```
{% endcode %}

## Utilize anything

The `processValue` method is async. You can request the server or use the Context-API to retrieve the necessary information to construct your value.

{% hint style="info" %}
**Only relevant for Umbraco 16 (release date: June 12th, 2025)**

For retrieving contexts, upgrading to version 16, where the `getContext` method will have a timeout feature is recommended. In this case, such will be needed for the preset not to get stuck if the context is unavailable when the reset is constructed.
{% endhint %}

## Extend Presets

Because the `processValue` method takes a value as its first argument, you can append the value constructed by other Presets. In this way, multiple Presets can shape the preset value for a property.

In the case of multiple Property Value Presets targeting the same Property. The `weight` of the Manifest determines the order they are executed.

This opens up for you to overwrite or alter the Preset Value for Properties that use a Built-in Property Value Preset.
