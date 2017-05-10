# Media Picker #

`Alias: Umbraco.MediaPicker2`

`Returns: IEnumerable<IPublishedContent>` or `IPublishedContent`

This property editors returns a single item if the "Pick multiple items" data type setting is disabled or a collection if it is enabled.

## Data Type Definition Example

![Media Picker Data Type Definition](images/Media-Picker2-DataType.png)

## Content Example 

![Media Picker Content](images/Media-Picker2-Content.png)

## Typed Example (multiple enabled): ##

```c#
    @{
        var typedMultiMediaPicker = Model.Content.GetPropertyValue<IEnumerable<IPublishedContent>>("sliders");
        foreach (var item in typedMultiMediaPicker)
        {
            <img src="@item.Url" style="width:200px"/>
        }
    }
```

## Typed Example (multiple disabled): ##

```c#
    @{
        var typedMediaPickerSingle = Model.Content.GetPropertyValue<IPublishedContent>("featuredBanner");
        if (typedMediaPickerSingle != null)
        {
            <p>@typedMediaPickerSingle.Url</p>
            <img src="@typedMediaPickerSingle.Url" style="width:200px" alt="@typedMediaPickerSingle.GetPropertyValue("alt")" />
        }
    }      
```