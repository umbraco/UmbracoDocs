---
description: A guide to adding a Value Summary to a custom Property Editor in Umbraco.
---

# Property Editor Value Summary

When Documents are displayed in a collection, the backoffice shows each property's value in a compact table column. By default, raw values appear as plain text. Registering a [Value Summary](../extending-overview/extension-types/value-summary/README.md) for your Property Editor lets you control how that value is presented — a formatted date, a color swatch, a tag — without any configuration in the collection itself.

The Document Collection receives the Editor Alias from the server for each property and uses it to look up the correct summary. This means the Value Type key for a Property Editor must match the schema alias exactly.

## Defining the Value Type

Define the Value Type constant alongside your Property Editor. Use the Schema Alias as the key:

{% code title="my-property-editor/value-type/constants.ts" %}
```typescript
export interface MyPropertyEditorValue {
  value: string;
  label: string;
}

export const MY_PROPERTY_EDITOR_VALUE_TYPE = 'My.PropertyEditor.Alias' as const;

declare global {
  interface UmbValueTypeMap {
    [MY_PROPERTY_EDITOR_VALUE_TYPE]: MyPropertyEditorValue;
  }
}
```
{% endcode %}

## Registering the Value Summary

Register a `valueSummary` manifest using the Value Type constant as `forValueType`:

{% code title="my-property-editor/value-summary/manifests.ts" %}
```typescript
{
  type: 'valueSummary',
  kind: 'default',
  alias: 'My.ValueSummary.PropertyEditor.Alias',
  name: 'My Property Editor Value Summary',
  forValueType: MY_PROPERTY_EDITOR_VALUE_TYPE,
  element: () => import('./my-property-editor-value-summary.element.js'),
}
```
{% endcode %}

## Implementing the Element

The element receives the property value and renders a compact representation of it. Extend `UmbValueSummaryElementBase` and override `render()`:

{% code title="my-property-editor/value-summary/my-property-editor-value-summary.element.ts" %}
```typescript
@customElement('my-property-editor-value-summary')
export class MyPropertyEditorValueSummaryElement extends UmbValueSummaryElementBase<MyPropertyEditorValue> {
  override render() {
    if (!this._value) return nothing;
    return html`<uui-tag look="secondary">${this._value.label}</uui-tag>`;
  }
}
```
{% endcode %}

See [Value Summary](../extending-overview/extension-types/value-summary/README.md) for the full range of options, including resolving server-side values.
