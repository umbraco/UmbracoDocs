---
description: >-
  Explore how to retrieve active A/B test variants for visitors using the
  Umbraco Engage C# API.
---

# Retrieving A/B test variants in C\#

## Retrieving Active A/B test variants

You can retrieve the active A/B test variants for a visitor in different ways depending on your specific scenario:

* `IAbTestingVisitorService.GetVisitorAbTestVariants(visitorExternalId, pageId, culture, contentTypeId)`
  * Namespace: `Umbraco.Engage.Infrastructure.AbTesting.Services.Interfaces`
  * Retrieves active A/B test variants on a specific page, without requiring a request context.
  * The visitor external id can be retrieved using `IAnalyticsVisitorExternalIdHandler.GetExternalId()`
* `IAbTestVisitorToVariantManager.GetActiveVisitorVariants(visitorExternalId)`
  * Namespace: `Umbraco.Engage.Infrastructure.AbTesting`
  * Retrieves _all_ active A/B test variants for the given visitor throughout the website.
  * The visitor external id can be retrieved using `IAnalyticsVisitorExternalIdHandler.GetExternalId()`

### Example - Getting the A/B test variants for the current visitor

This example demonstrates how to create a service that retrieves the active A/B test variants for a specific visitor, content, and culture variation. The service wraps the `IAbTestingVisitorService.GetVisitorAbTestVariants()` method, using the current HttpContext and UmbracoContext to obtain the visitor ID and requested content.

```cs
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Core.Web;
using Umbraco.Engage.Infrastructure.AbTesting.Models;
using Umbraco.Engage.Infrastructure.AbTesting.Services.Interfaces;
using Umbraco.Engage.Infrastructure.Analytics.Collection.Visitor;

namespace Umbraco.Example;

public class ExampleService
{
    private readonly IHttpContextAccessor _httpContextAccessor;
    private readonly IUmbracoContextAccessor _umbracoContextAccessor;
    private readonly IAnalyticsVisitorExternalIdHandler _externalIdHandler;
    private readonly IAbTestingVisitorService _abTestingVisitorService;

    public ExampleService(
        IHttpContextAccessor httpContextAccessor,
        IUmbracoContextAccessor umbracoContextAccessor,
        IAnalyticsVisitorExternalIdHandler externalIdHandler,
        IAbTestingVisitorService abTestingVisitorService)
    {
        _httpContextAccessor = httpContextAccessor;
        _umbracoContextAccessor = umbracoContextAccessor;
        _externalIdHandler = externalIdHandler ;
        _abTestingVisitorService = abTestingVisitorService;
    }

    /// <summary>
    /// Gets the active A/B test variants for the current visitor.
    /// </summary>
    /// <returns>Active <see cref="AbTestVariant"/>s for the visitor, or an empty list if unavailable.</returns>
    public IEnumerable<AbTestVariant> GetCurrentVisitorActiveAbTestVariants()
    {
        if (_httpContextAccessor?.HttpContext is not HttpContext httpCtx ||
            _externalIdHandler.GetExternalId(httpCtx) is not Guid externalId)
            return [];
        
        if (!_umbracoContextAccessor.TryGetUmbracoContext(out var umbCtx) || 
            umbCtx.PublishedRequest?.Culture is not string culture || 
            umbCtx.PublishedRequest?.PublishedContent is not IPublishedContent content)
            return [];

        return _abTestingVisitorService.GetVisitorAbTestVariants(externalId, content.Id, culture, content.ContentType.Id);
    }
}
```
