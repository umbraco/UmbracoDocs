---
description: Learn how to configure data views builders in Umbraco UI Builder.
---

# Data Views Builders

Data views builders allow you to create a collection’s data views dynamically at runtime. By default, Umbraco UI Builder uses hard-coded data views from the configuration. However, if you need to generate data views dynamically, a data views builder is required.

When resolving a data views builder, Umbraco UI Builder first attempts to retrieve it from the global Dependency Injection (DI) container. This allows injecting required dependencies into the builder. If no type is defined in the DI container, Umbraco UI Builder falls back to manually instantiating a new instance of the value mapper.

## Defining a Data Views Builder

To define a data views builder, create a class that inherits from `DataViewsBuilder<TEntityType>` and implements the required abstract methods.

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

## Setting the Data Views Builder of a Collection

Setting a data views builder is controlled via the [Collections](../collections/overview.md) settings.

### Using the `SetDataViewsBuilder()` Method

Sets the collection's data views builder, allowing you to define data views dynamically at runtime.

#### Method Syntax

```cs
SetDataViewsBuilder<TDataViewsBuilder>() : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.SetDataViewsBuilder<PersonDataViewsBuilder>();
````

### Using the `SetDataViewsBuilder(Type)` Method

Sets the collection's data views builder, allowing you to define data views dynamically at runtime.

#### Method Syntax

```cs
SetDataViewsBuilder(Type dataViewsBuilderType) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.SetDataViewsBuilder(typeof(PersonDataViewsBuilder));
````

### Using the `SetDataViewsBuilder(DataViewsBuilder<TEntityType>)` Method

Sets the collection's data views builder, allowing you to define data views dynamically at runtime.

#### Method Syntax

```cs
SetDataViewsBuilder(DataViewsBuilder<TEntityType> dataViewsBuilder) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.SetDataViewsBuilder(new PersonDataViewsBuilder());
````
