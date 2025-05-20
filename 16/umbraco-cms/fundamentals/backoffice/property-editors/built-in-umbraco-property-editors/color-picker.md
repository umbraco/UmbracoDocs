# Color Picker

`Schema Alias: Umbraco.ColorPicker`

`UI Alias: Umb.PropertyEditorUi.ColorPicker`

`Returns: String (Hexadecimal)`

`Returns: Umbraco.Cms.Core.PropertyEditors.ValueConverters.ColorPickerValueConverter.PickedColor (When using labels)`

The Color picker allows you to set some predetermined colors that the editor can choose between.

It is possible to add a label to use with the color.

## Data Type Definition Example

![Color Picker Data Type Definition](images/Color-Picker-DataType.png)

## Content Example

![Color Picker Content](../../../../../../10/umbraco-cms/fundamentals/backoffice/property-editors/built-in-property-editors/images/Color-Picker-Content-v8.png)

## Example with Modelsbuilder

```csharp
@{
     // Model has a property called "Color" which holds a Color Picker editor
    var hexColor = Model.Color;
    // Define the label if you've included it
    String colorLabel = Model.Color.Label;

    if (hexColor != null)
    {
        <div style="background-color: #@hexColor">@colorLabel</div>
    }
}
```

## Example without Modelsbuilder

```csharp
@using Umbraco.Cms.Core.PropertyEditors.ValueConverters
@{
    // Model has a property called "Color" which holds a Color Picker editor
    var hexColor = Model.Value("Color");
    // Define the label if you've included it
    var colorLabel = Model.Value<ColorPickerValueConverter.PickedColor>("Color").Label;

    if (hexColor != null)
    {
        <div style="background-color: #@hexColor">@colorLabel</div>
    }
}
```

## Add values programmatically

See the example below to see how a value can be added or changed programmatically. To update a value of a property editor you need the [Content Service](https://apidocs.umbraco.com/v15/csharp/api/Umbraco.Cms.Core.Services.ContentService.html).

{% hint style="info" %}
The example below demonstrates how to add values programmatically using a Razor view. However, this is used for illustrative purposes only and is not the recommended method for production environments.
{% endhint %}

### Without labels

```csharp
@inject IContentService Services;
@using Umbraco.Cms.Core.Services;
@{
    // Get access to ContentService
    var contentService = Services;

    // Create a variable for the GUID of the page you want to update
    var guid = Guid.Parse("32e60db4-1283-4caa-9645-f2153f9888ef");

    // Get the page using the GUID you've defined
    var content = contentService.GetById(guid); // ID of your page

    // Set the value of the property with alias 'color'. 
    // The value set here, needs to be one of the colors on the Color Picker
    content.SetValue("color", "38761d");

    // Save the change
    contentService.Save(content);
}
```

### With labels

```csharp
@inject IContentService Services;
@using Umbraco.Cms.Core.Services;
@{
    // Get access to ContentService
    var contentService = Services;

    // Create a variable for the GUID of the page you want to update
    var guid = Guid.Parse("32e60db4-1283-4caa-9645-f2153f9888ef");

    // Get the page using the GUID you've defined
    var content = contentService.GetById(guid); // ID of your page

    // Set the value of the property with alias 'color'. 
    // The value set here, needs to be one of the colors on the Color Picker
    content.SetValue("color", "{'value':'000000', 'label':'Black', 'sortOrder':1, 'id':'1'}");

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
@inject IPublishedSnapshotAccessor _publishedSnapshotAccessor;
@using Umbraco.Cms.Core.PublishedCache;
@{
    // Set the value of the property with alias 'color'
    content.SetValue(Home.GetModelPropertyType(_publishedSnapshotAccessor, x => x.Color).Alias, "38761d");
}
```
