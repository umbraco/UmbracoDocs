---
description: A guide to creating a Custom Property Value Converter in Umbraco
---

# Property Value Converters

A Property Value Converter converts a property editor's database-stored value into another type that is stored in the Umbraco cache. This way, the database stores only essential data. Razor views, the Published Content API, and the Content Delivery API use strongly typed, cleaner models.

For example, a Content Picker stores the Key of the picked node in the database. When reading published data, Umbraco returns an IPublishedContent object instead of the Key. This conversion is done by a Property Value Converter.

A Property Value Converter has three conversion levels:
* **Source** - The raw data stored in the database; this is generally a `string`.
* **Intermediate** - An object of a type that is appropriate to the property. For example, a node Key should be a `Guid`, or a collection of node Keys would be a `Guid[]`.
* **Object** - The object to be used when accessing the property using the Published Content API; for example, the object returned by the `IPublishedContent.Value<T>(alias)` method. Also, the Models Builder generates a property of the type of the object.

## Create a Property Value Converter
A class becomes a Property Value Converter when it implements the `IPropertyValueConverter` interface from the `Umbraco.Cms.Core.PropertyEditors` namespace. Property Value Converters are automatically registered when implementing the interface. Any given PropertyEditor can only utilize a single Property Value Converter.

```csharp
public class ContentPickerValueConverter : IPropertyValueConverter
```

{% hint style="info" %}
Consider using the `PropertyValueConverterBase` class as the base of your Property Value Converter instead of the `IPropertyValueConverter` interface. The `PropertyValueConverterBase` class comes with a default implementation of `IPropertyValueConverter`, so you only have to override the methods you need to change. In contrast, if you use the `IPropertyValueConverter`, you are responsible for implementing all methods yourself. In this document, it is assumed that you are using the `IPropertyValueConverter`, so methods are covered.
{% endhint %}

The `IPropertyValueConverter` interface exposes the following methods you need to implement:

## Implement information methods
Implement the following methods, which provide Umbraco with context about the Property Value Converter.

### `IsConverter(IPublishedPropertyType propertyType)`

This method is called for each `PublishedPropertyType` (Document Type Property) at Umbraco startup. By returning `true`, your value converter will be registered for that property type. Umbraco then executes your conversion methods whenever that value is requested.

Example: Checking if the `IPublishedPropertyType.EditorAlias` property is equal to the alias of the core content editor.\
This check is a string comparison but we recommend creating a constant for it to avoid spelling errors:

```csharp
public bool IsConverter(IPublishedPropertyType propertyType)
{
    return propertyType.EditorAlias.Equals(Constants.PropertyEditors.Aliases.ContentPicker);
}
```

### `IsValue(object value, PropertyValueLevel level)`
The `IsValue` method determines whether a property contains a meaningful value or should be considered "empty" at different stages of the value conversion process. This method is essential for Umbraco's `property.HasValue()` method.

{% hint style="info" %}
There's a basic implementation of this method in `PropertyValueConverterBase` that's good enough for most scenarios.
{% endhint %}

When Umbraco needs to check if a property has a valid value, it calls IsValue progressively through three conversion levels until one returns true. They are called in the order of Source > Inter > Object. This allows you to choose at what stage of the conversion you need to perform the validation to get the best results. Consider these scenarios:

```csharp
//If value is a simple string, it's enough to just check if string is null or empty
//This is the default implementation in PropertyValueConverterBase
public bool? IsValue(object? value, PropertyValueLevel level)
{
    switch (level)
    {
        case PropertyValueLevel.Source:
            return value != null && (!(value is string stringValue) || !string.IsNullOrWhiteSpace(stringValue));
        case PropertyValueLevel.Inter:
            return null;
        case PropertyValueLevel.Object:
            return null;
        default:
            throw new NotSupportedException($"Invalid level: {level}.");
    }
}

//If the value is numeric, it's usually not enough to check if the raw string value is null
//or empty, but also to check if the value is a valid int and if it doesn't contain the default value
public bool? IsValue(object? value, PropertyValueLevel level)
{
    switch (level)
    {
        case PropertyValueLevel.Source:
            return null;
        case PropertyValueLevel.Inter:
            return value is int intValue && intValue > 0;
        case PropertyValueLevel.Object:
            return null;
        default:
            throw new NotSupportedException($"Invalid level: {level}.");
    }
}

//If the value is a complex object, you can consider checking
//the object level
public bool? IsValue(object? value, PropertyValueLevel level)
{
        switch (level)
    {
        case PropertyValueLevel.Source:
            return null;
        case PropertyValueLevel.Inter:
            return null;
        case PropertyValueLevel.Object:
            return value is ComplexObject objectValue && objectValue.SomeProperty == "value";
        default:
            throw new NotSupportedException($"Invalid level: {level}.");
    }
}
```

