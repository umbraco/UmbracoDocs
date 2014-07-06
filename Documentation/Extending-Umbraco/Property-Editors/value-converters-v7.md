# Property Value Converters

**Applies to Umbraco 7 and newer**

A property value converter converts a property editors database stored value to another type. The converted value can be accessed from MVC Razor or any other Published Content API. 

Starting with Umbraco v7, property values have multiple levels:

- Data - The raw data stored in the database, this is generally a `String`
- Source - A object of type that is appropriate to the property, e.g. a nodeId should be a `Int` or a collection of nodeId's would be a array of `Int[]`
- Object - The object to be used when accessing the property using a Published Content API e.g. UmbracoHelper `GetPropertyValue<T>` method
- XPath - The object to be used when the property is accessed by XPath, this should generally be a `String` or a `XPathNodeIterator` 

**Note**: XPath is not currently used in Umbraco v7.1.x but it will be in a future version

For example the standard Umbraco Core "Content Picker" stores a nodeId as `String` type. However if you implement a converter it could return a `IPublishedContent` object.

## Implementing the Interface ##

Implement `IPropertyValueConverter` from the `Umbraco.Core` namepsace on your class

## Methods ##

### bool IsConverter(PublishedPropertyType propertyType) ###

This method is called for each PublishedPropertyType (document type property) at application startup. By returning True your value converter will be registered for that property type and your conversion methods will be executed when ever that value is requested. 

Example, checking if the PublishedPropertyType PropertyEditorAlias property is equal to the alias of the core content editor

	public bool IsConverter(PublishedPropertyType propertyType)
	{
	    return propertyType.PropertyEditorAlias.Equals("Umbraco.ContentPickerAlias");
	}

### object ConvertDataToSource(PublishedPropertyType propertyType, object data, bool preview) ###

This method should convert the raw data value into a appropriate type, for example, a nodeId stored as a `String` should be converted to a `Int`. This method returns the "Source".

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
            if (source == null)
            {
                return null;
            }

            if (UmbracoContext.Current != null)
            {
                var umbHelper = new UmbracoHelper(UmbracoContext.Current);
                return umbHelper.TypedContent(source);
            }

            return source;
        }

### object ConvertSourceToXPath(PublishedPropertyType propertyType, object source, bool preview) ###

This method converts the Source to XPath, the return value should generally be of type `String` or `XPathNodeIterator`.

In the example below, we convert the nodeId (converted by ConvertDataToSource) back into a `String`

    public object ConvertSourceToXPath(PublishedPropertyType propertyType, object source, bool preview)
    {
        return source.ToString();
    }

**Note**: This method is not currently requested in Umbraco v7.1.x but it will be in a future version