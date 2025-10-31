# Searchable Trees (ISearchableTree)

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

When you type a search term into the Umbraco backoffice search field, you'll see search results from all the Section Trees that your user account has permission to access:

![Content Section Dashboards](<../../../17/umbraco-cms/.gitbook/assets/backoffice-search-v8 (1).png>)

The results are grouped by 'Section Tree' like Content, Media, Document Types. Each 'Tree' has its own associated search mechanism that receives the search term and looks for matches in the tree that is responsible for searching.

You can create your own search mechanisms for your own custom sections or replace the default search implementation for a particular section tree.

## Custom Tree Search

To create a search for your own custom tree you need to create a C# class that implements the interface `Umbraco.Cms.Core.Trees.ISearchableTree`.

### ISearchableTree

```csharp
using System.Collections.Generic;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Models.ContentEditing;

namespace My.Website;

public interface ISearchableTree : IDiscoverable
{
    /// <summary>
    /// The alias of the tree that the <see cref="ISearchableTree"/> belongs to
    /// </summary>
    string TreeAlias { get; }

    /// <summary>
    /// Searches for results based on the entity type
    /// </summary>
    /// <param name="query">The search term used for finding matching results.</param>
    /// <param name="pageSize">The number of records to return for a page of results.</param>
    /// <param name="pageIndex">The 0-based index for retrieving a page of search results.</param>
    /// <param name="totalFound">Populated with the total number of results matching the provided search term.</param>
    /// <param name="searchFrom">
    ///     The starting point for the search, generally a node ID, but for members this is a member type alias.
    /// </param>
    /// <returns></returns>
    Task<EntitySearchResults> SearchAsync(string query, int pageSize, long pageIndex, string? searchFrom = null);
}
```

Your implementation needs to return an IEnumerable of `SearchResultEntity` items:

```csharp
public class SearchResultEntity : EntityBasic
{
    public SearchResultEntity() {
        /// <summary>
        /// The score of the search result
        /// </summary>
        [DataMember(Name = "score")]
        public float Score { get; set; }
    };

}
```

A `SearchResultEntity` consists of a Score (a Float value) identifying its relevance to the search term, and the set of `EntityBasic` properties that all Umbraco objects share: eg Name, Id, Udi, Icon, Trashed, Key, ParentId, Path, Alias, AdditionalData.

#### Example implementation of ISearchableTree

If we have a custom section Tree with the alias 'favouriteThingsAlias' (see the [custom tree example](extending-overview/extension-types/tree.md)) then we could implement searchability by creating the following C# class in our site:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Models.ContentEditing;
using Umbraco.Cms.Core.Trees;

namespace Umbraco.Docs.Samples.Web.Trees;

public class FavouriteThingsSearchableTree : ISearchableTree
{
    public string TreeAlias => "favouriteThingsAlias";

    public async Task<EntitySearchResults> SearchAsync(string query, int pageSize, long pageIndex, string searchFrom = null)
    {
        // your custom search implementation starts here
        Dictionary<int, string> favouriteThings = new Dictionary<int, string>();
        favouriteThings.Add(1, "Raindrops on Roses");
        favouriteThings.Add(2, "Whiskers on Kittens");
        favouriteThings.Add(3, "Skys full of Stars");
        favouriteThings.Add(4, "Warm Woolen Mittens");
        favouriteThings.Add(5, "Cream coloured Unicorns");
        favouriteThings.Add(6, "Schnitzel with Noodles");

        var searchResults = new List<SearchResultEntity>();

        var matchingItems = favouriteThings.Where(f => f.Value.StartsWith(query, true, System.Globalization.CultureInfo.CurrentCulture));
        foreach (var matchingItem in matchingItems)
        {
            // Making up the Id/Udi for this example! - these would normally be different for each search result.
            searchResults.Add(new SearchResultEntity()
            {
                Id = 12345,
                Alias = "favouriteThingItem",
                Icon = "icon-favorite",
                Key = new Guid("325746a0-ec1e-44e8-8f7b-6e7c4aab36d1"),
                Name = matchingItem.Value,
                ParentId = -1,
                Path = "-1,12345",
                Score = 1.0F,
                Trashed = false,
                Udi = Udi.Create("document", new Guid("325746a0-ec1e-44e8-8f7b-6e7c4aab36d1"))
            });
        }
        // Set number of search results found
        var totalFound = matchingItems.Count();
        // Return your results
        return new EntitySearchResults(searchResults, totalFound);
    }
}
```

That's all we need, after an application pool recycle, if we now search in the backoffice we'll see matches from our custom 'Favourite Things' tree:

![Content Section Dashboards](<../../../17/umbraco-cms/.gitbook/assets/favouritethings-search-v8 (1).png>)

Umbraco automatically finds any implementation of `ISearchableTree` in your site and automatically configures it to be used for the custom section mentioned in the TreeAlias property. Be careful not to accidentally have two `ISearchableTree` implementations trying to search the 'same' TreeAlias, it's _one_ `ISearchableTree` per TreeAlias.

## Replacing an existing Section Tree Search

Perhaps you want to change the logic for searching an existing section of the site, (why? - well you might have a 'company name' property on a MemberType in the Member section, and you want searches for that company name to filter the members who work there, the default implementation will only search on Member Name).

Or perhaps you want to replace Examine search in the backoffice with an external Search Service, e.g. Azure Search. In a cloud-hosted implementation you don't need to build the Examine indexes on each new server as your cloud hosting scales out.

### Example

First create your replacement custom `ISearchableTree` implementation, using the same approach as above, but specifying the TreeAlias of the Tree you aim to replace, e.g. 'Member'.

```csharp
public string TreeAlias => "member";
```

To avoid your custom implementation clashing with the default `ISearchableTree` for a Tree, you need to remove its `ISearchableTree` implementation from the collection of SearchableTrees using an `IComposer` when Umbraco starts up:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Web.BackOffice.Trees;

namespace Umbraco.Docs.Samples.Web.Trees;

public class RemoveCoreMemberSearchableTreeComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        // Remove core MemberTreeController
        builder.SearchableTrees().Exclude<MemberTreeController>();
    }
}
```

This would then allow your custom implementation of `ISearchableTree` with TreeAlias 'member' to be used when searching the Member Section Tree.
