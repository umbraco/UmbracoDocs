# Eye Dropper Color Picker

`Schema Alias: Umbraco.ColorPicker.EyeDropper`

`UI Alias: Umb.PropertyEditorUi.EyeDropper`

`Returns: string`

The Eye Dropper Color picker allows you to choose a color from the full color spectrum using HEX and RGBA.

## Data Type Definition Example

![Eye Dropper Color Picker Data Type Definition](images/Eye-Dropper-Color-Picker-DataType.png)

## Content Example

![Eye Dropper Color Picker Content](images/Eye-Dropper-Color-Picker-Content.png)

## Example with Modelsbuilder

```csharp
@{
    var color = Model.Color?.ToString();

    if (color != null)
    {
        <body style="background-color: @color"></body>
    }
}
```

## Example without Modelsbuilder

```csharp
@{
    var color = Model.Value<string>("Color");

    if (color != null)
    {
        <body style="background-color: @color"></body>
    }
}
```

## Add values programmatically

See the example below to see how a value can be added or changed programmatically. To update a value of a property editor you need the [Content Service](https://apidocs.umbraco.com/v15/csharp/api/Umbraco.Cms.Core.Services.ContentService.html).

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

    // Set the value of the property with alias 'color'.
    content.SetValue("color", "#6fa8dc");
    
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

{% include "../../../../.gitbook/includes/obsolete-warning-ipublishedsnapshotaccessor.md" %}

```csharp
@using Umbraco.Cms.Core.PublishedCache;
@inject IPublishedSnapshotAccessor _publishedSnapshotAccessor;
@{
    // Set the value of the property with alias 'color'
    content.SetValue(Home.GetModelPropertyType(_publishedSnapshotAccessor, x => x.Color).Alias, "#6fa8dc");
    
    // Set the value of the property with alias 'theme'
    content.SetValue(Home.GetModelPropertyType(_publishedSnapshotAccessor, x => x.Theme).Alias, "rgba(111, 168, 220, 0.7)");
}
```