### `GetPropertyValueType(IPublishedPropertyType propertyType)`

This is where you can specify the type returned by this converter. This type will be used by Models Builder to return data from properties using this converter in the proper type.

Example: Content Picker data is being converted to `IPublishedContent`.

```csharp
public Type GetPropertyValueType(IPublishedPropertyType propertyType)
{
    return typeof(IPublishedContent);
}
```

### `GetPropertyCacheLevel(IPublishedPropertyType propertyType)`

Here you specify which level the property value is cached at.

A property value can be cached at the following levels:

#### `PropertyCacheLevel.Element`
This is the most commonly used cache level and should be your default, unless you have specific reasons to do otherwise.

The property value will be cached until its _element_ is modified. The element is what holds (or owns) the property. For example:

* For properties used at the page level, the element is the entire page.
* For properties contained within Block List items, the element is the individual Block List item.

#### `PropertyCacheLevel.Elements`

The property value will be cached until _any_ element (see above) is changed. This means that any change to any page will clear the property value cache.

This is particularly useful for property values that contain references to other content or elements. For example, this cache level is utilized by the Content Picker to clear its property values from the cache upon content updates.

#### `PropertyCacheLevel.None`

The property value will _never_ be cached. Every time a property value is accessed (even within the same snapshot) property conversion is performed explicitly.

{% hint style="danger" %}
Use this cache level with extreme caution, as it incurs a massive performance penalty.
{% endhint %}

#### `PropertyCacheLevel.Unknown`

Do not use this cache level as it is a default fallback for the `PropertyCacheLevel` enum. It will throw an error when used.

```csharp
public PropertyCacheLevel GetPropertyCacheLevel(IPublishedPropertyType propertyType)
{
    return PropertyCacheLevel.Elements;
}
```

## Implement conversion methods
Implement the methods that perform the conversion from a raw database value to an intermediate value and then to the final type. Conversions happen in two steps.

### `ConvertSourceToIntermediate(IPublishedElement owner, IPublishedPropertyType propertyType, object source, bool preview)`
This method converts the raw data value into an appropriate intermediate type that is needed for the final conversion step to an object.
For example:
- A basic text property likely stores its data as a `string`, so that can be converted to a `string` intermediate value.
- A Content Picker stores the node identifier (`Udi`) as a `string`. To return `IPublishedContent`, the final conversion step needs a `Udi` instead. So in the intermediate step, check if the `string` value is a valid `Udi` and convert the `string` to a `Udi` as the intermediate value.

```csharp
// Basic text property example of intermediate conversion
public object ConvertSourceToIntermediate(IPublishedElement owner, IPublishedPropertyType propertyType, object source, bool preview)
{
    return source as string;
}
```

```csharp
// Converting the source value (string) to an intermediate value (GuidUdi)
public object? ConvertSourceToIntermediate(IPublishedElement owner, IPublishedPropertyType propertyType, 
	object? source, bool preview)
{
	if (source is not string { Length: > 0 } stringValue)
		return null;
		
	return UdiParser.TryParse(stringValue, out GuidUdi? guidUdi) ? guidUdi : null;
}
```

### `ConvertIntermediateToObject(IPublishedElement owner, IPublishedPropertyType propertyType, PropertyCacheLevel referenceCacheLevel, object inter, bool preview)`

This method converts the intermediate value to an object of the type specified in the `GetPropertyValueType()` method of the Property Value Converter. The returned value is used by the `GetPropertyValue<T>` method of `IPublishedContent`.

The example below converts the node `GuidUdi` into an `IPublishedContent` object.

```csharp
// Converts the intermediate value (GuidUdi) to the actual object value (IPublishedContent)
public object? ConvertIntermediateToObject(IPublishedElement owner, IPublishedPropertyType propertyType, PropertyCacheLevel referenceCacheLevel, object? inter, bool preview)
    => inter is GuidUdi guidUdi
        ? publishedContentCache.GetById(guidUdi.Guid)
        : null;
```

## Override existing Property Value Converters
To override an existing Property Value Converter, either from Umbraco or a package, additional steps are required. Deregister the existing one to prevent conflicts.

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
        var contentPickerValueConverter = builder.PropertyValueConverters().GetTypes()
            .FirstOrDefault(converter => converter.Name == "ContentPickerValueConverter");

        if (contentPickerValueConverter != null)
        {
            builder.PropertyValueConverters().Remove(contentPickerValueConverter);
        }
    }
}
```

## Full example

[Content Picker to `IPublishedContent` using `IPropertyValueConverter` interface](full-examples-value-converters.md)
