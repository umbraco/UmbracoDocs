---


---

# Examine Manager


Accessing the singleton can be done by using dependency injection. 

In a class you can inject the IExamineManager interface:

```csharp
using Examine;

namespace MyCustomUmbracoSolution
{
    public class MyClass
    {
        private readonly IExamineManager _examineManager;
        public MyClass(IExamineManager examineManager)
        {
            _examineManager = examineManager;
        }
    }
}
```
In a view the IExamineManager can be injected as well: 

```csharp
@inject IExamineManager ExamineManager;
```

This returns an active instance of the ExamineManager which exposes operations such as:

* Default index & search providers
* Full collection of index & search providers
* All indexing and searching methods

## Searching

It's important to highlight that the `Search` methods on the ExamineManager will call the Search methods of the **default** search provider specified in config. If you wish to search using a specified provider, you can retrieve it from the `SearchProviderCollection` (see example below).

You can access any of the searchers by their name, for example:

```csharp
var canGetSearcher = _examineManager.TryGetSearcher("ExternalSearcher", out var searcher);
```

For searching the method to use is:

```chsarp
ISearchResults Search(string searchText);
```

An example using this method is below:

```csharp
@inherits UmbracoViewPage
@using Examine
@inject IExamineManager ExamineManager
@{
    var query = Context.Request.Query["query"];
    var canGetSearcher = ExamineManager.TryGetSearcher("ExternalSearcher", out var searcher);

    if (canGetSearcher)
    {
        var searchResults = searcher.Search(query.ToString());
        if(searchResults.Any())
        {
            <ul>
                @foreach (var result in searchResults)
                {
                    if (result.Id != null)
                    {
                        var node = Umbraco.Content(result.Id);
                        <li>
                            <a href="@node.Url()">@node.Name</a>
                        </li>
                    }
                }
            </ul>
        }
    }
}
```

## Indexing

When you wanna populate an index, you will need to use the `IExamineManager` and get the specific index. The build-in index names are all available as constants from the `Umbraco.Cms.Core.Constants.UmbracoIndexes` namespace

```csharp
if (_examineManager.TryGetIndex(Umbraco.Cms.Core.Constants.UmbracoIndexes.ExternalIndexName, out IIndex index))
{
   // Use index here
}
```

The indexing methods available on a single index are:

```csharp
void DeleteFromIndex(IEnumerable<string> itemIds);
void DeleteFromIndex(this IIndex index, string itemId);
void IndexExists();
void IndexItems(IEnumerable<ValueSet> values);
```
