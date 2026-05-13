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

## BatchSize

For large indexing operations (such as rebuilding an index), content is loaded from the database and indexed in batches.

Depending on the complexity of your content model, lowering the batch size might speed up these operations.
