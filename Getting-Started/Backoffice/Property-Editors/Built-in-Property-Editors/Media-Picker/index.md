---
versionFrom: 8.1.0
---

# Media Picker #

`Alias: Umbraco.MediaPicker`

`Returns: IEnumerable<IPublishedContent>` or `IPublishedContent`

This property editors returns a single item if the "Pick multiple items" data type setting is disabled or a collection if it is enabled.

## Data Type Definition Example

![Media Picker Data Type Definition](images/Media-Picker-DataType-8_1.png)

### Ignorer user start nodes
Choose this to overrule user permissions, to enable any user of this property to pick any Media Item of the choosen Start node. If no Start node has been defined for this property any content can be viewed and selected of this property.

## Content Example

![Media Picker Content](images/Media-Picker-Content-v8.png)

## MVC View Example

### Multiple enabled without Modelsbuilder

```csharp
@{
    var typedMultiMediaPicker = Model.Value<IEnumerable<IPublishedContent>>("sliders");
    foreach (var item in typedMultiMediaPicker)
    {
        <img src="@item.Url" style="width:200px"/>
    }
}
```

### Multiple enabled with Modelsbuilder

```csharp
@{
    var typedMultiMediaPicker = Model.Sliders;
    foreach (var item in typedMultiMediaPicker)
    {
        <img src="@item.Url" style="width:200px" />
    }
}
```

## Multiple disabled without Modelsbuilder

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

## Multiple disabled with Modelsbuilder

```csharp
@{
    var typedMediaPickerSingle = Model.FeaturedBanner;
    if (typedMediaPickerSingle is Image image)
    {
        <p>@image.Url</p>
        <img src="@image.Url" style="width:200px"/>
    }
}
```
