---
description: A guide to defining a custom Value Type in Umbraco.
---

# Value Type

In an extensible system, different parts of the codebase need to agree on what kind of data they are working with. A value type is the contract that makes this possible — a named string constant that identifies the kind of data a value holds. Define one and you get compile-time autocomplete and type checking wherever value type keys are accepted across the system. [Value Summary](value-summary/README.md) extensions are one example of where value types are used to match a value to the right renderer.

## Built-in types

For common values, the core package already provides value types you can use directly. Import them from `@umbraco-cms/backoffice/value-type`.

| Constant | Key | TypeScript type |
|---|---|---|
| `UMB_STRING_VALUE_TYPE` | `Umb.ValueType.String` | `string` |
| `UMB_BOOLEAN_VALUE_TYPE` | `Umb.ValueType.Boolean` | `boolean` |
| `UMB_DATE_TIME_VALUE_TYPE` | `Umb.ValueType.DateTime` | `string` (ISO 8601) |

If your data matches one of these, you can use the constant directly without defining your own.

## Defining a value type

When none of the built-in types describe your data, define your own. Declare a constant with `as const` and extend the global `UmbValueTypeMap` interface in the same file. The TypeScript type you assign is the shape of the data this value type represents:

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
| Primitive or simple value | `My.ValueType.{Type}` | `My.ValueType.Status` |
| Domain — reference shapes | `My.ValueType.{Entity}.{Shape}` | `My.ValueType.Category.References` |
| Property editor | Property editor schema alias | `My.PropertyEditor.Alias` |

For property editors, always use the schema alias as the key. See [Property Editor Value Summary](../../property-editors/property-editor-value-summary.md) for details on why.

## Use cases

Value types are used across several extension points:

{% content-ref url="value-summary/README.md" %}
[Value Summary](value-summary/README.md)
{% endcontent-ref %}

{% content-ref url="../../property-editors/property-editor-value-summary.md" %}
[Property Editor Value Summary](../../property-editors/property-editor-value-summary.md)
{% endcontent-ref %}
