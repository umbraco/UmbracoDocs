---
versionFrom: 8.0.0
---

# Property Value Converters

**Applies to Umbraco 7 and newer**

A Property Value Converter converts a property editor's database-stored value to another type. The converted value can be accessed from MVC Razor or any other Published Content API. 

For example the standard Umbraco Core "Content Picker" stores a nodeId as `String` type. However if you implement a converter it could return an `IPublishedContent` object.

[From v7 Docs - still valid for v8?]

> Starting with Umbraco v7, published property values have four "Values":
> 
> - **Data** - The raw data stored in the database, this is generally a `String`
> - **Source** - An object of a type that is appropriate to the property, e.g. a nodeId should be an `Int` or a collection of nodeIds would be an integer array, `Int[]`
> - **Object** - The object to be used when accessing the property using a Published Content API, e.g. UmbracoHelper's `GetPropertyValue<T>` method
> - **XPath** - The object to be used when the property is accessed by XPath; This should generally be a `String` or an `XPathNodeIterator`
> 
> **Note**: XPath is not currently used in Umbraco v7.1.x but it will be in a future version


## Implementing the Interface ##

Implement `IPropertyValueConverter` from the `Umbraco.Core` namespace on your class

```csharp
public class ContentPickerPropertyConverter : IPropertyValueConverter
```

## Methods - Information ##

### IsConverter(PublishedPropertyType propertyType) ###

This method is called for each PublishedPropertyType (document type property) at application startup. By returning `True` your value converter will be registered for that property type and your conversion methods will be executed when ever that value is requested. 

Example: Checking if the PublishedPropertyType PropertyEditorAlias property is equal to the alias of the core content editor:

```csharp
public bool IsConverter(PublishedPropertyType propertyType)
{
    return propertyType.PropertyEditorAlias.Equals("Umbraco.ContentPickerAlias");
}
```

### IsValue(object value, PropertyValueLevel level) ###
[Need info about this...]

```csharp
public bool? IsValue(object value, PropertyValueLevel level)
{
    return null;
}
```
### GetPropertyValueType(IPublishedPropertyType propertyType) ###

This is where you can specify the type returned by this Converter. This type will be used by ModelsBuilder to return data from properties using this Converter in the proper type.

Example: Content Picker is being converted to `IPublishedContent`

```csharp
public Type GetPropertyValueType(IPublishedPropertyType propertyType)
{
    return typeof(IPublishedContent);
}
```

###PropertyCacheLevel GetPropertyCacheLevel(IPublishedPropertyType propertyType)###
[Need info about this... There is a code sample for v7 here: https://our.umbraco.com/Documentation/Extending/Property-Editors/value-converters-full-example-interface]
```csharp
public PropertyCacheLevel GetPropertyCacheLevel(IPublishedPropertyType propertyType)
{
    return PropertyCacheLevel.Unknown;
}
```

## Methods - Conversion ##

There are a few different levels of conversion which can occur.
[Need information about when these are used, etc.]

### ConvertSourceToIntermediate(IPublishedElement owner, IPublishedPropertyType propertyType, object source,            bool preview)###

This method should convert the raw data value into an appropriate type, for example, a nodeId stored as a `String` should be converted to an `Int` or `Udi`.  Include a `using Umbraco.Core` to be able to use the `TryConvertTo` extension method.


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

### ConvertIntermediateToObject(IPublishedElement owner, IPublishedPropertyType propertyType, PropertyCacheLevel referenceCacheLevel, object inter, bool preview)###

[This might all be wrong for v8...]
This method converts the Intermediate to an Object, the returned value is used by the `GetPropertyValue<T>` method of `IPublishedContent`. 

The below example converts the nodeId (converted to Int or Udi by ConvertSourceToIntermediate) into an IPublishedContent object.  

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
### ConvertIntermediateToXPath(IPublishedElement owner, IPublishedPropertyType propertyType, PropertyCacheLevel referenceCacheLevel, object inter, bool preview) ###


This method converts the Intermediate to XPath, the return value should generally be of type `String` or `XPathNodeIterator`.

In the example below, we convert the nodeId (converted by ConvertSourceToIntermediate) back into a `String`

```csharp
public object ConvertIntermediateToXPath(IPublishedElement owner, IPublishedPropertyType propertyType, PropertyCacheLevel referenceCacheLevel, object inter, bool preview)
{
    if (inter == null) return null;
    return inter.ToString();
}
```

[Is this true?]

**Note**: This method is not currently requested in Umbraco v7.1.x but it will be in a future version



### Property Value Cache Level ###

[This whole Cache section needs to be updated...]

**Note**: This data is not currently used in Umbraco v7.1.x but it will be by the future "object cache layer" to determine at which level each value returned by the `ConvertDataToSource`, `ConvertSourceToObject` & `ConvertSourceToXPath` methods should be cached.

#### Properties ####

Level - Content (this Published Content), ContentCache (any Published Content), Request, None<br/>
Value - All, Source, Object, XPath

In the example below the Content Picker is being converted to `IPublishedContent` so both the Source and XPath values can be cached at the content level but the Object value can only be cached at the ContentCache level. This is because the picked node may change when it's published and we don't want the converted value to become stale; therefore we should clear it.

#### Class Attribute ####

```csharp
[PropertyValueCache(PropertyCacheValue.Source, PropertyCacheLevel.Content)]
[PropertyValueCache(PropertyCacheValue.Object, PropertyCacheLevel.ContentCache)]
[PropertyValueCache(PropertyCacheValue.XPath, PropertyCacheLevel.Content)]
public class ContentPickerPropertyConverter : IPropertyValueConverter
```

If all values should use the same level you can use the shortcut below

```csharp
[PropertyValueCache(PropertyCacheValue.All, PropertyCacheLevel.ContentCache)]
```

#### Interface ####

```csharp
public PropertyCacheLevel GetPropertyCacheLevel(PublishedPropertyType propertyType, PropertyCacheValue cacheValue)
{
    switch (cacheValue)
    {
        case PropertyCacheValue.Object:
            return PropertyCacheLevel.ContentCache; 

        case PropertyCacheValue.Source:
            return PropertyCacheLevel.Content;

        case PropertyCacheValue.XPath:
            return PropertyCacheLevel.Content;
    }

    return PropertyCacheLevel.None;
}
```

## Samples ##
[Need updated Samples]

[Content Picker to `IPublishedContent` using attribute meta data](value-converters-full-example-attributes.md)

[Content Picker to `IPublishedContent` using `IPropertyValueConverterMeta` interface](value-converters-full-example-interface.md) (Umbraco v7.1.5+)

## Overriding Existing PropertyValueConverters with your Custom Ones ##

Any given PropertyEditor can only utilize a single PropertyValueConverter. If you have a new custom PropertyEditor, just creating the PropertyValueConverter will work, since there isn't already an exisiting Converter for that PropertyEditor. If you are attempting to override one of the standard PropertyValueConverters, however, you will need to take some additional steps to de-register the standard one.

[I tried using this code... but it doesn't seem to actually work, so perhaps someone can verify it]

```csharp
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Core.Logging;
using Umbraco.Web;

public class Startup : IUserComposer
{
    public void Compose(Composition composition)
    {         
        //Swap ContentPicker Value Converter
        composition.PropertyValueConverters().Remove<Umbraco.Web.PropertyEditors.ValueConverters.ContentPickerValueConverter>();
        composition.PropertyValueConverters().Append<MyCustom.ContentValueConverter>();     
    }
}
```
