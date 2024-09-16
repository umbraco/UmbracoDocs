# C# API

Note: this API is available for 1.10.0+

### Active A/B test variants

The currently active A/B test variants of a visitor can be retrieved in a few slightly different ways depending on your scenario.

- **IAbTestingService.GetCurrentVisitorActiveAbTestVariants()**
    - Namespace uMarketingSuite.Web.AbTesting
    - Returns the active variants for the current visitor on the current page.
    - Can only be used with an active request context
- **IAbTestingVisitorService.GetVisitorAbTestVariants(visitorExternalId, pageId, culture, contentTypeId)**
    - Namespace uMarketingSuite.Business.AbTesting
    - To retrieve active A/B test variants on a specific page, no request context needed.
    - The visitor external id can be retrieved using **IAnalyticsVisitorExternalIdHandler.GetExternalId()**
- **IAbTestVisitorToVariantManager.GetActiveVisitorVariants(visitorExternalId)**
    - Namespace uMarketingSuite.Business.AbTesting
    - To retrieve *all* active A/B test variants of the given visitor throughout the website.
    - The visitor external id can be retrieved using **IAnalyticsVisitorExternalIdHandler.GetExternalId()**

Note you can simply inject the specified services into your own code. The code below uses the **IAbTestingService.GetCurrentVisitorActiveAbTestVariants()** by injecting the service into a controller: 

    using uMarketingSuite.Business.AbTesting;using uMarketingSuite.Web.AbTesting;public class YourController : SurfaceController{    public YourController(IAbTestingService abTestingService)    {        var activeVariantsCurrentVisitor = abTestingService.GetCurrentVisitorActiveAbTestVariants();    }}