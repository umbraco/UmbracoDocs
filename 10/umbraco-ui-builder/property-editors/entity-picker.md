---
description: Using the entity picker property editor with Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Entity Picker

The Entity Picker property editor is an Umbraco property editor that lets you select one or more entities from a Konstrukt collection.

## Configuring an entity picker

To configure an entity picker you'll want to create a Data Type in the Umbraco backoffice choosing 'Konstrukt Entity Picker' from the property editor dropdown.

![Datatype config](../../images/entity_picker_config.png)

From there choose the 'Section' and then 'Collection' you'd like to pick entities from, as well as an optional list view 'Data View' if there are any configured.

You can also set a minimum and maximum number of items to be able to pick if required.

With an entity picker Data Type defined, finish off the configuration by adding it to the desired Document Type definition.

![Doctype config](../../images/entity_picker_setup.png) 

## Using an entity picker

Using the entity picker should be pretty familiar as it aims to mimic the content picker as closely as possible.

To pick an entity click the 'Add' link to launch the picker dialog. The dialog should present a paginated list of entities to pick from. If any searchable fields have been configured for the entity type, you can also perform a search by typing a search term in the search input field.

![Entity picker dialog](../../images/entity_picker_search.png) 

To pick your items simply click on the entity names and then click 'Select' in the bottom right hand corner.

The picker should display a summary of the selected entities and can be sorted by dragging the selected entities into the desired order.

![Entity picker values](../../images/entity_picker_picked.png) 

To save the value either save or save and publish the current document.

## Getting the value of an entity picker
 
The entity picker property editor comes with a built in [value converter](https://our.umbraco.org/documentation/extending/property-editors/value-converters) meaning that whenever you retrieve the property value from Umbraco it will return the actual selected entities, even converting them to the relevant type.

````csharp
// Example
foreach(var p in Model.People){
    ...
}
````
