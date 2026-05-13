---
description: How to use the TextBox property editors in Umbraco CMS.
---

# Textbox

`Schema Alias: Umbraco.TextBox`

`UI Alias: Umb.PropertyEditorUi.TextBox`

`Returns: String`

Textbox is an HTML input control for text. It can be configured to have a fixed character limit. The default maximum amount of characters is 512 unless it's specifically changed to a lower amount.

## Data Type Definition Example

![Textbox Data Type Definition](../../../../.gitbook/assets/Textbox-Setup.png)

## Content Example

### Without a character limit

![Textbox Content Example](<../../../../.gitbook/assets/Textbox-Content-v8 (1).png>)

### With a character limit

![Textbox Content Example Without a Character Limit](<../../../../.gitbook/assets/Textbox-Content-Limit-v8 (1).png>)

## MVC View Example

### Without Models Builder

```csharp
@{
    // Perform an null-check on the field with alias 'pageTitle'
    if (Model.HasValue("pageTitle")){
        // Print the value of the field with alias 'pageTitle'
        <p>@(Model.Value("pageTitle"))</p>
    }
}
```

### With Models Builder

```csharp
@{
    // Perform an null-check on the field with alias 'pageTitle'
    @if (!Model.HasValue(Model.PageTitle))
    {
        // Print the value of the field with alias 'pageTitle'
        <p>@Model.PageTitle</p>
    }
}
```

## Add values programmatically

See the example below to see how a value can be added or changed programmatically. To update a value of a property editor you need the [Content Service](https://apidocs.umbraco.com/v17/csharp/api/Umbraco.Cms.Core.Services.ContentService.html).

{% hint style="info" %}
The example below demonstrates how to add values programmatically using a Razor view. However, this is used for illustrative purposes only and is not the recommended method for production environments.
{% endhint %}

```csharp
@using Umbraco.Cms.Core.Services
@inject IContentService ContentService
@{
    // Create a variable for the GUID of the page you want to update
    var guid = new Guid("32e60db4-1283-4caa-9645-f2153f9888ef");

    // Get the page using the GUID you've defined
    var content = ContentService.GetById(guid); // ID of your page

    // Set the value of the property with alias 'pageTitle'
    content.SetValue("pageTitle", "Umbraco Demo");

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
    // Set the value of the property with alias 'pageTitle'
    content.SetValue(Home.GetModelPropertyType(PublishedContentTypeCache, x => x.PageTitle).Alias, "Umbraco Demo");
}
```
