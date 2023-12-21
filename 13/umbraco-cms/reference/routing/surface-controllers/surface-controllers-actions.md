---
description: "Information about Surface Controller Actions Result Helpers in Umbraco"
---

# Surface controller actions

A surface controller can return a few Umbraco specific actions.

## CurrentUmbracoPage

Returns the current Umbraco page.

```csharp
namespace RoutingDocs.Controllers;

public class MyController : SurfaceController
{
    public MyController(
        IUmbracoContextAccessor umbracoContextAccessor,
        IUmbracoDatabaseFactory databaseFactory,
        ServiceContext services,
        AppCaches appCaches,
        IProfilingLogger profilingLogger,
        IPublishedUrlProvider publishedUrlProvider)
        : base(umbracoContextAccessor, databaseFactory, services, appCaches, profilingLogger, publishedUrlProvider)
    {
    }

    [HttpPost]
    public IActionResult PostMethod()
    {
        if (!ModelState.IsValid)
        {
            return CurrentUmbracoPage();
        }

        return RedirectToCurrentUmbracoPage();
    }
}
```

## RedirectToCurrentUmbracoPage

Redirects to the currently rendered Umbraco page.

```csharp
namespace RoutingDocs.Controllers;

public class MyController : SurfaceController
{
    public MyController(
        IUmbracoContextAccessor umbracoContextAccessor,
        IUmbracoDatabaseFactory databaseFactory,
        ServiceContext services,
        AppCaches appCaches,
        IProfilingLogger profilingLogger,
        IPublishedUrlProvider publishedUrlProvider)
        : base(umbracoContextAccessor, databaseFactory, services, appCaches, profilingLogger, publishedUrlProvider)
    {
    }

    [HttpPost]
    public IActionResult PostMethod()
    {
        if (!ModelState.IsValid)
        {
            return CurrentUmbracoPage();
        }

        return RedirectToCurrentUmbracoPage();
    }
}
```

This action can also take in a `QueryString` object to be included in the redirect. 

### Querystring parameter using a string value

```csharp
namespace RoutingDocs.Controllers;

public class MyController : SurfaceController
{
    public MyController(
        IUmbracoContextAccessor umbracoContextAccessor,
        IUmbracoDatabaseFactory databaseFactory,
        ServiceContext services,
        AppCaches appCaches,
        IProfilingLogger profilingLogger,
        IPublishedUrlProvider publishedUrlProvider)
        : base(umbracoContextAccessor, databaseFactory, services, appCaches, profilingLogger, publishedUrlProvider)
    {
    }

    [HttpPost]
    public IActionResult PostMethod()
    {
        var paramValue = "someValue";
        var queryString = QueryString.Create("param", paramValue);
        return RedirectToCurrentUmbracoPage(queryString);
    }
}
```

## RedirectToCurrentUmbracoUrl

Redirects to the currently rendered Umbraco URL.

```csharp
namespace RoutingDocs.Controllers;

public class MyController : SurfaceController
{
    public MyController(
        IUmbracoContextAccessor umbracoContextAccessor,
        IUmbracoDatabaseFactory databaseFactory,
        ServiceContext services,
        AppCaches appCaches,
        IProfilingLogger profilingLogger,
        IPublishedUrlProvider publishedUrlProvider)
        : base(umbracoContextAccessor, databaseFactory, services, appCaches, profilingLogger, publishedUrlProvider)
    {
    }

    [HttpPost]
    public IActionResult PostMethod()
    {
        return RedirectToCurrentUmbracoUrl();
    }
}
```

## RedirectToUmbracoPage

Redirects to a given Umbraco page.

```csharp
namespace RoutingDocs.Controllers;

public class MyController : SurfaceController
{
    public MyController(
        IUmbracoContextAccessor umbracoContextAccessor,
        IUmbracoDatabaseFactory databaseFactory,
        ServiceContext services,
        AppCaches appCaches,
        IProfilingLogger profilingLogger,
        IPublishedUrlProvider publishedUrlProvider)
        : base(umbracoContextAccessor, databaseFactory, services, appCaches, profilingLogger, publishedUrlProvider)
    {
    }

    [HttpPost]
    public IActionResult PostMethod()
    {
        // Gets the first child page of the current page
        var childPage = CurrentPage.FirstChild();
        return RedirectToUmbracoPage(childPage);
    }
}
```

You can also redirect to a page key (GUID).

```csharp
namespace RoutingDocs.Controllers;

public class MyController : SurfaceController
{
    public MyController(
        IUmbracoContextAccessor umbracoContextAccessor,
        IUmbracoDatabaseFactory databaseFactory,
        ServiceContext services,
        AppCaches appCaches,
        IProfilingLogger profilingLogger,
        IPublishedUrlProvider publishedUrlProvider)
        : base(umbracoContextAccessor, databaseFactory, services, appCaches, profilingLogger, publishedUrlProvider)
    {
    }

    [HttpPost]
    public IActionResult PostMethod()
    {
        var childPage = CurrentPage.FirstChild();
        return RedirectToUmbracoPage(childPage.Key);
    }
}
```

There are overloads for adding a `QueryString` object.
