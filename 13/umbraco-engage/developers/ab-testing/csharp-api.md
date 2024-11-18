---
description: >-
  Explore how to retrieve active A/B test variants for visitors using the
  Umbraco Engage C# API.
---

# Retrieving A/B test variants in C#

## Retrieving Active A/B test variants

You can retrieve the active A/B test variants for a visitor in different ways depending on your specific scenario:

* `IAbTestingService.GetCurrentVisitorActiveAbTestVariants()`
  * Namespace: `Umbraco.Engage.Web.AbTesting`
  * Returns the active variants for the current visitor on the current page.
  * Can only be used with an active request context
* `IAbTestingVisitorService.GetVisitorAbTestVariants(visitorExternalId, pageId, culture, contentTypeId)`
  * Namespace: `Umbraco.Engage.Business.AbTesting`
  * Retrieves active A/B test variants on a specific page, without requiring a request context.
  * The visitor external id can be retrieved using `IAnalyticsVisitorExternalIdHandler.GetExternalId()`
* `IAbTestVisitorToVariantManager.GetActiveVisitorVariants(visitorExternalId)`
  * Namespace: `Umbraco.Engage.Business.AbTesting`
  * Retrieves _all_ active A/B test variants for the given visitor throughout the website.
  * The visitor external id can be retrieved using `IAnalyticsVisitorExternalIdHandler.GetExternalId()`

### Example

To use these services, inject the specified service into your code. The example below uses `IAbTestingService.GetCurrentVisitorActiveAbTestVariants()` by injecting the service into a controller:

```cs
using Umbraco.Engage.Business.AbTesting;
using Umbraco.Engage.Web.AbTesting;

public class YourController : SurfaceController
{
    public YourController(IAbTestingService abTestingService)
    {
        var activeVariantsCurrentVisitor = abTestingService.GetCurrentVisitorActiveAbTestVariants();
    }
}
```
