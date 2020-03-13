---
versionFrom: 8.0.0
---

# Language Variation

Introduced in Umbraco 8, Language Variation allows you to have several different variations of content based on a language culture. In the documentation there are several other useful articles about the feature:

- [Getting started with Language Variants](../../Getting-Started/Backoffice/Variants/index.md)
- [Rendering variant values](../../Getting-Started/Design/Rendering-Content/index.md)

[`IPublishedContent`](../Querying/IPublishedContent/index.md) contains all language variations of a node, and when rendering it out it will then use the Culture you are currently on. This can then be overridden on an individual property level if you want, like this:

```csharp
@Model.Value("pageTitle", "fr", fallback: Fallback.ToLanguage)
```

Here we would attempt to render the `pageTitle` property in the French variant and fallback to the current culture language if it can't find it in French.

The problem here comes if you want to output all values of an IPublishedContent model in a specific culture in something that has no access to the "current culture", such as a [Surface Controller](../Routing/surface-controllers.md).

If you do something like this:

```csharp
using System.Linq;
using System.Web.Mvc;
using Umbraco.Web.Mvc;

namespace TestStuff
{
    public class TestController : SurfaceController
    {
        public ActionResult Index()
        {
            var culturedRootNode = Umbraco.ContentAtRoot().First();
            TempData.Add("CulturedRootNode", culturedRootNode);

            return View();
        }
    }
}
```

You will get the root node in the default culture. However you can set a new `VariationContext` like this:

```csharp
using System.Linq;
using System.Web.Mvc;
using Umbraco.Web.Mvc;
using Umbraco.Core.Models.PublishedContent;

namespace TestStuff
{
    public class TestController : SurfaceController
    {
        private readonly IVariationContextAccessor _variationContextAccessor;

        public TestController(IVariationContextAccessor variationContextAccessor)
        {
            _variationContextAccessor = variationContextAccessor;
        }
        public ActionResult Index()
        {
            const string culture = "af"; // Afrikaans

            // This is how the culture is set for the context we are in
            _variationContextAccessor.VariationContext = new VariationContext(culture);

            var culturedRootNode = Umbraco.ContentAtRoot().First();
            TempData.Add("CulturedRootNode", culturedRootNode);

            return View();
        }
    }
}
```

So we access the `IVariationContextAccessor.VariationContext` and set it to a new one with our own specified culture (remember `using Umbraco.Core.Models.PublishedContent;` at the top to get access to it).

The elements you get afterwards will be in the culture you have specified.
