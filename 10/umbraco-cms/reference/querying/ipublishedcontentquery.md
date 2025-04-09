---
meta.Title: Umbraco IPublishedContentQuery
description: Querying in views with IPublishedContentQuery in Umbraco
---

# IPublishedContentQuery

The `IPublishedContentQuery` interface contains different query methods for accessing strongly typed content in services etc.

## How to inject IPublishedContentQuery

In order to inject the `IPublishedContentQuery` into your services, you must add a using statement for `Umbraco.Cms.Core` and inject the service using the constructor.

```C#
using Umbraco.Cms.Core;

namespace Umbraco.Docs.Samples.Web.Services
{
    public class SearchService
    {
        private readonly IPublishedContentQuery _publishedContentQuery;

        public SearchService(IPublishedContentQuery publishedContentQuery)
        {
            _publishedContentQuery = publishedContentQuery;
        }
    }
}
```

Now you can access the `IPublishedContentQuery` through `_publishedContentQuery`

## Examples

### .Search(string term)

By default, `IPublishedContentQuery` will search on Umbraco's 'External' search index for any published content matching the provided search term.

```csharp
public IEnumerable<PublishedSearchResult> Search(string searchTerm)
{
    foreach (var result in _publishedContentQuery.Search(searchTerm))
    {
        yield return result;
    }
}
```

### .Search(string term, int skip, int take, out long totalRecords)

Specifying the number of records 'to skip' and the number of records 'to take' improves performance with many matching search results. This approach is beneficial when there is a requirement to implement paging.

```csharp
public IEnumerable<PublishedSearchResult> Search(string searchTerm, int skip = 5, int take = 10)
{
    foreach (var result in _publishedContentQuery.Search(searchTerm, skip, take, out long totalRecords))
    {
        yield return result;
    }
}
```

### .Search(IQueryExecutor queryExecutor)

For more complex searching you can construct an Examine QueryExecutor. In the example the search will execute against content of type "blogPost" only. [Further information on using Examine](../searching/examine/quick-start.md#different-ways-to-query)

```csharp
using System;
using System.Collections.Generic;
using Examine;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Infrastructure.Examine;
using Umbraco.Extensions;

namespace Umbraco.Docs.Samples.Web.Services
{
    public class SearchService
    {
        private readonly IPublishedContentQuery _publishedContentQuery;
        private readonly IExamineManager _examineManager;

        public SearchService(IPublishedContentQuery publishedContentQuery, IExamineManager examineManager)
        {
            _publishedContentQuery = publishedContentQuery;
            _examineManager = examineManager;
        }

        public IEnumerable<PublishedSearchResult> Search(string searchTerm)
        {
            if (!_examineManager.TryGetIndex(Constants.UmbracoIndexes.ExternalIndexName, out IIndex index))
            {
                throw new InvalidOperationException($"No index found by name{Constants.UmbracoIndexes.ExternalIndexName}");
            }

            var query = index.Searcher.CreateQuery(IndexTypes.Content);
            var queryExecutor = query.NodeTypeAlias("blogPost").And().ManagedQuery(searchTerm);

            foreach (var result in _publishedContentQuery.Search(queryExecutor))
            {
                yield return result;
            }
        }
    }
}
```
