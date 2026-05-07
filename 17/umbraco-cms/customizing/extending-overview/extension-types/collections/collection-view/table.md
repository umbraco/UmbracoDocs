# Table Collection View

The Table Collection View renders items produced by an active [Collection](../collection.md). The collection is responsible for fetching items through its [Collection Repository](../collection.md#collection-repository).

When you want to display entities in a tabular layout within a collection, use the Table Collection View Kind. The table renders without a custom element — you only need to define which columns to show in the manifest.

The base Collection Item Model that all items must satisfy is:

```typescript
export interface UmbCollectionItemModel {
  unique: string;
  entityType: string;
  name?: string;
  icon?: string;
}
```

If your collection's repository returns additional fields, extend the base model with your own interface. This interface documents the contract between the repository output and the column definitions.

```typescript
export interface MyCollectionItemModel extends UmbCollectionItemModel {
  status: string;
  creator: string;
}
```

Define this interface alongside your repository. For a full example of a repository that populates these fields, see [Collection](../collection.md).

The table kind always renders the following columns automatically:

| Column | Description |
|---|---|
| **Name** | Always the first column. Renders the item icon and name. |
| **Description** | Rendered only when at least one item in the collection has a description. |
| _(manifest columns)_ | Any columns defined in `meta.columns`, inserted after Name/Description. Values are rendered as strings. |
| **[Entity Actions](../../entity-actions.md)** | Renders the item's Entity Actions menu. |

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
