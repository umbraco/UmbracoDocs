# Content Picker

`Alias: Umbraco.ContentPicker`

`Returns: IPublishedContent`

The content picker opens a panel to pick a specific page from the content structure. The value saved is the selected nodes [UDI](../../../../reference/querying/udi-identifiers.md)

## Data Type Definition Example

![Content Picker Data Type Definition](../built-in-property-editors/images/Content-Picker2-DataType-v10.png)

## Content Example

![Content Picker Content](../built-in-property-editors/images/Content-Picker-Content-v10.png)

## MVC View Example

### Without Modelsbuilder

```csharp
@{
    IPublishedContent typedContentPicker = Model.Value<IPublishedContent>("featurePicker");
    if (typedContentPicker != null)
    {
        <p>@typedContentPicker.Name</p>
    }
}
```

### With Modelsbuilder

```csharp
@{
    IPublishedContent typedContentPicker = Model.FeaturePicker;
    if (typedContentPicker != null)
    {
        <p>@typedContentPicker.Name</p>
    }
}
```

## Add values programmatically

See the example below to see how a value can be added or changed programmatically. To update a value of a property editor you need the [Content Service](../../../../reference/management/services/contentservice/).

{% hint style="info" %}
The example below demonstrates how to add values programmatically using a Razor view. However, this is used for illustrative purposes only and is not the recommended method for production environments.
{% endhint %}

```csharp
@using Umbraco.Cms.Core.Services;

@inject IContentService Services;
@{
    // Get access to ContentService
    var contentService = Services;

    // Create a variable for the GUID of the page you want to update
    var guid = Guid.Parse("32e60db4-1283-4caa-9645-f2153f9888ef");

    // Get the page using the GUID you've defined
    var content = contentService.GetById(guid); // ID of your page

    // Get the page you want to assign to the content picker 
    var page = Umbraco.Content("665d7368-e43e-4a83-b1d4-43853860dc45");
    
    // Create an Udi of the page
    var udi = Udi.Create(Constants.UdiEntityType.Document, page.Key);

    // Set the value of the property with alias 'featurePicker'. 
    content.SetValue("featurePicker", udi.ToString());

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
@using Umbraco.Cms.Core.PublishedCache;
@using Umbraco.Cms.Core;

@inject IPublishedSnapshotAccessor _publishedSnapshotAccessor;
@{
    // Set the value of the property with alias 'featurePicker'
    content.SetValue(Home.GetModelPropertyType(_publishedSnapshotAccessor, x => x.FeaturePicker).Alias, udi.ToString());
}
```
