---
description: A guide to creating a custom Value Summary in Umbraco. Use it to render a compact value presentation.
---

# Value Summary

The `valueSummary` extension controls how a value appear in compact space like a table column. The purpose is to surface the most meaningful parts of the value so users can scan and compare at a glance.

With a Value Summary, you control the presentation: a date formatted for the user's locale, a status code shown as a colored badge, or a stored reference resolved to a name. Without a registered summary, raw values appear as plain text.

{% hint style="info" %}
Value Summary depends on the [Value Type](value-type.md) concept. Define a Value Type for your data before registering a summary.
{% endhint %}

## Creating a Value Summary

The basic Value Summary consists of a manifest, an element, and a Value Type. The Value Type is what tells the renderer which summary to use for a given piece of data:

{% code title="my-feature/value-type/constants.ts" %}
```typescript
export const MY_STATUS_VALUE_TYPE = 'My.ValueType.Status' as const;

declare global {
  interface UmbValueTypeMap {
    [MY_STATUS_VALUE_TYPE]: string;
  }
}
```
{% endcode %}

Then register a `valueSummary` manifest. The `forValueType` property links the manifest to your value type — the renderer looks up summaries by Value Type:

{% code title="manifests.ts" %}
```typescript
{
  type: 'valueSummary',
  kind: 'default',
  alias: 'My.ValueSummary.Status',
  name: 'My Status Value Summary',
  forValueType: MY_STATUS_VALUE_TYPE,
  element: () => import('./status-value-summary.element.js'),
}
```
{% endcode %}

The element is responsible for rendering the value. Extend `UmbValueSummaryElementBase` and override `render()`. The current value is available as `this._value`:

{% code title="status-value-summary.element.ts" %}
```typescript
@customElement('my-status-value-summary')
export class MyStatusValueSummaryElement extends UmbValueSummaryElementBase<string> {
  override render() {
    return html`<uui-tag look="secondary">${this._value}</uui-tag>`;
  }
}
```
{% endcode %}

The value type can also be an object. If your data has structure, define the TypeScript type accordingly and access its properties directly in `render()`. A color value with a hex code and a label, for example, lets you render a swatch alongside the name — all from the stored value, no server call needed:

{% code title="my-feature/value-type/constants.ts" %}
```typescript
export interface MyColorValue {
  hex: string;
  label: string;
}

export const MY_COLOR_VALUE_TYPE = 'My.ValueType.Color' as const;

declare global {
  interface UmbValueTypeMap {
    [MY_COLOR_VALUE_TYPE]: MyColorValue;
  }
}
```
{% endcode %}

{% code title="color-value-summary.element.ts" %}
```typescript
@customElement('my-color-value-summary')
export class MyColorValueSummaryElement extends UmbValueSummaryElementBase<MyColorValue> {
  override render() {
    if (!this._value) return nothing;
    return html`
      <span style="background: ${this._value.hex};" id="color-swatch"></span>
      ${this._value.label}
    `;
  }

  static styles = css`
    :host {
      display: flex;
      align-items: center;
      gap: var(--uui-size-3);
    }
    
    #color-swatch {
      display: inline-block;
      width: 16px;
      height: 16px;
      border-radius: 2px;
    }
  `;
}
```
{% endcode %}

## Resolving server-side values

Sometimes the stored value is not meaningful on its own. You might store a key or unique identifier, but want to display a name. In those cases, you need to fetch additional data from the server before you can render the summary. A resolver handles this lookup.

Add a `valueResolver` property to the manifest pointing to the resolver module:

{% code title="manifests.ts" %}
```typescript
{
  type: 'valueSummary',
  kind: 'default',
  alias: 'My.ValueSummary.Category',
  name: 'Category Value Summary',
  forValueType: MY_CATEGORY_VALUE_TYPE,
  element: () => import('./category-value-summary.element.js'),
  valueResolver: () => import('./category-value-summary.resolver.js'),
}
```
{% endcode %}

The resolver module must export the resolver class under the name `valueResolver` — this is the specific name the extension system looks for when loading the module. Because a table can show many rows at once, the resolver receives all values for the entire column in a single batch call rather than one call per row. The resolver returns a `data` array that must be in the same order and the same length as the input — this is how each resolved result maps back to the correct row. If a value cannot be resolved, include a placeholder at that position to keep the arrays aligned.

{% code title="category-value-summary.resolver.ts" %}
```typescript
export class MyCategoryValueSummaryResolver extends UmbValueSummaryResolverBase<string, CategoryItem> {
  async resolveValues(values: ReadonlyArray<string>) {
    const items = await fetchCategoriesByKeys(values);
    return { data: items };
  }
}

export { MyCategoryValueSummaryResolver as valueResolver };
```
{% endcode %}

If the resolved data can change while the user has the collection open — for example, if a linked entity can be renamed elsewhere in the backoffice — return an `asObservable` function alongside `data`. The collection subscribes to it and updates the displayed values reactively without a full reload.

Most item repositories already return an `asObservable` alongside the data. Pass it through from your fetch call:

{% code title="category-value-summary.resolver.ts" %}
```typescript
async resolveValues(values: ReadonlyArray<string>) {
  const { data, asObservable } = await fetchCategoriesByKeys(values);
  return { data, asObservable };
}
```
{% endcode %}

The resolved result should still be compact. If you are resolving a reference, show a name or label — not a full entity representation.

Value Summary can be used with Property Editors to display property values in a Document Collection:

{% content-ref url="../../../../customizing/property-editors/property-editor-value-summary.md" %}
[Property Editor Value Summary](../../../../customizing/property-editors/property-editor-value-summary.md)
{% endcontent-ref %}

Value Summary can also be used in a Table Collection View:

{% content-ref url="../collections/collection-view/README.md" %}
[Table Collection View](../collections/collection-view/README.md)
{% endcontent-ref %}
