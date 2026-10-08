---
hidden: true
---

# Umbraco Document PATCH Endpoint Specification

Machine-readable reference for tooling, LLMs, and AI agents constructing PATCH payloads.

## Endpoint

```
PATCH /umbraco/management/api/v1/document/{id:guid}/patch
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | GUID (path) | The document key |

**Headers:**

| Header | Value |
|--------|-------|
| `Content-Type` | `application/json-patch+json` |
| `Authorization` | Bearer token or cookie-based auth. |

**Status Codes:**

| Code | Condition |
|------|-----------|
| 200 | Success |
| 400 | Invalid path syntax, missing value, path resolution failure, invalid culture. |
| 404 | Document not found, content type not found. |
| 422 | Property type not found on content type. |

## Request Schema

```json
{
  "operations": [
    {
      "op": "replace" | "add" | "remove",
      "path": "<path-expression>",
      "value": <any>           // REQUIRED for replace and add. OMIT for remove.
    }
  ]
}
```

- `operations` is REQUIRED, minimum 1 element.
- Operations are applied sequentially. Each operation sees the result of all prior operations.
- If any operation fails, the entire request fails (no partial application).

## Path Syntax Grammar

```bnf
path          ::= "/" segment ( "/" segment | filter )*
segment       ::= property | index | append
property      ::= token                     // object property access
index         ::= DIGIT+                    // zero-based array index
append        ::= "-"                       // append to array (add only)
filter        ::= "[" condition ("," condition)* "]"
condition     ::= key "=" value
key           ::= NON_EMPTY_STRING          // property name to match (case-sensitive)
value         ::= "null" | STRING           // "null" (case-insensitive) matches null/missing; string is exact match (case-sensitive)
token         ::= RFC6901_TOKEN             // with ~1 decoded to "/" and ~0 decoded to "~"
```

**Constraints:**
- Path **must** start with `/`.
- Path **must** contain at least one segment.
- `/-` (AppendSegment) **must** be the last segment.
- `/-` is only valid with `add` operations.
- Filter brackets **must** be closed.
- Filter conditions **must** contain `=`.
- Filter keys **must not** be empty.

## Path Segment Types

| Type | Syntax | Resolves To | Example |
|------|--------|-------------|---------|
| PropertySegment | `/name` | Named property on a JsonObject. | `/value`, `/markup`, `/layout` |
| FilterSegment | `[k=v,k2=v2]` | First element in a JsonArray matching **all** conditions. | `[alias=title,culture=en-US,segment=null]` |
| IndexSegment | `/0`, `/1` | Element at numeric index in a JsonArray. | `/contentData/0` |
| AppendSegment | `/-` | Past-the-end position in a JsonArray. | `/contentData/-` |

## Filter Matching Rules

Given an array element (JsonObject) and a set of filter conditions:

1. For each condition `(key, value)`:
   - If `value` is `null`: match succeeds if the element does **not** have the property, OR the property value is JSON `null`.
   - If `value` is a string: match succeeds if the element **has** the property and its string representation equals `value` (StringComparison.Ordinal — **case-sensitive**).
2. All conditions must match (and logic).
3. The **first** matching element is returned.
4. If no element matches, the operation fails with 400.

{% hint style="info" %}
The `null` keyword in filter values is matched case-insensitively (`null`, `NULL`, `Null` all work). All other string values are case-sensitive.
{% endhint %}

## Operation Semantics

### Replace

| Target | Behavior |
|--------|----------|
| Object property | Sets property to new value. |
| Array element (by index or filter) | Replaces element value. |
| Cannot target `/-` | Error |

### Add

| Target | Behavior |
|--------|----------|
| Object property | Sets property (creates if missing). |
| Array with `/-` | Appends to end of array. |
| Array with index `/N` | Inserts at index N, shifts existing elements right. |

### Remove

| Target | Behavior |
|--------|----------|
| Object property | Removes the property. |
| Array element (by index or filter) | Removes element, shifts subsequent elements left. |
| Cannot target `/-` | Error |

## JSON Structure Specification

The PATCH operates on a JSON representation of `UpdateDocumentRequestModel`. This section defines the exact shape at each level.

### Root Object

```
{
  "values": DocumentValueModel[],
  "variants": DocumentVariantRequestModel[],
  "template": { "id": GUID } | null
}
```

### DocumentValueModel (Root-Level Values Entry)

```
{
  "alias": string,           // Property type alias (e.g., "title", "blockList")
  "culture": string | null,  // ISO culture code or null for invariant
  "segment": string | null,  // Segment name or null
  "value": any               // Value type depends on property editor
}
```

{% hint style="info" %}
Root-level value entries do not have an `editorAlias` field.
{% endhint %}

### DocumentVariantRequestModel

```
{
  "culture": string | null,
  "segment": string | null,
  "name": string             // Document name for this variant
}
```

### Block Value (BlockList, BlockGrid, or Bare Block Structure in Rich Text Editor)

```
{
  "layout": {
    "<EditorAlias>": LayoutItem[]   // See Layout Items section
  },
  "contentData": BlockItemData[],   // See BlockItemData section
  "settingsData": BlockItemData[],  // Same shape as contentData
  "expose": ExposeEntry[]           // See Expose Entry section
}
```

**Editor aliases (used as keys in `layout`):**

| Editor | Alias |
|--------|-------|
| Block List | `Umbraco.BlockList` |
| Block Grid | `Umbraco.BlockGrid` |
| Rich Text | `Umbraco.RichText` |

### Layout Items

**Block List:**
```
{
  "contentKey": GUID,
  "settingsKey": GUID | null
}
```

**Block Grid:**
```
{
  "columnSpan": integer,
  "rowSpan": integer,
  "areas": BlockGridAreaItem[],
  "contentKey": GUID,
  "settingsKey": GUID | null
}
```

**BlockGridAreaItem:**
```
{
  "key": GUID,
  "items": BlockGridLayoutItem[]   // Recursive nesting
}
```

**Rich Text:**
```
{
  "contentKey": GUID,
  "settingsKey": GUID | null
}
```

### BlockItemData (`contentData` / `settingsData` Entry)

```
{
  "key": GUID,                         // Unique block instance identifier
  "contentTypeKey": GUID,              // Element type key
  "values": BlockPropertyValue[]       // See BlockPropertyValue section
}
```

### BlockPropertyValue (Values Inside Block `contentData`)

```
{
  "alias": string,                     // Property alias on the element type
  "culture": string | null,
  "segment": string | null,
  "value": any,                        // Property value (can be a nested block value object)
  "editorAlias": string                // Property editor alias (e.g., "Umbraco.TextBox")
}
```

{% hint style="info" %}
Block-level values have `editorAlias`. Root-level values do not.
{% endhint %}

### Expose Entry

```
{
  "contentKey": GUID,
  "culture": string | null,
  "segment": string | null
}
```

### RichTextEditorValue (Value of a Rich Text Editor Property)

```
{
  "markup": string,       // HTML content with <umb-rte-block> tags for inline blocks
  "blocks": BlockValue    // Standard block value structure (see Block Value section)
}
```

**Rich Text Editor block reference in markup:**
```html
<umb-rte-block data-content-key="GUID"></umb-rte-block>
```


## Path Construction Algorithm

Use this step-by-step process to construct a path to any target in the document.

### Reaching a Root Property Value

```
/values[alias=<ALIAS>,culture=<CULTURE|null>,segment=<SEGMENT|null>]/value
```

Examples:
```
/values[alias=title,culture=null,segment=null]/value
/values[alias=title,culture=en-US,segment=null]/value
/values[alias=description,culture=en-US,segment=desktop]/value
```

### Reaching a Variant Name

```
/variants[culture=<CULTURE|null>,segment=<SEGMENT|null>]/name
```

### Navigating Into Block Editor Values

Once at a block editor's `/value`, append paths to navigate its internal structure:

**Find a block by key:**
```
/contentData[key=<BLOCK_GUID>]
```

**Find a property value on that block:**
```
/contentData[key=<BLOCK_GUID>]/values[alias=<ALIAS>]/value
/contentData[key=<BLOCK_GUID>]/values[alias=<ALIAS>,culture=<CULTURE>]/value
/contentData[key=<BLOCK_GUID>]/values[alias=<ALIAS>,culture=<CULTURE>,segment=<SEGMENT>]/value
```

**Navigate into a nested block editor:**
If the block property's value is itself a block editor, continue with `/contentData[key=...]/values[alias=...]/value` again:
```
/contentData[key=OUTER_BLOCK]/values[alias=innerList,culture=null,segment=null]/value/contentData[key=INNER_BLOCK]/values[alias=text]/value
```

### Rich Text Editor Path Adjustment

For Rich Text Editor values, block data is under `/blocks/`, not directly under `/value/`:

```
/values[alias=rte,culture=null,segment=null]/value/blocks/contentData[key=<GUID>]/values[alias=text]/value
                                                  ^^^^^^^^
                                                  Extra /blocks/ segment for Rich Text Editor
