# Content Picker Value Converter Example

{% code title="ContentPickerPropertyConverter.cs" %}
```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Core.PropertyEditors;
using Umbraco.Cms.Core.PublishedCache;

namespace UmbracoDocs.Samples;

public class ContentPickerPropertyConverter : IPropertyValueConverter
{
    private readonly IPublishedSnapshotAccessor _publishedSnapshotAccessor;

    // Injecting the PublishedSnapshotAccessor for fetching content
    public ContentPickerPropertyConverter(IPublishedSnapshotAccessor publishedSnapshotAccessor)
        => _publishedSnapshotAccessor = publishedSnapshotAccessor;

    public bool IsConverter(IPublishedPropertyType propertyType)
        => propertyType.EditorAlias.Equals("Umbraco.ContentPicker");

    public bool? IsValue(object? value, PropertyValueLevel level)
    {
        return level switch
        {
            PropertyValueLevel.Source => value is string stringValue && string.IsNullOrWhiteSpace(stringValue) is false,
            _ => throw new NotSupportedException($"Invalid level: {level}.")
        };
    }

    public Type GetPropertyValueType(IPublishedPropertyType propertyType)
        => typeof(IPublishedContent);

    public PropertyCacheLevel GetPropertyCacheLevel(IPublishedPropertyType propertyType)
        => PropertyCacheLevel.Elements;

    public object? ConvertSourceToIntermediate(IPublishedElement owner, IPublishedPropertyType propertyType, object? source, bool preview)
        // parse the source string to a GuidUdi intermediate value
        => source is string stringValue && UdiParser.TryParse(stringValue, out GuidUdi? guidUdi)
            ? guidUdi
            : null;

    public object? ConvertIntermediateToObject(IPublishedElement owner, IPublishedPropertyType propertyType, PropertyCacheLevel referenceCacheLevel, object? inter, bool preview)
        // inter is expected to be a GuidUdi at this point (see ConvertSourceToIntermediate)
        => inter is GuidUdi guidUdi
            ? _publishedSnapshotAccessor.GetRequiredPublishedSnapshot().Content?.GetById(guidUdi.Guid)
            : null;
}
```
{% endcode %}
