---
description: Configuring searchable properties in Konstrukt, the backoffice UI builder for Umbraco.
---

# Searchable Properties

Searchable properties allow you to define any `String` based properties on a model that should be searchable via Konstrukt list view and entity picker search controls. 

![Search](../images/search.png)

## Defining searchable properties

#### **AddSearchableProperty(Lambda searchablePropertyExpression) : KonstruktCollectionConfigBuilder&lt;TEntityType&gt;**

Adds the given property to the searchable properties collection. 

````csharp
// Example
collectionConfig.AddSearchableProperty(p => p.FirstName);
````