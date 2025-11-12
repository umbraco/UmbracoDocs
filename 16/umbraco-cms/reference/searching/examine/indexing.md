---
description: >-
  Learn how to build and customize the indexes that comes with your Umbraco
  website.
---

# Custom indexing

## Customizing the built in indexes

You can modify the built-in indexes in the following ways:

* [Events](https://shazwazza.github.io/Examine/articles/indexing.html#events) - giving you control over exactly what data goes into them and how the fields are configured
* Changing the field value types to change how values are stored in the index
* Changing the `IValueSetValidator` to change what goes into the index
* Take control of the entire index creation pipeline to change the implementation

We can do all this by using the `ConfigureNamedOptions` pattern.

## Creating a ConfigureOptions class

We will start by creating a ConfigureExamineOptions class, that derives from `IConfigureNamedOptions<LuceneDirectoryIndexOptions>`:

```csharp
using Examine.Lucene;
using Microsoft.Extensions.Options;

namespace Umbraco.Docs.Samples.Web.CustomIndexing;

public class ConfigureExternalIndexOptions : IConfigureNamedOptions<LuceneDirectoryIndexOptions>
{
    public void Configure(string name, LuceneDirectoryIndexOptions options)
    {
        throw new System.NotImplementedException();
    }

    public void Configure(LuceneDirectoryIndexOptions options)
    {
        throw new System.NotImplementedException();
    }
}
```

{% hint style="info" %}
In this sample we are altering the external index and thus we name the class `ConfigureExternalIndexOptions`. If you are altering multiple indexes, it is recommended to have separate classes for each index - i.e. `ConfigureExternalIndexOptions` for the external index, `ConfigureInternalIndexOptions` for the internal index and so on.
{% endhint %}

When using the `ConfigureNamedOptions` pattern, we have to register this in a composer for it to configure our indexes, this can be done like this:

```csharp
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;

namespace Umbraco.Docs.Samples.Web.CustomIndexing;

[ComposeAfter(typeof(Umbraco.Cms.Infrastructure.Examine.AddExamineComposer))]
public class ExamineComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.ConfigureOptions<ConfigureExternalIndexOptions>();
    }
}
```

{% hint style="info" %}
The use of the `ComposeAfter` attribute guarantees that the composer will run after the core composer responsible for setting up the default index details.
{% endhint %}

### Changing field value types

By default, Examine will store values into the Lucene index as "Full Text" fields, meaning the values will be indexed and analyzed for a textual search. However, if a field value is numerical, date/time, or another non-textual value type, you might want to change how the value is stored in the index. This will let you take advantage of some value type-specific search features such as numerical or date range.

There is some documentation about this in the [Examine documentation](https://shazwazza.github.io/Examine/articles/configuration.html).

The easiest way to modify how a field is configured is using the `ConfigureNamedOptions` pattern like so:

```csharp
using Examine;
using Examine.Lucene;
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core;

namespace Umbraco.Docs.Samples.Web.CustomIndexing;

public class ConfigureExternalIndexOptions : IConfigureNamedOptions<LuceneDirectoryIndexOptions>
{
    public void Configure(string name, LuceneDirectoryIndexOptions options)
    {
        if (name.Equals(Constants.UmbracoIndexes.ExternalIndexName))
        {
            options.FieldDefinitions.AddOrUpdate(new FieldDefinition("price", FieldDefinitionTypes.Double));
        }
    }

    // Part of the interface, but does not need to be implemented for this.
    public void Configure(LuceneDirectoryIndexOptions options)
    {
        throw new System.NotImplementedException();
    }
}
```

This will ensure that the `price` field in the index is treated as a `double` type (if the `price` field does not exist in the index, it is added).

## Changing IValueSetValidator

An `IValueSetValidator` is responsible for validating a `ValueSet` to see if it should be included in the index. For example, by default the validation process for the ExternalIndex checks if a `ValueSet` has a category type of either "media" or "content" (not member). If a `ValueSet` was passed to the ExternalIndex and it did not pass this requirement it would be ignored.

The `IValueSetValidator` is also responsible for filtering the data in the `ValueSet`. For example, by default the validator for the MemberIndex will validate on all the default member properties, so an extra property "PhoneNumber", would not pass validation, and therefore not be included.

The `IValueSetValidator` implementation for the built-in indexes, can be changed like this:

```csharp
using Examine.Lucene;
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core;
using Umbraco.Cms.Infrastructure.Examine;

namespace Umbraco.Docs.Samples.Web.CustomIndexing;

public class ConfigureMemberIndexOptions : IConfigureNamedOptions<LuceneDirectoryIndexOptions>
{
    public void Configure(string name, LuceneDirectoryIndexOptions options)
    {
        if (name.Equals(Constants.UmbracoIndexes.MembersIndexName))
        {
            options.Validator = new MemberValueSetValidator(null, null, new[] {"email"}, null);
        }
    }

    // Part of the interface, but does not need to be implemented for this.
    public void Configure(LuceneDirectoryIndexOptions options)
    {
        throw new System.NotImplementedException();
    }
}
```

{% hint style="info" %}
Remember to register `ConfigureMemberIndexOptions` in your composer.
{% endhint %}

## Creating your own index

### A custom Umbraco content index

The following example will show how to create an index that will only include nodes based on the **Product**.

{% hint style="info" %}
It is recommended to use the existing built-in `ExternalIndex`. You should then query based on the `NodeTypeAlias` instead of creating a new separate index based on that particular node type. However, should the need arise, the example below will show you how to do it.

Take a look at the [Examine Quick Start](quick-start.md) guide to see some examples of how to search the ExternalIndex.
{% endhint %}

To create this index we need five things:

1. An `UmbracoExamineIndex` implementation that defines the index.
2. An `IConfigureNamedOptions` implementation that configures the index fields and options.
3. An `IValueSetBuilder` implementation that builds index value sets a piece of content.
4. An `IndexPopulator` implementation that populates the index with the value sets for all applicable content.
5. An `INotificationHandler` implementation that updates the index when content changes.
6. A composer that adds all these services to the runtime.

#### ProductIndex

```csharp
using Examine.Lucene;
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Infrastructure.Examine;
using IHostingEnvironment = Umbraco.Cms.Core.Hosting.IHostingEnvironment;

namespace Umbraco.Docs.Samples.Web.CustomIndexing;

public class ProductIndex : UmbracoExamineIndex
{
    public ProductIndex(
        ILoggerFactory loggerFactory,
        string name,
        IOptionsMonitor<LuceneDirectoryIndexOptions> indexOptions,
        IHostingEnvironment hostingEnvironment,
        IRuntimeState runtimeState)
        : base(loggerFactory,
        name,
        indexOptions,
        hostingEnvironment,
        runtimeState)
    {
    }
}
```

#### ConfigureProductIndexOptions

```csharp
using Examine;
using Examine.Lucene;
using Lucene.Net.Analysis.Standard;
using Lucene.Net.Index;
using Lucene.Net.Util;
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core.Configuration.Models;

namespace Umbraco.Docs.Samples.Web.CustomIndexing;

public class ConfigureProductIndexOptions : IConfigureNamedOptions<LuceneDirectoryIndexOptions>
{
    private readonly IOptions<IndexCreatorSettings> _settings;

    public ConfigureProductIndexOptions(IOptions<IndexCreatorSettings> settings)
        => _settings = settings;

    public void Configure(string? name, LuceneDirectoryIndexOptions options)
    {
        if (name?.Equals("ProductIndex") is false)
        {
            return;
        }

        options.Analyzer = new StandardAnalyzer(LuceneVersion.LUCENE_48);

        options.FieldDefinitions = new(
            new("id", FieldDefinitionTypes.Integer),
            new("name", FieldDefinitionTypes.FullText)
        );

        options.UnlockIndex = true;

        if (_settings.Value.LuceneDirectoryFactory == LuceneDirectoryFactory.SyncedTempFileSystemDirectoryFactory)
        {
            // if this directory factory is enabled then a snapshot deletion policy is required
            options.IndexDeletionPolicy = new SnapshotDeletionPolicy(new KeepOnlyLastCommitDeletionPolicy());
        }
    }

    // not used
    public void Configure(LuceneDirectoryIndexOptions options) => throw new NotImplementedException();
}
```

#### ProductIndexValueSetBuilder

```csharp
using Examine;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Infrastructure.Examine

namespace Umbraco.Docs.Samples.Web.CustomIndexing;

public class ProductIndexValueSetBuilder : IValueSetBuilder<IContent>
{
    public IEnumerable<ValueSet> GetValueSets(params IContent[] contents)
    {
        foreach (IContent content in contents.Where(CanAddToIndex))
        {
            var indexValues = new Dictionary<string, object>
            {
                // this is a special field used to display the content name in the Examine dashboard
                [UmbracoExamineFieldNames.NodeNameFieldName] = content.Name!,
                ["name"] = content.Name!,
                // add the fields you want in the index
                ["id"] = content.Id,
            };

            yield return new ValueSet(content.Id.ToString(), IndexTypes.Content, content.ContentType.Alias, indexValues);
        }
    }

    // filter out all content types except "product"
    private bool CanAddToIndex(IContent content) => content.ContentType.Alias == "product";
}
```

#### ProductIndexPopulator

```csharp
using Examine;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Infrastructure.Examine;

namespace Umbraco.Docs.Samples.Web.CustomIndexing;

public class ProductIndexPopulator : IndexPopulator
{
    private readonly IContentService _contentService;
    private readonly ProductIndexValueSetBuilder _productIndexValueSetBuilder;

    public ProductIndexPopulator(IContentService contentService, ProductIndexValueSetBuilder productIndexValueSetBuilder)
    {
        _contentService = contentService;
        _productIndexValueSetBuilder = productIndexValueSetBuilder;
        RegisterIndex("ProductIndex");
    }

    protected override void PopulateIndexes(IReadOnlyList<IIndex> indexes)
    {
        foreach (IIndex index in indexes)
        {
            IContent[] roots = _contentService.GetRootContent().ToArray();
            index.IndexItems(_productIndexValueSetBuilder.GetValueSets(roots));

            foreach (IContent root in roots)
            {
                const int pageSize = 10000;
                var pageIndex = 0;
                IContent[] descendants;
                do
                {
                    descendants = _contentService.GetPagedDescendants(root.Id, pageIndex, pageSize, out _).ToArray();
                    IEnumerable<ValueSet> valueSets = _productIndexValueSetBuilder.GetValueSets(descendants);
                    index.IndexItems(valueSets);

                    pageIndex++;
                }
                while (descendants.Length == pageSize);
            }
        }
    }
}
```

{% hint style="info" %}
This is only an example of how you could do indexing. In this example, we're indexing all content, both published and unpublished.

In certain scenarios only published content should be added to the index. To achieve that, you will need to implement your own logic to filter out unpublished content. This can be somewhat tricky as the published state can vary throughout an entire structure of content nodes in the content tree. For inspiration on how to go about such filtering, you can look at the [ContentIndexPopulator in Umbraco](https://github.com/umbraco/Umbraco-CMS/blob/c878567633a6a3354c1414ccd130c9be518b25f0/src/Umbraco.Infrastructure/Examine/ContentIndexPopulator.cs#L115).
{% endhint %}

#### ProductIndexingNotificationHandler

The index will only update its content when you manually trigger an index rebuild in the Examine dashboard. This is not always the desired behavior for a custom index.

To update your index when content changes, you can use notification handlers.

{% hint style="info" %}
The following handler class does not automatically update the descendant items of the modified content nodes, such as removing descendants of deleted content. If changes to the parent content item can affect its children or descendant items in your setup, refer to the [UmbracoContentIndex.PerformDeleteFromIndex() in Umbraco](https://github.com/umbraco/Umbraco-CMS/blob/main/src/Umbraco.Examine.Lucene/UmbracoContentIndex.cs#L124-L153). Such logic should be applied when both removing and reindexing content items of type _product_.
{% endhint %}

```csharp
using Examine;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Cache;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Services.Changes;
using Umbraco.Cms.Core.Sync;
using Umbraco.Cms.Infrastructure;
using Umbraco.Cms.Infrastructure.Search;

namespace Umbraco.Docs.Samples.Web.CustomIndexing;

public class ProductIndexingNotificationHandler : INotificationHandler<ContentCacheRefresherNotification>
{
    private readonly IRuntimeState _runtimeState;
    private readonly IUmbracoIndexingHandler _umbracoIndexingHandler;
    private readonly IExamineManager _examineManager;
    private readonly IContentService _contentService;
    private readonly ProductIndexValueSetBuilder _productIndexValueSetBuilder;

    public ProductIndexingNotificationHandler(
        IRuntimeState runtimeState,
        IUmbracoIndexingHandler umbracoIndexingHandler,
        IExamineManager examineManager,
        IContentService contentService,
        ProductIndexValueSetBuilder productIndexValueSetBuilder)
    {
        _runtimeState = runtimeState;
        _umbracoIndexingHandler = umbracoIndexingHandler;
        _examineManager = examineManager;
        _contentService = contentService;
        _productIndexValueSetBuilder = productIndexValueSetBuilder;
    }

    /// <summary>
    ///     Updates the index based on content changes.
    /// </summary>
    public void Handle(ContentCacheRefresherNotification notification)
    {
        if (NotificationHandlingIsDisabled())
        {
            return;
        }

        if (!_examineManager.TryGetIndex("ProductIndex", out IIndex? index))
        {
            throw new InvalidOperationException("Could not obtain the product index");
        }

        ContentCacheRefresher.JsonPayload[] payloads = GetNotificationPayloads(notification);

        foreach (ContentCacheRefresher.JsonPayload payload in payloads)
        {
            // Remove
            if (payload.ChangeTypes.HasType(TreeChangeTypes.Remove))
            {
                index.DeleteFromIndex(payload.Id.ToString());
            }
            // Reindex
            else if (payload.ChangeTypes.HasType(TreeChangeTypes.RefreshNode) ||
                     payload.ChangeTypes.HasType(TreeChangeTypes.RefreshBranch))
            {
                IContent? content = _contentService.GetById(payload.Id);
                if (content == null || content.Trashed)
                {
                    index.DeleteFromIndex(payload.Id.ToString());
                    continue;
                }

                IEnumerable<ValueSet> valueSets = _productIndexValueSetBuilder.GetValueSets(content);
                index.IndexItems(valueSets);
            }
        }
    }

    private bool NotificationHandlingIsDisabled()
    {
        // Only handle events when the site is running.
        if (_runtimeState.Level != RuntimeLevel.Run)
        {
            return true;
        }

        if (_umbracoIndexingHandler.Enabled == false)
        {
            return true;
        }

        if (Suspendable.ExamineEvents.CanIndex == false)
        {
            return true;
        }

        return false;
    }

    private ContentCacheRefresher.JsonPayload[] GetNotificationPayloads(CacheRefresherNotification notification)
    {
        if (notification.MessageType != MessageType.RefreshByPayload ||
            notification.MessageObject is not ContentCacheRefresher.JsonPayload[] payloads)
        {
            throw new NotSupportedException();
        }

        return payloads;
    }
}
```

{% hint style="info" %}
You can find further inspiration for implementing notification handlers (_for example, for media updates_) in the [UmbracoExamine.PDF package](https://github.com/umbraco/UmbracoExamine.PDF).
{% endhint %}

#### ExamineComposer

```csharp
using Examine;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Cms.Infrastructure.Examine;

namespace Umbraco.Docs.Samples.Web.CustomIndexing;

[ComposeAfter(typeof(AddExamineComposer))]
public class ExamineComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddExamineLuceneIndex<ProductIndex, ConfigurationEnabledDirectoryFactory>("ProductIndex");

        builder.Services.ConfigureOptions<ConfigureProductIndexOptions>();

        builder.Services.AddSingleton<ProductIndexValueSetBuilder>();

        builder.Services.AddSingleton<IIndexPopulator, ProductIndexPopulator>();

        builder.AddNotificationHandler<ContentCacheRefresherNotification, ProductIndexingNotificationHandler>();
    }
}
```

{% hint style="info" %}
The order of these registrations matters. It is important to register your index with `AddExamineLuceneIndex` before calling `ConfigureOptions`.
{% endhint %}

#### Result

![Custom product index](images/examine-management-product-index.png)

![Product document](images/examine-management-product-document.png)

### A custom index for non-Umbraco data

If you have a need, you can also use an Examine index for other data, that you aren't managing as Umbraco content.

As an illustrative example, consider a collection of books. This example uses a hardcoded collection. In a real-world scenario, the data would more likely come from a database.

```csharp
namespace Umbraco.Docs.Samples.Web.CustomIndexing;

public class Book
{
    public int Id { get; set; }

    public string Title { get; set; } = string.Empty;

    public string Author { get; set; } = string.Empty;

    public int PublishedYear { get; set; }
}

public static class BookData
{
    public static List<Book> GetBooks() =>
        [
            new() { Id = 1, Title = "The Great Gatsby", Author = "F. Scott Fitzgerald", PublishedYear = 1925 },
            new() { Id = 2, Title = "To Kill a Mockingbird", Author = "Harper Lee", PublishedYear = 1960 },
            new() { Id = 3, Title = "1984", Author = "George Orwell", PublishedYear = 1949 },
            new() { Id = 4, Title = "Pride and Prejudice", Author = "Jane Austen", PublishedYear = 1813 },
            new() { Id = 5, Title = "The Catcher in the Rye", Author = "J.D. Salinger", PublishedYear = 1951 }
        ];
}
```

As with the previous example, define an index. At this time, Umbraco data isn't being indexed; the implementation inherits directly from `LuceneIndex`:

```csharp
using Examine.Lucene;
using Examine.Lucene.Providers;
using Microsoft.Extensions.Options;

namespace Umbraco.Docs.Samples.Web.CustomIndexing;

public class BookIndex : LuceneIndex
{
    public BookIndex(
        ILoggerFactory loggerFactory,
        string name,
        IOptionsMonitor<LuceneDirectoryIndexOptions> indexOptions)
        : base(loggerFactory, name, indexOptions)
    {
    }
}
```

The index is customized and fields are defined as before via `IConfigureNamedOptions`:

```csharp
using Examine;
using Examine.Lucene;
using Microsoft.Extensions.Options;

namespace Umbraco.Docs.Samples.Web.CustomIndexing;

public class ConfigureBookIndexOptions : IConfigureNamedOptions<LuceneDirectoryIndexOptions>
{
    public void Configure(string? name, LuceneDirectoryIndexOptions options)
    {
        if (name?.Equals("BookIndex") is false)
        {
            return;
        }

        options.FieldDefinitions = new(
            new("id", FieldDefinitionTypes.Integer),
            new("title", FieldDefinitionTypes.FullText),
            new("author", FieldDefinitionTypes.FullText),
            new("publishedYear", FieldDefinitionTypes.Integer)
        );
    }

    public void Configure(LuceneDirectoryIndexOptions options)
        => Configure(string.Empty, options);
}
```

And once again, a composer is required to register the necessary components:

```csharp
using Examine;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Infrastructure.Examine;

namespace Umbraco.Docs.Samples.Web.CustomIndexing;

[ComposeAfter(typeof(AddExamineComposer))]
public class ExamineComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddExamineLuceneIndex<BookIndex, ConfigurationEnabledDirectoryFactory>("BookIndex");

        builder.Services.ConfigureOptions<ConfigureBookIndexOptions>();
    }
}
```

With this in place, the details of the index will be available under the **Settings** > **Examine Management** > **Indexes** screen.

To verify indexing and querying, a controller can be used:

```csharp
using Examine;
using Microsoft.AspNetCore.Mvc;

namespace Umbraco.Docs.Samples.Web.CustomIndexing;

[ApiController]
[Route("/umbraco/api/books")]
public class BooksController : ControllerBase
{
    private readonly IExamineManager _examineManager;

    public BooksController(IExamineManager examineManager) => _examineManager = examineManager;

    [HttpPost("populateIndex")]
    public async Task<IActionResult> PopulateIndex()
    {
        if (_examineManager.TryGetIndex("BookIndex", out IIndex? index) == false)
        {
            throw new InvalidOperationException("Book index not found");
        }

        List<Book> books = BookData.GetBooks();
        foreach (Book book in books)
        {
            index.IndexItems(
            [
                ValueSet.FromObject(
                    book.Id.ToString(),
                    "Book",
                    book),
            ]);
        }

        return Ok("Done");
    }

    [HttpGet("query")]
    public async Task<IActionResult> Query(string q)
    {
        if (_examineManager.TryGetIndex("BookIndex", out IIndex? index) == false)
        {
            throw new InvalidOperationException("Book index not found");
        }

        var results = index.Searcher.Search(q)
            .Select(x => new BookDto(x.Values["title"], x.Values["author"], int.Parse(x.Values["publishedYear"])))
            .ToList();
        return Ok(results);
    }

    private class BookDto
    {
        public BookDto(string title, string author, int publishedYear)
        {
            Title = title;
            Author = author;
            PublishedYear = publishedYear;
        }

        public string Title { get; }

        public string Author { get; }

        public int PublishedYear { get; }
    }
}
```





