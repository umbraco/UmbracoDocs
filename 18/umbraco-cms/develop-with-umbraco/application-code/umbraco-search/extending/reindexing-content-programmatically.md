---
description: >-
  An article discussing how to trigger reindexing of content programmatically - and when to do it
---

# Reindexing content programmatically

If you ever need to trigger the reindexing of content manually, you should use the [`IDistributedContentIndexRefresher`](https://github.com/umbraco/Umbraco.Cms.Search/blob/main/src/Umbraco.Cms.Search.Core/Services/ContentIndexing/IDistributedContentIndexRefresher.cs) service.

As the name implies, this service ensures that the content reindexing happens correctly across all instances in a load balanced setup. This is important, because some search providers (including the [default provider](../getting-started/examine-search-provider.md)) explicitly depend on this behavior.

{% hint style="info" %}
In Umbraco, "content" implies either documents, media or members. However, documents are also named "content", which can be a little confusing.
{% endhint %}

## How to use the service

The service allows for reindexing content, media and members. For content, either draft or published state should be targeted explicitly.

Here's a code sample to show the usage of the service:

{% code title="MyContentReindexer.cs" %}
```csharp
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Search.Core.Models.Indexing;
using Umbraco.Cms.Search.Core.Services.ContentIndexing;

namespace My.Site.Indexing;

public class MyContentReindexer
{
    private readonly IDistributedContentIndexRefresher _distributedContentIndexRefresher;

    public MyContentReindexer(IDistributedContentIndexRefresher distributedContentIndexRefresher)
        => _distributedContentIndexRefresher = distributedContentIndexRefresher;

    public void ReindexContent(IContent content, bool published)
    {
        var contentState = published ? ContentState.Published : ContentState.Draft;
        _distributedContentIndexRefresher.RefreshContent([content], contentState);
    }

    public void ReindexMedia(IMedia media)
        => _distributedContentIndexRefresher.RefreshMedia([media]);

    public void ReindexMember(IMember member)
        => _distributedContentIndexRefresher.RefreshMember([member]);
}
```
{% endcode %}

## Use with caution

Content reindexing can be an expensive operation, so use it reasonably.

You should _never_ allow reindexing to be triggered on demand, for example as part of a page rendering or an API. Doing so could lead to excessive resource usage, and ultimately might bring your site down.
