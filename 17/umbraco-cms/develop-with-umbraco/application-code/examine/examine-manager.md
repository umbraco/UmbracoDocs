# Examine Manager

Accessing the singleton can be done by using dependency injection.

In a class you can inject the IExamineManager interface:

```csharp
using Examine;

namespace MyCustomUmbracoSolution;

public class MyClass
{
    private readonly IExamineManager _examineManager;
    public MyClass(IExamineManager examineManager)
    {
        _examineManager = examineManager;
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

Important to note that the `Search` methods on the ExamineManager will call the Search methods of the **default** search provider specified in config. If you want to search using a specific provider, there are generally two approaches for this.

If you want to use the searcher of a specific index, you should get the the searcher via the index:

```csharp
@inherits UmbracoViewPage
@using Examine
@using Umbraco.Cms.Core
@inject IExamineManager ExamineManager
@{

    // Get the search text from the query string
    string query = Context.Request.Query["query"];

    // Try to get the "ExternalIndex" from the Examine manager
    if (ExamineManager.TryGetIndex(Constants.UmbracoIndexes.ExternalIndexName, out IIndex index))
    {

        // Search via the searcher of the index
        ISearchResults searchResults = index.Searcher.Search(query);

        // Check whether the search revealed any results
        if (searchResults.Any())
        {
            <ul>
                @foreach (ISearchResult result in searchResults)
                {

                    // Skip the result if the ID is null
                    if (result.Id is null) continue;

                    // Skip the result if not found in the content cache
                    if (Umbraco.Content(result.Id) is not {} node) continue;

                    <li>
                        <a href="@node.Url()">@node.Name</a>
                    </li>

                }
            </ul>
        }

    }

}
```

If you have configured a custom searcher that you wish to use instead, you can access the searcher directly via the `IExamineManager` instance:

```csharp
bool canGetSearcher = ExamineManager.TryGetSearcher("MyCustomSearcher", out ISearcher searcher);
```

An example using a custom searcher is below:

```csharp
@inherits UmbracoViewPage
@using Examine
@inject IExamineManager ExamineManager
@{

    // Get the search text from the query string
    string query = Context.Request.Query["query"];

    // Try to get the "MyCustomSearcher" searcher
    if (ExamineManager.TryGetSearcher("MyCustomSearcher", out ISearcher searcher))
    {

        // Search via the searcher
        ISearchResults searchResults = searcher.Search(query);

        // Check whether the search revealed any results
        if (searchResults.Any())
        {
            <ul>
                @foreach (ISearchResult result in searchResults)
                {

                    // Skip the result if the ID is null
                    if (result.Id is null) continue;

                    // Skip the result if not found in the content cache
                    if (Umbraco.Content(result.Id) is not {} node) continue;

                    <li>
                        <a href="@node.Url()">@node.Name</a>
                    </li>

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
