# Table Collection View

When you want to display entities in a tabular layout within a collection, use the Table Collection View Kind. The table renders without a custom element — you only need to define which columns to show in the manifest.

The Table Collection View renders items produced by a [Collection](../collection.md). The collection is responsible for fetching items through its [Collection Repository](../collection.md#collection-repository).

The columns defined in `meta.columns` map to fields on your collection item model. In the example below, `status` and `creator` map to fields on `MyCollectionItemModel`. For details on defining the item model, see [Collection](../collection.md#item-model).

The table kind always renders the following columns automatically:

| Column | Description |
|---|---|
| **Name** | Always the first column. Renders the item icon and name. |
| **Description** | Rendered only when at least one item in the collection has a description. |
| _(manifest columns)_ | Any columns defined in `meta.columns`, inserted after Name/Description. Values are rendered as strings by default, or via a [Value Summary](../../value-summary/README.md) when `valueType` is set. |
| **[Entity Actions](../../entity-actions.md)** | Renders the item's Entity Actions menu. |

## Column options

Each entry in `meta.columns` supports the following properties:

| Property | Required | Description |
|---|---|---|
| `label` | Yes | The column header text. |
| `field` | Yes | The field name on the collection item model to read the value from. |
| `valueType` | No | A [Value Type](../../value-type.md) key. When set, the column renders the value using the matching [Value Summary](../../value-summary/README.md) instead of a plain string. |

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
        "field": "status",
        "valueType": "My.ValueType.Status"
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

In the example above, the `status` column uses a `valueType` to render its value through a registered Value Summary. The `creator` column renders its value as a plain string.

{% content-ref url="../../value-type.md" %}{% endcontent-ref %}
{% content-ref url="../../value-summary/README.md" %}{% endcontent-ref %}
