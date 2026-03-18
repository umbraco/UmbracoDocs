---
description: >-
  Getting started on searching with Umbraco Search
---

# Getting started with Umbraco Search

The fundamental purpose of Umbraco Search is to build search experience. The `ISearcher` interface is your main entry point for searching.

`ISearcher` features multiple different approaches to search, all of which you can combine into single queries. Each of these are described below.

## Indexed values

Umbraco Search indexes all relevant content properties alongside system fields like the content ID (key), name, type and so on.

An overview of the indexed system fields can be found in [system fields](system-fields.md) article.

## Property editor data in Umbraco Search

Different [Umbraco property editors](../../umbraco-cms/fundamentals/backoffice/property-editors/built-in-umbraco-property-editors) yield different index value types; some yield searchable `Text`, some yield filterable `Keyword`, and some yield numeric or date field types. This is important to keep in mind when searching with Umbraco Search, because the way property values are indexed directly affects the search results.

A list of the built-in Umbraco property editors and their corresponding index value types can be found in the [built-in property editors](built-in-property-editors.md) article.

## Search by query (full text search)

Searching by query yields results where one or more fields indexed as `Text` contains the search query.

{% code title="MySearchService.cs" %}
```csharp
using Umbraco.Cms.Search.Core;
using Umbraco.Cms.Search.Core.Models.Searching;
using Umbraco.Cms.Search.Core.Services;

namespace My.Site.Services;

public class MySearchService(ISearcher searcher)
{
    public async Task<SearchResult> SearchByQueryAsync()
        => await searcher.SearchAsync(
            indexAlias: Constants.IndexAliases.PublishedContent,
            query: "pink"
        );
}
```
{% endcode %}

## Search by filtering

Multiple filters can be applied in a single query, and multiple values can be defined for each filter. Umbraco Search performs an `AND` search between filters, and an `OR` search between filter values.

When applying filters, you must pay attention to the expected index value types of the fields targeted for filtering. Mismatched combinations of filters and value types will most likely yield zero results.

For example, use a `TextFilter` when filtering `Text` value types, and a `KeywordFilter` for `Keyword` value types.

{% code title="MySearchService.cs" %}
```csharp
using Umbraco.Cms.Search.Core;
using Umbraco.Cms.Search.Core.Models.Searching;
using Umbraco.Cms.Search.Core.Models.Searching.Filtering;
using Umbraco.Cms.Search.Core.Services;

namespace My.Site.Services;

public class MySearchService(ISearcher searcher)
{
    public async Task<SearchResult> FilterByKeywordAndIntegerAsync()
        => await searcher.SearchAsync(
            indexAlias: Constants.IndexAliases.PublishedContent,
            // "genre" must be either "rock" or "pop", and "releaseYear" must be either 1984, 1985 or 1986
            filters:
            [
                new KeywordFilter(
                    FieldName: "genre",
                    Values: ["rock", "pop"],
                    Negate: false
                ),
                new IntegerExactFilter(
                    FieldName: "releaseYear",
                    Values: [1984, 1985, 1986],
                    Negate: false
                )
            ]
        );
}
```
{% endcode %}

Filters can be negated, in which case Umbraco Search will perform an `AND NOT`:

```csharp
// "genre" must be either "rock" or "pop", and "releaseYear" must NOT be any of 1984, 1985 or 1986
filters:
[
    new KeywordFilter(
        FieldName: "genre",
        Values: ["rock", "pop"],
        Negate: false
    ),
    new IntegerExactFilter(
        FieldName: "releaseYear",
        Values: [1984, 1985, 1986],
        Negate: true
    )
]
```

Numeric and date filters also exist in a range version - for example, the `IntegerRangeFilter`:

```csharp
// "genre" must be either "rock" or "pop", and "releaseYear" must either be in the range [1950,1960) or [1980,1990)
filters:
[
    new KeywordFilter(
        FieldName: "genre",
        Values: ["rock", "pop"],
        Negate: false
    ),
    new IntegerRangeFilter(
        FieldName: "releaseYear",
        Ranges:
        [
            new(
                MinValue: 1950,
                MaxValue: 1960
            ),
            new(
                MinValue: 1980,
                MaxValue: 1990
            )
        ],
        Negate: false
    )
]
```

{% hint style="info" %}
Ranges include the lower interval and excludes the upper. The example above translates into: _"releaseYear" either between 1950 and 1959 (both inclusive) or between 1980 and 1989 (both inclusive)_.
{% endhint %}

## Facets in search results

Umbraco Search can create facets for fields indexed as type `Keyword`, `Integer`, `Decimal` or `DateTimeOffset`.

You must pay attention to the expected field value type when defining facets. Mismatched combinations of facets and value types will most likely yield zero facet results.

