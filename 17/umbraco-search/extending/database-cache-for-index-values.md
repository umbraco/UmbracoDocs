---
description: >-
  A brief description of the database cache for index values, and how that
  affects you as a developer
---

# Database Cache for Index Values

All content index data gathered by the [content indexers](gathering-data-with-content-indexers.md) is cached in the database. This allows for efficient index rebuilding when required.

By default, the cache should be transparent to you as a developer. It is solely an optimization initiative to limit the resources spent when rebuilding indexes.

However, if you change the implementations of custom content indexers or [property value handlers](index-values-for-property-editors.md), you might need to pay attention to the cache.

If those changes should be applied to already indexed content, you can either:

* Manually save and publish (if applicable) the affected content from the Umbraco backoffice, or
* Programmatically trigger an index refresh for the affected content, or
* Programmatically flush the entire index data cache, and trigger an index rebuild - either manually or programmatically.

The list above is ordered in magnitude of (expected) operational cost. If at all possible, use one of the first options, rather than triggering a complete cache rebuild. However, there is no decisively "wrong" approach here. It all depends on the scenario you're facing.

{% hint style="info" %}
Some search providers (including the [default provider](../getting-started/examine-search-provider.md)) operate on a per-instance basis in a load-balanced setup. Therefore, it's crucial to trigger indexing operations across all instances.

The code samples below use "distributed" services to that end.
{% endhint %}

## Triggering an index refresh for specific content

You can use `IDistributedContentIndexRefresher` to refresh specific content in all relevant content indexes.

The following example demonstrates how this could be used to refresh all content of a given content type:

{% code title="MyIndexRefresher.cs" %}
```csharp
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Search.Core.Models.Indexing;
using Umbraco.Cms.Search.Core.Services.ContentIndexing;

namespace My.Site.Services;

public class MyIndexRefresher
{
    private readonly IDistributedContentIndexRefresher _distributedContentIndexRefresher;
    private readonly IContentService _contentService;
    private readonly ILogger<MyIndexRefresher> _logger;

    public MyIndexRefresher(
        IDistributedContentIndexRefresher distributedContentIndexRefresher,
        IContentService contentService,
        ILogger<MyIndexRefresher> logger)
    {
        _distributedContentIndexRefresher = distributedContentIndexRefresher;
        _contentService = contentService;
        _logger = logger;
    }

    public void RefreshContentIndexesForContentType(int contentTypeId, bool published)
    {
        var currentPage = 0;
        long totalRecords;
        const int pageSize = 500;

        _logger.LogInformation("Starting content index refresh for content type: {contentTypeId}.", contentTypeId);
 
        do
        {
            // Fetch the next page of content items for content type {contentTypeId}.
            var content = _contentService.GetPagedOfType(contentTypeId, currentPage++, pageSize, out totalRecords, filter: null);
 
            // Propagate an index refresh command for the content across all instances.
            var contentState = published ? ContentState.Published : ContentState.Draft;
            _distributedContentIndexRefresher.RefreshContent(content, contentState);
        }
        while(currentPage * pageSize < totalRecords);

        _logger.LogInformation("Finished refreshing {total} content items for content type: {contentTypeId}.", totalRecords, contentTypeId);
    }
}
```
{% endcode %}

{% hint style="info" %}
The `IDistributedContentIndexRefresher` automatically clears the relevant parts of the database cache.
{% endhint %}

## Flushing the entire index data cache

The `IIndexDocumentService` lets you manage the contents of the index data cache - including an option to perform a complete cache flush:

{% code title="MyIndexDocumentCacheFlusher.cs" %}
```csharp
using Umbraco.Cms.Search.Core.Services.ContentIndexing;

namespace My.Site.Services;

public class MyIndexDocumentCacheFlusher
{
    private readonly IIndexDocumentService _indexDocumentService;
    private readonly ILogger<MyIndexDocumentCacheFlusher> _logger;

    public MyIndexDocumentCacheFlusher(
        IIndexDocumentService indexDocumentService,
        ILogger<MyIndexDocumentCacheFlusher> logger)
    {
        _indexDocumentService = indexDocumentService;
        _logger = logger;
    }

    public async Task FlushAllIndexDocumentCacheAsync()
    {
        _logger.LogInformation("Starting flush all index document cache.");

        await _indexDocumentService.DeleteAllAsync();

        _logger.LogInformation("All index document cache has been flushed.");
    }
}
```
{% endcode %}

{% hint style="warning" %}
Flushing the entire index data cache comes with a high cost. Without the cache, Umbraco Search must rebuild everything from scratch in the next indexing cycle. Please use this with caution.
{% endhint %}

## Rebuilding an index

You can either trigger an index rebuild manually from the [Umbraco Search backoffice](../getting-started/backoffice.md), or trigger it programmatically with the `IDistributedContentIndexRebuilder`:

{% code title="MyIndexRebuilder.cs" %}
```csharp
using Umbraco.Cms.Search.Core.Services.ContentIndexing;

namespace My.Site.Services;

public class MyIndexRebuilder
{
    private readonly IDistributedContentIndexRebuilder _distributedContentIndexRebuilder;
    private readonly ILogger<MyIndexRebuilder> _logger;

    public MyIndexRebuilder(
        IDistributedContentIndexRebuilder distributedContentIndexRebuilder,
        ILogger<MyIndexRebuilder> logger)
    {
        _distributedContentIndexRebuilder = distributedContentIndexRebuilder;
        _logger = logger;
    }

    public void RebuildContentIndex(string indexAlias)
    {
        _logger.LogInformation("Triggering a rebuild of content index with alias: {indexAlias}.", indexAlias);
        _distributedContentIndexRebuilder.Rebuild(indexAlias);
    }
}
```
{% endcode %}

{% hint style="info" %}
The `IDistributedContentIndexRebuilder` does _not_ clear any database cache on its own.
{% endhint %}