```

The markup is at:
```
/values[alias=rte,culture=null,segment=null]/value/markup
```

### Layout and Expose Paths

Layout arrays are keyed by editor alias:
```
.../value/layout/Umbraco.BlockList/-
.../value/layout/Umbraco.BlockGrid/-
.../value/blocks/layout/Umbraco.RichText/-     (Rich Text Editor: note /blocks/)
```

Expose arrays:
```
.../value/expose/-
.../value/blocks/expose/-                      (Rich Text Editor: note /blocks/)
```

### General Recursive Pattern

For any level of nesting, the pattern repeats:

```
/values[alias=<PROP>,culture=<C>,segment=<S>]/value
  → for Rich Text Editor: /blocks
  → /contentData[key=<GUID>]/values[alias=<PROP>,culture=<C>,segment=<S>]/value
      → for Rich Text Editor: /blocks
      → /contentData[key=<GUID>]/values[alias=<PROP>,...]/value
          → ... (repeat as deep as needed)
```


## Adding a Block Checklist

When adding a block to any block editor, you need these operations:

### Block List or Block Grid (3 operations)

| # | Operation | Path suffix | Value |
|---|-----------|-------------|-------|
| 1 | `add` | `/contentData/-` | BlockItemData object. |
| 2 | `add` | `/layout/<EditorAlias>/-` | Layout item. |
| 3 | `add` | `/expose/-` | Expose entry (one per culture/segment). |

### Rich Text Editor (4 operations)

| # | Operation | Path suffix | Value |
|---|-----------|-------------|-------|
| 1 | `add` | `/blocks/contentData/-` | BlockItemData object. |
| 2 | `add` | `/blocks/layout/Umbraco.RichText/-` | Layout item. |
| 3 | `add` | `/blocks/expose/-` | Expose entry. |
| 4 | `replace` | `/markup` | Updated HTML with `<umb-rte-block data-content-key="NEW_GUID">`. |

### Culture-Variant Blocks

If a block has culture-variant properties, add one expose entry per culture:

```json
{ "contentKey": "GUID", "culture": "en-US", "segment": null }
{ "contentKey": "GUID", "culture": "nl", "segment": null }
```

### Invariant Blocks

For invariant blocks, expose has `culture: null`:

```json
{ "contentKey": "GUID", "culture": null, "segment": null }
```


## Complete Worked Example

**Scenario:** A document has a root Block List (`blockList` property, invariant). Inside it is a container block that has a `block` property (another Block List, invariant). Inside that is a grid container block with a `grid` property (Block Grid, invariant). Inside the grid is a text block with a culture-variant `text` property. We want to update the Dutch text.

**Structure visualization:**
```
Document
  └─ values[alias=blockList] → Block List
       └─ contentData[key=CONTAINER_KEY]
            └─ values[alias=block] → Block List
                 └─ contentData[key=GRID_CONTAINER_KEY]
                      └─ values[alias=grid] → Block Grid
                           └─ contentData[key=TEXT_BLOCK_KEY]
                                └─ values[alias=text,culture=nl] → "nederlands"
