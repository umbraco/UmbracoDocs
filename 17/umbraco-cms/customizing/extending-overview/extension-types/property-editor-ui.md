---
description: Reference documentation for the propertyEditorUi extension type
---

# Property Editor UI

The `propertyEditorUi` extension type registers a Property Editor UI in the Umbraco backoffice. A Property Editor UI is the client-side component that renders the editing interface for content editors to input and manage their data.

{% hint style="info" %}
For detailed information about implementing Property Editor UI web components using Lit, see the [Property Editor UI Guide](../../property-editors/composition/property-editor-ui.md).
{% endhint %}

## Manifest Structure

The manifest defines how the UI appears in the backoffice, which schema it works with, and what configuration options are available.

### Basic Example

A minimal UI manifest specifies the element location and which schema to use:

```typescript
import type { ManifestPropertyEditorUi } from '@umbraco-cms/backoffice/property-editor';

export const manifest: ManifestPropertyEditorUi = {
    type: 'propertyEditorUi',
    alias: 'My.PropertyEditorUi.TextBox',
    name: 'My Text Box Property Editor UI',
    element: () => import('./my-text-box.element.js'),
    meta: {
        label: 'My Text Box',
        propertyEditorSchemaAlias: 'Umbraco.TextBox',
        icon: 'icon-autofill',
        group: 'common',
    },
};
```

### Example with Settings

If your Property Editor UI has configurable settings, define them in the manifest:

```typescript
export const manifest: ManifestPropertyEditorUi = {
    type: 'propertyEditorUi',
    alias: 'My.PropertyEditorUi.Suggestions',
    name: 'Suggestions Editor UI',
    element: () => import('./suggestions.element.js'),
    meta: {
        label: 'Suggestions',
        propertyEditorSchemaAlias: 'My.PropertyEditor.Suggestions',
        icon: 'icon-chat',
        group: 'pickers',
        settings: {
            properties: [
                {
                    alias: 'placeholder',
                    label: 'Placeholder text',
                    description: 'Text shown when the field is empty',
                    propertyEditorUiAlias: 'Umb.PropertyEditorUi.TextBox',
                },
                {
                    alias: 'showButton',
                    label: 'Show suggestion button',
                    description: 'Display a button to generate suggestions',
                    propertyEditorUiAlias: 'Umb.PropertyEditorUi.Toggle',
                },
            ],
            defaultData: [
                {
                    alias: 'showButton',
                    value: true,
                },
            ],
        },
    },
};
```

## Manifest Properties

The `propertyEditorUi` manifest can contain the following properties:

### Required Properties

| Property | Type                      | Description                                                      |
| -------- | ------------------------- | ---------------------------------------------------------------- |
| type     | string                    | Must be `"propertyEditorUi"`                                     |
| alias    | string                    | Unique identifier for the UI                                     |
| name     | string                    | Friendly name displayed in the backoffice                        |
| element  | function \| string        | Path to or import function for the web component element         |
| meta     | object                    | Metadata object containing UI configuration (see Meta Properties)|

### Optional Properties

| Property | Type   | Description                                                    |
| -------- | ------ | -------------------------------------------------------------- |
| weight   | number | Ordering weight. Higher numbers appear first in lists.         |

## Meta Properties

The `meta` object contains the following properties:

### Required Meta Properties

| Property                     | Type   | Description                                                           |
| ---------------------------- | ------ | --------------------------------------------------------------------- |
| label                        | string | Display label shown in the UI picker                                  |
| propertyEditorSchemaAlias    | string | The alias of the Property Editor Schema this UI works with            |
| icon                         | string | Icon identifier (e.g., `"icon-autofill"`)                            |
| group                        | string | Group name for categorizing property editors                          |

### Optional Meta Properties

| Property         | Type    | Description                                                              |
| ---------------- | ------- | ------------------------------------------------------------------------ |
| settings         | object  | Configuration settings for the UI (see Settings below)                   |
| supportsReadOnly | boolean | Indicates whether the UI supports read-only mode                         |

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
| alias                    | string | Yes      | Unique identifier for this configuration property                             |
| label                    | string | Yes      | Display label for the configuration field                                      |
| description              | string | No       | Help text shown below the label                                                |
| propertyEditorUiAlias    | string | Yes      | The Property Editor UI to use for editing this configuration value             |
| config                   | object | No       | Optional configuration to pass to the Property Editor UI                       |
| weight                   | number | No       | Ordering weight for the configuration field. Higher numbers appear first.      |
| validation               | object | No       | Validation rules. Object with `mandatory` (boolean) and optional `mandatoryMessage` (string) properties |
| propertyEditorDataSourceAlias | string | No  | Alias of a data source to use with this configuration property                 |

