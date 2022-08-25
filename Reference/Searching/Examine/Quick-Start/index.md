---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# Quick start

_This guide will help you get set up quickly using Examine with minimal configuration options. Umbraco ships Examine with 3 indexes: internal, external, and members. The internal index should not be used for searching when returning results on a public website because it includes content that has not been published yet. Instead, you can use the external index to get up and running._

## Performing a search

:::note
In the coming examples the [Umbraco Starter Kit](https://our.umbraco.com/packages/starter-kits/the-starter-kit/) has been used, as it provides some example content that can be searched. Some of the examples below therefore may require 'the setting up of templates, etc' if you are following the guide on your own existing site.
:::

The starter kit comes with some Templates, Document Types and content nodes created already. We will use some of these to set up a basic search system. This is a 'Quick Start' guide, as much more complex searches are possible with Examine.

We will make it possible to 'search' on the _People_ page, by adding a search bar to the template page: `people.cshtml` - add the following form at the top of the template, but underneath the `<nav>` element:

```csharp
...
</nav>
-->
<div>
    <form action="@Model.Url()" method="get">
        <input type="text" placeholder="Search" name="query"/>
        <button>Search</button>
    </form>
</div>
<div class="employee-grid">
...
```
This will create a basic input field at the top of the page and make it post to the same people page when submitted along with the search term.
### Handling the search request

The best practice for POST requests is to encapsulate the request handling in a controller. To do this we will leverage the concept of [route hijacking](https://our.umbraco.com/documentation/reference/routing/custom-controllers/).

Lets start by creating a `PeopleController` that derives from `RenderController` and add an `Index` method.

:::note
It is important to name our controller by the convention `_NameOfViewController_`. In our case the view is named People, so the controller is named `PeopleController`.
:::
```csharp
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ViewEngines;
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Web.Common.Controllers;

namespace MyStarterKitSite.Controllers;
public class PeopleController : RenderController
{
    public PeopleController(
    ILogger<RenderController> logger,
    ICompositeViewEngine compositeViewEngine,
    IUmbracoContextAccessor umbracoContextAccessor)
    : base(
        logger,
        compositeViewEngine,
        umbracoContextAccessor)
    {
    }

    public override IActionResult Index()
    {
        return CurrentTemplate(CurrentPage);
    }
}
```


### Adding a Service that handles our search logic
To search anything from our controller, we first need to create a service that handles the actual search logic. We'll start by create an interface for our service.

```csharp
using System.Collections.Generic;
using Umbraco.Cms.Core.Models.PublishedContent;
namespace MyStarterKitSite.Services;

public interface ISearchService
{
    IEnumerable<IPublishedContent> SearchContentNames(string query);
}

```

Now create a default implementation of the service interface.

```csharp
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Web.UI.Services;

public class SearchService : ISearchService
{
    public IEnumerable<IPublishedContent> SearchContentNames(string query) => throw new NotImplementedException();
}
```

And finally register the service in `Startup`.

```csharp
public void ConfigureServices(IServiceCollection services)
{
    // ... (removed for abbreviation)
    services.AddTransient<ISearchService, SearchService>();
}
```

### Examine Search Index
To perform the search we will first need to get a reference to the particular Examine index that we want to search. Then we will use this index to access its corresponding `Searcher`. We use the `Searcher` to construct the query logic to execute and search the index.

Umbraco ships with three indexes:
* ExternalIndex - available to use for indexing published unprotected content.
* InternalIndex - which Umbraco's backoffice search uses.
* InternalMemberIndex - which Umbraco's Membership implementation uses.

([You can create your own indexes too](../indexing)) if you need to analyse text in a different language for example.

The service `IExamineManager` is used to retrieve an Examine index by its 'alias', so we need to inject that service into our `SearchService`.
```csharp
using System.Collections.Generic;
using Examine;
using Umbraco.Cms.Core.Models.PublishedContent;

namespace MyStarterKitSite.Services;

public class SearchServices : ISearchService
{
    private readonly IExamineManager _examineManager;
    public SearchServices(IExamineManager examineManager)
    {
        _examineManager = examineManager;
    }
    public IEnumerable<IPublishedContent> SearchContentNames(string query) => throw new NotImplementedException();
}
```

### Creating the Search Query
With the `IExamineManager` injected in our `SearchService`, we can implement the `SearchContentNames` method. We do this using the `Searcher` for the Examine index 'ExternalIndex'.

```csharp
IEnumerable<string> ids = Array.Empty<string>();
if (!string.IsNullOrEmpty(query) && _examineManager.TryGetIndex("ExternalIndex", out IIndex? index))
{
    ids = index
        .Searcher
        .CreateQuery("content")
        .NodeTypeAlias("person")
        .And()
        .Field("nodeName", query)
        .Execute()
        .Select(x => x.Id);
}
```

:::tip
We reference the External index by it's alias "ExternalIndex". Umbraco has a set of 'Constants' that refer to the indexes that can be more convenient to use `Constants.UmbracoIndexes`. So, in the example here we could have used `Constants.UmbracoIndexes.ExternalIndexName` instead of "ExternalIndex".
:::

The `Searcher` has a CreateQuery method, where you can choose to search content, media or members eg:
```csharp
Searcher.CreateQuery("content")
```

From here you can see how we can chain together the logic to perform the search. In the example we are searching all `content` using the `person` Document Type, where the `nodeName` is equal to the search term that was typed in the input bar.

```csharp
Searcher.CreateQuery("content").NodeTypeAlias("person").And().Field("nodeName", searchTerm)
```

Calling `.Execute()` at the end of the query logic triggers the search and returns a set of matching search results, which we can loop through to get the IDs of the resulting content items.
## Getting the content
We want to retrieve the actual content from the IDs. For that we need the `UmbracoHelper`, so let's go ahead and inject that into our `SearchService`.
```csharp
private readonly IExamineManager _examineManager;
private readonly UmbracoHelper _umbracoHelper;

public SearchService(IExamineManager examineManager, UmbracoHelper umbracoHelper)
{
    _examineManager = examineManager;
    _umbracoHelper = umbracoHelper;
}
```

The final method looks like this:
```csharp
public IEnumerable<IPublishedContent> SearchContentNames(string query)
{
    IEnumerable<string> ids = Array.Empty<string>();
    if (!string.IsNullOrEmpty(query) && _examineManager.TryGetIndex("ExternalIndex", out IIndex? index))
    {
        ids = index.Searcher.CreateQuery("content").NodeTypeAlias("person").And().Field("nodeName", query).Execute()
            .Select(x => x.Id);
    }

    foreach (var id in ids)
    {
        yield return _umbracoHelper.Content(id);
    }
}
```
After getting the ids from our search, we then loop through the list, and return the content.

# Creating a custom viewmodel
We will now need a custom view model, so that we can pass our search results to the view.
Our view model needs to inherit from `PublishedContentWrapped`, because our People view is expecting a model that is content.
We then wrap the content and add the search data, all in a convenient view model.
```csharp
using System.Collections.Generic;
using System.Linq;
using Umbraco.Cms.Core.Models.PublishedContent;

namespace MyStarterKitSite.Models;

public class SearchViewModel : PublishedContentWrapped
{
    public SearchViewModel(IPublishedContent content, IPublishedValueFallback publishedValueFallback)
        : base(content, publishedValueFallback)
    {
    }

    public IEnumerable<IPublishedContent> SearchResults { get; set; } = Enumerable.Empty<IPublishedContent>();
    public bool HasSearched { get; set; }
}
```

## Using the service and view model in the controller
Now that we've created our service to handle the actual search logic, and our view model to pass the search results to the view, lets look at using them in the controller.
We will want to update the `Index()` method to get out the query string from the request, then create a view model and populate the `SearchResults` property by using our service.
```csharp
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ViewEngines;
using Microsoft.Extensions.Logging;
using MyStarterKitSite.Models;
using MyStarterKitSite.Services;
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Web.Common.Controllers;

namespace MyStarterKitSite.Controllers;

public class PeopleController : RenderController
{
    private readonly IPublishedValueFallback _publishedValueFallback;
    private readonly ISearchService _searchService;

    public PeopleController(
        ILogger<RenderController> logger,
        ICompositeViewEngine compositeViewEngine,
        IUmbracoContextAccessor umbracoContextAccessor,
        IPublishedValueFallback publishedValueFallback,
        ISearchService searchService)
        : base(logger,
            compositeViewEngine,
            umbracoContextAccessor)
    {
        _publishedValueFallback = publishedValueFallback;
        _searchService = searchService;
    }

    public override IActionResult Index()
    {
        // Get the queryString from the request
        string queryString = HttpContext.Request.Query["query"];

        // Create the view model and pass it to the view
        SearchViewModel viewModel = new(CurrentPage!, _publishedValueFallback)
        {
            SearchResults = _searchService.SearchContentNames(queryString),
            HasSearched = !string.IsNullOrEmpty(queryString),
        };

        return CurrentTemplate(viewModel);
    }
}
```

## Updating the view to use the viewmodel
The final thing we need to do is update the view to use our new view model. We do that by changing the `@inherits` line in the view.
```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<MyStarterKitSite.Models.SearchViewModel>
```
Lets now use the view model to display the search results. We'll place them directly under the form we created earlier.
```csharp
<div>
    @if (Model.SearchResults.Any())
    {
        <ul>
            @foreach (var content in Model.SearchResults)
            {
                <li>
                    <a href="@content.Url()">@content.Name</a>
                </li>
            }
        </ul>
    }
    else if(Model.HasSearched)
    {
        <p>No results found</p>
    }
</div>
```

# Different ways to query
Examine has a lot of different ways to query data. Building upon the example from before, here are a few other searches that can be done to get different data:
### Search through all nodes
Let's say you want to search through **all content nodes** by their **file names**. You could amend the query from before like this:
```csharp
Searcher.CreateQuery("content").Field("nodeName", searchTerm).Execute();
```
### Search using Lucene queries
To do the search like above, but only use Lucene to query, amend the query from before like this:
```csharp
Searcher.CreateQuery().NativeQuery("+__IndexType:content +nodeName:" + searchTerm).Execute();
```
### Search children of a specific node
To search through **all child nodes of a specific node** by their **bodyText property**, amend the query from before like this:
```csharp
Searcher.CreateQuery("content").ParentId(1105).And().Field("bodyText", searchTerm).Execute();
```

### Search descendants of a specific home node

To search through **all descendants of a specific node** by their **bodyText property**, refer to [this article](../examine-events#Adding-the-path-of-the-node-as-a-searchable-field-into-the-index).

