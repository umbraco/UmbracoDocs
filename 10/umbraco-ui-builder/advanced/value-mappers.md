---
description: Configuring value mappers in Konstrukt, the back office UI builder for Umbraco.
---

# Value Mappers

A value mapper is a little Konstrukt helper class that sits between the editor UI and the database and lets you tweak the stored value of a field. By default Konstrukt will save a datatypes value is it would be stored in Umbraco. Value mappers let you change this. 

When Konstrukt resolves a value mapper it will attempt to do so from the global DI container which means you can inject amy dependencies that you require for your mapper. If there is no such type defined in the DI container, Konstrukt will then fallback to maually instantiating a new instance of the value mapper.

## Defining a value mapper

To define a mapper you create a class that inherits from the base class `KonstruktValueMapper` and implements the methods `EditorToModel` and `ModelToEditor`.

````csharp
// Example
public class MyValueMapper : KonstruktValueMapper
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

#### **SetValueMapper&lt;TMapperType&gt;() : KonstruktEditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Set the value mapper for the current field.

````csharp
// Example
fieldConfig.SetValueMapper<MyValueMapper>();
````

#### **SetValueMapper(Type mapperType) : KonstruktEditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Set the value mapper for the current field. 

````csharp
// Example
fieldConfig.SetValueMapper(typeof(MyValueMapper));
````

#### **SetValueMapper(KonstruktMapper mapper) : KonstruktEditorFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Set the value mapper for the current field.

````csharp
// Example
fieldConfig.SetValueMapper(new MyValueMapper());
````