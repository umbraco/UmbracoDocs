---
versionFrom: 8.0.0
---

# Searchable Trees (ISearchableTree)

When you type a search term into the Umbraco backoffice search field, you'll see search results from all the Section Trees that your user account has permissions to access:

![Content Section Dashboards](images/backoffice-search-v8.png)

The results are grouped by 'Section Tree' e.g. Content, Media, Document Types: essentially, each 'Tree' has its own associated search mechanism that receives the search term and looks for matches in the tree that is responsible for searching.

You can create your own search mechanisms for your own custom sections or replace the default search implementation for a particular section tree.

## Custom Tree Search

To create a search for your own custom tree you need to create a C# class that implements the interface `Umbraco.Web.Search.ISearchableTree`.

### ISearchableTree

```csharp
public interface ISearchableTree
{
    //
    // Summary:
    //     The alias of the tree that the Umbraco.Web.Search.ISearchableTree belongs to
    string TreeAlias { get; }

    //
    // Summary:
    //     Searches for results based on the entity type
    // Parameters:
    //   query:
    //   pageSize:
    //   pageIndex:
    //   totalFound:
    //   searchFrom:
    //     A starting point for the search, generally a node id, but for members this is
    //     a member type alias
    IEnumerable<SearchResultEntity> Search(string query, int pageSize, long pageIndex, out long totalFound, string searchFrom = null);
}
```

Your implementation needs to return an IEnumerable of `SearchResultEntity` items:

```csharp
public class SearchResultEntity : EntityBasic
{
    public SearchResultEntity();

    //
    // Summary:
    //     The score of the search result
    [System.Runtime.Serialization.DataMemberAttribute(Name = "score")]
    public float Score { get; set; }
}
```

A `SearchResultEntity` consists of a Score (a Float value) identifying its relevance to the search term, and the set of `EntityBasic` properties that all Umbraco objects share: eg Name, Id, Udi, Icon, Trashed, Key, ParentId, Path, Alias, AdditionalData.

#### Example implementation of ISearchableTree

If we have a custom section Tree with alias 'favouriteThingsAlias' (see the [custom tree example](../trees-v7.md)) then we could implement searchability by creating the following c# class in our site:

```csharp
  public class FavouriteThingsSearchableTree : ISearchableTree
    {
        public string TreeAlias => "favouriteThingsAlias";

        public IEnumerable<SearchResultEntity> Search(string query, int pageSize, long pageIndex, out long totalFound, string searchFrom = null)
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
                // making up the Id/Udi for this example! - these would normally be different for each search result.
                searchResults.Add(new SearchResultEntity() { Id = 12345, Alias = "favouriteThingItem", Icon = "icon-favorite", Key = new Guid("325746a0-ec1e-44e8-8f7b-6e7c4aab36d1"), Name = matchingItem.Value, ParentId = -1, Path = "-1,123456", Score = 1.0F, Trashed = false, Udi = Udi.Create("document", new Guid("325746a0-ec1e-44e8-8f7b-6e7c4aab36d1")) });
            }
            // set number of search results found
            totalFound = matchingItems.Count();
            // return your IEnumerable of SearchResultEntity
            return searchResults;
        }
    }
```

That's all we need, after an application pool recycle, if we now search in the backoffice we'll see matches from our custom 'Favourite Things' tree:

![Content Section Dashboards](images/favouritethings-search-v8.png)

Umbraco automatically finds any implementation of ISearchableTree in your site, and automatically configures it to be used for the custom section mentioned in the TreeAlias property. Be careful not to accidentally have two ISearchableTree implementations trying to search the 'same' TreeAlias, it's *one* ISearchableTree per TreeAlias!

## Replacing an existing Section Tree Search (SearchableTreeResolver)

Perhaps you want to change the logic for searching an existing section of the site, (why? - well you might have a 'company name' property on a MemberType in the Member section, and you want searches for that company name to filter the members who work there, the default implementation will only search on Member Name)

Or perhaps you want to replace Examine search in the backoffice with an external Search Service, e.g. Azure Search. In a cloud hosted implementation you don't need to build the Examine indexes on each new server as your cloud hosting scales out.

### Example

First create your replacement custom `ISearchableTree` implementation, using the same approach as above, but specifying the TreeAlias of the Tree you aim to replace, e.g. 'Member'

```csharp
public string TreeAlias => "member";
```
To avoid your custom implementation clashing with the default `ISearchableTree` for a Tree, you need to remove its `ISearchableTree` implementation from the collection of SearchableTrees using an IUserComposer when Umbraco starts up:

```csharp
using Umbraco.Core.Components;
using Umbraco.Web;

namespace My.Website
{
    [RuntimeLevel(MinLevel = RuntimeLevel.Run)]
    public class RemoveCoreMemberSearchableTreeComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {
            //Remove core MemberTreeController
            composition.SearchableTrees().Exclude<MemberTreeController>();
        }
    }
}
```

This would then allow your custom implementation of ISearchableTree with TreeAlias 'Member' to be used when searching the Member Section Tree.
