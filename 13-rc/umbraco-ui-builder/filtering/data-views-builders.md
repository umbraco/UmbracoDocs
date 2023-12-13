---
description: Configuring data views builders in Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Data Views Builders

Data views builders allow you to create a collection data views list dynamically at run time. By default, Umbraco UI Builder will use the hard-coded data views defined in your Umbraco UI Builder config. However, if you need to build your data views list dynamically, then this is when you'd use a data views builder.

When Umbraco UI Builder resolves a data views builder it will attempt to do so from the global DI container. This means you can inject any dependencies that you require for your builder. If there is no type defined in the DI container, Umbraco UI Builder will fall-back to manually instantiating a new instance of value mapper.

## Defining a data views builder

To define a data views builder you can create a class that inherits from the base class `DataViewsBuilder<TEntityType>` and implements the abstract methods.

````csharp
// Example
public class PersonDataViewsBuilder : DataViewsBuilder<Person>
{
    public override IEnumerable<DataViewSummary> GetDataViews()
    {
        // Generate and return a list of data views
    }

    public override Expression<Func<Person, bool>> GetDataViewWhereClause(string dataViewAlias)
    {
        // Return a where clause expression for the supplied data view alias
    }
}
````

The required methods are:

* **GetDataViews:** Returns the list of data views to choose from.
* **GetDataViewWhereClause:** Returns the boolean **where clause** expression for the given data views alias.

## Setting the data views builder of a collection

Setting a data views builder is controlled via the [collections](../collections/overview.md) configuration.

### **SetDataViewsBuilder&lt;TDataViewsBuilder&gt;() : CollectionConfigBuilder&lt;TEntityType&gt;**

Sets the collections data views builder which allows you to define the data views dynamically at run time.

````csharp
// Example
collectionConfig.SetDataViewsBuilder<PersonDataViewsBuilder>();
````

### **SetDataViewsBuilder(Type dataViewsBuilderType) : CollectionConfigBuilder&lt;TEntityType&gt;**

Sets the collections data views builder which allows you to define the data views dynamically at run time.

````csharp
// Example
collectionConfig.SetDataViewsBuilder(typeof(PersonDataViewsBuilder));
````

### **SetDataViewsBuilder(DataViewsBuilder&lt;TEntityType&gt; dataViewsBuilder) : CollectionConfigBuilder&lt;TEntityType&gt;**

Sets the collections data views builder which allows you to define the data views dynamically at run time.

````csharp
// Example
collectionConfig.SetDataViewsBuilder(new PersonDataViewsBuilder());
````
