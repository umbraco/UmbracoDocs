# Content Picker Value Converter Example

```csharp
using System;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Core.PropertyEditors;
using Umbraco.Cms.Core.PublishedCache;
using Umbraco.Extensions;

namespace MyConverters;

public class ContentPickerPropertyConverter : IPropertyValueConverter
{
    private readonly IPublishedSnapshotAccessor _publishedSnapshotAccessor;

    //Injecting the PublishedSnapshotAccessor for fetching content
    public ContentPickerPropertyConverter(IPublishedSnapshotAccessor publishedSnapshotAccessor)
    {
        _publishedSnapshotAccessor = publishedSnapshotAccessor;
    }

    public bool IsConverter(IPublishedPropertyType propertyType)
    {
        return propertyType.EditorAlias.Equals("Umbraco.ContentPicker");
    }

    public bool? IsValue(object value, PropertyValueLevel level)
    {
        switch (level)
        {
            case PropertyValueLevel.Source:
                return value != null && (!(value is string) || string.IsNullOrWhiteSpace((string) value) == false);
            default:
                throw new NotSupportedException($"Invalid level: {level}.");
        }
    }

    public Type GetPropertyValueType(IPublishedPropertyType propertyType)
    {
        return typeof(IPublishedContent);
    }

    public PropertyCacheLevel GetPropertyCacheLevel(IPublishedPropertyType propertyType)
    {
        return PropertyCacheLevel.Elements;
    }

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

    public object ConvertIntermediateToObject(IPublishedElement owner, IPublishedPropertyType propertyType, PropertyCacheLevel referenceCacheLevel, object inter, bool preview)
    {
        if (inter == null)
            return null;

        if ((propertyType.Alias != null) == false)
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

    public object ConvertIntermediateToXPath(IPublishedElement owner, IPublishedPropertyType propertyType, PropertyCacheLevel referenceCacheLevel, object inter, bool preview)
    {
        if (inter == null) return null;
        return inter.ToString();
    }
}

<div data-gb-custom-block data-tag="hint" data-style='warning'>

The current implementation of XPath is suboptimal, marked as obsolete, and scheduled for removal in Umbraco 14. The replacement for ContentXPath is [IContentLastChanceFinder](../../implementation/custom-routing/README.md#last-chance-icontentfinder).

</div>

```
