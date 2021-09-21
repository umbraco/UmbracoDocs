---
versionFrom: 9.0.0
meta.Title: "Umbraco IPublishedContentQuery"
meta.Description: "Querying in views with IPublishedContentQuery in Umbraco"
state: complete
verified-against: rc-003
update-links: false
---

# IPublishedContentQuery

The `IPublishedContentQuery` interface contains various query methods for accessing strongly typed content in templates.

## How to reference IPublishedContentQuery

In order to reference the `IPublishedContentQuery` in your views you must add a using statement for `Umbraco.Core` and inject the service using the `@inject` keyword.

```C#
@using Umbraco.Cms.Core
@inject IPublishedContentQuery _publishedContentQuery;
```

Now you can access the `IPublishedContentQuery` through `_publishedContentQuery`


## Examples

### .Search(string term)

By default, `IPublishedContentQuery` will search on Umbracos 'External' search index for any published content matching the provided search term. 

```csharp
<ul>
	@foreach (var result in _publishedContentQuery.Search("ipsum"))
	{
		<li><a href="@result.Content.Url()">@result.Content.Name</a></li>
	}
</ul>
```

### .Search(string term, int skip, int take, out long totalRecords)

Specifying the number of records 'to skip', and the number of records 'to take' is more performant when there are lots of matching search results and there is a requirement to implement paging.

```csharp
@{
	var results = _publishedContentQuery.Search("ipsum", 5, 10, out long totalRecord);
}

<p>Total results: @totalRecord</p>
<ul>
	@foreach (var result in results)
	{
		<li><a href="@result.Content.Url()">@result.Content.Name</a></li>
	}
</ul>
```

### .Search(IQueryExecutor queryExecutor)

For more complex searching you can construct an Examine QueryExecutor. In the example the search will execute against content of type "blogPost" only.
[Further information on using Examine](../../Searching/Examine/Quick-Start/index.md#different-ways-to-query)

```csharp
@using Umbraco.Cms.Core
@using Examine
@using Umbraco.Cms.Infrastructure.Examine
@inject IPublishedContentQuery _publishedContentQuery;
@inject IExamineManager _examineManager; 

@{
	if (!_examineManager.TryGetIndex(Constants.UmbracoIndexes.ExternalIndexName, out IIndex index))
	{
		throw new InvalidOperationException($"No index found by name{ Constants.UmbracoIndexes.ExternalIndexName }");
	}

	var term = "ipsum";
	var query = index.Searcher.CreateQuery(IndexTypes.Content);
	var queryExecutor = query.NodeTypeAlias("blogPost").And().ManagedQuery(term);
}

<ul>
	@foreach (var result in _publishedContentQuery.Search(queryExecutor))
    {
	    <li><a href="@result.Content.Url()">@result.Content.Name</a></li>
    }
</ul>
```