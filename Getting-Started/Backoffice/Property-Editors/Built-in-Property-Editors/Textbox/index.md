---
versionFrom: 8.0.0
---

# Textbox

`Alias: Umbraco.Textbox`

`Returns: String`

Textbox is an HTML input control for text. It can be configured to have a fixed character limit. The default maximum amount of characters is 500 unless it's specifically changed to a lower amount.

## Data Type Definition Example

![Textbox Data Type Definition](images/Textbox-Setup-v8.png)

## Content Example

### Without a character limit

![Textbox Content Example](images/Textbox-Content-v8.png)

### With a character limit

![Textbox Content Example Without a Character Limit](images/Textbox-Content-Limit-v8.png)

## MVC View Example

### Without Modelsbuilder

```csharp
@{
    // Perform an null-check on the field with alias 'pageTitle'
    if (Model.HasValue("pageTitle")){
        // Print the value of the field with alias 'pageTitle'
        <p>@(Model.Value("pageTitle"))</p>
    }
}
```

### With Modelsbuilder

```csharp
@{
    // Perform an null-check on the field with alias 'pageTitle'
    if (Model.PageTitle.HasValue())
    {
        // Print the value of the field with alias 'pageTitle'
        <p>@Model.PageTitle</p>
    }
}
```

## Add value programmatically

See the example below to learn how a value can be added or changed programmatically to a TextBox property. To update a value of a property editor you need the [Content Service](../../../../../Reference/Management/Services/ContentService/index.md).

```csharp
@{
    // Get access to ContentService
    var contentService = Services.ContentService;

    // Create a variable for the GUID of your page
    var guid = new Guid("796a8d5c-b7bb-46d9-bc57-ab834d0d1248");

    // Get the page using the GUID you've just defined
    var content = contentService.GetById(guid);
    // Set the value of the property with alias 'pageTitle'
    content.SetValue("pageTitle", "text for the text box/string.");

    // Save and publish the change
    contentService.SaveAndPublish(content);
}
```
