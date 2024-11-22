---
description: How to use the TextBox property editors in Umbraco CMS.
---

# Textbox

`Schema alias: Umbraco.TextBox`

`UI Alias: Umb.PropertyEditorUi.TextBox`

`Returns: String`

Textbox is an HTML input control for text. It can be configured to have a fixed character limit. The default maximum amount of characters is 512 unless it's specifically changed to a lower amount.

## Data Type Definition Example

![Textbox Data Type Definition](images/Textbox-Setup.png)

## Content Example

### Without a character limit

![Textbox Content Example](../../../../../../10/umbraco-cms/fundamentals/backoffice/property-editors/built-in-property-editors/images/Textbox-Content-v8.png)

### With a character limit

![Textbox Content Example Without a Character Limit](../../../../../../10/umbraco-cms/fundamentals/backoffice/property-editors/built-in-property-editors/images/Textbox-Content-Limit-v8.png)

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
    @if (!Model.HasValue(Model.PageTitle))
    {
        // Print the value of the field with alias 'pageTitle'
        <p>@Model.PageTitle</p>
    }
}
```

## Add values programmatically

See the example below to see how a value can be added or changed programmatically. To update a value of a property editor you need the [Content Service](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.ContentService.html).

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
    var guid = new Guid("32e60db4-1283-4caa-9645-f2153f9888ef");

    // Get the page using the GUID you've defined
    var content = contentService.GetById(guid); // ID of your page

    // Set the value of the property with alias 'pageTitle'
    content.SetValue("pageTitle", "Umbraco Demo");

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

    // Set the value of the property with alias 'pageTitle'
    content.SetValue(Home.GetModelPropertyType(_publishedSnapshotAccessor, x => x.PageTitle).Alias, "Umbraco Demo");
}
```
