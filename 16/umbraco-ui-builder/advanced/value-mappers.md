---
description: Configuring value mappers in Umbraco UI Builder to modify how data is stored and retrieved.
---

# Value Mappers

Value mappers in Umbraco UI Builder act as intermediaries between the editor UI and the database, allowing customization of stored field values. By default, Umbraco UI Builder saves data as it would be stored in Umbraco, but value mappers enable modifications.

When resolving a value mapper, Umbraco UI Builder first checks the global DI container. If no type is defined, it manually instantiates a new instance.

## Defining a Value Mapper

To define a mapper, create a class that inherits from the base class `ValueMapper` and implements the `EditorToModel` and `ModelToEditor` methods.

### Example

````csharp
public class MyValueMapper : ValueMapper
{
    public override object EditorToModel(object input)
    {
        // Tweak the input and return mapped object
        ...
    }

    public override object ModelToEditor(object input)
    {
        // Tweak the input and return mapped object
        ...
    }    
}
````

## Setting a Field Value Mapper

Value mappers are defined as part of a collection editor field configuration.

### Using the `SetValueMapper()` Method

Set the value mapper for the current field.

#### Method Syntax

```csharp
SetValueMapper<TMapperType>() : EditorFieldConfigBuilder<TEntityType, TValueType>
```

#### Example

````csharp
fieldConfig.SetValueMapper<MyValueMapper>();
````

### Using the `SetValueMapper(Type mapperType)` Method

Set the value mapper for the current field using a type reference.

#### Method Syntax

```csharp
SetValueMapper(Type mapperType) : EditorFieldConfigBuilder<TEntityType, TValueType>
```

#### Example

````csharp
fieldConfig.SetValueMapper(typeof(MyValueMapper));
````

### Using the `SetValueMapper(Mapper mapper)` Method

Set the value mapper for the current field using an instance.

#### Method Syntax

```csharp
SetValueMapper(Mapper mapper) : EditorFieldConfigBuilder<TEntityType, TValueType>
```

#### Example

````csharp
fieldConfig.SetValueMapper(new MyValueMapper());
````
