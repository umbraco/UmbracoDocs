---
versionFrom: 8.13.0
---

# Eye Dropper Color Picker

`Alias: Umbraco.ColorPicker.EyeDropper`

`Returns: object`

The Eye Dropper Color picker allows you to choose a color from the full color spectrum using HEX and RGBA.

## Data Type Definition Example

![Eye Dropper Color Picker Data Type Definition](images/Eye-Dropper-Color-Picker-DataType-v8.png)

## Content Example

![Eye Dropper Color Picker Content](images/Eye-Dropper-Color-Picker-Content-v8.png)

## Example with Modelsbuilder

```csharp
@{
    var color = Model.Color?.ToString();

    if (!string.isNullOrEmpty(color))
    {
        <div style="background-color: @color"></div>
    }
}
```

## Example without Modelsbuilder

```csharp
@{
    var color = Model.Value<string>("Color");

    if (!string.isNullOrEmpty(color))
    {
        <div style="background-color: @color"></div>
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

```csharp
@{
    // Set the value of the property with alias 'color'
    content.SetValue(Home.GetModelPropertyType(x => x.Color).Alias, "#6fa8dc");
    
    // Set the value of the property with alias 'theme'
    content.SetValue(Home.GetModelPropertyType(x => x.Theme).Alias, "rgba(111, 168, 220, 0.7)");
}
```
