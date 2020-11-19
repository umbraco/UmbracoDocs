---
versionFrom: 8.0.0
---

# Checkbox

`Returns: Boolean`

Checkbox is a standard checkbox which saves either 0 or 1, depending on the checkbox being checked or not.

## Data Type Definition Example

![True/False Data Type Definition](images/Checkbox-Data-Type.png)

The Checkbox property has a setting which allows you to set the default value of the checkbox, either checked (true) or unchecked (false).

It is also possible to define a label, that will be displayed next to the checkbox on the content.

## Content Example

![No Edit Content Example](images/Checkbox-Content.png)

## MVC View Example

### Without Modelsbuilder

```csharp
@{
    if (!Model.Value<bool>("myCheckBox"))
    {
        <p>The Checkbox is not checked!</p>
    }
}
```

### With Modelsbuilder

```csharp
@{
    if (!Model.MyCheckbox)
    {
        <p>The Checkbox is not checked!</p>
    }
}
```

## Add value

See the example below to see how a value can be added or changed programmatically. To update a value of a property editor you need the [Content Service](../../../../../Reference/Management/Services/ContentService/index.md).

```csharp
@{
    var contentService = Services.ContentService;

    var guid = new Guid("796a8d5c-b7bb-46d9-bc57-ab834d0d1248");
    
    var content = contentService.GetById(guid); // ID of your page
    content.SetValue("myCheckBox", true);
            
    contentService.SaveAndPublish(content);
}
```

Although the use of a GUID is preferable, you can also use the numeric ID to get the page:

```csharp
@{
    var content = contentService.GetById(1234); 
}
```


