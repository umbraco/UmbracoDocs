---
description: >-
  The UmbracoContext is a helpful service provided on each request to the
  website
---

# UmbracoContext helper

The UmbracoContext is the simplified way to work with the current request on your website.

You can use UmbracoContext to access the content and media cache. Other useful properties are the original and cleaned URLs of the current request. You can also check if the current request is running in "preview" mode.

## How to reference UmbracoContext

If you are using Views you can reference the UmbracoContext with the syntax: `@UmbracoContext`

If you need an `UmbracoContext` in your own controllers, you need to inject an `IUmbracoContextAccessor`.

The following is an example of how to get access to the `UmbracoContext` in a controller:

``` csharp
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Web.Common.PublishedModels;
using Umbraco.Extensions;

namespace Umbraco.Docs.Samples.Web.Controllers.Api;

[ApiController]
[Route("/umbraco/api/people")]
public class PeopleController : Controller
{
    private readonly IUmbracoContextAccessor _umbracoContextAccessor;

    public PeopleController(IUmbracoContextAccessor umbracoContextAccessor)
    {
        _umbracoContextAccessor = umbracoContextAccessor;
    }

    [HttpGet("getall")]
    public ActionResult<IEnumerable<string>> GetAll()
    {
        if (_umbracoContextAccessor.TryGetUmbracoContext(out IUmbracoContext? context) == false)
        {
            return this.Problem("unable to get content");
        }

        if (context.Content == null)
        {
            return this.Problem("Content Cache is null");
        }

        var personContentType = context.Content.GetContentType(Person.ModelTypeAlias);
        Debug.Assert(context.Content.HasContent());
        var personNodes = (context.Content.GetAtRoot()
                .First()
                .FirstChild<People>()
                .Children<Person>() ?? Array.Empty<Person>())
            .Select(p => p.Name);
        return personContentType == null
            ? this.Problem("Person Content Type is null")
            : Ok(personNodes);
    }
}
```

UmbracoContext is registered with a scoped lifetime. See the [Microsoft documentation](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/dependency-injection?view=aspnetcore-5.0#lifetime-and-registration-options) for more information. A service scope is created for each request, which means you can resolve an instance directly in a controller.
