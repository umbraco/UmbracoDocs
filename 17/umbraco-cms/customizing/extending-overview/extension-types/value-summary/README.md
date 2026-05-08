---
description: Reference documentation for the valueSummary extension type. Use it to render a compact value representation in collection views.
---

# Value Summary

The `valueSummary` extension controls how a value appear in compact space like a table column. The purpose is to surface the most meaningful parts of the value so users can scan and compare at a glance.

With a Value Summary, you control the presentation: a date formatted for the user's locale, a status code shown as a colored badge, or a stored reference resolved to a name. Without a registered summary, raw values appear as plain text.

{% hint style="info" %}
Value Summary depends on the [Value Type](value-type.md) concept. Define a Value Type for your data before registering a summary.
{% endhint %}

## Creating a Value Summary

The simplest Value Summary consists of a manifest, an element, and a Value Type. The Value Type is what tells the renderer which summary to use for a given piece of data:

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

Extend `UmbValueSummaryElementBase` and override `render()`. The current value is available as `this._value`:

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

## Resolving server-side values

Sometimes the stored value is not meaningful on its own. You might store a key or unique identifier, but want to display a name. In those cases, you need to fetch additional data from the server before you can render the summary. A resolver handles this lookup.

Because a collection can show many rows at once, the resolver receives all values for the entire column in a single batch call rather than one call per row. The resolver returns a `data` array that must be in the same order and the same length as the input — this is how each resolved result maps back to the correct row. If a value cannot be resolved, include a placeholder at that position to keep the arrays aligned.

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

The module must export the resolver class under the name `valueResolver` — this is the specific name the extension system looks for when loading the module.

If the resolved data can change while the user has the collection open — for example, if a linked entity can be renamed elsewhere in the backoffice — return an `asObservable` function alongside `data`. The collection will then stay in sync reactively without a full reload.

Add `valueResolver` to the manifest to wire it up:

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

The resolved result should still be compact. If you are resolving a reference, show a name or label — not a full entity representation.

## Using Value Summary in a collection

### Property editor collections

If you are building a property editor and want your values to display meaningfully in the Content section's list view, you do not need to configure anything in the collection manifest. The collection receives an editor alias from the server for each property and uses it to look up the correct summary. Registering a `valueSummary` manifest with `forValueType` set to your property editor's schema alias is all that is needed.

### Generic table collections

If you are building a custom collection with columns that hold data you want to display as more than plain text, set `valueType` in the column definition of your collection view manifest:

```typescript
{
  field: 'status',
  label: 'Status',
  valueType: MY_STATUS_VALUE_TYPE,
}
```

The table renders your summary for every cell in that column. If `valueType` is omitted, the raw value is rendered as text.
