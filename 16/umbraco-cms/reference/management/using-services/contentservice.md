---
description: Example on how to create and publish content programmatically using the ContentService.
---

# Content Service

Learn how to use the Content Service.

## Creating content programmatically

In the example below, a new page is programmatically created using the content service. It is assumed that there are two document types, namely Catalogue and Product. In this case, a new Product is added underneath the Catalogue page. Add the below code in the Catalogue template.

```csharp
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Services;

namespace Umbraco.Cms.Web.UI.Custom;

public class PublishContentDemo
{
    private readonly IContentService _contentService;

    public PublishContentDemo(IContentService contentService) => _contentService = contentService;

    public void Create()
    {
        // Create a variable for the GUID of the parent page - Catalogue, where you want to add a child item.
        var parentId = Guid.Parse("b6fbbb31-a77f-4f9c-85f7-2dc4835c7f31");

        // Create a new child item of type 'Product'
        var demoProduct = _contentService.Create("Microphone", parentId, "product");

        // Set the value of the property with alias 'category'
        demoProduct.SetValue("category" , "audio");

        // Set the value of the property with alias 'price'
        demoProduct.SetValue("price", "1500");

        // Save and publish the child item
        _contentService.Save(demoProduct);
        _contentService.Publish(demoProduct, ["en-us", "da"]);
    }
}
```

In a multi-language setup, it is necessary to set the name of the content item for a specified culture:

```csharp
demoProduct.SetCultureName("Microphone", "en-us"); // this will set the english name
demoProduct.SetCultureName("Mikrofon", "da"); // this will set the danish name
```

For information on how to retrieve multilingual languages, see the [Retrieving languages](localizationservice.md) article.

## Publishing content programmatically

The ContentService is also used for publishing operations.

The following example shows a page being published with all descendants.

```csharp
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Services;

namespace Umbraco.Cms.Web.UI.Custom;

public class PublishContentDemo
{
    private readonly IContentService _contentService;

    public PublishContentDemo(IContentService contentService) => _contentService = contentService;

    public void Publish(Guid key)
    {
        IContent? content = _contentService.GetById(key)
            ?? throw new InvalidOperationException($"Could not find content with key: {key}.");

         _contentService.PublishBranch(content, PublishBranchFilter.Default, ["en-us", "da"]);
    }
}
```

The `PublishBranchFilter` option can include one or more of the following flags:

- `Default` - publishes existing published content with pending changes.
- `IncludeUnpublished` - publishes unpublished content and existing published with pending changes.
- `ForceRepublish` - publishes existing published content with or without pending changes.
- `All` - combines `IncludeUnpublished` and `ForceRepublish`.
