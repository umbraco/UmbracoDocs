---
versionFrom: 9.0.0
versionTo: 10.0.0
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

Important to note that the `Search` methods on the ExamineManager will call the Search methods of the **default** search provider specified in config. If you want to search using a specified provider, you can retrieve it from the `SearchProviderCollection` (see example below).

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

When calling the index methods on the `ExamineManager` it will call the same methods on every Indexer that is registered. If for some reason you require to only call the index methods on a particular provider then you can access the provider by name, for example:

```csharp
var canGetIndex = ExamineManager.TryGetIndex("ExternalIndexer", out var index);
```

The indexing methods available are:

```csharp
void DeleteFromIndex(IEnumerable<string> itemIds);
void DeleteFromIndex(this IIndex index, string itemId);
```
