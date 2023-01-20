---
versionFrom: 8.0.0
versionTo: 8.1.0
meta.RedirectLink: "https://docs.umbraco.com/umbraco-cms/fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/media-picker"
---

# Media Picker

`Alias: Umbraco.MediaPicker`

`Returns: IEnumerable<IPublishedContent>` or `IPublishedContent`

This property editors returns a single item if the "Pick multiple items" data type setting is disabled or a collection if it is enabled.

## Data Type Definition Example

![Media Picker Data Type Definition](images/Media-Picker-DataType-v8.png)

## Content Example

![Media Picker Content](images/Media-Picker-Content-v8.png)

## Typed Example (multiple enabled)

```csharp
@{
    var typedMultiMediaPicker = Model.Value<IEnumerable<IPublishedContent>>("sliders");
    foreach (var item in typedMultiMediaPicker)
    {
        <img src="@item.Url" style="width:200px"/>
    }
}
```

## Typed Example (multiple disabled)

```csharp
@{
    var typedMediaPickerSingle = Model.Value<IPublishedContent>("featuredBanner");
    if (typedMediaPickerSingle != null)
    {
        <p>@typedMediaPickerSingle.Url</p>
        <img src="@typedMediaPickerSingle.Url" style="width:200px" alt="@typedMediaPickerSingle.Value("alt")" />
    }
}
```
