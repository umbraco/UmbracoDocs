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

Previously the `UmbracoHelper` could be used to work with tags, this has been moved out of `UmbracoHelper` and is now available from `ITagQuery` which you can read more about in the [ITagQuery document](../ITagQuery/index.md).


## Working with Members

Previously the `UmbracoHelper` could be used to work with members, this has ben moved out of `UmbracoHelper` and is now available from `IMemberManager`, see [IMemberManager](../IMemberManager/index.md) for more information

## Searching

Previously the `UmbracoHelper` could be used to run queries on your content, this has been moved out of `UmbracoHelper` and is now available from `IPublishedContentQuery`, see [IPublishedContentQuery](../IPublishedContentQuery/index.md) for more information.

## Fetching Dictionary Values

### .GetDictionaryValue(string key)

Returns a dictionary value(`string`) for the key specified.

```html
<p>@Umbraco.GetDictionaryValue("createdOn"): @Model.CreateDate</p>
```

Alternatively, you can also specify an `altText` which will be returned if the dictionary value is empty.

```html
<p>@Umbraco.GetDictionaryValue("createdOn", "Date Created"): @Model.CreateDate</p>
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
