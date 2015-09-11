# Property Value Converters

**Applies to Umbraco 7 and newer**

A property value converter converts a property editors database stored value to another type. The converted value can be accessed from MVC Razor or any other Published Content API. 

Starting with Umbraco v7, published property values have four "Values":

- Data - The raw data stored in the database, this is generally a `String`
- Source - A object of type that is appropriate to the property, e.g. a nodeId should be a `Int` or a collection of nodeId's would be a array of `Int[]`
- Object - The object to be used when accessing the property using a Published Content API e.g. UmbracoHelper `GetPropertyValue<T>` method
- XPath - The object to be used when the property is accessed by XPath, this should generally be a `String` or a `XPathNodeIterator` 

**Note**: XPath is not currently used in Umbraco v7.1.x but it will be in a future version

For example the standard Umbraco Core "Content Picker" stores a nodeId as `String` type. However if you implement a converter it could return a `IPublishedContent` object.

## Implementing the Interface ##

Implement `IPropertyValueConverter` from the `Umbraco.Core` namespace on your class

	public class ContentPickerPropertyConverter : IPropertyValueConverter

## Methods ##

### bool IsConverter(PublishedPropertyType propertyType) ###

This method is called for each PublishedPropertyType (document type property) at application startup. By returning True your value converter will be registered for that property type and your conversion methods will be executed when ever that value is requested. 

Example, checking if the PublishedPropertyType PropertyEditorAlias property is equal to the alias of the core content editor

	public bool IsConverter(PublishedPropertyType propertyType)
	{
	    return propertyType.PropertyEditorAlias.Equals("Umbraco.ContentPickerAlias");
	}

### object ConvertDataToSource(PublishedPropertyType propertyType, object data, bool preview) ###

This method should convert the raw data value into a appropriate type, for example, a nodeId stored as a `String` should be converted to a `Int`. This method returns the "Source".  Include a `using Umbraco.Core` to be able to use the TryConvertTo extension method.

    public object ConvertDataToSource(PublishedPropertyType propertyType, object data, bool preview)
    {
        var attemptConvertInt = data.TryConvertTo<int>();
        if (attemptConvertInt.Success)
        {
            return attemptConvertInt.Result;
        }

        return null;
    }

### object ConvertSourceToObject(PublishedPropertyType propertyType, object source, bool preview) ###

This method converts the Source to a Object, the returned value is used by the `GetPropertyValue<T>` method of `IPublishedContent`. 

The below example converts the nodeId (converted to Int by ConvertDataToSource) into a IPublishedContent object using the UmbracoHelper TypedContent method.  

	public object ConvertSourceToObject(PublishedPropertyType propertyType, object source, bool preview)
	{
	    if (source == null || UmbracoContext.Current == null) // add using Umbraco.Web
	    {
	        return null;
	    }
	
	    var umbHelper = new UmbracoHelper(UmbracoContext.Current);
	    return umbHelper.TypedContent(source);
	}

### object ConvertSourceToXPath(PublishedPropertyType propertyType, object source, bool preview) ###

This method converts the Source to XPath, the return value should generally be of type `String` or `XPathNodeIterator`.

In the example below, we convert the nodeId (converted by ConvertDataToSource) back into a `String`

    public object ConvertSourceToXPath(PublishedPropertyType propertyType, object source, bool preview)
    {
        return source.ToString();
    }

**Note**: This method is not currently requested in Umbraco v7.1.x but it will be in a future version

## Meta Data ##

There are two options for implementing the meta data for a value converter, the first method is to use class attributes and the second is to implement the `IPropertyValueConverterMeta` interface, this is only available in Umbraco **v7.1.5+**

### Property Value Type ###

This meta property is used by the `IPublishedContentModelFactory` to report the CLR type of the `PublishedPropertyType` returned by the `ConvertSourceToObject` method.

In the example below the Content Picker is being converted to `IPublishedContent`

#### Class Attribute ####

	[PropertyValueType(typeof(IPublishedContent))]
	public class ContentPickerPropertyConverter : IPropertyValueConverter

#### Interface ####

    public Type GetPropertyValueType(PublishedPropertyType propertyType)
    {
        return typeof(IPublishedContent);
    }

### Property Value Cache Level ###

**Note**: This data is not currently used in Umbraco v7.1.x but it will be by the future "object cache layer" to determine at which level each value returned by the `ConvertDataToSource`, `ConvertSourceToObject` & `ConvertSourceToXPath` methods should be cached at.

#### Properties ####

Level - Content (this Published Content), ContentCache (any Published Content), Request, None<br/>
Value - All, Source, Object, XPath

In the example below the Content Picker is being converted to `IPublishedContent` so both the Source and XPath values can be cached at the content level but the Object value can only be cached at the ContentCache level. This is because the picked node may change when it's published and we don't want the converted value to become stale therefore we should clear it.

#### Class Attribute ####

    [PropertyValueCache(PropertyCacheValue.Source, PropertyCacheLevel.Content)]
    [PropertyValueCache(PropertyCacheValue.Object, PropertyCacheLevel.ContentCache)]
    [PropertyValueCache(PropertyCacheValue.XPath, PropertyCacheLevel.Content)]
    public class ContentPickerPropertyConverter : IPropertyValueConverter

If all values should use the same level you can use the short cut below

    [PropertyValueCache(PropertyCacheValue.All, PropertyCacheLevel.ContentCache)]

#### Interface ####

    public PropertyCacheLevel GetPropertyCacheLevel(PublishedPropertyType propertyType, PropertyCacheValue cacheValue)
    {
        PropertyCacheLevel returnLevel;
        switch (cacheValue)
        {
            case PropertyCacheValue.Object:
                returnLevel = PropertyCacheLevel.ContentCache; 
                break;
            case PropertyCacheValue.Source:
                returnLevel = PropertyCacheLevel.Content;
                break;
            case PropertyCacheValue.XPath:
                returnLevel = PropertyCacheLevel.Content;
                break;
            default:
                returnLevel = PropertyCacheLevel.None;
                break;
        }

## Samples ##

[Content Picker to `IPublishedContent` using attribute meta data](value-converters-v7-full-example-attributes.md)

[Content Picker to `IPublishedContent` using `IPropertyValueConverterMeta` interface](value-converters-v7-full-example-interface.md) (Umbraco v7.1.5+)
