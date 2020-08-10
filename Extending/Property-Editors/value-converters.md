---
versionFrom: 8.0.0
meta.Title: "Umbraco Property Value Converters"
meta.Description: "A guide to creating a custom property value converter in Umbraco"
---

# Property Value Converters

**Applies to Umbraco 8 and newer**

A Property Value Converter converts a property editor's database-stored value to another type. The converted value can be accessed from MVC Razor or any other Published Content API.

For example the standard Umbraco Core "Content Picker" stores a nodeId as `String` type. However if you implement a converter it could return an `IPublishedContent` object.

Published property values have four "Values":

- **Source** - The raw data stored in the database, this is generally a `String`
- **Intermediate** - An object of a type that is appropriate to the property, e.g. a nodeId should be an `Int` or a collection of nodeIds would be an integer array, `Int[]`
- **Object** - The object to be used when accessing the property using a Published Content API, e.g. UmbracoHelper's `GetPropertyValue<T>` method
- **XPath** - The object to be used when the property is accessed by XPath; This should generally be a `String` or an `XPathNodeIterator`

## Registering PropertyValueConverters

PropertyValueConverters are automatically registered when implementing the interface. Any given PropertyEditor can only utilize a single PropertyValueConverter. 
 
If you are implementing a PropertyValueConverter for a PropertyEditor that doesn't already have one, creating the PropertyValueConverter will automatically enable it and no further actions are needed. 
 
If you are attempting to override an existing PropertyValueConverter (this could be one included with Umbraco or in a package), you will however need to take some additional steps to deregister the existing one to avoid conflicts:

```csharp
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Core.Logging;
using Umbraco.Web;

public class Startup : IUserComposer
{
    public void Compose(Composition composition)
    {
        //If the type is accessible (not internal) you can deregister it by the type:
        composition.PropertyValueConverters().Remove<MyCustom.StandardValueConnector>();

        //If the type is not accessible you will need to locate the instance and then remove it:
        var contentPickerValueConverter = composition.PropertyValueConverters().GetTypes().FirstOrDefault(x => x.Name == "ContentPickerValueConverter");
        if (contentPickerValueConverter != null)
        {
            composition.PropertyValueConverters().Remove(contentPickerValueConverter);
        }
    }
}
```

The built-in PropertyValueConverters included with Umbraco, are currently marked as internal. This means you will not be able to remove them by type since the type isn't accessible outside of the namespace. In order to remove such PropertyValueConverters, you will need to look up the instance by name and then deregister it by the instance. This could be the case for other PropertyValueConverters included by packages as well, depending on the implementation details.

## Implementing the Interface

Implement `IPropertyValueConverter` from the `Umbraco.Core` namespace on your class

```csharp
public class ContentPickerValueConverter : IPropertyValueConverter
```

## Methods - Information

### IsConverter(IPublishedPropertyType propertyType)

This method is called for each PublishedPropertyType (Document Type Property) at application startup. By returning `True` your value converter will be registered for that property type and your conversion methods will be executed whenever that value is requested.

Example: Checking if the IPublishedPropertyType EditorAlias property is equal to the alias of the core content editor.
This check is a string comparison but we recommend creating a constant for it to avoid spelling errors:

```csharp
public bool IsConverter(IPublishedPropertyType propertyType)
{
    return propertyType.EditorAlias.Equals(Constants.PropertyEditors.Aliases.ContentPicker);
}
```

### IsValue(object value, PropertyValueLevel level)

This method is called to determine if the passed-in value is a value, and is of the level specified. There's a basic implementation of this in `PropertyValueConverterBase`.

### GetPropertyValueType(IPublishedPropertyType propertyType)

This is where you can specify the type returned by this Converter. This type will be used by ModelsBuilder to return data from properties using this Converter in the proper type.

Example: Content Picker data is being converted to `IPublishedContent`.

```csharp
public Type GetPropertyValueType(IPublishedPropertyType propertyType)
{
    return typeof(IPublishedContent);
}
```

### PropertyCacheLevel GetPropertyCacheLevel(IPublishedPropertyType propertyType)

Here you specify which level the property value is cached at.

A property value can be cached at the following levels:

- **Unknown** - Default value.
- **Element** - It will be cached until the element itself is modified.
- **Elements** - It will be cached until any element is modified.
- **Snapshot** - It will be cached for the current snapshot - which in most cases is tied to a request, meaning it is for the lifetime of a request.
- **None** - It will never be cached and will need conversion every time.

```csharp
public PropertyCacheLevel GetPropertyCacheLevel(IPublishedPropertyType propertyType)
{
    return PropertyCacheLevel.Elements;
}
```

## Methods - Conversion

There are a few different levels of conversion which can occur.

### ConvertSourceToIntermediate(IPublishedElement owner, IPublishedPropertyType propertyType, object source, bool preview)

This method should convert the raw data value into an appropriate type. For example, a node identifier stored as a `String` should be converted to an `Int` or `Udi`. 

Include a `using Umbraco.Core` to be able to use the `TryConvertTo` extension method.

```csharp
public object ConvertSourceToIntermediate(IPublishedElement owner, IPublishedPropertyType propertyType, object source, bool preview)
{
    if (source == null) return null;

    var attemptConvertInt = source.TryConvertTo<int>();
    if (attemptConvertInt.Success)
        return attemptConvertInt.Result;

    var attemptConvertUdi = source.TryConvertTo<Udi>();
    if (attemptConvertUdi.Success)
        return attemptConvertUdi.Result;

    return null;
}
```

### ConvertIntermediateToObject(IPublishedElement owner, IPublishedPropertyType propertyType, PropertyCacheLevel referenceCacheLevel, object inter, bool preview)

This method converts the Intermediate to an Object. The returned value is used by the `GetPropertyValue<T>` method of `IPublishedContent`. 

The below example converts the nodeId (converted to `Int` or `Udi` by *ConvertSourceToIntermediate*) into an 'IPublishedContent' object.  

```csharp
public object ConvertIntermediateToObject(IPublishedElement owner, IPublishedPropertyType propertyType, PropertyCacheLevel referenceCacheLevel, object inter, bool preview)
{
    if (inter == null)
        return null;

    if ((propertyType.Alias != null && PropertiesToExclude.Contains(propertyType.Alias.ToLower(CultureInfo.InvariantCulture))) == false)
    {
        IPublishedContent content;
        if (inter is int id)
        {
            content = _publishedSnapshotAccessor.PublishedSnapshot.Content.GetById(id);
            if (content != null)
                return content;
        }
        else
        {
            var udi = inter as GuidUdi;
            if (udi == null)
                return null;
            content = _publishedSnapshotAccessor.PublishedSnapshot.Content.GetById(udi.Guid);
            if (content != null && content.ContentType.ItemType == PublishedItemType.Content)
                return content;
        }
    }

    return inter;
}
```

### ConvertIntermediateToXPath(IPublishedElement owner, IPublishedPropertyType propertyType, PropertyCacheLevel referenceCacheLevel, object inter, bool preview)

This method converts the Intermediate to XPath. The return value should generally be of type `String` or `XPathNodeIterator`.

In the example below, we convert the nodeId (converted by ConvertSourceToIntermediate) back into a `String`.

```csharp
public object ConvertIntermediateToXPath(IPublishedElement owner, IPublishedPropertyType propertyType, PropertyCacheLevel referenceCacheLevel, object inter, bool preview)
{
    if (inter == null) return null;
    return inter.ToString();
}
```

## Sample

[Content Picker to `IPublishedContent` using `IPropertyValueConverter` interface](full-examples-value-converters.md)
