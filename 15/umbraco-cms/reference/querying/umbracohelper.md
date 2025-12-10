---
description: Using the Umbraco Helper
---

# UmbracoHelper

UmbracoHelper is the unified way to work with published content/media on your website. You can use the UmbracoHelper to query/traverse Umbraco published data.

UmbracoHelper also has a variety of helper methods that are useful when working in your views and controllers.

## How to reference UmbracoHelper

If you are using Views you can reference UmbracoHelper with the syntax: `@Umbraco`

If you need an `UmbracoHelper` in your own controllers, you need to inject an instance.

Example of getting `UmbracoHelper` in a controller:

```csharp
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Web.Common;
using Umbraco.Cms.Web.Common.Controllers;

namespace UmbracoHelperDocs.Controllers;

[Route("customcontent/[action]")]
public class CustomContentController : Controller
{
    private readonly UmbracoHelper _umbracoHelper;

    public CustomContentController(UmbracoHelper umbracoHelper)
        => _umbracoHelper = umbracoHelper;

    public IActionResult GetHomeNodeName()
    {
        IPublishedContent rootNode = _umbracoHelper
            .ContentAtRoot()
            .FirstOrDefault();

        if (rootNode is null)
        {
            return NotFound();
        }

        return Ok(rootNode.Name);
    }
}
```

UmbracoHelper is registered with a scoped lifetime (see [Microsoft documentation](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/dependency-injection?view=aspnetcore-5.0#lifetime-and-registration-options) for more information), as a service scope is created for each request you can resolve an instance directly in a controller.

If you need to use an UmbracoHelper in a service with a singleton lifetime you would instead need to make use of the IUmbracoHelperAccessor interface to obtain a temporary reference to an instance.

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

@foreach (var child in pageFromGui.Children())
{
	<a href="@child.Url()">@child.Name</a>
}
```

### .ContentAtRoot()

Returns a collection of `IPublishedContent` objects from the Content tree.

```csharp
@* Get the children of the first content item found in the root *@
@foreach (var child in Umbraco.ContentAtRoot().First().Children())
{
	<a href="@child.Url()">@child.Name</a>
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

Previously the `UmbracoHelper` could be used to work with tags, this has been moved out of `UmbracoHelper` and is now available from `ITagQuery` which you can read more about in the [ITagQuery document](itagquery.md).

## Working with Members

Previously the `UmbracoHelper` could be used to work with members, this has ben moved out of `UmbracoHelper` and is now available from `IMemberManager`, see [IMemberManager](imembermanager.md) for more information

## Searching

Previously the `UmbracoHelper` could be used to run queries on your content, this has been moved out of `UmbracoHelper` and is now available from `IPublishedContentQuery`, see [IPublishedContentQuery](ipublishedcontentquery.md) for more information.

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
