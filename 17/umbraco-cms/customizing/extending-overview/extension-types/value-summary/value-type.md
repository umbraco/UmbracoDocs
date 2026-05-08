---
description: Reference documentation for the Value Type concept. Use it to define a named, type-safe key for values used in valueSummary manifests.
---

# Value Type

The collection needs a way to know which summary renderer to use for a given piece of data. A value type provides that link — it is a named string constant that identifies the kind of data a value holds. When you define one, you get compile-time autocomplete and type checking anywhere that accepts a value type key, including `valueSummary` manifests and collection column definitions.

## Built-in types

For common values, the core package already provides Value Types you can use directly. Import them from `@umbraco-cms/backoffice/value-type`.

| Constant | Key | TypeScript type |
|---|---|---|
| `UMB_STRING_VALUE_TYPE` | `Umb.ValueType.String` | `string` |
| `UMB_BOOLEAN_VALUE_TYPE` | `Umb.ValueType.Boolean` | `boolean` |
| `UMB_DATE_TIME_VALUE_TYPE` | `Umb.ValueType.DateTime` | `string` (ISO 8601) |

If your data matches one of these, you can use the constant directly in your manifest without defining your own.

## Defining a value type

When none of the built-in types describe your data, define your own. Declare a constant with `as const` and extend the global `UmbValueTypeMap` interface in the same file. The TypeScript type you assign is the type of the raw value your summary will receive:

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

Export the constant from your package entry point so other packages can import and use it.

### Naming

Follow the pattern that matches your use case:

| Category | Pattern | Example |
|---|---|---|
| System / primitive | `Umb.ValueType.{Type}` | `Umb.ValueType.DateTime` |
| Domain — reference shapes | `Umb.ValueType.{Entity}.{Shape}` | `Umb.ValueType.Tag.References` |
| Property editor | Property editor schema alias | `My.PropertyEditor.RichText` |

For property editors, always use the schema alias as the key. Collection views receive the editor alias from the server and use it directly to look up the correct summary. The key must match exactly.
