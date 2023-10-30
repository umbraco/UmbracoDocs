# Language Variation

Language Variation allows you to have different variations of content based on a language culture. In the documentation there are other useful articles about the feature:

* [Getting started with Language Variants](../fundamentals/backoffice/variants.md)
* [Rendering variant values](../fundamentals/design/rendering-content.md)

[`IPublishedContent`](querying/ipublishedcontent/) contains all language variations of a node, and when rendering it out it will then use the Culture you are currently on. This can then be overridden on an individual property level if you want, like this:

```csharp
@Model.Value("pageTitle", "fr", fallback: Fallback.ToLanguage)
```

Here we would attempt to render the `pageTitle` property in the French variant. We want to fallback to the current culture language if it can't find it in French.

The challenge arises when trying to display all values of an IPublishedContent model in a specific culture from a "current culture"-less context, like a [`SurfaceController`](routing/surface-controllers/).

If you do something like this:

```csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Core.Cache;
using Umbraco.Cms.Core.Logging;
using Umbraco.Cms.Core.Routing;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Infrastructure.Persistence;
using Umbraco.Cms.Web.Website.Controllers;
using Umbraco.Extensions;

namespace TestStuff
{
    public class TestController : SurfaceController
    {

        public TestController(
            IUmbracoContextAccessor umbracoContextAccessor, 
            IUmbracoDatabaseFactory databaseFactory, 
            ServiceContext services, 
            AppCaches appCaches, 
            IProfilingLogger profilingLogger, 
            IPublishedUrlProvider publishedUrlProvider) 
            : base(umbracoContextAccessor, databaseFactory, services, appCaches, profilingLogger, publishedUrlProvider)
        {
        }

        public IActionResult Index()
        {
            var culturedRootNode = CurrentPage.Root();
            TempData.Add("CulturedRootNode", culturedRootNode);

            return View();
        }
    }
}
```

You will get the root node in the default culture. However you can set a new `VariationContext` like this:

```csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Core.Cache;
using Umbraco.Cms.Core.Logging;
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Core.Routing;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Infrastructure.Persistence;
using Umbraco.Cms.Web.Website.Controllers;
using Umbraco.Extensions;

namespace TestStuff
{
    public class TestController : SurfaceController
    {
        private readonly IVariationContextAccessor _variationContextAccessor;

        public TestController(
            IUmbracoContextAccessor umbracoContextAccessor, 
            IUmbracoDatabaseFactory databaseFactory, 
            ServiceContext services, 
            AppCaches appCaches, 
            IProfilingLogger profilingLogger, 
            IPublishedUrlProvider publishedUrlProvider, 
            IVariationContextAccessor variationContextAccessor) 
            : base(umbracoContextAccessor, databaseFactory, services, appCaches, profilingLogger, publishedUrlProvider)
        {
            _variationContextAccessor = variationContextAccessor;
        }

        public IActionResult Index()
        {
            const string culture = "af"; // Afrikaans

            // This is how the culture is set for the context we are in
            _variationContextAccessor.VariationContext = new VariationContext(culture);

            var culturedRootNode = CurrentPage.Root();
            TempData.Add("CulturedRootNode", culturedRootNode);

            return View();
        }
    }
}
```

So we access the `IVariationContextAccessor.VariationContext` and set it to a new one with our own specified culture (remember `using Umbraco.Core.Models.PublishedContent;` at the top to get access to it).

The elements you get afterwards will be in the culture you have specified.
