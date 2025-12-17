---
description: >-
  Configure and use the Entity Picker property editor in Umbraco UI Builder to
  select entities from a collection.
---

# Entity Picker

The Entity Picker property editor allows selecting one or more entities from an Umbraco UI Builder collection.

## Configuring an Entity Picker

To configure an entity picker, follow these steps:

1. Go to the **Settings** section in the Umbraco backoffice.
2. Create a **New Data Type**.
3. Select **UI Builder Entity Picker** from the **Property Editor** field.

![Data Type config](../.gitbook/assets/entity_picker_config.png)

4. Enter a **Name** for the picker and click **Save**.
5. Select the **Section** the collection is located in.
6. Select the **Collection** to pick the entities from.
7. _\[Optional]_ Select a list view **Data View**, if configured.
8. Enter a **Minimum number of items** and **Maximum number of items** that can be selected.
9. Click **Save**.

After defining the entity picker Data Type, add it to the desired Document Type.

![Document Type config](../.gitbook/assets/entity_picker_setup.png)

## Using an Entity Picker

The entity picker functions similarly to the content picker.

To pick an entity, follow these steps:

1. Go to the Document Type where the entity picker Data Type is added.
2. Click **Add** to open the picker dialog, displaying a paginated list of entities.
3. _\[Optional]_ If searchable fields are configured, use the search input field to filter results.

![Entity picker dialog](../.gitbook/assets/entity_picker_search.png)

4. Click on the entity names.
5. Click **Submit**.\
   The picker displays a summary of selected entities, which can be reordered by dragging them.
6. Click **Save** or **Save and publish** to save the changes.

![Entity picker values](../.gitbook/assets/entity_picker_picked.png)

## Retrieving the Value of an Entity Picker

The entity picker property editor includes a built-in [value converter](https://docs.umbraco.com/umbraco-cms/customizing/property-editors/property-value-converters). Retrieving the property value from Umbraco returns the selected entities, converting them to the relevant type.

```csharp
// Example
foreach(var p in Model.People){
    ...
}
```
