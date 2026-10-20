---
description: "Information on the indexing section"
---

# Indexing Settings

This section allows you to configure how content is indexed for Examine.

```json
"Umbraco": {
  "CMS": {
    "Indexing": {
      "ExplicitlyIndexEachNestedProperty": true,
      "IndexExternalBlockElements": false,
      "BatchSize": 10000
    }
  }
}
```
## ExplicitlyIndexEachNestedProperty

When indexing content, each property contained within certain complex editors are indexed as separate fields by default. These complex editors include:

- Block List
- Block Grid

The complex editors are also indexed to their own separate fields, which then contains "the sum" of all properties contained within.

In some cases this yields a lot of fields in the index, which can lead to errors when performing searches. Changing this setting to `false` can mend that issue. It prevents each contained property from being written to the index in its own field.

## IndexExternalBlockElements

[Elements](../../model-your-content/content-types-and-structure/data/defining-content/elements.md) from the Library can be embedded as block content in the Block List, Block Grid, Single Block, and Rich Text editors. By default, the content of these Elements is not added to the search index of the documents that embed them.

Set this to `true` to include that content in the index entry of the referencing document. This only applies to the published content index (`Umb_PublishedContent`). The draft content index (`Umb_Content`) is not affected.

Only published Elements are included. When an Element is published, unpublished, moved to the Recycle Bin, or deleted, the documents that embed it are re-indexed automatically.

Rebuild the published content index after changing this setting for the change to take effect.

## BatchSize

For large indexing operations (such as rebuilding an index), content is loaded from the database and indexed in batches.

Depending on the complexity of your content model, lowering the batch size might speed up these operations.
