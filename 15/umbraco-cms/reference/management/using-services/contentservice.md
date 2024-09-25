---
description: Example on how to create content programmatically using the ContentService.
---

# Content Service

Learn how to use the Content Service.

## Creating content programmatically

In the example below, a new page is programmatically created using the content service. It is assumed that there are two document types, namely Catalogue and Product. In this case, a new Product is added underneath the Catalogue page. Add the below code in the Catalogue template.

```csharp
// Get access to ContentService - Add this at the top of your razor view
@inject IContentService ContentService
@using Umbraco.Cms.Core.Services

// Add this anywhere in your Catalogue template
@{
    // Create a variable for the GUID of the parent page - Catalogue, where you want to add a child item.
    var parentId = Guid.Parse("b6fbbb31-a77f-4f9c-85f7-2dc4835c7f31");

    // Create a new child item of type 'Product'
    var demoproduct = ContentService.Create("Microphone", parentId, "product"); 

    // Set the value of the property with alias 'category'
    demoproduct.SetValue("category" , "audio");

    // Set the value of the property with alias 'price'
    demoproduct.SetValue("price", "1500");

    // Save and publish the child item
    ContentService.SaveAndPublish(demoproduct);
    
}
```

In a multilanguage setup, it is necessary to set the name of the content item for a specified culture:

```csharp
demoproduct.SetCultureName("Microphone", "en-us"); // this will set the english name
demoproduct.SetCultureName("Mikrofon", "da"); // this will set the danish name
```

For information on how to retrieve multilingual languages, see the [Retrieving languages](./retrieving-languages.md) article.
