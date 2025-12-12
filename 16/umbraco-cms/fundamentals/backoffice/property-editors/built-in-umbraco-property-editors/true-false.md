# Toggle

`Schema Alias: Umbraco.TrueFalse`

`UI Alias: Umb.PropertyEditorUi.Toggle`

`Returns: Boolean`

Toggle is a standard checkbox which saves either 0 or 1, depending on the checkbox being checked or not.

## Data Type Definition Example

![True/False Data Type Definition](images/Checkbox-Data-Type.png)

The Toggle property has a setting which allows you to set the default value of the checkbox, either checked (true) or unchecked (false).

It is also possible to define a label, that will be displayed next to the checkbox on the content.

## Content Example

![No Edit Content Example](../built-in-property-editors/images/Checkbox-Content.png)

## MVC View Example

### Without Models Builder

```csharp
@{
    if (!Model.Value<bool>("myCheckBox"))
    {
        <p>The Checkbox is not checked!</p>
    }
}
```

### With Models Builder

```csharp
@{
    if (!Model.MyCheckbox)
    {
        <p>The Checkbox is not checked!</p>
    }
}
```

## Add values programmatically

See the example below to see how a value can be added or changed programmatically. To update a value of a property editor you need the [Content Service](https://apidocs.umbraco.com/v16/csharp/api/Umbraco.Cms.Core.Services.ContentService.html).

{% hint style="info" %}
The example below demonstrates how to add values programmatically using a Razor view. However, this is used for illustrative purposes only and is not the recommended method for production environments.
{% endhint %}

```csharp
@using Umbraco.Cms.Core.Services
@inject IContentService ContentService
@{
    // Create a variable for the GUID of the page you want to update
    var guid = new Guid("796a8d5c-b7bb-46d9-bc57-ab834d0d1248");
    
    // Get the page using the GUID you've defined
    var content = ContentService.GetById(guid); // ID of your page

    // Set the value of the property with alias 'myCheckBox'
    content.SetValue("myCheckBox", true);
            
    // Save the change
    ContentService.Save(content);
}
```

Although the use of a GUID is preferable, you can also use the numeric ID to get the page:

```csharp
@{
    // Get the page using it's id
    var content = ContentService.GetById(1234); 
}
```

If Models Builder is enabled you can get the alias of the desired property without using a magic string:

```csharp
@using Umbraco.Cms.Core.PublishedCache
@inject IPublishedContentTypeCache PublishedContentTypeCache
@{
    // Set the value of the property with alias 'myCheckBox'
    content.SetValue(Home.GetModelPropertyType(PublishedContentTypeCache, x => x.MyCheckBox).Alias, true);
}
```
