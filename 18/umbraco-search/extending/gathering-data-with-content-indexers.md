---
description: An explanation of the content indexer concept for Umbraco Search
---

# Gathering Data with Content Indexers

When content changes, Umbraco Search gathers data for indexing using _content indexers_.

A content indexer is an implementation of `IContentIndexer`. Umbraco Search has two built-in content indexers:

* The [`SystemFieldsContentIndexer`](https://github.com/umbraco/Umbraco.Cms.Search/blob/main/src/Umbraco.Cms.Search.Core/Services/ContentIndexing/Indexers/SystemFieldsContentIndexer.cs) gathers all [system fields](../getting-started/system-fields.md).
* The [`PropertyValueFieldsContentIndexer`](https://github.com/umbraco/Umbraco.Cms.Search/blob/main/src/Umbraco.Cms.Search.Core/Services/ContentIndexing/Indexers/PropertyValueFieldsContentIndexer.cs) gathers all property values using the [property value handlers](index-values-for-property-editors.md).

You can add additional content indexers if you need extra data indexed per content item.

## A custom content indexer

The following example appends extra index data for all content items being indexed. It uses a fictitious service, `IMyContentDataService`, to fetch the extra data on a per-item basis:

{% code title="MyContentIndexer.cs" %}
```csharp
using My.Site.Services;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Search.Core.Models.Indexing;
using Umbraco.Cms.Search.Core.Services.ContentIndexing;

namespace My.Site.ContentIndexing;

public class MyContentIndexer : IContentIndexer
{
    private readonly IMyContentDataService _myContentDataService;

    public MyContentIndexer(IMyContentDataService myContentDataService)
        => _myContentDataService = myContentDataService;

    public async Task<IEnumerable<IndexField>> GetIndexFieldsAsync(
        IContentBase content,
        string?[] cultures,
        bool published,
        CancellationToken cancellationToken)
    {
        // Get the custom data for the content.
        IList<string> values = await _myContentDataService.GetSomeValuesAsync(content.Key);

        if (values.Count is 0)
        {
            // No custom data found, don't add anything to the index.
            return [];
        }
        
        // Add the custom data as searchable texts to a new index field called "myData".
        return [
            new IndexField(
                FieldName: "myData",
                Value: new IndexValue { Texts = values },
                Culture: null,
                Segment: null
            )
        ];
    }
}
```
{% endcode %}

{% hint style="info" %}
Content indexers are invoked for _all_ types of content - documents, media and members.
{% endhint %}

You'll also need a composer to register the content indexer:

{% code title="MyContentIndexerComposer.cs" %}
```csharp
using My.Site.ContentIndexing;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Search.Core.Services.ContentIndexing;

namespace My.Site.DependencyInjection;

public class MyContentIndexerComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.Services.AddTransient<IContentIndexer, MyContentIndexer>();
}
```
{% endcode %}

## Content indexer outputs are cached

The index data produced by content indexers is cached in the Umbraco database to optimize index rebuilding.

First and foremost, this means that content indexers are _not_ invoked during index rebuilds. This means you can use content indexers for expensive operations on a per-item basis.

Secondly, if your content indexer produces sensitive data, you need to pay extra attention. That data will also end in the cache. This might require you to take extra steps towards tracking sensitive data across your application.

You can read more about the index value cache and how to work with it in [the Database Cache for Index Values article](database-cache-for-index-values.md).
