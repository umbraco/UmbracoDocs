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
      "BatchSize": 10000,
      "LoadOnlyPropertiesForIncludedFields": false
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

## LoadOnlyPropertiesForIncludedFields

By default, a content index rebuild loads every property of every document from the database. Every culture is loaded, for both the draft and the published version. This happens even when an index only includes a few fields.

When this setting is `true`, a rebuild only loads the properties needed for the fields the indexes include. The default value is `false`.

### Benefits

On sites with many cultures or large property values, loading the properties dominates the time and memory a rebuild takes. Block List and Block Grid values in many languages are a typical example.

An index used to search titles and descriptions doesn't need the block content. If the index only includes those fields and this setting is enabled, a rebuild never loads the block content from the database.

In a benchmark with 24 cultures and 1000-character property values, an index including only name and title fields showed the following results:

| Measurement | All properties loaded | Included properties loaded |
| --- | --- | --- |
| Load time per document | 17.3 ms | 8.5 ms |
| Peak retained memory | 396 MB | 51 MB |
| Time to populate 40 documents | 1034 ms | 345 ms |

### When to use it

Enable this setting when both of the following apply:

- Rebuilding your content indexes takes a long time or uses a lot of memory.
- Your content indexes only need a subset of the document properties.

The setting has no effect on its own. Each content index being rebuilt must also be restricted to specific fields. For more information, see the [Including only specific fields in a content index](../application-code/examine/indexing.md#including-only-specific-fields-in-a-content-index) section of the Custom indexing article.

The setting only takes effect when every index being rebuilt has a validator that includes specific fields. Otherwise all properties are loaded, as before. Rebuilding a single index, for example from the Examine dashboard, only considers that index. When all indexes are rebuilt together, such as at start-up, all content indexes of the same kind need to include specific fields.

### How properties are matched to fields

The property each included field comes from is worked out from the field name. A field named `{alias}`, `{alias}_{culture}`, `__Raw_{alias}` or `{alias}.{nested path}` loads the property with the alias `{alias}`. The built-in property index value factories name fields this way.

{% hint style="warning" %}
Custom code can produce fields that aren't named after the property they come from. Examples are:

- A custom `IPropertyIndexValueFactory`, for example one that indexes the property `body` as `searchText`.
- A replacement `IContentValueSetBuilder`.
- A custom `IUrlSegmentProvider` that reads a property other than `umbracoUrlName`.

With this setting enabled, a rebuild doesn't load the source property, so the field is empty on every document. Nothing is logged. Saving a document fills the field again, as indexing a single document loads all properties.
{% endhint %}

If an included field comes from custom code like this, use one of these options to keep the field filled:

- **Include the source property alias as well.** For example, include `body` alongside `searchText`. An included name that no field uses doesn't add anything to the index. It only makes a rebuild load that property.
- **Override `ContentIndexPopulator.GetPropertyAliasesToLoad`.** The `protected virtual` method returns the aliases of the properties to load, or `null` to load all properties. You need to subclass both `ContentIndexPopulator` and `PublishedContentIndexPopulator` and replace their registrations, so this option is better suited to packages.

Fields built in a `TransformingIndexValues` event handler need nothing extra. The validator removes fields before the handler runs, so the fields the handler reads must already be included.
