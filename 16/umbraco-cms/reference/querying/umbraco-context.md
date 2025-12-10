---
description: >-
  The UmbracoContext is a helpful service provided on each request to the
  website.
---

# UmbracoContext helper

The UmbracoContext is the simplified way to work with the current request on your website.

You can use UmbracoContext to access the content and media cache. Other useful properties are the original and cleaned URLs of the current request. You can also check if the current request is running in "preview" mode.

## How to reference UmbracoContext

If you are using Views you can reference the UmbracoContext with the syntax: `@UmbracoContext`.

If you need an `UmbracoContext` in your own controllers, you need to inject an `IUmbracoContextAccessor`.

The following is an example of how to get access to the `UmbracoContext` in a controller:

``` csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Web;

namespace MyProject.Controllers.Api;

[ApiController]
[Route("/umbraco/api/people")]
public class PeopleController : Controller
{
    private readonly IUmbracoContextAccessor _umbracoContextAccessor;
    private readonly IPublishedContentQuery _publishedContentQuery;

    public PeopleController(
        IUmbracoContextAccessor umbracoContextAccessor,
        IPublishedContentQuery publishedContentQuery)
    {
        _umbracoContextAccessor = umbracoContextAccessor;
        _publishedContentQuery = publishedContentQuery;
    }

    [HttpGet("getall")]
    public ActionResult<IEnumerable<string>> GetAll()
    {
        // Try to get the UmbracoContext
        if (_umbracoContextAccessor.TryGetUmbracoContext(out IUmbracoContext? context) == false)
        {
            return Problem("Unable to get UmbracoContext");
        }

        if (context.Content == null)
        {
            return Problem("Content Cache is null");
        }

        // Use IPublishedContentQuery to get root content
        var rootNodes = _publishedContentQuery.ContentAtRoot();

        if (!rootNodes.Any())
        {
            return Problem("No content found at root");
        }

        // Find a specific parent node (e.g., "People" section)
        var peopleNode = rootNodes
            .FirstOrDefault()?
            .Children()
            .FirstOrDefault(c => c.ContentType.Alias == "people");

        if (peopleNode == null)
        {
            return Problem("People node not found");
        }

        // Get only the direct children of the People node
        // Use Children() extension method instead of Children property. Scheduled for removal in Umbraco 18.
        var personNodes = peopleNode.Children()
            .Where(c => c.ContentType.Alias == "person")
            .Select(p => p.Name);

        return Ok(personNodes);
    }
}
```

{% hint style="info" %}
For content querying scenarios, use `IPublishedContentQuery.ContentAtRoot()`.

For advanced navigation, multi-site setups, or culture-specific root detection, use
`IDocumentNavigationQueryService.TryGetRootKeys()`, which returns GUID keys representing the structure of the content tree.
{% endhint %}

UmbracoContext is registered with a scoped lifetime. See the [Microsoft documentation](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/dependency-injection#lifetime-and-registration-options) for more information. A service scope is created for each request, which means you can resolve an instance directly in a controller.
