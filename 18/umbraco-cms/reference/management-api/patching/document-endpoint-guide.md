# Umbraco Document PATCH Endpoint Guide

## What is the PATCH Endpoint

The Document PATCH endpoint lets you make **partial updates** to an Umbraco document. Instead of sending the entire document back (like a PUT), you describe only the changes you want to make.

This is useful when you need to:

- Update a single property without touching the rest of the document.
- Modify a value inside a deeply nested block editor.
- Add or remove blocks from a block list, block grid, or rich text editor.
- Update variant names for specific cultures.

## Endpoint

```
PATCH /umbraco/management/api/v1/document/{id}/patch
Content-Type: application/json-patch+json
```

- `{id}` is the document's GUID (for example, `a4ecec0e-3218-40b1-875b-dbaa7175028e`).
- Requires authentication (backoffice user with update permission on the document).

## Request Format

The request body is a JSON object with an `operations` array. Each operation has three fields:

```json
{
  "operations": [
    {
      "op": "replace",
      "path": "/values[alias=title,culture=en-US,segment=null]/value",
      "value": "New Title"
    }
  ]
}
```

| Field | Required | Description |
|-------|----------|-------------|
| `op` | Yes | The operation: `"replace"`, `"add"`, or `"remove"`. |
| `path` | Yes | A path expression pointing to the target location in the document. |
| `value` | For replace/add | The new value to set. |

Multiple operations are applied **in order** - each operation sees the result of all previous ones.

{% hint style="warning" %}
JSON does not support comments. Do not include `//` comment lines in your request body.
{% endhint %}

## Operations

### Replace

Replaces an existing value at the target location.

```json
{ "op": "replace", "path": "/values[alias=title,culture=null,segment=null]/value", "value": "New Title" }
```

### Add

Adds a value. Behavior depends on the target:

- **To an array with `/-`**: appends to the end.
- **To an array with an index (for example, `/1`)**: inserts at that position, shifting existing elements.
- **To an object property**: sets the property (creates it if missing).

```json
{ "op": "add", "path": "/values[alias=blocks,culture=null,segment=null]/value/contentData/-", "value": { ... } }
```

### Remove

Removes the value at the target location.

```json
{ "op": "remove", "path": "/values[alias=blocks,culture=null,segment=null]/value/contentData[key=some-guid]" }
```

## Response Codes

| Code | Meaning |
|------|---------|
| **200** | All operations applied successfully. |
| **400** | Invalid path syntax, missing value for replace/add, or path could not be resolved. |
| **404** | Document not found, or content type not found. |
| **422** | Property type not found on the content type. |


## Path Syntax

