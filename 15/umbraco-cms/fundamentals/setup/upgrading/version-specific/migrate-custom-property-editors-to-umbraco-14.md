---
description: >-
This article helps you migrate custom Property Editors to Umbraco 14 and later.
---

# Migrate custom Property Editors to Umbraco version 14 and later

{% hint style="info" %}
This article applies _only_ to implementers of custom Property Editors, that is:

- Maintainers of Property Editor packages.
- Site implementers who have built their own Property Editors.
{% endhint %}

Umbraco 14 introduces a split between server-side and client-side Property Editor aliases. The reasoning behind this change is two-fold:

1. It allows server-side implementations to be reused for multiple client-side Property Editor UIs.
2. It helps to ensure a better division between client-side and server-side responsibility.

## Migration impact for Property Editors

In the Umbraco source code, the change manifests as the `EditorUiAlias` property on `IDataType`. 

When upgrading from Umbraco 13 to Umbraco 14 and later, Umbraco automatically migrates all Data Types to include an `EditorUiAlias` value. For custom Property Editors, this migration is based on certain assumptions.

### Manifest based Property Editors

If the Property Editor is built with a [package manifest](https://docs.umbraco.com/umbraco-cms/13.latest/tutorials/creating-a-property-editor#setting-up-a-plugin):

1. Assign the package manifest `alias` to the Data Type `EditorUiAlias`, and
2. Convert the Data Type `EditorAlias` to the alias of a core Data Editor, based on the `valueType` specified in the package manifest.

The following table contains the applied conversion from `valueType` to `EditorAlias`:

| Property Editor `valueType` | Resulting `EditorAlias`  |
|-----------------------------|--------------------------|
| `BIGINT`                    | `Umbraco.Plain.Integer`  |
| `DATE`                      | `Umbraco.Plain.DateTime` |
| `DATETIME`                  | `Umbraco.Plain.DateTime` |
| `DECIMAL`                   | `Umbraco.Plain.Decimal`  |
| `JSON`                      | `Umbraco.Plain.Json`     |
| `INT`                       | `Umbraco.Plain.Integer`  |
| `STRING`                    | `Umbraco.Plain.String`   |
| `TEXT`                      | `Umbraco.Plain.String`   |
| `TIME`                      | `Umbraco.Plain.Time`     |
| `XML`                       | `Umbraco.Plain.String`   |

{% hint style="warning" %}
**This might also impact Property Value Converters**

Property Value Converters for package manifest based Property Editors might be impacted by this migration.

It is common practice to pair a Property Editor to a Property Value Converter using the package manifest `alias`:

```csharp
public bool IsConverter(IPublishedPropertyType propertyType)
  => propertyType.EditorAlias.Equals("My.Editor.Alias");
```

Since the migration moves the `alias` to `EditorUiAlias`, the Umbraco 14 and later equivalent code looks like this:

```csharp
public bool IsConverter(IPublishedPropertyType propertyType)
  => propertyType.EditorUiAlias.Equals("My.Editor.Alias");
```
{% endhint %}

### Code based editors

If the Property Editor is built with a [Data Editor](https://docs.umbraco.com/umbraco-cms/13.latest/tutorials/creating-a-property-editor#setting-up-a-property-editor-with-csharp), we:

1. Assign the Data Editor `Alias` to the Data Type `EditorUiAlias`, and
2. Retain the Data Type `EditorAlias` to as-is (which is the Data Editor `Alias`).

{% hint style="info" %}
The Data Editor `Alias` is found in the `DataEditor` attribute:

```csharp
[DataEditor("My.Editor.Alias")]
public class MySuggestionsDataEditor : DataEditor
{
}
```
{% endhint %}

## Migration impact for porting Property Editor UIs

The [`umbraco-package.json`](https://docs.umbraco.com/umbraco-cms/tutorials/creating-a-property-editor#setting-up-a-plugin) file is a central component for extensions in Umbraco 14+, including Property Editor UIs.

To keep the Property Editor working with migrated properties, ensure that the `propertyEditorUi` extension is declared with:

1. The migrated value of `EditorUiAlias` as its `alias`, and
2. The migrated value of `EditorAlias` as its `propertyEditorSchemaAlias` (found in the extension `meta` collection).

For example:

{% code title="umbraco-package.json" %}
```json
{
    "name": "My.Editors",
    "version": "1.0.0",
    "extensions": [
        {
            "type": "propertyEditorUi",
            "alias": "My.Editor.Alias",
            (...)
            "meta": {
                "propertyEditorSchemaAlias": "Umbraco.Plain.String",
                (...)
            }
        }
    ]
}
```
{% endcode %}

{% hint style="info" %}
See the [Creating a Property Editor](https://docs.umbraco.com/umbraco-cms/tutorials/creating-a-property-editor) article for guidance on building a Property Editor UI for Umbraco 14 and later.
{% endhint %}

## Alternatives

If the Data Type migration yields an undesirable result, your have two options:

1. Manually change the `EditorAlias` and/or `EditorUiAlias` directly in the `umbracoDataType` table, or 
2. Create a custom migration to update the properties (see [this article](https://docs.umbraco.com/umbraco-cms/extending/database) for inspiration).