```

**PATCH request:**
```json
{
  "operations": [
    {
      "op": "replace",
      "path": "/values[alias=blockList,culture=null,segment=null]/value/contentData[key=f32d4827-5fe6-4adf-a49f-6118962c8a57]/values[alias=block,culture=null,segment=null]/value/contentData[key=dc9db89c-9dc8-4df2-99ac-0c92049e958b]/values[alias=grid,culture=null,segment=null]/value/contentData[key=5122504c-47ca-4632-9ea0-0b1cc45d60ea]/values[alias=text,culture=nl,segment=null]/value",
      "value": "nederlands bijgewerkt"
    }
  ]
}
```

**Path segment breakdown:**

| Segment | Type | Resolves to |
|---------|------|-------------|
| `/values` | Property | Root values array. |
| `[alias=blockList,culture=null,segment=null]` | Filter | The blockList property entry. |
| `/value` | Property | The block list value object. |
| `/contentData` | Property | Content data array. |
| `[key=f32d4827-...]` | Filter | The container block. |
| `/values` | Property | Container block's values array. |
| `[alias=block,culture=null,segment=null]` | Filter | The "block" property (inner block list). |
| `/value` | Property | The inner block list value object. |
| `/contentData` | Property | Inner content data array. |
| `[key=dc9db89c-...]` | Filter | The grid container block. |
| `/values` | Property | Grid container's values array. |
| `[alias=grid,culture=null,segment=null]` | Filter | The "grid" property (block grid). |
| `/value` | Property | The block grid value object. |
| `/contentData` | Property | Grid content data array. |
| `[key=5122504c-...]` | Filter | The text block. |
| `/values` | Property | Text block's values array. |
| `[alias=text,culture=nl,segment=null]` | Filter | The Dutch text value. |
| `/value` | Property | The actual string value. |


## Error Conditions

| Error | HTTP Code | Cause |
|-------|-----------|-------|
| Invalid path syntax | 400 | Path doesn't start with `/`, unclosed bracket, empty filter key, and so on. |
| Missing value | 400 | `replace` or `add` operation has `value: null`. |
| Path resolution failed | 400 | Property not found on object, filter matched no elements, index out of bounds. |
| Invalid culture | 400 | Culture in path doesn't exist in the system. |
| Document not found | 404 | No document with the given ID. |
| Content type not found | 404 | Document's content type was deleted. |
| Property type not found | 422 | Property alias doesn't exist on the content type. |


## Important Rules

1. **No JSON comments.** JSON does not support `//` or `/* */`. Including them will cause a parse error.

