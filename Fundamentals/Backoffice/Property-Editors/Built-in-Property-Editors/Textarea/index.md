---
versionFrom: 8.0.0
---

# Textarea

`Alias: Umbraco.TextArea`

`Returns: String`

Textarea is an HTML textarea control for multiple lines of text. It can be configured to have a fixed character limit, as well as define how big the space for writing can be. By default, there is no character limit unless it's specifically set to a specific value like 200 for instance. If you don't specify the number of rows, 10 will be the amount of rows the textarea will be occupying, unless changed to a custom value.

## Data Type Definition Example

### Without a character limit

![Textarea Data Type Definition](images/Textarea-Setup-v8.png)

### With a character limit

![Textarea Data Type Definition With Limits](images/Textarea-Setup-Limit-v8.png)

## Settings

## Content Example

### Without a character and rows limit

![Textarea Content Example](images/Textarea-Content-v8.png)

### With a character limit and rows limit

![Textbox Content Example With Limits](images/Textarea-Content-Limit-v8.png)

## MVC View Example

### Without Modelsbuilder

```csharp
@{
    if (Model.HasValue("description")){
        <p>@(Model.Value<string>("description"))</p>
    }
}
```

### With Modelsbuilder

```csharp
@if (!Model.HasValue(Model.Description))
{
   <p>@Model.Description</p>
}
```

## Add value programmatically

See the example below to learn how a value can be added or changed programmatically to a Textarea property. To update a value of a property editor you need the [Content Service](../../../../../Reference/Management/Services/ContentService/index.md).

```csharp
@{
    // Get access to ContentService
    var contentService = Services.ContentService;

    // Create a variable for the GUID of your page
    var guid = new Guid("796a8d5c-b7bb-46d9-bc57-ab834d0d1248");

    // Get the page using the GUID you've just defined
    var content = contentService.GetById(guid);
    // Set the value of the property with alias 'description'
    content.SetValue("description", "This is some text for the text area!");

    // Save the change
    contentService.Save(content);
}
```