Paths tell the PATCH endpoint exactly where in the document JSON to apply the operation. The syntax is based on [JSON Pointer](https://datatracker.ietf.org/doc/html/rfc6901) with Umbraco extensions for filtering arrays.

### Building Blocks

| Syntax | What it does | Example |
|--------|-------------|---------|
| `/property` | Access a named property on an object. | `/value`, `/name`, `/markup` |
| `[key=value]` | Find an array element where `key` equals `value`. | `[alias=title]` |
| `[k1=v1,k2=v2]` | Find an element matching all conditions. | `[alias=title,culture=en-US,segment=null]` |
| `/0`, `/1`, ... | Access an array element by index (zero-based). | `/contentData/0` |
| `/-` | Target the end of an array (for add/append). | `/contentData/-` |
| `~1` | Escape sequence for `/` in a property name. | `/Umbraco.BlockList` uses no escape since `.` is fine |
| `~0` | Escape sequence for `~` in a property name. | Rarely needed |

### Filter Syntax Details

Filters match array elements by their properties. All conditions must match (and logic).

- **String values**: matched exactly, case-sensitive.
- **Null values**: use the literal word `null` (case-insensitive) to match properties that are null or missing.
- **Multiple conditions**: separated by commas, all must match.
- **First match wins**: if multiple elements match, the first one is used.

```
[alias=title,culture=en-US,segment=null]
 ↑              ↑                ↑
 property       exact string     matches null
 name=value     match            values
```


## The Document JSON Structure

PATCH paths navigate a JSON representation of the document. Understanding this structure is key to writing correct paths.

### Root Level

```json
{
  "values": [ ... ],     // Property values (one entry per alias + culture + segment combination)
  "variants": [ ... ],   // Variant names (one entry per culture + segment combination)
  "template": { "id": "guid" }  // or null
}
```

### Values Array

Each entry in `values` represents a single property value for a specific culture and segment:

```json
{
  "alias": "title",        // Property type alias
  "culture": "en-US",      // Culture code, or null for invariant
  "segment": null,          // Segment name, or null for non-segmented
  "value": "Hello World"   // The actual value (type depends on the property editor)
}
```

For standard property editors (Textbox, Textarea, and so on), `value` is a string or number.

For complex editors (Block List, Block Grid, Rich Text), `value` is a nested JSON object.

### Variants Array

Each entry represents a culture/segment variant of the document:

```json
{
  "culture": "en-US",    // or null for invariant
  "segment": null,        // or segment name
  "name": "Home Page"    // The document name for this variant
}
```


## Block Editor Values

When a property uses a block editor (Block List, Block Grid, or Rich Text), the `value` field contains a structured object with four arrays:

```json
{
  "layout": {
    "Umbraco.BlockList": [            // Keyed by the editor alias
      { "contentKey": "guid-1", "settingsKey": null },
      { "contentKey": "guid-2", "settingsKey": null }
    ]
  },
  "contentData": [
    {
      "key": "guid-1",
      "contentTypeKey": "element-type-guid",
      "values": [
        { "alias": "headline", "culture": null, "segment": null, "value": "Hello", "editorAlias": "Umbraco.TextBox" }
      ]
    },
    {
      "key": "guid-2",
      "contentTypeKey": "element-type-guid",
      "values": [ ... ]
    }
  ],
  "settingsData": [],
  "expose": [
    { "contentKey": "guid-1", "culture": "en-US", "segment": null },
    { "contentKey": "guid-1", "culture": "nl", "segment": null },
    { "contentKey": "guid-2", "culture": null, "segment": null }
  ]
}
```

### The Four Arrays

| Array | Purpose |
|-------|---------|
| **`layout`** | Defines the visual order and structure of blocks. Keyed by editor alias (`Umbraco.BlockList`, `Umbraco.BlockGrid`, or `Umbraco.RichText`). |
| **`contentData`** | The actual block content. Each item has a `key` (GUID), `contentTypeKey` (element type GUID), and `values` (array of property values). |
| **`settingsData`** | Same structure as `contentData` but for block settings. |
| **`expose`** | Controls which blocks are visible for which cultures/segments. Each entry links a `contentKey` to a `culture` and `segment`. |

### Layout Items by Editor Type

**Block List** layout items:

```json
{ "contentKey": "guid", "settingsKey": null }
```

**Block Grid** layout items (include size and areas):

```json
{
  "columnSpan": 12,
  "rowSpan": 1,
  "areas": [
    {
      "key": "area-guid",
      "items": [ /* nested BlockGridLayoutItems */ ]
    }
  ],
  "contentKey": "guid",
  "settingsKey": null
}
```

**Rich Text** layout items:

```json
{ "contentKey": "guid", "settingsKey": null }
```

### Block Grid `contentData` is Flat

In a Block Grid, all blocks appear in the same flat `contentData` array, regardless of nesting. The area structure is only expressed in the `layout`. You can find any block directly with `contentData[key=guid]`.

### Nested Block Values Are Expanded

When a block property contains another block editor, the inner value is fully expanded into a nested JSON object. You can navigate into it by continuing the path through the inner block's `value`.


## Rich Text Editor Specifics

Rich Text Editor values have a different shape than Block List or Block Grid. The value wraps in an object with `markup` and `blocks`:

```json
{
  "markup": "<p>Some text</p><umb-rte-block data-content-key=\"guid-1\"></umb-rte-block><p>More text</p>",
  "blocks": {
    "layout": { "Umbraco.RichText": [ ... ] },
    "contentData": [ ... ],
    "settingsData": [ ... ],
    "expose": [ ... ]
  }
}
```

**Key differences from Block List / Block Grid:**

- The block data lives under `blocks`, not directly in the value.
- Paths into Rich Text Editor blocks go through `/value/blocks/contentData/...` (not `/value/contentData/...`).
- The `markup` contains `<umb-rte-block data-content-key="guid">` tags that reference blocks.
- When adding a Rich Text Editor block, you must also update `markup` to include the new `<umb-rte-block>` tag.


## Common Recipes

### Update a Property Value

```json
{
  "operations": [
    {
      "op": "replace",
      "path": "/values[alias=title,culture=null,segment=null]/value",
      "value": "Updated Title"
    }
  ]
}
```

### Update a Variant Name

```json
{
  "operations": [
    {
      "op": "replace",
      "path": "/variants[culture=en-US,segment=null]/name",
      "value": "New Page Name"
    }
  ]
}
```

### Update a Culture-Specific Property

```json
{
  "operations": [
    {
      "op": "replace",
      "path": "/values[alias=title,culture=nl,segment=null]/value",
      "value": "Bijgewerkte Titel"
    }
  ]
}
```

### Replace a Value Inside a Block List Block

Given a document with a `contentBlocks` property (Block List), find the block by its key and update its `headline` property:

```json
{
  "operations": [
    {
      "op": "replace",
      "path": "/values[alias=contentBlocks,culture=null,segment=null]/value/contentData[key=ba452058-c92b-46c5-be51-5a0aeedc4e06]/values[alias=headline,culture=null,segment=null]/value",
      "value": "Updated Headline"
    }
  ]
}
```

### Add a Block to a Block List

Adding a block requires **3 operations** — add the content data, the layout entry, and the expose entry:

```json
{
  "operations": [
    {
      "op": "add",
      "path": "/values[alias=contentBlocks,culture=null,segment=null]/value/contentData/-",
      "value": {
        "contentTypeKey": "151b61c6-79ec-4fd5-88d2-468778193fd7",
        "key": "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee",
        "values": [
          {
            "alias": "headline",
            "culture": null,
            "segment": null,
            "value": "New Block Headline"
          }
        ]
      }
    },
    {
      "op": "add",
      "path": "/values[alias=contentBlocks,culture=null,segment=null]/value/layout/Umbraco.BlockList/-",
      "value": {
        "contentKey": "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee",
        "settingsKey": null
      }
    },
    {
      "op": "add",
      "path": "/values[alias=contentBlocks,culture=null,segment=null]/value/expose/-",
      "value": {
        "contentKey": "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee",
        "culture": null,
        "segment": null
      }
    }
  ]
}
```

### Insert a Block at a Specific Position

Use an index instead of `/-` to insert before a specific position. This inserts at index 1 (second position):

```json
{
  "operations": [
    {
      "op": "add",
      "path": "/values[alias=contentBlocks,culture=null,segment=null]/value/contentData/1",
      "value": { "contentTypeKey": "...", "key": "new-guid", "values": [ ... ] }
    },
    {
      "op": "add",
      "path": "/values[alias=contentBlocks,culture=null,segment=null]/value/layout/Umbraco.BlockList/1",
      "value": { "contentKey": "new-guid", "settingsKey": null }
    },
    {
      "op": "add",
      "path": "/values[alias=contentBlocks,culture=null,segment=null]/value/expose/-",
      "value": { "contentKey": "new-guid", "culture": null, "segment": null }
    }
  ]
}
```

{% hint style="info" %}
`contentData` and `layout` use index `/1` to insert at position 1, but `expose` uses `/-` to append (order does not matter for expose).
{% endhint %}

### Remove a Block

Removing a block requires **3 operations** — remove from `contentData`, `layout`, and `expose`:

```json
{
  "operations": [
    {
      "op": "remove",
      "path": "/values[alias=contentBlocks,culture=null,segment=null]/value/contentData[key=block-to-remove-guid]"
    },
    {
      "op": "remove",
      "path": "/values[alias=contentBlocks,culture=null,segment=null]/value/layout/Umbraco.BlockList[contentKey=block-to-remove-guid]"
    },
    {
      "op": "remove",
      "path": "/values[alias=contentBlocks,culture=null,segment=null]/value/expose[contentKey=block-to-remove-guid]"
    }
  ]
}
```

{% hint style="info" %}
For blocks with multiple expose entries (culture-variant blocks), you need a separate remove for each expose entry.
{% endhint %}

### Update a Deeply Nested Property

Consider a document with this nesting: Root Block List > container block > nested Block List > grid container block > Block Grid > text block.

To update the dutch text value of a text block deep inside the grid:

```json
{
  "operations": [
    {
      "op": "replace",
      "path": "/values[alias=blockList,culture=null,segment=null]/value/contentData[key=f32d4827-...]/values[alias=block,culture=null,segment=null]/value/contentData[key=dc9db89c-...]/values[alias=grid,culture=null,segment=null]/value/contentData[key=5122504c-...]/values[alias=text,culture=nl,segment=null]/value",
      "value": "bijgewerkte tekst"
    }
  ]
}
```

Reading this path left to right:

```
/values[alias=blockList,culture=null,segment=null]   → find the "blockList" property
  /value                                              → enter its value (the block list object)
    /contentData[key=f32d4827-...]                    → find the container block
      /values[alias=block,culture=null,segment=null]  → find its "block" property (inner block list)
        /value                                        → enter the inner block list value
          /contentData[key=dc9db89c-...]              → find the grid container block
            /values[alias=grid,culture=null,segment=null]  → find its "grid" property (block grid)
              /value                                  → enter the block grid value
                /contentData[key=5122504c-...]        → find the text block
                  /values[alias=text,culture=nl,segment=null]  → find the dutch text
                    /value                            → the actual text string
```

### Add a Block to a Rich Text Editor

Adding a block to a Rich Text Editor requires **4 operations** — the markup must also be updated:

```json
{
  "operations": [
    {
      "op": "add",
      "path": "...path-to-rte.../value/blocks/contentData/-",
      "value": {
        "contentTypeKey": "element-type-guid",
        "key": "new-block-guid",
        "values": [
          { "alias": "text", "culture": "en-US", "segment": null, "value": "Block text" }
        ]
      }
    },
    {
      "op": "add",
      "path": "...path-to-rte.../value/blocks/layout/Umbraco.RichText/-",
      "value": { "contentKey": "new-block-guid", "settingsKey": null }
    },
    {
      "op": "add",
      "path": "...path-to-rte.../value/blocks/expose/-",
      "value": { "contentKey": "new-block-guid", "culture": "en-US", "segment": null }
    },
    {
      "op": "replace",
      "path": "...path-to-rte.../value/markup",
      "value": "<p>Existing text</p><umb-rte-block data-content-key=\"new-block-guid\"></umb-rte-block>"
    }
  ]
}
```

{% hint style="info" %}
The path goes through `/value/blocks/contentData` (not `/value/contentData`) because the Rich Text Editor wraps its block data inside a `blocks` object.
{% endhint %}


## Tips and Gotchas

1. **No JSON comments** — JSON does not support `//` or `/* */` comments. Remove all comments before sending.

2. **Case sensitivity** — property names in paths are case-sensitive. Use camelCase to match the JSON (`contentData`, not `ContentData`; `layout`, not `Layout`).

3. **Filter values are case-sensitive** — `culture=en-US` and `culture=EN-US` are different. Use the exact casing from the GET response.

4. **`null` in filters is case-insensitive** — `culture=null`, `culture=NULL`, and `culture=Null` all work.

5. **GUIDs must be unique** — when adding new blocks, each block key must be a unique GUID that doesn't already exist in the document.

6. **Keep `contentData`, `layout`, and `expose` in sync** — when adding a block, you need entries in all three. When removing, remove from all three. Mismatches will cause save errors.

7. **Operations are sequential** — each operation sees the result of previous ones. If you add a block in operation 1 and reference its key in operation 2, that works.

8. **First match wins** — if a filter matches multiple array elements, the first one is used. Use `key=guid` for unique matching.

9. **Block Grid `contentData` is flat** — don't look for blocks nested inside areas in `contentData`. All blocks are at the top level of `contentData` regardless of their visual area placement.

10. **GET response as reference** — use the GET response from `/umbraco/management/api/v1/document/{id}` to understand the current structure and find the keys/aliases you need for your PATCH paths. The JSON structure the PATCH operates on closely mirrors the block value structures in the GET response.
