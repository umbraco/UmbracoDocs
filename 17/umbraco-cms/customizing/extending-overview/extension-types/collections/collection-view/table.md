# Table Collection View

When you want to display entities in a tabular layout within a collection, use the Table Collection View Kind. This will render a table layout without requiring a custom element — you only need to define which columns to show in the manifest.

The default Collection Item Model used in a Table Collection View is based on the following interface:

```typescript
export interface UmbCollectionItemModel {
  unique: string;
  entityType: string;
  name?: string;
  icon?: string;
}
```

If your collection exposes additional fields, extend the base model with your own interface:

```typescript
export interface MyCollectionItemModel extends UmbCollectionItemModel {
  status: string;
  creator: string;
}
```

The table kind always renders the following columns automatically:

| Column | Description |
|---|---|
| **Name** | Always the first column. Renders the item icon and name. |
| **Description** | Rendered only when at least one item in the collection has a description. |
| _(manifest columns)_ | Any columns defined in `meta.columns`, inserted after Name/Description. Values are rendered as strings. |
| **[Entity Actions](../entity-actions.md)** | Always the last column. Right-aligned; renders the item's context menu. |

Register the Table Collection View in the extension registry with the kind set to "table":

## Manifest

{% code title="umbraco-package.json" %}
```json
{
  "type": "collectionView",
  "kind": "table",
  "alias": "My.CollectionView.Table",
  "name": "My Table Collection View",
  "meta": {
    "columns": [
      {
        "label": "Status",
        "field": "status"
      },
      {
        "label": "Creator",
        "field": "creator"
      }
    ]
  },
  "conditions": [
    {
      "alias": "Umb.Condition.CollectionAlias",
      "match": "My.Collection" // Collection alias to display this collection view for
    }
  ]
}
```
{% endcode %}
