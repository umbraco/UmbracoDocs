# Publishing content programmatically

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

        _contentService.SaveAndPublishBranch(content, PublishBranchFilter.Default);
    }
}
```

The `PublishBranchFilter` option can include one or more of the following flags:

- `Default` - publishes existing published content with pending changes.
- `IncludeUnpublished` - publishes unpublished content and existing published content with pending changes.
- `ForceRepublish` - publishes existing published content with or without pending changes.
- `All` - combines `IncludeUnpublished` and `ForceRepublish`.

