---
description: Querying content with IPublishedContentQuery in Umbraco
---

# IPublishedContentQuery

The `IPublishedContentQuery` interface contains methods for querying strongly typed content.

{% hint style="warning" %}

**Use with caution**

The `IPublishedContentQuery` has limited filtering capabilities. It should only be used for broad, site-wide search functionality where filtering is not important.

Do _not_ combine `IPublishedContentQuery` with post-filtering of search results in memory. This will severely degrade your site performance. Instead, use the [search feature](../../search/README.md) for advanced querying.

{% endhint %}

## How to inject IPublishedContentQuery

In order to inject the `IPublishedContentQuery` into your services, you must add a using statement for `Umbraco.Cms.Core` and inject the service using the constructor.

```csharp
using Umbraco.Cms.Core;

namespace Umbraco.Docs.Samples.Web.Services;

public class SearchService
{
    private readonly IPublishedContentQuery _publishedContentQuery;

    public SearchService(IPublishedContentQuery publishedContentQuery)
    {
        _publishedContentQuery = publishedContentQuery;
    }
}
```

Now you can access the `IPublishedContentQuery` through `_publishedContentQuery`

## Examples

### .Search(string term)

By default, `IPublishedContentQuery` will search on Umbraco's 'public' search index for any published content matching the provided search term.

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
    foreach (var result in _publishedContentQuery.Search(searchTerm, skip, take, out _))
    {
        yield return result;
    }
}
```

## Limitations for background tasks

The `IPublishedContentQuery` cannot be injected into a background task, as it relies on context. Instead, create a service scope and resolve `IPublishedContentQuery` from it:

```csharp
public class MyBackgroundJob : RecurringBackgroundJobBase
{
    private readonly IServiceScopeFactory _serviceScopeFactory;
    private readonly IUmbracoContextFactory _umbracoContextFactory;

    public MyBackgroundJob(
        IServiceScopeFactory serviceScopeFactory,
        IUmbracoContextFactory umbracoContextFactory)
        : base(TimeSpan.FromMinutes(5))
    {
        _serviceScopeFactory = serviceScopeFactory;
        _umbracoContextFactory = umbracoContextFactory;
    }

    public override Task RunJobAsync(CancellationToken cancellationToken)
    {
        using UmbracoContextReference _ = _umbracoContextFactory.EnsureUmbracoContext();
        using IServiceScope serviceScope = _serviceScopeFactory.CreateScope();
        IPublishedContentQuery publishedContentQuery = serviceScope.ServiceProvider.GetRequiredService<IPublishedContentQuery>();
        IEnumerable<PublishedSearchResult> results = publishedContentQuery.Search("[your search term]");

        // do something with the results here
        
        return Task.CompletedTask;
    }
}
```
