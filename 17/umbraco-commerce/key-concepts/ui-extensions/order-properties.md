---
description: Order Properties UI Extension for Umbraco Commerce
---

# Order Properties
With the use of [Properties](../properties.md), Umbraco Commerce allows a lot of flexibility to capture whatever data you need to record against an Order. To complement that functionality, it is also possible to configure those properties to be editable within the backoffice UI.

Order Properties are defined as manifest entries in your [`umbraco-package.manifest`](https://docs.umbraco.com/umbraco-cms/extending/package-manifest).

```json
"extensions": [
    {
        "type": "ucOrderProperty",
        "alias": "Uc.OrderProperty.FirstName",
        "name": "Customer FirstName",
        "weight": 400,
        "meta": {
            "propertyAlias": "firstName",
            "group": "Uc.OrderPropertyGroup.Customer",
            "editorUiAlias": "Umb.PropertyEditorUi.TextBox",
            "labelUiAlias": "Umb.PropertyEditorUi.Label"
        }
    }
]
```

Each entry must have a type of `ucOrderProperty` along with a unique `alias` and `name`. An optional `forEntityTypes` key can also be defined to control whether the property is visible on the Cart editor, or the Order editor, or both. The `forEntityTypes` is an array and can accept either or both of `uc:cart` or `uc:order` values.

A `meta` entry provides configuration options for the property

| Name | Description |  
| -- | -- |
| `label` | A fallback label for the property, if there is no localization available. If empty, or undefined, it will display the default localization fallback. |
| `description` |  A fallback label for the property description, if there is no localization available. If empty, or undefined, it will display the default localization fallback. |
| `propertyAlias` | The alias of the order line property to edit |
| `group` | Defines a [group](#order-property-groups) in which to display the property |
| `editorUiAlias` | The alias of the property editor to use to edit this property |
| `editorConfig` | A JSON serialized string to pass to the editor UI as config |
| `labelUiAlias` | The alias of the property editor to use to view this property |

## Order Property Groups

Order properties can be defined as one of the following to control where the property is displayed.

| Name | Description |  
| -- | -- |
| `Uc.OrderPropertyGroup.Customer` | Displays the property in the Customer fieldset of the customer details editor modal |
| `Uc.OrderPropertyGroup.Billing` | Displays the property in the Billing fieldset of the customer details editor modal |
| `Uc.OrderPropertyGroup.Shipping` | Displays the property in the Shipping fieldset of the customer details editor modal |
| `Uc.OrderPropertyGroup.Notes` | Displays the property in the Notes section of the Order editor |
| `Uc.OrderPropertyGroup.AdditionalInfo` | Displays the property in the Additional Info fieldset of the Order editor |

## Localization

When displaying your properties in the backoffice UI it is necessary to provide localizable labels. This is controlled by Umbraco's [UI Localization](https://docs.umbraco.com/umbraco-cms/extending/language-files/ui-localization) feature.

Umbraco Commerce will automatically look for the following entries:

| Key |  Description |
| --- | --- | 
| `ucProperties_{alias}Label` | A main label for the property |
| `ucProperties_{alias}Description` | A description for the property |

Here `{alias}` is the property alias of a property.