2. **All block keys must be unique GUIDs.** When adding blocks, generate a fresh GUID for each new block. Duplicates will cause save errors.

3. **`contentData`, `layout`, and `expose` must stay in sync.** Every block must have entries in all three arrays. Missing entries cause validation failures on save.

4. **Property names are camelCase.** The JSON uses `camelCase` naming: `contentData` (not `ContentData`), `layout` (not `Layout`), `contentTypeKey` (not `ContentTypeKey`).

5. **Filter values are case-sensitive.** `culture=en-US` will not match `culture=en-us`. Use the exact casing from the GET response.

6. **Block Grid `contentData` is flat.** All blocks in a grid are in the same `contentData` array regardless of area nesting. Area structure exists only in `layout`.

7. **Rich Text Editor blocks need /blocks/ in the path.** Rich Text Editor values wrap block data in `{ markup, blocks: { ... } }`. Always include `/blocks/` before `contentData`, `layout`, `settingsData`, or `expose` when targeting Rich Text Editor block data.

8. **Rich Text Editor blocks need markup updates.** When adding or removing Rich Text Editor blocks, also update the `markup` to add or remove the corresponding `<umb-rte-block data-content-key="GUID"></umb-rte-block>` tag.

9. **Nested block values are fully expanded.** When a block property contains another block editor, its value is a complete block value object (with its own `layout`, `contentData`, `settingsData`, `expose`). Navigate into it by continuing the path.

10. **Operations are sequential.** Operation N sees the document state after operations 1 through N-1. You can add a block in one operation and reference it in the next.

11. **Use the GET response as a map.** Fetch the document with `GET /umbraco/management/api/v1/document/{id}` to discover the current structure, block keys, property aliases, cultures, and content type keys.

12. **Block Grid layout items need size.** When adding to a Block Grid, layout items must include `columnSpan` and `rowSpan` (typically `12` and `1`), plus `areas: []`.
