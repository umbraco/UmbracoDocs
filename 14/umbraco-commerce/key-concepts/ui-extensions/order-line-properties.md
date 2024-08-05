---
description: Order Line Properties UI Extension for Umbraco Commerce
---

# Order Line Properties
With the use of [Properties](../properties.md), Umbraco Commerce allows a lot of flexibility to capture whatever data you need to record against an Order Line. To complement that functionality, it is also possible to configure those properties to be editable within the backoffice UI.

Order Properties are defined as manifest entries in your [`umbraco-package.manifest`](https://docs.umbraco.com/umbraco-cms/extending/package-manifest).

```json
"extensions": [
    {
        "type": "ucOrderLineProperty",
        "alias": "Uc.OrderLineProperty.FirstName",
        "name": "Customer FirstName",
        "weight": 400,
        "meta": {
            "propertyAlias": "firstName",
            "readOnly": false,
            "showInOrderLineSummary": true,
            "summaryStyle": "inline",
            "editorUiAlias": "Umb.PropertyEditorUi.TextBox",
            "labelUiAlias": "Umb.PropertyEditorUi.Label"
        }
    }
]
```

Each entry must have a type of `ucOrderLineProperty` along with a unique `alias` and `name`. An optional `forEntityTypes` key can also be defined to control whether the property is visible on the Cart editor, or the Order editor, or both. The `forEntityTypes` is an array and can accept either or both of `uc:cart` or `uc:order` values.

A `meta` entry provides configuration options for the property

| Name | Description |  
| -- | -- |
| `propertyAlias` | The alias of the order line property to edit |
| `readOnly` | Set whether the property should be defined as read only and so should be viewable but not editable |
| `showInOrderLineSummary` | Set whether the property should display on the orderline summary |
| `summaryStyle` | Can be either `inline` in which case the property value will be displayed inline with other inline properties below the product name, or `table` in which case the property value will be displayed in a table below the product name |
| `editorUiAlias` | The alias of the property editor to use to edit this property |
| `editorConfig` | A JSON serialized string to pass to the editor UI as config |
| `labelUiAlias` | The alias of the property editor to use to view this property |

## Localization

When displaying your properties in the backoffice UI it is necessary to provide localizable labels. This is controlled by Umbraco's [UI Localization](https://docs.umbraco.com/umbraco-cms/extending/language-files/ui-localization) feature.

Umbraco Commerce will automatically look for the following entries:

| Key |  Description |
| --- | --- | 
| `ucProperties_{alias}Label` | A main label for the property |
| `ucProperties_{alias}Description` | A description for the property |

Here `{alias}` is the property alias of a property.