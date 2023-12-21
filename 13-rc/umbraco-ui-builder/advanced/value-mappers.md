---
description: Configuring value mappers in Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Value Mappers

A value mapper is an Umbraco UI Builder helper class that sits between the editor UI and the database. It also lets you tweak the stored value of a field. By default Umbraco UI Builder will save a datatype value as it would be stored in Umbraco. Value mappers let you change this.

When Umbraco UI Builder resolves a value mapper it will attempt to do so from the global DI container. This means you can inject any dependencies that you require for your mapper. If there is no type defined in the DI container, Umbraco UI Builder will fall-back to manually instantiating a new instance of value mapper.

## Defining a value mapper

To define a mapper create a class that inherits from the base class `ValueMapper` and implements the methods `EditorToModel` and `ModelToEditor`.

````csharp
// Example
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

## Setting a field value mapper

Value mappers are defined as part of a collection editor field configuration.

### **SetValueMapper&lt;TMapperType&gt;() : EditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Set the value mapper for the current field.

````csharp
// Example
fieldConfig.SetValueMapper<MyValueMapper>();
````

### **SetValueMapper(Type mapperType) : EditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Set the value mapper for the current field.

````csharp
// Example
fieldConfig.SetValueMapper(typeof(MyValueMapper));
````

### **SetValueMapper(Mapper mapper) : EditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Set the value mapper for the current field.

````csharp
// Example
fieldConfig.SetValueMapper(new MyValueMapper());
````
