# Property Value Converter full example
This page includes an example of a complete Property Value Converter. The example is that of a Property Value Converter for a Content Picker, where the user picks a node from the Umbraco tree.


{% code title="ContentPickerPropertyConverter.cs" %}

```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Core.PropertyEditors;
using Umbraco.Cms.Core.PublishedCache;

namespace UmbracoDocs.Samples;

// Injecting the IPublishedContentCache for fetching content from the Umbraco cache
public class ContentPickerPropertyConverter(IPublishedContentCache publishedContentCache) : IPropertyValueConverter
{
    // Make sure the Property Value Converter only applies to the Content Picker property editor
    public bool IsConverter(IPublishedPropertyType propertyType)
        => propertyType.EditorAlias.Equals(Constants.PropertyEditors.Aliases.ContentPicker);


    // We consider the value to be a value only when we have the actual IPublishedContent object,
    // meaning that there is a valid picked content item.
    public bool? IsValue(object? value, PropertyValueLevel level)
    {
        return level switch
        {
            PropertyValueLevel.Source => null,
            PropertyValueLevel.Inter => null,
            PropertyValueLevel.Object => value is IPublishedContent,
            _ => throw new ArgumentOutOfRangeException(nameof(level), level, $"Invalid level: {level}.")
        };
    }

    // The type returned by this converter is IPublishedContent
    // And the Models Builder will take care of returning the actual generated type
    public Type GetPropertyValueType(IPublishedPropertyType propertyType)
        => typeof(IPublishedContent);

    // Because we have a reference to another content item, we need to use the Elements cache level,
    // to make sure that changes to the referenced item are detected and the cache invalidated accordingly.
    public PropertyCacheLevel GetPropertyCacheLevel(IPublishedPropertyType propertyType)
        => PropertyCacheLevel.Elements;

    // Converts the source value (string) to an intermediate value (GuidUdi)
    public object? ConvertSourceToIntermediate(IPublishedElement owner, IPublishedPropertyType propertyType, 
        object? source, bool preview)
    {
        if (source is not string { Length: > 0 } stringValue)
            return null;
            
        return UdiParser.TryParse(stringValue, out GuidUdi? guidUdi) ? guidUdi : null;
    }

    // Converts the intermediate value (GuidUdi) to the actual object value (IPublishedContent)
    public object? ConvertIntermediateToObject(IPublishedElement owner, IPublishedPropertyType propertyType,
        PropertyCacheLevel referenceCacheLevel, object? inter, bool preview)
        => inter is GuidUdi guidUdi
            ? publishedContentCache.GetById(guidUdi.Guid)
            : null;
}


```

{% endcode %}
