---
versionFrom: 8.1.0
---

# Media Picker

`Alias: Umbraco.MediaPicker`

`Returns: IEnumerable<IPublishedContent>` or `IPublishedContent`

This property editors returns a single item if the "Pick multiple items" data type setting is disabled or a collection if it is enabled.

:::note 
As of Umbraco 8.14, this Media Picker has been replaced by [Media Picker 3](../Media-Picker-3). This updated property contains more customizable features, and we recommend using this over the Media Picker, which is also marked as the *old* version of the picker.
:::

## Data Type Definition Example

![Media Picker Data Type Definition](images/Media-Picker-DataType-8_1.png)

### Ignorer user start nodes

Use setting to overrule user permissions, to enable any user of this property to pick any Media Item of the choosen Start node.

When this setting is enabled, a user who doesn't normally have access to the media selected as "Start Node" (/Design in this case), can access the media when using this particular Media Picker. If no Start node has been defined for this property any content can be viewed and selected of this property.

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

## Add values programmatically

See the example below to see how a value can be added or changed programmatically. To update a value of a property editor you need the [Content Service](../../../../../Reference/Management/Services/ContentService/index.md).

```csharp
@{
    // Get access to ContentService
    var contentService = Services.ContentService;

    // Create a variable for the GUID of the page you want to update
    var guid = Guid.Parse("32e60db4-1283-4caa-9645-f2153f9888ef");

    // Get the page using the GUID you've defined
    var content = contentService.GetById(guid); // ID of your page

    // Get the media you want to assign to the media picker 
    var media = Umbraco.Media("bca8d5fa-de0a-4f2b-9520-02118d8329a8");

    // Create an Udi of the media
    var udi = Udi.Create(Constants.UdiEntityType.Media, media.Key);

    // Set the value of the property with alias 'featuredBanner'. 
    content.SetValue("featuredBanner", udi.ToString());

    // Save the change
    contentService.Save(content);
}
```

Although the use of a GUID is preferable, you can also use the numeric ID to get the page:

```csharp
@{
    // Get the page using it's id
    var content = contentService.GetById(1234); 
}
```

If Modelsbuilder is enabled you can get the alias of the desired property without using a magic string:

```csharp
@{
    // Set the value of the property with alias 'featuredBanner'
    content.SetValue(Home.GetModelPropertyType(x => x.FeaturedBanner).Alias, true);
}
```
