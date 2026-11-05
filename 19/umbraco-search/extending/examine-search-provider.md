---
description: >-
  Extension points for the Examine search provider
---

# Extending the Examine search provider

The Examine search provider is built with extensibility in mind. It provides extensibility points for indexing and searching custom data formats that go beyond the standard Umbraco Search data format.

This is useful when you need to:

- Index data that is not covered by the built-in `IndexValue`.
- Add custom filtering capabilities to the searcher.

{% hint style="info" %}
This article _only_ applies to the default Examine search provider. Alternative search providers might provide similar means of extending the query capabilities.
{% endhint %}

## Create a custom `IndexValue`

The `IndexValue` record holds the data to be indexed. Create a specialized implementation to support additional index data:

{% code title="CustomIndexValue.cs" %}
```csharp
using Umbraco.Cms.Search.Core.Models.Indexing;

namespace My.Site.Search.Custom;

public record CustomIndexValue : IndexValue
{
    public IEnumerable<Guid>? Guids { get; init; }
}
```
{% endcode %}

## Create a custom `Indexer`

Extend the `Indexer` class to handle your custom `IndexValue` type by:

1. Overriding the `AppendCustomIndexValues` method to add custom fields to the index, and
2. Optionally override `MergeIndexValue` to handle merging if the same field appears multiple times.

{% code title="CustomIndexer.cs" %}
```csharp
using Examine;
using Microsoft.Extensions.Options;
using Umbraco.Cms.Search.Core.Models.Indexing;
using Umbraco.Cms.Search.Provider.Examine.Configuration;
using Umbraco.Cms.Search.Provider.Examine.Helpers;
using Umbraco.Cms.Search.Provider.Examine.Services;

namespace My.Site.Search.Custom;

public class CustomIndexer : Indexer
{
    public CustomIndexer(IExamineManager examineManager, IOptions<FieldOptions> fieldOptions)
        : base(examineManager, fieldOptions)
    {
    }

    protected override void AppendCustomIndexValues(
        IndexField field,
        Dictionary<string, IEnumerable<object>> result)
    {
        if (field.Value is CustomIndexValue customValue && customValue.Guids?.Any() == true)
        {
            // Index the Guids as keyword values (unanalyzed) for exact matching
            var fieldName = FieldNameHelper.FieldName(
                $"{field.FieldName}_guids", "keywords", field.Segment);
            result.Add(fieldName, customValue.Guids.Select(g => g.ToString()).ToList());
        }
    }

    protected override IndexValue MergeIndexValue(IndexValue original, IndexValue toMerge)
    {
        IndexValue baseMerged = base.MergeIndexValue(original, toMerge);

        var originalCustom = original as CustomIndexValue;
        var toMergeCustom = toMerge as CustomIndexValue;

        if (originalCustom?.Guids is null && toMergeCustom?.Guids is null)
        {
            return baseMerged;
        }

        return new CustomIndexValue
        {
            Keywords = baseMerged.Keywords,
            Integers = baseMerged.Integers,
            Decimals = baseMerged.Decimals,
            DateTimeOffsets = baseMerged.DateTimeOffsets,
            Texts = baseMerged.Texts,
            TextsR1 = baseMerged.TextsR1,
            TextsR2 = baseMerged.TextsR2,
            TextsR3 = baseMerged.TextsR3,
            Guids = MergeValues(originalCustom?.Guids, toMergeCustom?.Guids)
        };
    }
}
```
{% endcode %}

## Create a custom `Filter`

Create a custom filter record that extends `Filter` to enable filtering by your custom data:

{% code title="GuidFilter.cs" %}
```csharp
using Umbraco.Cms.Search.Core.Models.Searching.Filtering;

namespace My.Site.Search.Custom;

public record GuidFilter(string FieldName, Guid[] Values, bool Negate)
    : Filter(FieldName, Negate);
```
{% endcode %}

## Create a custom `Searcher`

Extend the `Searcher` class to handle your custom filter. Override the `AddCustomFilter` method to implement the filtering logic:

