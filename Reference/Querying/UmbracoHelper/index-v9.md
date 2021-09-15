---
versionFrom: 9.0.0
meta.Title: "Umbraco Helper"
meta.Description: "Using the Umbraco Helper"
state: complete
verified-against: rc-003
update-links: true
---

# UmbracoHelper

UmbracoHelper is the unified way to work with published content/media on your website. You can use the UmbracoHelper to query/traverse Umbraco published data.

UmbracoHelper also has a variety of helper methods that are useful when working in your views and controllers.

## How to reference UmbracoHelper

If you are using Views or Partial View Macros you can reference UmbracoHelper with the syntax: `@Umbraco`

If you need the `UmbracoHelper` in your own controllers, you need to inject `IUmbracoHelperAccessor`, and resolve the helper with the `TryGetUmbracoHelper` method. A `HttpContext` is required to use the `UmbracoHelper`, if the helper cannot be resolved the `TryGetUmbracoHelper` method will return false. 

Example of getting `UmbracoHelper` in a controller:

```C#
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Web.Common;
using Umbraco.Cms.Web.Common.Controllers;

namespace UmbracoHelperDocs.Controllers
{
    [Route("customcontent/[action]")]
    public class CustomContentController : UmbracoApiController
    {
        private readonly IUmbracoHelperAccessor _umbracoHelperAccessor;

        public CustomContentController(IUmbracoHelperAccessor umbracoHelperAccessor)
        {
            // Inject IUmbracoHelperAccessor
            _umbracoHelperAccessor = umbracoHelperAccessor;
        }

        public ActionResult<string> GetHomeNodeName()
        {
            // Try and get the UmbracoHelper
            if (_umbracoHelperAccessor.TryGetUmbracoHelper(out var umbracoHelper) is false)
            {
                // If TryGetUmbracoHelper returns false, we couldn't get the helper because there was no HTTP Context
                // This should not happen in an Umbraco Controller
                return StatusCode(500);
            }

            // Do something with the UmbracoHelper
            var rootNode = umbracoHelper.ContentAtRoot().FirstOrDefault();
            if (rootNode is null)
            {
                return NotFound();
            }

            return rootNode.Name;
        }
    }
}
```

## IPublishedContent

UmbracoHelper will expose all content in the form of `IPublishedContent`. To get a reference to the currently executing content item from the UmbracoHelper, use `UmbracoHelper.AssignedContentItem`.

The samples below demonstrate using `UmbracoHelper` in Razor. Working with the `UmbracoHelper` will be the same in controllers, except for the fact that you must resolve it with `IUmbracoHelperAccessor` like shown above.

## Working with Content

### .Content(Guid id)

Given a node ID, returns a `IPublishedContent`

```csharp
@{
	var pageFromGui = Umbraco.Content(Guid.Parse("af22cb83-9bd4-454b-ab06-cc19ac8e983d"));
}

<h3>@pageFromGui.Value("propertyAlias")</h3>

@foreach (var child in pageFromGui.Children)
{
	<a href="@child.Url()">@child.Name</a>
}
```

### .ContentAtRoot()

Returns a collection of `IPublishedContent` objects from the Content tree.

```csharp
@* Get the children of the first content item found in the root *@
@foreach (var child in Umbraco.ContentAtRoot().First().Children)
{
	<a href="@child.Url()">@child.Name</a>
}
```

### .ContentAtXPath(string xpath)

Queries the cache for content matching a given XPath query and returns a collection of `IPublishedContent` objects.

```csharp
@{
    var newsArticles = Umbraco.ContentAtXPath("//newsArticle");
    var bodyText = newsArticles.First().Value("bodyText");
}
```

### .ContentSingleAtXPath(string xpath)

Queries the cache for content matching a given XPath query and returns the first match as an `IPublishedContent` object.

```csharp
@{
    var newsArticle = Umbraco.ContentSingleAtXPath("//newsArticle");
    var bodyText = newsArticle.Value("bodyText");
}
```

## Working with Media

### .Media(Guid id)

Given a node ID, returns an `IPublishedContent` Media entity

```csharp
@{
    var media = Umbraco.Media(Guid.Parse("ca4249ed-2b23-4337-b522-63cabe5587d1"));
    var image = media.Url();
    var height = media.Value<int>("umbracoHeight");
}
```

