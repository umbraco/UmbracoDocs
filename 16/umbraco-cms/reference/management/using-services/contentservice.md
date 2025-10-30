---
description: Example on how to create and publish content programmatically using the `IContentService`.
---

# Content Service

Learn how to use the Content Service.

## Creating content programmatically

In the example below, a new content item is programmatically created using the content service. It is assumed that there are two document types, namely **Catalogue** and **Product**. A new *Product* node will be created under the *Catalogue* page.

Create a new C# class file (for example, `MyProject/Services/PublishContentDemo.cs`) inside your web project.

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

        // Save content first
        _contentService.Save(demoProduct);

        // Publish content
        var userId = 0; // 0 = system user
        _contentService.Publish(demoProduct, new[] { "*" }, userId); // use "*" for invariant content
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

The `IContentService` is also used for publishing existing content. The following example shows how to publish a page and all its descendants.

Create a new C# class file (for example, `MyProject/Services/PublishBranchContentDemo.cs`) inside your web project.

```csharp
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Services;

namespace Umbraco.Cms.Web.UI.Custom;

public class PublishBranchContentDemo
{
    private readonly IContentService _contentService;

    public PublishBranchContentDemo(IContentService contentService) => _contentService = contentService;

    public void Publish(Guid key)
    {
        var parentKey = Guid.Parse("ec4aafcc-0c25-4f25-a8fe-705bfae1d324");

        var content = _contentService.GetById(key)
            ?? throw new InvalidOperationException($"Could not find content with key: {key}.");

        var userId = 0;
        _contentService.PublishBranch(content, PublishBranchFilter.Default, new[] { "*" }, userId);
    }
}
```

The `PublishBranchFilter` option can include one or more of the following flags:

- `Default` - publishes only nodes with pending changes.
- `IncludeUnpublished` - publishes unpublished content and existing nodes with pending changes.
- `ForceRepublish` - republishes all nodes, even if unchanged.
- `All` - combines `IncludeUnpublished` and `ForceRepublish`.
- For multilingual content, replace `"*"` with the array of cultures, for example, `new[] { "en-us", "da" }`.
