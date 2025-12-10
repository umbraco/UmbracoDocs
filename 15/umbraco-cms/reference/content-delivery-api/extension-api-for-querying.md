---
description: >-
  Learn how to extend the Content Delivery API with custom selecting, filtering,
  and sorting options for the multi-item-based endpoint.
---

# Extension API for querying

The Delivery API allows you to retrieve multiple items by utilizing the `/umbraco/delivery/api/v2/content` endpoint. With the built-in query parameters, you have the flexibility to get any number of content nodes based on your needs. For a comprehensive list of supported query options, refer to the [Endpoints](./#endpoints) section.

For the query endpoint, we have created a new Examine index (_DeliveryApiContentIndex_) that facilitates fast retrieval of the desired content. This index ensures quick indexing and searching of data, with the possibility for future extensions.

In this article, we'll explore creating custom selecting, filtering, and sorting options to enhance the querying capabilities of the Delivery API.

## Query options

Let's take a look at an example of using the query endpoint with query parameters for `fetch`, `filter`, and `sort`. A request might look like this:

```http
GET /umbraco/delivery/api/v2/content?fetch=xxx&filter=yyy&filter=zzz&sort=aaa&sort=bbb
```

The placeholders in the example (`xxx`, `yyy`, etc.) represent the values that each query option evaluates in order to determine the suitable query handler.

{% hint style="info" %}
You can include only one `fetch` parameter, while multiple `filter` and `sort` parameters are allowed. Additionally, the order of the `sort` parameters influences the sorting behaviour. Refer to the [Query parameters](./#query-parameters) section for the currently supported options.
{% endhint %}

The implementation of each querying option consists of a class for indexing the data into the _DeliveryApiContentIndex_ and another one for handling the query. By implementing the `IContentIndexHandler` interface, you can control how your relevant data is indexed and made available for querying through our index. And you can customize the querying behaviour to suit your needs by implementing the `ISelectorHandler`, `IFilterHandler`, and `ISortHandler` interfaces.

In the following sections, we will explore the implementation details of creating custom querying functionality for the Delivery API.

## Custom selector

Selectors handle the `fetch` part of a query.

To showcase how to build a custom selector, consider a site structure with a few blog posts. A post is linked to an author, which is another content item.

Authors can be marked as _'Featured'_ using a toggle, granting them additional visibility and recognition. We will use this marker as part of the indexing implementation for our selector option.

The following example demonstrates the implementation of an `AuthorSelector`, which allows you to customize the querying behaviour specifically for finding all featured authors. This class contains both indexing and querying responsibilities. However, keep in mind that it is generally recommended to separate these responsibilities into dedicated classes.

{% code title="AuthorSelector.cs" lineNumbers="true" %}
```csharp
using Umbraco.Cms.Core.DeliveryApi;
using Umbraco.Cms.Core.Models;

namespace Umbraco.Docs.Samples;

public class AuthorSelector : ISelectorHandler, IContentIndexHandler
{
    private const string FeaturedAuthorsSpecifier = "featuredAuthors";
    private const string FieldName = "featured";

    // Querying
    public bool CanHandle(string query)
        => query.StartsWith(FeaturedAuthorsSpecifier, StringComparison.OrdinalIgnoreCase);

    public SelectorOption BuildSelectorOption(string selector) =>
        new SelectorOption
        {
            FieldName = FieldName,
            Values = new[] { "y" }
        };

    // Indexing
    public IEnumerable<IndexFieldValue> GetFieldValues(IContent content, string? culture)
    {
        if (content.ContentType.Alias.InvariantEquals("author") == false)
        {
            return Enumerable.Empty<IndexFieldValue>();
        }

        var isFeatured = content.GetValue<bool>("featured");

        return new[]
        {
            new IndexFieldValue
            {
                FieldName = FieldName,
                Values = new object[] { isFeatured ? "y" : "n" }
            }
        };
    }

    public IEnumerable<IndexField> GetFields()
        => new[]
        {
            new IndexField
            {
                FieldName = FieldName,
                FieldType = FieldType.StringRaw,
                VariesByCulture = false
            }
        };
}
```
{% endcode %}

The `AuthorSelector` class implements the `ISelectorHandler` and `IContentIndexHandler` interfaces.

`ISelectorHandler` allows for handling the `fetch` value in API queries through the `CanHandle()` and `BuildSelectorOption()` methods.

* `CanHandle()` determines if the given `fetch` query corresponds to the `"featuredAuthors"` value.
* `BuildSelectorOption()` constructs the selector option to search for authors with a positive value (for example, `"y"`) in a `"featured"` index field.

The `GetFields()` and `GetFieldValues()` methods each play a role in defining how the data should be indexed and made searchable.

* `GetFields()` defines the behaviour of fields that are added to the index. In this example, the `"featured"` field is added as a "raw" string for efficient and accurate searching.
* `GetFieldValues()` is responsible for retrieving the values of the defined index fields. In this case, the `"featured"` field of content items of type `"author"`. It creates an `IndexFieldValue` with the appropriate field value (`"y"` for featured, `"n"` otherwise), which will be added to the index.

Since our custom query option modifies the index structure, we will need to rebuild the _DeliveryApiContentIndex_. You can find it by navigating to the "Examine Management" dashboard in the "Settings" section. Once rebuilt, we can make a request to the Delivery API query endpoint as follows:

**Request**

```http
GET /umbraco/delivery/api/v2/content?fetch=featuredAuthors
```

**Response**

```json
{
    "total": 3,
    "items": [
        ...
    ]
}
```

## Custom filter

Filters handle the `filter` part of a query.

Staying within the topic of blog posts and their authors, we will create a custom filter to find posts by specific author(s).

This filter allows specifying the desired author(s) by their key (`Guid`) in an `author:` filter option. Multiple authors can be included by listing their keys as comma-separated-values, like:

**Request**

```http
GET /umbraco/delivery/api/v2/content?filter=author:7c630f15-8d93-4980-a0fc-027314dc827a,75380b4f-6d6e-47a1-9222-975cdfb2ac5f
```

The response will include the blog posts associated with the provided authors, enabling us to retrieve only the relevant results from the API.

**Response**

```json
{
    "total": 4,
    "items": [
        ...
    ]
}
```

Our filter implementation follows a similar structure to the custom selector we discussed earlier. We continue to utilize the `IContentIndexHandler` interface, but this time we introduce the `IFilterHandler`. This combination gives us flexibility and control over the filtering behaviour.

The procedure remains the same - we store and query the author key in a new `"authorId"` field within the index. Consequently, we will need to rebuild the index to reflect the changes.

To illustrate the implementation, consider the following code example:

{% code title="AuthorFilter.cs" lineNumbers="true" %}
```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.DeliveryApi;
using Umbraco.Cms.Core.Models;

namespace Umbraco.Docs.Samples;

public class AuthorFilter : IFilterHandler, IContentIndexHandler
{
    private const string AuthorSpecifier = "author:";
    private const string FieldName = "authorId";

    // Querying
    public bool CanHandle(string query)
        => query.StartsWith(AuthorSpecifier, StringComparison.OrdinalIgnoreCase);

    public FilterOption BuildFilterOption(string filter)
    {
        var fieldValue = filter.Substring(AuthorSpecifier.Length);

        // There might be several values for the filter
        var values = fieldValue.Split(',');

        return new FilterOption
        {
            FieldName = FieldName,
            Values = values,
            Operator = FilterOperation.Is
        };
    }

    // Indexing
    public IEnumerable<IndexFieldValue> GetFieldValues(IContent content, string? culture)
    {
        GuidUdi? authorUdi = content.GetValue<GuidUdi>("author");

        if (authorUdi is null)
        {
            return Array.Empty<IndexFieldValue>();
        }

        return new[]
        {
            new IndexFieldValue
            {
                FieldName = FieldName,
                Values = new object[] { authorUdi.Guid }
            }
        };
    }

    public IEnumerable<IndexField> GetFields() => new[]
    {
        new IndexField
        {
            FieldName = FieldName,
            FieldType = FieldType.StringRaw,
            VariesByCulture = false
        }
    };
}
```
{% endcode %}

The principal difference from the selector is that the filter implements `BuildFilterOption()` instead of `BuildSelectorOption()`. Here, the filter performs an exact match for any specified `Guid` in the query. Efficiently, this makes the filter perform an `OR` operation against the index.

Since we need to perform an exact match, the index field (`authorId`) is once again defined as a "raw" string. Other options include "analyzed" and "sortable" strings. These support "contains" searches and alpha-numeric sorting, respectively.

### Filter operators

When implementing a filter, you can use the following operators:  `Is`, `IsNot`, `Contains`, `DoesNotContain`, `GreaterThan`, `GreaterThanOrEqual`, `LessThan` and `LessThanOrEqual`.

{% hint style="info" %}
The range operators (_the latter four_) only work with number and date fields - `FieldType.Number` and `FieldType.Date` respectively.
{% endhint %}

It is possible to pass multiple values to each operator, and these values will be treated inclusively as an __or__ operator. For example, if `tag1` and `tag2` were passed into a filter using the `Is` operator, _any_ document containing __either__ `tag1` __or__ `tag2` would return. The request for this might look like this:

```http
GET /umbraco/delivery/api/v2/content?filter=customTagFilter:tag1,tag2
```

If you require this functionality to be restrictive i.e. `tag1` __and__ `tag2`, then the current approach would be to chain the custom filter. The request would change to look more like this:

```http
GET /umbraco/delivery/api/v2/content?filter=customTagFilter:tag1&filter=customTagFilter:tag2
```

## Custom sort

Finally, we can also add custom handling for the `sort` part of the query.

We'll add a custom sort handler that allows us to sort blog posts based on a custom `"publishDate"` Date Picker property. The implementation will allow for sorting the posts in ascending or descending order.

{% hint style="info" %}
This sorting should only be used with query results that have a published date to ensure accurate results.
{% endhint %}

To demonstrate this, consider the following implementation example:

{% code title="PublishDateSort.cs" lineNumbers="true" %}
```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.DeliveryApi;
using Umbraco.Cms.Core.Models;

namespace Umbraco.Docs.Samples;

public class PublishDateSort : ISortHandler, IContentIndexHandler
{
    private const string SortOptionSpecifier = "publishDate:";
    private const string FieldName = "publishDate";

    // Querying
    public bool CanHandle(string query)
        => query.StartsWith(SortOptionSpecifier, StringComparison.OrdinalIgnoreCase);

    public SortOption BuildSortOption(string sort)
    {
        var sortDirection = sort.Substring(SortOptionSpecifier.Length);

        return new SortOption
        {
            FieldName = FieldName,
            Direction = sortDirection.StartsWith("asc", StringComparison.OrdinalIgnoreCase)
                ? Direction.Ascending
                : Direction.Descending
        };
    }

    // Indexing
    public IEnumerable<IndexFieldValue> GetFieldValues(IContent content, string? culture)
    {
        var publishDate = content.GetValue<DateTime?>("publishDate");

        if (publishDate is null)
        {
            return Enumerable.Empty<IndexFieldValue>();
        }

        return new[]
        {
            new IndexFieldValue
            {
                FieldName = FieldName,
                Values = new object[] { publishDate }
            }
        };
    }

    public IEnumerable<IndexField> GetFields()
        => new[]
        {
            new IndexField
            {
                FieldName = FieldName,
                FieldType = FieldType.Date,
                VariesByCulture = false
            }
        };
}
```
{% endcode %}

The implementation follows the same structure as the other examples, defined by the `IContentIndexHandler` and `ISortHandler` interfaces.

One point to highlight is that we store the `"publishDate"` value as a "date" field in the index, which allows for correct date sorting.

Once more, when adding fields to the index, we need to rebuild it to reflect the changes.

In the following example request, we also apply the author filter to retrieve only `"blogpost"` content nodes, which we know have the `"publishDate"` field.

**Request**

```http
GET /umbraco/delivery/api/v2/content?filter=author:7c630f15-8d93-4980-a0fc-027314dc827a&sort=publishDate:asc
```

**Response**

```json
{
    "total": 2,
    "items": [
        ...
    ]
}
```
