---
versionFrom: 7.0.0
meta.Title: "Surface Controller Actions"
meta.Description: "Information about Surface Controller Actions in Umbraco"

---

A surface controller can return a few Umbraco specific actions. 

## CurrentUmbracoPage

Returns the current umbraco page

```csharp
namespace TestWebsite.Core.Controllers
{
    public class TestSurfaceController : SurfaceController
    {
      
        [HttpPost]
        public ActionResult PostForm(TestViewModel vm)
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
        public ActionResult PostForm(TestViewModel vm)
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
        public ActionResult Index()
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
        public ActionResult Index()
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

Redirects to the currently rendered Umbraco url

```csharp
namespace TestWebsite.Core.Controllers
{
    public class TestSurfaceController : SurfaceController
    {
        public ActionResult Index()
        {
            return this.RedirectToCurrentUmbracoUrl();
        }
    }
}
```

## RedirectToUmbracoPage

Redirects to a given Umbraco page

```csharp
namespace TestWebsite.Core.Controllers
{
    public class TestSurfaceController : SurfaceController
    {
        public ActionResult Index()
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
        public ActionResult Index()
        {
            //redirect to a page with id 1054
            return this.RedirectToUmbracoPage(1054);
        }
    }
}
```

There are overloads for adding a `string` querystring parameter or a `NameValueCollection` for multiple querystring parameters.