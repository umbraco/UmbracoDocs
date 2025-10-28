---
description: A guide to creating a custom property value converter in Umbraco
---

# Property Value Converters

A Property Value Converter converts a property editor's database-stored value to another type. The converted value can be accessed from MVC Razor or any other Published Content API.

For example the standard Umbraco Core "Content Picker" stores a nodeId as `String` type. However if you implement a converter it could return an `IPublishedContent` object.

Published property values have four "Values":

* **Source** - The raw data stored in the database, this is generally a `String`
* **Intermediate** - An object of a type that is appropriate to the property, for example a nodeId should be an `Int` or a collection of nodeIds would be an integer array, `Int[]`
* **Object** - The object to be used when accessing the property using a Published Content API, for example UmbracoHelper's `GetPropertyValue<T>` method
* **XPath** - The object to be used when the property is accessed by XPath; This should generally be a `String` or an `XPathNodeIterator`

{% hint style="warning" %}
The current implementation of XPath is suboptimal, marked as obsolete, and scheduled for removal in Umbraco 14. The replacement for ContentXPath is [IContentLastChanceFinder](../../implementation/custom-routing/#last-chance-icontentfinder).
{% endhint %}

## Registering PropertyValueConverters

PropertyValueConverters are automatically registered when implementing the interface. Any given PropertyEditor can only utilize a single PropertyValueConverter.

If you are implementing a PropertyValueConverter for a PropertyEditor that doesn't already have one, creating the PropertyValueConverter will automatically enable it. No further actions are needed.

If you aim to override an existing PropertyValueConverter, possibly from Umbraco or a package, additional steps are necessary. Deregister the existing one to prevent conflicts in this scenario.

```csharp
using System.Linq;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;

public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        //If the type is accessible (not internal) you can deregister it by the type:
        builder.PropertyValueConverters().Remove<MyCustom.StandardValueConnector>();

        //If the type is not accessible you will need to locate the instance and then remove it:
        var contentPickerValueConverter = builder.PropertyValueConverters().GetTypes().FirstOrDefault(x => x.Name == "ContentPickerValueConverter");
        if (contentPickerValueConverter != null)
        {
            builder.PropertyValueConverters().Remove(contentPickerValueConverter);
        }
    }
}
```

The built-in PropertyValueConverters included with Umbraco, are currently marked as internal. This means you will not be able to remove them by type since the type isn't accessible outside of the namespace. In order to remove such PropertyValueConverters, you will need to look up the instance by name and then deregister it by the instance. This could be the case for other PropertyValueConverters included by packages as well, depending on the implementation details.

## Implementing the Interface

Implement `IPropertyValueConverter` from the `Umbraco.Cms.Core.PropertyEditors` namespace on your class

```csharp
public class ContentPickerValueConverter : IPropertyValueConverter
```

## Methods - Information

### IsConverter(IPublishedPropertyType propertyType)

This method is called for each PublishedPropertyType (Document Type Property) at application startup. By returning `True` your value converter will be registered for that property type and your conversion methods will be executed whenever that value is requested.

Example: Checking if the IPublishedPropertyType EditorAlias property is equal to the alias of the core content editor.\
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

#### `PropertyCacheLevel.Unknown`

Do not use this cache level unless you know exactly what you're doing. We recommend using the `PropertyCacheLevel.Element` level.

#### `PropertyCacheLevel.Element`

The property value will be cached until its _element_ is modified. The element is what holds (or owns) the property. For example:

* For properties used at the page level, the element is the entire page.
* For properties contained within Block List items, the element is the individual Block List item.

This is the most commonly used cache level and should be your default, unless you have specific reasons to do otherwise.

#### `PropertyCacheLevel.Elements`

The property value will be cached until _any_ element (see above) is changed. This means that any change to any page will clear the property value cache.

This is particularly useful for property values that contain references to other content or elements. For example, this cache level is utilized by the Content Picker to clear its property values from the cache upon content updates.

#### `PropertyCacheLevel.Snapshot`

The property value will only be cached for the duration of the current _snapshot_.

A snapshot represents a point in time. For example, a snapshot is created for every content request from the frontend. When accessing a property in a snapshot using this cache level, it gets converted, cached throughout the snapshot, and later cleared.

For all intents and purposes, think of this cache level as "per request". If your property value should _only_ be cached per request, this is the cache level you should use. Use it with caution, as the added property conversions incur a performance penalty.

#### `PropertyCacheLevel.None`

The property value will _never_ be cached. Every time a property value is accessed (even within the same snapshot) property conversion is performed explicitly.

Use this cache level with extreme caution, as it incurs a massive performance penalty.

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

Include a `using Umbraco.Extensions;` to be able to use the `TryConvertTo` extension method.

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

The below example converts the nodeId (converted to `Int` or `Udi` by _ConvertSourceToIntermediate_) into an 'IPublishedContent' object.

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

{% hint style="warning" %}
The current implementation of XPath is suboptimal, marked as obsolete, and scheduled for removal in Umbraco 14. The replacement for ContentXPath is [IContentLastChanceFinder](../../implementation/custom-routing/#last-chance-icontentfinder).
{% endhint %}

## Sample

[Content Picker to `IPublishedContent` using `IPropertyValueConverter` interface](full-examples-value-converters.md)
