---
description: Learn how to Index and search data that does not originate from Umbraco.
---

# Using other sources

Umbraco Search is built for handling Umbraco content (documents, media, and members). However, it is entirely possible to use Umbraco Search for other kinds of data as well.

This article explores how to index and search for bespoke data.

{% hint style="info" %}
If your site does not own the data, please consider whether your site should really be responsible for searching the data. Perhaps that responsibility would be better placed at the data source.
{% endhint %}

## You are in control

Umbraco Search does not perform any active handling for custom indexes; you are in complete control.

It's your responsibility to create the index and to keep it up to date with changes.

If you need management UI for index maintenance (for example, rebuilding the index), you must supply this as well.

## Example: A collection of books

The following example illustrates how to use Umbraco Search with a `Book` entity, which looks like this:

{% code title="Book.cs" %}
```csharp
public class Book
{
    public required Guid Id { get; init; }

    public required string Title { get; init; }

    public required string Author { get; init; }

    public required int PublishYear { get; init; }
}
```
{% endcode %}

It is assumed that you have an `IBookService` to provide `Book` entities:

{% code title="IBookService.cs" %}
```csharp
public interface IBookService
{
    Task<Book> GetAsync(Guid id);

    Task<IEnumerable<Book>> GetAllAsync();
}
```
{% endcode %}

### The `IIndexer`

You can inject the `IIndexer` from Umbraco Search into your services to perform index maintenance:

{% code title="BookIndexService.cs" %}
```csharp
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Search.Core.Models.Indexing;
using Umbraco.Cms.Search.Core.Services;

namespace My.Site.Services;

internal sealed class BookIndexService(IIndexer indexer, IBookService bookService)
{
    private string IndexAlias => "My_Books";
    
    public async Task RebuildIndexAsync()
    {
        // Fetch all books from the person service.
        var books = await bookService.GetAllAsync();

        // Reset (re-create) the index before rebuilding the index.
        await indexer.ResetAsync(IndexAlias);

        // Index all the books.
        foreach (var book in books)
        {
            await AddOrUpdateAsync(book);
        }
    }

    public async Task AddOrUpdateAsync(Book book)
    {
        // Extract the index fields for the book.
        IndexField[] fields =
        [
            new("title", new IndexValue { Texts = [book.Title] }, Culture: null, Segment: null),
            new("author", new IndexValue { Keywords = [book.Author] }, Culture: null, Segment: null),
            new("publishYear", new IndexValue { Integers = [book.PublishYear] }, Culture: null, Segment: null),
        ];

        // Pass the fields to be indexed by the indexer.
        await indexer.AddOrUpdateAsync(
            indexAlias: IndexAlias,
            id: book.Id,
            objectType: UmbracoObjectTypes.Unknown,
            variations: [new Variation(null, null)],
            fields: fields,
            protection: null);
    }

    public async Task DeleteAsync(Guid bookId)
        => await indexer.DeleteAsync(IndexAlias, [bookId]);
}
```
{% endcode %}

{% hint style="info" %}
The default search provider for Umbraco Search is powered by Examine. It requires you to register a Lucene index for the new entity in a composer:

```csharp
using Examine;
using Examine.Lucene.Providers;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Infrastructure.Examine;

namespace My.Services;

public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.Services.AddExamineLuceneIndex<LuceneIndex, ConfigurationEnabledDirectoryFactory>("My_Books", _ => { });
}
```

Also, keep in mind that additional field-level configuration may be needed to suit your search requirements. See the [Examine search provider](../getting-started/examine-search-provider.md) documentation for details.
{% endhint %}

### The `ISearcher`

To search the index, inject the `ISearcher` in your search services:

{% code title="BookSearchService.cs" %}
```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Search.Core.Models.Searching.Filtering;
using Umbraco.Cms.Search.Core.Models.Searching.Sorting;
using Umbraco.Cms.Search.Core.Services;

namespace My.Site.Services;

internal sealed class BookSearchService(ISearcher searcher, IBookService bookService)
{
    private string IndexAlias => "My_Books";

    public async Task<PagedModel<Book>> SearchAsync(
        string? query,
        IEnumerable<string>? authors,
        Range<int>? publishYear,
        int skip = 0,
        int take = 10)
    {
        var authorsAsArray = authors as string[] ?? authors?.ToArray() ?? [];

        if (query.IsNullOrWhiteSpace() && authorsAsArray.Length is 0 && publishYear is null)
        {
            // No search parameters passed.
            return new PagedModel<Book>();
        }

        // define the active filters
        var filters = new List<Filter>();
        if (authorsAsArray.Length > 0)
        {
            // Author is a keyword field in the index.
            filters.Add(
                new KeywordFilter(
                    FieldName: "author",
                    Values: authorsAsArray,
                    Negate: false
                )
            );
        }
        if (publishYear is not null)
        {
            // Publish year is an integer field in the index.
            filters.Add(
                new IntegerRangeFilter(
                    FieldName: "publishYear",
                    Ranges: [new IntegerRangeFilterRange(publishYear.Minimum, publishYear.Maximum)],
                    Negate: false
                )
            );
        }

        // Sort the results by title, descending.
        var sorter = new TextSorter("title", Direction.Ascending);

        // Perform the books search.
        var searchResult = await searcher.SearchAsync(
            indexAlias: IndexAlias,
            query: query,
            filters: filters,
            sorters: [sorter],
            skip: skip,
            take: take
        );

        // Fetch the resulting books from the book service and return them as the result.
        var books = new List<Book>();
        foreach (var document in searchResult.Documents)
        {
            var book = await bookService.GetAsync(document.Id);
            books.Add(book);
        }

        return new PagedModel<Book>(searchResult.Total, books);
    }
}
```
{% endcode %}
