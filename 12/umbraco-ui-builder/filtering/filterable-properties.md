---
description: Configuring filterable properties in Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Filterable Properties

Umbraco UI Builder can dynamically build a filter dialog choosing appropriate editor views for you based on a basic property configuration. Properties of a number or date types will become range pickers and enums. Properties with options defined will become select/checkbox lists and all other properties will become text input filters.

![Filterable Properties](../images/filterable_properties.png)

## Defining filterable properties

Defining filterable properties is controlled via the [collections](../collections/overview.md) configuration.

### **AddFilterableProperty(Lambda filterablePropertyExpression, Lambda filterConfig = null) : CollectionConfigBuilder&lt;TEntityType&gt;**

Adds the given property to the filterable properties collection.

````csharp
// Example
collectionConfig.AddFilterableProperty(p => p.FirstName, filterConfig => filterConfig 
    // ...
);
````

## Changing the label of a filterable property

### **SetLabel(string label) : FilterablePropertyConfigBuilder&lt;TEntityType, TValueType&gt;**

````csharp
// Example
filterConfig.SetLabel("First Name");
````

## Adding a description to a filterable property

### **SetDescription(string description) : FilterablePropertyConfigBuilder&lt;TEntityType, TValueType&gt;**

````csharp
// Example
filterConfig.SetDescription("The first name of the person");
````

## Defining basic options for a filterable property

### **SetOptions(IDictionary&lt;TValueType, string&gt; options) : FilterablePropertyConfigBuilder&lt;TEntityType, TValueType&gt;**

````csharp
// Example
filterConfig.SetOptions(new Dictionary<string, string> {
    { "Option1", "Option One" },
    { "Option2", "Option Two" }
});
````

## Defining options with custom compare clauses for a filterable property

### **AddOption(object key, string label, Lambda compareExpression) : FilterablePropertyConfigBuilder&lt;TEntityType, TValueType&gt;**

````csharp
// Example
filterConfig.AddOption("Option1", "Option One", (val) => val != "Option Two");
````

## Configuring the mode of a filterable property

For filterable properties with options you can configure whether the options should be multiple or single choice.

### **SetMode(FilterMode mode) : FilterablePropertyConfigBuilder&lt;TEntityType, TValueType&gt;**

````csharp
// Example
filterConfig.SetMode(FilterMode.MultipleChoice);
````
