---
versionFrom: 7.0.0
meta.Title: "Surface Controller Actions"
meta.Description: "Information about Surface Controller Actions Result Helpers in Umbraco"
---

# Surface controller actions

A surface controller can return a few Umbraco specific actions.

## CurrentUmbracoPage

Returns the current Umbraco page.

```csharp
namespace TestWebsite.Core.Controllers
{
    public class TestSurfaceController : SurfaceController
    {
        [HttpPost]
        public ActionResult PostMethod()
        {
            if (!ModelState.IsValid)
            {
                return this.CurrentUmbracoPage();
            }

            return this.RedirectToCurrentUmbracoPage();
        }
    }
}
```

## RedirectToCurrentUmbracoPage

Redirects to the currently rendered Umbraco page.

```csharp
namespace TestWebsite.Core.Controllers
{
    public class TestSurfaceController : SurfaceController
    {
        [HttpPost]
        public ActionResult PostMethod()
        {
            if (!ModelState.IsValid)
            {
                return this.CurrentUmbracoPage();
            }

            return this.RedirectToCurrentUmbracoPage();
        }
    }
}
```

This action can also take in a `string` value for a querystring parameter in the url or a `NameValueCollection` for multiple querystring parameters in the url.

### Querystring parameter using a string value

```csharp
namespace TestWebsite.Core.Controllers
{
    public class TestSurfaceController : SurfaceController
    {
        [HttpPost]
        public ActionResult PostMethod()
        {
            var paramValue = "someValue";
            return this.RedirectToCurrentUmbracoPage("param=" + paramValue);
        }
    }
}
```

### Querystring parameter using a NameValueCollection

```csharp
namespace TestWebsite.Core.Controllers
{
    public class TestSurfaceController : SurfaceController
    {
       [HttpPost]
        public ActionResult PostMethod()
        {
            var queryStringCollection = new NameValueCollection();
            queryStringCollection.Add("param1", "paramvalue1");
            queryStringCollection.Add("param2", "paramvalue2");
            return this.RedirectToCurrentUmbracoPage(queryStringCollection);
        }
    }
}
```

## RedirectToCurrentUmbracoUrl

Redirects to the currently rendered Umbraco url.

```csharp
namespace TestWebsite.Core.Controllers
{
    public class TestSurfaceController : SurfaceController
    {
        [HttpPost]
        public ActionResult PostMethod()
        {
            return this.RedirectToCurrentUmbracoUrl();
        }
    }
}
```

## RedirectToUmbracoPage

Redirects to a given Umbraco page.

```csharp
namespace TestWebsite.Core.Controllers
{
    public class TestSurfaceController : SurfaceController
    {
        [HttpPost]
        public ActionResult PostMethod()
        {
            //gets the first child page of the current page
            var childPage = CurrentPage.FirstChild();
            return this.RedirectToUmbracoPage(childPage);
        }
    }
}
```

You can also redirect to a page id.

```csharp
namespace TestWebsite.Core.Controllers
{
    public class TestSurfaceController : SurfaceController
    {
        [HttpPost]
        public ActionResult PostMethod()
        {
            //redirect to a page with id 1054
            return this.RedirectToUmbracoPage(1054);
        }
    }
}
```

There are overloads for adding a `string` querystring parameter or a `NameValueCollection` for multiple querystring parameters.
