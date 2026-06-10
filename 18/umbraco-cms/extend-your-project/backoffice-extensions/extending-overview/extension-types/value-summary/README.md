---
description: A guide to creating a custom Value Summary in Umbraco. Use it to render a compact value presentation.
---

# Value Summary

The `valueSummary` extension controls how a value appears in a compact space like a table column. The purpose is to surface the most meaningful parts of the value so users can scan and compare at a glance.

With a Value Summary, you control how values are presented. You can show a date in the user's locale, a status code as a colored badge, or a stored reference resolved to a name. Without a registered summary, raw values appear as plain text.

{% hint style="info" %}
Value Summary depends on the [Value Type](../value-type.md) concept. Define a Value Type for your data before registering a summary.
{% endhint %}

## Creating a Value Summary

The basic Value Summary consists of a manifest, an element, and a Value Type. The Value Type is what tells the renderer which summary to use for a given piece of data:

{% code title="my-feature/value-type/constants.ts" %}
```typescript
export type MyStatusValue = 'active' | 'inactive' | 'pending';

export const MY_STATUS_VALUE_TYPE = 'My.ValueType.Status' as const;

declare global {
  interface UmbValueTypeMap {
    [MY_STATUS_VALUE_TYPE]: MyStatusValue;
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
export class MyStatusValueSummaryElement extends UmbValueSummaryElementBase<MyStatusValue> {
  override render() {
    if (!this._value) return nothing;
    return html`<uui-tag look="secondary">${this.localize.term(`myStatus_${this._value}`)}</uui-tag>`;
  }
}
```
{% endcode %}

A value type can represent any data structure, including complex objects. If your data has a shape, define it accordingly and access its properties directly in `render()`. A color value with a hex code and a label, for example, lets you render a swatch alongside the name. In this example, the representation comes from information already in the stored value — no server call is needed:

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

The resolver module must export the resolver class under the name `valueResolver`. The extension system looks for this specific export name when loading the module. Because a table can show many rows at once, the resolver receives all values for the entire column in a single batch call. The resolver returns a `data` array in the same order and length as the input. This is how each resolved result maps back to the correct row. If a value cannot be resolved, include a placeholder at that position to keep the arrays aligned.

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

If a resolved value can change while the Value Summary is open, return an `asObservable` function alongside `data`. For example, a linked entity could be renamed elsewhere in the backoffice. The collection subscribes to the observable and updates displayed values without a full reload.

Many [repositories](../../../foundation/repositories/README.md) already return an `asObservable` alongside the data. Pass it through from your fetch call:

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

{% content-ref url="../../../property-editors/property-editor-value-summary.md" %}{% endcontent-ref %}

Value Summary can also be used in a Table Collection View:

{% content-ref url="../collections/collection-view/README.md" %}{% endcontent-ref %}