### Settings Default Data Array

Each object in the `defaultData` array provides default values:

| Property | Type    | Required | Description                                   |
| -------- | ------- | -------- | --------------------------------------------- |
| alias    | string  | Yes      | The alias of the configuration property       |
| value    | unknown | Yes      | The default value for this configuration      |

## Element Loading

The `element` property accepts three formats:

### Import Function (Recommended)

```typescript
element: () => import('./my-editor.element.js')
```

This uses dynamic imports for better code splitting and lazy loading.

### String Path

```typescript
element: '/App_Plugins/MyEditor/my-editor.element.js'
```

This loads the element from a static file path.

### Class Constructor

```typescript
import { MyEditorElement } from './my-editor.element.js';

element: MyEditorElement
```

This directly provides the custom element class constructor.

## Complete Example

```typescript
import type { ManifestPropertyEditorUi } from '@umbraco-cms/backoffice/property-editor';

export const manifest: ManifestPropertyEditorUi = {
    type: 'propertyEditorUi',
    alias: 'My.PropertyEditorUi.AdvancedTextBox',
    name: 'Advanced Text Box UI',
    element: () => import('./advanced-text-box.element.js'),
    weight: 200,
    meta: {
        label: 'Advanced Text Box',
        propertyEditorSchemaAlias: 'Umbraco.TextBox',
        icon: 'icon-edit',
        group: 'common',
        settings: {
            properties: [
                {
                    alias: 'placeholder',
                    label: 'Placeholder text',
                    description: 'Text displayed when the field is empty',
                    propertyEditorUiAlias: 'Umb.PropertyEditorUi.TextBox',
                },
                {
                    alias: 'showCharacterCount',
                    label: 'Show character count',
                    description: 'Display the number of characters entered',
                    propertyEditorUiAlias: 'Umb.PropertyEditorUi.Toggle',
                },
            ],
            defaultData: [
                {
                    alias: 'placeholder',
                    value: 'Enter text here...',
                },
                {
                    alias: 'showCharacterCount',
                    value: true,
                },
            ],
        },
    },
};
```

## Icon Names

The `icon` property uses Umbraco's built-in icon set. Common icon names include:

- `icon-autofill` - Text and input related editors
- `icon-list` - List and collection editors  
- `icon-calendar` - Date and time editors
- `icon-picture` - Media and image editors
- `icon-user` - User and member related editors
- `icon-link` - Link and URL editors
- `icon-readonly` - Read-only or display editors

While any string value is technically accepted, using unrecognized icon names may result in a missing or default icon being displayed.

## Group Names

The `group` property categorizes property editors in the backoffice UI. Common group names include:

- `common` - General purpose editors (default if not specified)
- `pickers` - Content, media, and member pickers
- `lists` - List-based editors like checkboxes and dropdowns
- `richContent` - Rich text and block-based editors
- `media` - Media-specific editors
- `date` - Date and time editors
- `people` - User and member editors
- `advanced` - Advanced or specialized editors

While technically a free-form string, using these documented values ensures proper grouping in the UI.

## Read-Only Support

Set `supportsReadOnly: true` in the `meta` object if your Property Editor UI implements read-only mode:

```typescript
meta: {
    label: 'My Editor',
    propertyEditorSchemaAlias: 'My.Schema',
    icon: 'icon-edit',
    group: 'common',
    supportsReadOnly: true,
}
```

When enabled, your element will receive a `readonly` property that indicates whether it should display in read-only mode. Your implementation must handle this property appropriately.

## Important Notes

{% hint style="warning" %}
The `propertyEditorSchemaAlias` in the manifest **must match** an existing Property Editor Schema alias. This connects the UI to the backend data handling and validation.
{% endhint %}

{% hint style="info" %}
The web component element specified in the `element` property must implement the `UmbPropertyEditorUiElement` interface. See the [Property Editor UI Guide](../../property-editors/composition/property-editor-ui.md) for implementation details.
{% endhint %}

## Related Documentation

* [Property Editor UI Guide](../../property-editors/composition/property-editor-ui.md) - Learn about implementing the web component
* [Property Editor Schema Extension Type](property-editor-schema.md) - Reference for the Property Editor Schema extension type
* [Creating a Property Editor Tutorial](../../../tutorials/creating-a-property-editor/) - Step-by-step guide to building a custom property editor
