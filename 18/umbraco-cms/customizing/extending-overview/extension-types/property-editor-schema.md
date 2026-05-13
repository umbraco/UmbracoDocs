---
description: Reference documentation for the propertyEditorSchema extension type
---

# Property Editor Schema

The `propertyEditorSchema` extension type registers a Property Editor Schema in the Umbraco backoffice. A Property Editor Schema defines the server-side data contract for a property editor, including data storage type, validation rules, and configuration options.

{% hint style="info" %}
For detailed information about implementing Property Editor Schemas with C# classes (`DataEditor` and `DataValueEditor`), see the [Property Editor Schema Guide](../../property-editors/composition/property-editor-schema.md).
{% endhint %}

## Manifest Structure

The manifest defines how the schema appears in the backoffice and what configuration options are available when creating Data Types.

### Basic Example

A minimal schema manifest specifies which Property Editor UI should be used by default:

```typescript
import type { ManifestPropertyEditorSchema } from '@umbraco-cms/backoffice/property-editor';

export const manifest: ManifestPropertyEditorSchema = {
    type: 'propertyEditorSchema',
    name: 'Text Box',
    alias: 'Umbraco.TextBox',
    meta: {
        defaultPropertyEditorUiAlias: 'Umb.PropertyEditorUi.TextBox',
    },
};
```

### Example with Configuration

If your Property Editor Schema has configurable settings, define them in the manifest to enable administrators to configure the Data Type in the backoffice:

```typescript
export const manifest: ManifestPropertyEditorSchema = {
    type: 'propertyEditorSchema',
    name: 'Decimal',
    alias: 'Umbraco.Decimal',
    meta: {
        defaultPropertyEditorUiAlias: 'Umb.PropertyEditorUi.Decimal',
        settings: {
            properties: [
                {
                    alias: 'placeholder',
                    label: 'Placeholder text',
                    description: 'Enter the text to be displayed when the value is empty',
                    propertyEditorUiAlias: 'Umb.PropertyEditorUi.TextBox',
                },
                {
                    alias: 'step',
                    label: 'Step size',
                    description: 'The increment size for the numeric input',
                    propertyEditorUiAlias: 'Umb.PropertyEditorUi.TextBox',
                },
            ],
            defaultData: [
                {
                    alias: 'step',
                    value: '0.01',
                },
            ],
        },
    },
};
```

## Manifest Properties

The `propertyEditorSchema` manifest can contain the following properties:

### Required Properties

| Property | Type   | Description                                                                 |
| -------- | ------ | --------------------------------------------------------------------------- |
| type     | string | Must be `"propertyEditorSchema"`.                                            |
| alias    | string | Unique identifier for the schema. Must match the C# `DataEditor` alias.    |
| name     | string | Friendly name displayed in the backoffice.                                   |
| meta     | object | Metadata object containing schema configuration (see Meta Properties below). |

{% hint style="warning" %}
The `alias` in the manifest **must exactly match** the alias used in the C# `DataEditor` attribute. The alias is the only connection between the server-side schema implementation and the client-side manifest.
{% endhint %}

### Optional Properties

| Property | Type   | Description                                                    |
| -------- | ------ | -------------------------------------------------------------- |
| weight   | number | Ordering weight. Higher numbers appear first in lists.         |
| kind     | string | Optional kind identifier for grouping related schemas. |

## Meta Properties

The `meta` object contains the following properties:

### Required Meta Properties

| Property                     | Type   | Description                                                           |
| ---------------------------- | ------ | --------------------------------------------------------------------- |
| defaultPropertyEditorUiAlias | string | The alias of the default Property Editor UI to use with this schema.  |

### Optional Meta Properties

| Property | Type   | Description                                                              |
| -------- | ------ | ------------------------------------------------------------------------ |
| settings | object | Configuration settings for the property editor (see Settings below).      |

## Settings Structure

The `settings` object defines what configuration options appear when creating or editing a Data Type:

```typescript
settings: {
    properties: PropertyEditorSettingsProperty[];
    defaultData?: PropertyEditorSettingsDefaultData[];
}
```

### Settings Properties Array

Each object in the `properties` array defines a configuration field:

| Property                 | Type   | Required | Description                                                                    |
| ------------------------ | ------ | -------- | ------------------------------------------------------------------------------ |
| alias                    | string | Yes      | Unique identifier. Must match the C# `ConfigurationEditor` property name.     |
| label                    | string | Yes      | Display label for the configuration field.                                      |
| description              | string | No       | Help text shown below the label.                                                |
| propertyEditorUiAlias    | string | Yes      | The Property Editor UI to use for editing this configuration value.             |
| config                   | object | No       | Optional configuration to pass to the Property Editor UI.                       |
| weight                   | number | No       | Optional ordering weight for the configuration field.                           |

{% hint style="warning" %}
Configuration property aliases in `settings.properties` **must match** the property names defined in your C# `ConfigurationEditor` class. If they don't match, configuration values won't be properly passed to the backend for validation and storage.
{% endhint %}

### Settings Default Data Array

Each object in the `defaultData` array provides default values:

| Property | Type    | Required | Description                                   |
| -------- | ------- | -------- | --------------------------------------------- |
| alias    | string  | Yes      | The alias of the configuration property.       |
| value    | unknown | Yes      | The default value for this configuration.      |

## Complete Example

```typescript
import type { ManifestPropertyEditorSchema } from '@umbraco-cms/backoffice/property-editor';

export const manifest: ManifestPropertyEditorSchema = {
    type: 'propertyEditorSchema',
    name: 'Suggestions Editor',
    alias: 'My.PropertyEditor.Suggestions',
    weight: 100,
    meta: {
        defaultPropertyEditorUiAlias: 'My.PropertyEditorUi.Suggestions',
        settings: {
            properties: [
                {
                    alias: 'maxChars',
                    label: 'Maximum characters allowed',
                    description: 'The maximum number of allowed characters in a suggestion',
                    propertyEditorUiAlias: 'Umb.PropertyEditorUi.Integer',
                    weight: 10,
                },
                {
                    alias: 'placeholder',
                    label: 'Placeholder text',
                    description: 'Text displayed when the field is empty',
                    propertyEditorUiAlias: 'Umb.PropertyEditorUi.TextBox',
                    weight: 20,
                },
                {
                    alias: 'disabled',
                    label: 'Disabled',
                    description: 'Disables the suggestion button',
                    propertyEditorUiAlias: 'Umb.PropertyEditorUi.Toggle',
                    weight: 30,
                },
            ],
            defaultData: [
                {
                    alias: 'maxChars',
                    value: 50,
                },
                {
                    alias: 'placeholder',
                    value: 'Write a suggestion',
                },
                {
                    alias: 'disabled',
                    value: true,
                },
            ],
        },
    },
};
```

## Important Notes

Umbraco ships with [default property editor schemas](../../../tutorials/creating-a-property-editor/default-property-editor-schema-aliases.md) that you can use without creating custom C# classes.

## Related Documentation

* [Property Editor Schema Guide](../../property-editors/composition/property-editor-schema.md) - Learn about implementing the C# classes (`DataEditor` and `DataValueEditor`).
* [Property Editor UI Extension Type](property-editor-ui.md) - Reference for the Property Editor UI extension type.
* [Creating a Property Editor Tutorial](../../../tutorials/creating-a-property-editor/) - Step-by-step guide to building a custom property editor.
* [Adding Server-Side Validation](../../../tutorials/creating-a-property-editor/adding-server-side-validation.md) - Tutorial on implementing validation in your schema.