### .MediaAtRoot()

Returns a collection of `IPublishedContent` objects from the Media tree.

```csharp
@foreach (var child in Umbraco.MediaAtRoot())
{
	<img src="@child.Url()"/>
}
```

## Working with Tags



## Working with Members

### .Member(1234)

Given a node ID, returns a single `IPublishedContent` Member 

```csharp
@{
    var member = Umbraco.MembershipHelper.GetById(Guid.Parse("1f46e266-9acb-4f5b-afdb-5e26c23c56e3"));
    var email = member.Value<string>("email");
}
```

### Member Helpers

### .MemberIsLoggedOn()

Returns a `Boolean` on whether there is currently a member profile

```csharp
@if(Umbraco.MemberIsLoggedOn()) {
    <h1>Welcome!</h1>
}
```

### .MemberHasAccess(string path)

Returns a `Boolean` on whether the currently logged in member has access to the page given its [Umbraco path](../IPublishedContent/Properties.md#path).

```csharp
@if (Umbraco.MemberHasAccess(Model.Path))
{
    <h1>Welcome!</h1>
}
```

### .IsProtected(string path)

Returns a `Boolean` on whether a page with a given [Umbraco path](../IPublishedContent/Properties.md#path) has public access restrictions set.

```csharp
@foreach (var child in Model.Children) {
    <h2>@child.Name</h2>
    if(Umbraco.MembershipHelper.IsProtected(child.Path)){
        <blink>Members only</blink>
    }
}
```

## Fetching miscellaneous data

### .GetDictionaryValue(string key)

Returns a dictionary value(`string`) for the key specified.

```html
<p>@Umbraco.GetDictionaryValue("createdOn"): @Model.CreateDate</p>
```

Alternatively, you can also specify an `altText` which will be returned if the dictionary value is empty.

```html
<p>@Umbraco.GetDictionaryValue("createdOn", "Date Created"): @Model.CreateDate</p>
```

### .Search(string term)

By default, Umbraco searches it's 'External' search index for any published content matching the provided search term. 

```csharp
@{
    <ul>
        @foreach (var result in Umbraco.ContentQuery.Search("ipsum"))
        {
            <li><a href="@result.Content.Url">@result.Content.Name</a></li>
        }
    </ul>
}
```

### .Search(string term, int skip, int take, out long totalRecords)

Specifying the number of records 'to skip', and the number of records 'to take' is more performant when there are lots of matching search results and there is a requirement to implement paging.

```csharp
@{
    var search = Umbraco.ContentQuery.Search("ipsum", 5, 10, out long totalRecords);
    <ul>
        <li>
            Total results: @totalRecords
            <ul>
                @foreach (var result in search)
                {
                    <li><a href="@result.Content.Url">@result.Content.Name</a></li>
                }
            </ul>
        </li>
    </ul>
}
```

### .Search(IQueryExecutor queryExecutor)

For more complex searching you can construct an Examine QueryExecutor. In the example the search will execute against content of type "blogPost" only.
[Further information on using Examine](../../Searching/Examine/Quick-Start/index.md#different-ways-to-query)

```csharp
@{
    if (!ExamineManager.Instance.TryGetIndex(Constants.UmbracoIndexes.ExternalIndexName, out IIndex index))
    {
        throw new InvalidOperationException($"No index found by name{ Constants.UmbracoIndexes.ExternalIndexName }");
    }

    var term = "ipsum";
    var query = index.GetSearcher().CreateQuery(IndexTypes.Content);
    var queryExecutor = query.NodeTypeAlias("blogPost").And().ManagedQuery(term);

    foreach (var result in Umbraco.ContentQuery.Search(queryExecutor))
    {
        {
            <li><a href="@result.Content.Url">@result.Content.Name</a></li>
        }
    }
}
```

## Templating Helpers

### .RenderMacro(string alias, object parameters)

Renders a macro in the current page content, given the macro's alias, and parameters required by the macro.

```csharp
@Umbraco.RenderMacro("navigation", new {root="1083", header="Hello"})
```

### .RenderTemplate(int contentId, int? altTemplateId)

Renders a template, as if a page with the given contentId was requested, optionally with an alternative template ID passed in.

```csharp
@Umbraco.RenderTemplate(1234)
```
