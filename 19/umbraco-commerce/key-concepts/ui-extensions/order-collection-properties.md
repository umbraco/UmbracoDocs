---
description: Order Collection Properties UI Extension for Umbraco Commerce
---

# Order Collection Properties
With the use of [Properties](../properties.md), Umbraco Commerce allows a lot of flexibility to capture whatever data you need to record against an Order. To complement that functionality, it is also possible to configure those properties to be displayed within the Orders collection view.

Order Collection Properties are defined as manifest entries in your [`umbraco-package.manifest`](https://docs.umbraco.com/umbraco-cms/extending/package-manifest).

```json
"extensions": [
    {
        "type": "ucOrderCollectionProperty",
        "alias": "Uc.OrderCollectionProperty.FirstName",
        "name": "Customer FirstName",
        "weight": 400,
        "meta": {
            "propertyAlias": "firstName",
            "labelUiAlias": "Umb.PropertyEditorUi.Label",
            "align": "right"
        }
    }
]
```

Each entry must have a type of `ucOrderCollectionProperty` along with a unique `alias` and `name`. An optional `forEntityTypes` key can also be defined to control whether the property is visible on the Cart editor, or the Order editor, or both. The `forEntityTypes` is an array and can accept either or both of the `uc:cart` or `uc:order` values.

A `meta` entry provides configuration options for the property

| Name | Description |  
| -- | -- |
| `propertyAlias` | The alias of the order line property to edit |
| `labelUiAlias` | The alias of the property editor to use to view this property |
| `align` | Can be `left`, `center`, or `right` to control the alignment of the column |

## Localization

When displaying your properties in the backoffice UI it is necessary to provide localizable labels. This is controlled by Umbraco's [UI Localization](https://docs.umbraco.com/umbraco-cms/extending/language-files/ui-localization) feature.

Umbraco Commerce will automatically look for the following entries:

| Key |  Description |
| --- | --- | 
| `ucProperties_{alias}Label` | A main label for the property used as a column heading |

Here `{alias}` is the property alias of a property.