{% code title="CustomSearcher.cs" %}
```csharp
using Examine;
using Examine.Search;
using Microsoft.Extensions.Options;
using Umbraco.Cms.Search.Core.Models.Searching.Filtering;
using Umbraco.Cms.Search.Provider.Examine.Configuration;
using Umbraco.Cms.Search.Provider.Examine.Helpers;
using Umbraco.Cms.Search.Provider.Examine.Services;

namespace My.Site.Search.Custom;

public class CustomSearcher : Searcher
{
    public CustomSearcher(IExamineManager examineManager, IOptions<SearcherOptions> searcherOptions)
        : base(examineManager, searcherOptions)
    {
    }

    protected override void AddCustomFilter(
        IBooleanOperation searchQuery,
        Filter filter,
        string? culture,
        string? segment)
    {
        if (filter is GuidFilter guidFilter)
        {
            var fieldName = FieldNameHelper.FieldName(
                $"{filter.FieldName}_guids", "keywords", segment);
            var guidStrings = guidFilter.Values.Select(g => g.ToString()).ToArray();

            if (guidFilter.Negate)
            {
                searchQuery.Not().GroupedOr([fieldName], guidStrings);
            }
            else
            {
                searchQuery.And().GroupedOr([fieldName], guidStrings);
            }
        }
    }
}
```
{% endcode %}

## Create a custom `IContentIndexer`

Implement an [`IContentIndexer`](gathering-data-with-content-indexers.md) to hook into the content indexing pipeline and add custom fields whenever content is indexed:

{% code title="MyDataContentIndexer.cs" %}
```csharp
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Search.Core.Models.Indexing;
using Umbraco.Cms.Search.Core.Services.ContentIndexing;
using My.Site.Services;

namespace My.Site.Search.Custom;

public class MyDataContentIndexer : IContentIndexer
{
    private readonly IMyDataService _myDataService;

    public MyDataContentIndexer(IMyDataService myDataService)
        => _myDataService = myDataService;

    public async Task<IEnumerable<IndexField>> GetIndexFieldsAsync(
        IContentBase content,
        string?[] cultures,
        bool published,
        CancellationToken cancellationToken)
    {
        if (content is not IContent document)
        {
            return [];
        }

        // Fetch data from your custom service
        Guid[] myData = await _myDataService.GetDataAsync(document.Key, cancellationToken);

        if (myData.Length == 0)
        {
            return [];
        }

        // Return index fields with custom IndexValue containing the data in the Guids collection
        return
        [
            new IndexField(
                FieldName: "myDataField",
                Value: new CustomIndexValue { Guids = myData },
                Culture: null,
                Segment: null)
        ];
    }
}
```
{% endcode %}

{% hint style="info" %}
The `IMyDataService` service in this sample is a fictional service of your own making.
{% endhint %}

## Registering custom implementations

Register your custom `Indexer`, `Searcher` and `IContentIndexer` in a composer:

{% code title="CustomSearchComposer.cs" %}
```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Search.Core.Services;
using Umbraco.Cms.Search.Core.Services.ContentIndexing;
using Umbraco.Cms.Search.Provider.Examine.Services;

namespace My.Site.DependencyInjection;

public sealed class CustomSearchComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        // Register the custom content indexer to add fields during content indexing
        builder.Services.AddTransient<IContentIndexer, MyDataContentIndexer>();

        // Register the custom indexer to handle the CustomIndexValue type
        builder.Services.AddTransient<IExamineIndexer, CustomIndexer>();
        builder.Services.AddTransient<IIndexer, CustomIndexer>();

        // Register the custom searcher to handle the GuidFilter type
        builder.Services.AddTransient<IExamineSearcher, CustomSearcher>();
        builder.Services.AddTransient<ISearcher, CustomSearcher>();
    }
}
```
{% endcode %}

## Using the custom filter

With all of this in place, you can search using your custom filter:

{% code title="MySearchService.cs" %}
```csharp
using Umbraco.Cms.Search.Core.Models.Searching;
using Umbraco.Cms.Search.Core.Services;
using Constants = Umbraco.Cms.Search.Core.Constants;

namespace My.Site.Services;

public class MySearchService(ISearcher searcher)
{
    public async Task<SearchResult> SearchByMyDataAsync(Guid id)
        => await searcher.SearchAsync(
            indexAlias: Constants.IndexAliases.PublishedContent,
            filters: [new GuidFilter("myDataField", [id], Negate: false)]
        );
}
```
{% endcode %}

## Additional extension points

The `Searcher` class provides additional virtual methods for extending faceting and sorting:

| Method | Purpose |
|--------|---------|
| `AddCustomFacet` | Add custom facet operations to the search query. |
| `ExtractCustomFacetResult` | Extract custom facet results from the search results. |
| `AddCustomSorter` | Handle custom sorter types. |

