# C# API

{% hint style="info" %}
This API is available from version 1.10.0 onwards.
{% endhint %}

## Retrieving Active A/B test variants

You can retrieve the active A/B test variants for a visitor in different ways depending on your specific scenario:

- **IAbTestingService.GetCurrentVisitorActiveAbTestVariants()**
  - Namespace: `uMarketingSuite.Web.AbTesting`
  - Returns the active variants for the current visitor on the current page.
  - Can only be used with an active request context
- **IAbTestingVisitorService.GetVisitorAbTestVariants(visitorExternalId, pageId, culture, contentTypeId)**
  - Namespace: `uMarketingSuite.Business.AbTesting`
  - Retrieves active A/B test variants on a specific page, without requiring a request context.
  - The visitor external id can be retrieved using **IAnalyticsVisitorExternalIdHandler.GetExternalId()**
- **IAbTestVisitorToVariantManager.GetActiveVisitorVariants(visitorExternalId)**
  - Namespace: `uMarketingSuite.Business.AbTesting`
  - Retrieves *all* active A/B test variants for the given visitor throughout the website.
  - The visitor external id can be retrieved using **IAnalyticsVisitorExternalIdHandler.GetExternalId()**

### Example

To use these services, inject the specified service into your code. The example below uses **IAbTestingService.GetCurrentVisitorActiveAbTestVariants()** by injecting the service into a controller:

```cs
using uMarketingSuite.Business.AbTesting;
using uMarketingSuite.Web.AbTesting;

public class YourController : SurfaceController
{
    public YourController(IAbTestingService abTestingService)
    {
        var activeVariantsCurrentVisitor = abTestingService.GetCurrentVisitorActiveAbTestVariants();
    }
}
```
