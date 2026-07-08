---
description: How to configure the Examine search provider
---

# The Examine Search Provider

Umbraco Search uses a provider-based approach to the underlying search technology. The default search provider is powered by [Examine](https://github.com/Shazwazza/Examine).

In this article, you'll learn how to configure the Examine search provider to produce the results you're expecting.

{% hint style="info" %}
This article _only_ applies to the default Examine search provider. Alternative search providers might be available, and they might require a different configuration.
{% endhint %}

## Configuring fields for faceting and/or sorting

Fields that will be used for faceting and/or sorting must be explicitly configured for the Examine search provider. This is done by configuring the `FieldOptions` using the options pattern, and _must_ be done prior to indexing any content.

The field configuration is a mapping between the Umbraco property aliases that hold the values and the expected field index type of those properties. For example, the `genre` and `releaseYear` fields used throughout this article should be configured like this:

{% code title="FieldOptionsComposer.cs" %}
```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Search.Provider.Examine.Configuration;

namespace My.Site.DependencyInjection;

public class FieldOptionsComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.Services.Configure<FieldOptions>(options
            => options.Fields =
            [
                // configure faceting and sorting for the "genre" property
                new FieldOptions.Field
                {
                    PropertyName = "genre",
                    FieldValues = FieldValues.Keywords,
                    Facetable = true,
                    Sortable = true
                },
                // configure faceting and sorting for the "releaseYear" property
                new FieldOptions.Field
                {
                    PropertyName = "releaseYear",
                    FieldValues = FieldValues.Integers,
                    Facetable = true,
                    Sortable = true
                }
            ]
        );
}
```
{% endcode %}

{% hint style="warning" %}
The field configurations must be known at index time. Any changes made to this configuration only take effect for newly indexed content.

If an index is already populated, it might be necessary to rebuild it for changes to take effect.
{% endhint %}

## Configuring the search behavior

The `SearcherOptions` allow for configuring certain aspects of how a search is executed. It is configured using the options pattern:

{% code title="SearcherOptionsComposer.cs" %}
```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Search.Provider.Examine.Configuration;

namespace My.Site.DependencyInjection;

public class SearcherOptionsComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.Services.Configure<SearcherOptions>(options =>
        {
            // configure searcher options here
        });
}
```
{% endcode %}

### Boost levels

Certain Umbraco properties yield different textual relevance values. The Examine search provider automatically performs relevance boosting accordingly, but the boost levels can be tweaked if required. Use:

* `SearcherOptions.BoostFactorTextR1` to control the relevance of the highest relevance text (for example, document names and H1 tags).
* `SearcherOptions.BoostFactorTextR2` to control the relevance of the second-highest relevance text (for example, H2 tags).
* `SearcherOptions.BoostFactorTextR3` to control the relevance of the third-highest relevance text (for example, H3 tags).

See also the [built-in property editors](built-in-property-editors.md) article.

### Facet result behavior

The available facet values are grouped by the `FieldName` passed to the facet definition when searching. In the examples above, this would be `genre` and `releaseYear`.

When an end user picks a facet value from a search result, the subsequent search should contain a filter for the picked value. For example, the `KeywordFilter` in the examples above.

The default behavior for facet results is to _exclude_ the facet values that are not a part of the search result. Effectively, that means all the facet values that are _not_ picked within the facet group.

If all (applicable) facet values should be _included_ for all groups in the search result, configure `SearcherOptions.ExpandFacetValues` as `true`.

{% hint style="warning" %}
This incurs a performance penalty, which is linear to the number of active facet groups in the query.
{% endhint %}

### Max facet values

The Examine search provider limits the number of resulting facet values within a facet group to 100. This limit can be changed using `SearcherOptions.MaxFacetValues`.

## Optimizing server resources

The default Examine indexes from Umbraco CMS are no longer in use, if Umbraco Search powers all things search - that is:

* Frontend search.
* Backoffice search.
* The Delivery API (if applicable on your site).

However, Umbraco CMS continues to keep them up-to-date with content changes. Since this is a waste of server resources, the default Examine indexes can be explicitly disabled by means of composition:

{% code title="DisableDefaultIndexesComposer.cs" %}
```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Search.Provider.Examine.DependencyInjection;

namespace My.Site.DependencyInjection;

public class DisableDefaultIndexesComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.DisableDefaultExamineIndexes();
}
```
{% endcode %}

## Directory factory configuration

The Examine search provider automatically applies the [Examine directory configuration](https://docs.umbraco.com/umbraco-cms/reference/configuration/examinesettings) from Umbraco CMS.