{% code title="MySearchService.cs" %}
```csharp
using Umbraco.Cms.Search.Core;
using Umbraco.Cms.Search.Core.Models.Searching;
using Umbraco.Cms.Search.Core.Models.Searching.Faceting;
using Umbraco.Cms.Search.Core.Services;

namespace My.Site.Services;

public class MySearchService(ISearcher searcher)
{
    public async Task<SearchResult> FacetByKeywordAndIntegerAsync()
        => await searcher.SearchAsync(
            indexAlias: Constants.IndexAliases.PublishedContent,
            // include facets for "genre" and "releaseYear" in the search result
            facets:
            [
                new KeywordFacet(
                    FieldName: "genre"
                ),
                new IntegerExactFacet(
                    FieldName: "releaseYear"
                )
            ]
        );
}
```
{% endcode %}

Numeric and date facets also exist in a range version - for example, the `IntegerRangeFacet`:

```csharp
facets:
[
    new KeywordFacet(
        FieldName: "genre"
    ),
    new IntegerRangeFacet(
        FieldName: "releaseYear",
        Ranges:
        [
            new (
                Key: "Rocking 50s",
                MinValue: 1950,
                MaxValue: 1960
            ),
            new (
                Key: "Glamorous 80s",
                MinValue: 1980,
                MaxValue: 1990
            )
        ]
    )
]
```

## Sorting search results

All fields can be used for sorting (ordering) search results, and sorting can be performed across multiple fields in a single query.

Sorting by field is also tied explicitly to the field value type. Mismatched combinations of sorters and value types will yield incorrectly sorted search results.

{% code title="MySearchService.cs" %}
```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Search.Core.Models.Searching;
using Umbraco.Cms.Search.Core.Models.Searching.Sorting;
using Umbraco.Cms.Search.Core.Services;
using Constants = Umbraco.Cms.Search.Core.Constants;

namespace My.Site.Services;

public class MySearchService(ISearcher searcher)
{
    public async Task<SearchResult> SortByKeywordAndIntegerAsync()
        => await searcher.SearchAsync(
            indexAlias: Constants.IndexAliases.PublishedContent,
            query: "pink",
            // sort the search results by "releaseYear" decsending, then by "genre" ascending
            sorters:
            [
                new IntegerSorter(
                    FieldName: "releaseYear",
                    Direction: Direction.Descending
                ),
                new KeywordSorter(
                    FieldName: "genre",
                    Direction: Direction.Ascending
                )
            ]
        );
}
```
{% endcode %}

{% hint style="info" %}
Use the `ScoreSorter` to sort by search result score (relevance).
{% endhint %}

## Search result pagination

Search results are paginated by using `skip` and `take`.

{% code title="MySearchService.cs" %}
```csharp
using Umbraco.Cms.Search.Core.Models.Searching;
using Umbraco.Cms.Search.Core.Services;
using Constants = Umbraco.Cms.Search.Core.Constants;

namespace My.Site.Services;

public class MySearchService(ISearcher searcher)
{
    public async Task<SearchResult> SearchWithPaginationAsync()
        => await searcher.SearchAsync(
            indexAlias: Constants.IndexAliases.PublishedContent,
            query: "pink",
            // skip the first 20 results and return the next 10 results
            skip: 20,
            take: 10
        );
}
```
{% endcode %}

## Searching specific content variations

By default, Umbraco Search will search only for invariant content. Use `culture` and/or `segment` to include within specific content variations.

{% hint style="info" %}
Invariant content will automatically be included in the search result when searching for variant content.
{% endhint %}

{% code title="MySearchService.cs" %}
```csharp
using Umbraco.Cms.Search.Core.Models.Searching;
using Umbraco.Cms.Search.Core.Services;
using Constants = Umbraco.Cms.Search.Core.Constants;

namespace My.Site.Services;

public class MySearchService(ISearcher searcher)
{
    public async Task<SearchResult> SearchSpecificCultureAndSegmentAsync()
        => await searcher.SearchAsync(
            indexAlias: Constants.IndexAliases.PublishedContent,
            query: "rosa",
            culture: "es-ES",
            segment: "rock-n-rollers"
        );
}
```
{% endcode %}

## Searching for protected content

Use the `AccessContext` to include protected content (that is, content with public access restrictions applied) in search results.

The `AccessContext` requires the ID (key) of the currently logged-in [member](../../umbraco-cms/fundamentals/data/members.md), and accepts an optional collection of group IDs.

{% hint style="info" %}
Umbraco Search has no knowledge of members. If public access rules are defined based on member groups, make sure to pass the group IDs alongside the member ID in `AccessContext`.
{% endhint %}

{% code title="MySearchService.cs" %}
```csharp
using Umbraco.Cms.Search.Core.Models.Searching;
using Umbraco.Cms.Search.Core.Services;
using Constants = Umbraco.Cms.Search.Core.Constants;

namespace My.Site.Services;

public class MySearchService(ISearcher searcher)
{
    public async Task<SearchResult> SearchProtectedContent(Guid principalId, Guid[]? groupIds)
    {
        return await searcher.SearchAsync(
            indexAlias: Constants.IndexAliases.PublishedContent,
            query: "pink",
            accessContext: new AccessContext(
                PrincipalId: principalId,
                GroupIds: groupIds
            )
        );
    }
}
```
{% endcode %}
