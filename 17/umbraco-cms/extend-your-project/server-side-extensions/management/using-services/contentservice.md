---
description: Example on how to create and publish content programmatically using the `IContentService`.
---

# Content Service

Learn how to use the Content Service.

## Creating content programmatically

In the example below, a new content item is programmatically created using the content service. It is assumed that there are two document types, namely *Catalogue* and *Product*. A new *Product* node will be created under the *Catalogue* page.

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
        var userId = -1; // -1 = system user
        _contentService.Publish(demoProduct, new[] { "*" }, userId); // use "*" for invariant content
    }
}
```

{% hint style="info" %}
Always call `Save()` before `Publish()`, as publishing without saving first will not persist the changes.
{% endhint %}

In a multi-language setup, it is necessary to set the name of the content item for a specified culture:

```csharp
demoProduct.SetCultureName("Microphone", "en-us"); // this will set the english name
demoProduct.SetCultureName("Mikrofon", "da"); // this will set the danish name
```

For information on how to retrieve multilingual languages, see the [Retrieving languages](localizationservice.md) article.


### Getting date values programmatically
When creating content programmatically, you may need to read back date values stored on a content node. This could be to validate, transform, or pass them to another service. The `IContentService` returns date property values as raw JSON, which must be deserialized into a `DateTimeDto` before use.
The following example retrieves a date property from an existing content node and converts it to a `DateOnly` value:
```csharp
using System.Text.Json;
using Umbraco.Cms.Core.Services;
using static Umbraco.Cms.Core.PropertyEditors.ValueConverters.DateTimeValueConverterBase;

namespace Umbraco.Cms.Web.UI.Custom;
public class GetDateValueDemo
{
	private readonly IContentService _contentService;

	public GetDateValueDemo(IContentService contentService) => _contentService = contentService;

	public void GetDate(Guid key)
	{
		var content = _contentService.GetById(key);

		if (content is not null)
		{
			var rawValue = content.GetValue("myDateProperty");

			if (string.IsNullOrEmpty(rawValue?.ToString()) is false)
			{
				var dto = JsonSerializer.Deserialize<DateTimeDto>(rawValue.ToString()!);

				if (dto is not null)
				{
					var dateOnly = DateOnly.FromDateTime(dto.Date.Date);
				}
			}
		}
	}
}
```
(generated with the help of Claude)

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
        var parentKey = Guid.Parse("b6fbbb31-a77f-4f9c-85f7-2dc4835c7f31");

        var content = _contentService.GetById(key)
            ?? throw new InvalidOperationException($"Could not find content with key: {key}.");

        var userId = -1;
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

