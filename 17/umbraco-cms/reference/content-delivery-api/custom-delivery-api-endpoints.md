---
description: Implementing custom Delivery API endpoints.
---

# Custom Delivery API endpoints

Sometimes it can be useful to extend the Delivery API with custom endpoints.

At its core, a custom Delivery API endpoint is no different from an ordinary an API controller. However, there are a few tricks that can make your own endpoints feel more like part of the native Delivery API. These include:

- Consistent JSON serialization.
- Matching routing schemes.
- Swagger documentation.
- Authentication.
- Respecting the configured Delivery API access rules.

In this article you'll find snippets and examples to get you started.

## A basic Delivery API endpoint

Here is a basic example of a Delivery API endpoint:

{% code title="BasicDeliveryApiController.cs" lineNumbers="true" %}
```csharp
using Asp.Versioning;
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Api.Delivery.Controllers;
using Umbraco.Cms.Api.Delivery.Filters;
using Umbraco.Cms.Api.Delivery.Routing;

namespace Umbraco.Docs;

[ApiVersion("2.0")]
[VersionedDeliveryApiRoute("custom")]
[ApiExplorerSettings(GroupName = "Custom")]
[DeliveryApiAccess]
public class BasicDeliveryApiController : DeliveryApiControllerBase
{
    [HttpGet("basic-api")]
    [MapToApiVersion("2.0")]
    [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public IActionResult Get() => Ok(123);
}
```
{% endcode %}

There is quite a lot going on here, so let's break it down.

Implementing the `DeliveryApiControllerBase` ensures that:

1. The endpoint is automatically included in the Swagger documentation for the Delivery API.
2. The endpoint respects the JSON serialization scheme for the entire Delivery API.

There are also a few attributes applied to the endpoint:
 
1. The `ApiVersion` and `MapToApiVersion` attributes matches the endpoint version to the current Delivery API version.
2. The `VersionedDeliveryApiRoute` attribute ensures that the endpoint routing matches that of the Delivery API.
3. The `ApiExplorerSettings` attribute adds the endpoint to a custom group in the Swagger documentation.
4. The `DeliveryApiAccess` attribute ensures that this endpoint can only be invoked if the Content Delivery API is [enabled](README.md#enable-the-content-delivery-api).
5. The `ProducesResponseType` attributes helps the Swagger documentation understand the endpoint. 

{% hint style="info" %}
`DeliveryApiAccess` also comes in a specific version for the [Media Delivery API](media-delivery-api.md) - the `DeliveryApiMediaAccess` attribute.
{% endhint %}

## A Delivery API endpoint for content

If your custom Delivery API endpoint outputs content, you will likely find the `ContentApiControllerBase` a better fit as base class. Here is an example of how to use it:

{% code title="ContentDeliveryApiController.cs" lineNumbers="true" %}
```csharp
using Asp.Versioning;
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Api.Delivery.Controllers.Content;
using Umbraco.Cms.Api.Delivery.Routing;
using Umbraco.Cms.Core.DeliveryApi;
using Umbraco.Cms.Core.Models.DeliveryApi;

namespace Umbraco.Docs;

[ApiVersion("2.0")]
[VersionedDeliveryApiRoute("custom")]
[ApiExplorerSettings(GroupName = "Custom")]
public class ContentDeliveryApiController : ContentApiControllerBase
{
    public ContentDeliveryApiController(
        IApiPublishedContentCache apiPublishedContentCache,
        IApiContentResponseBuilder apiContentResponseBuilder)
        : base(apiPublishedContentCache, apiContentResponseBuilder)
    {
    }

    [HttpGet("content-api/{id:guid}")]
    [MapToApiVersion("2.0")]
    [ProducesResponseType(typeof(IApiContentResponse), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<IActionResult> Get(Guid id)
    {
        var content = await ApiPublishedContentCache.GetByIdAsync(id);
        return content is not null
            ? Ok(ApiContentResponseBuilder.Build(content))
            : NotFound();
    }
}
```
{% endcode %}

This endpoint does not require the `DeliveryApiAccess` attribute, because it is already defined on the base class.

The `ContentApiControllerBase` adds a lot of functionality to your custom endpoint, including:

- Basic request validation.
- Variance context for requests.
- Delivery API [output caching](output-caching.md), including the appropriate `Vary` response headers.
- Comprehensive Swagger documentation for [property expansion and limiting](https://docs.umbraco.com/umbraco-cms/reference/content-delivery-api/property-expansion-and-limiting).

The base class also gives convenient access to:
- The `IApiPublishedContentCache`, a specialized content cache tailored for the Delivery API. Among other things, it enforces the configuration of [(dis)allowed output types](README.md#additional-configuration).
- The `IApiContentResponseBuilder` for generating a content response format that conforms with the Delivery API. This includes support for property expansion and limiting.

## A Delivery API endpoint for media

Similarly to content, a base class also exists for media endpoints; the `MediaApiControllerBase`. This base class provides much of the same functionality as the corresponding base class for content.

Here's an example of how to use the `MediaApiControllerBase`:

{% code title="MediaDeliveryApiController.cs" lineNumbers="true" %}
```csharp
using Asp.Versioning;
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Api.Delivery.Controllers.Media;
using Umbraco.Cms.Api.Delivery.Routing;
using Umbraco.Cms.Core.Models.DeliveryApi;
using Umbraco.Cms.Core.PublishedCache;
using Umbraco.Cms.Infrastructure.DeliveryApi;

namespace Umbraco.Docs;

[ApiVersion("2.0")]
[VersionedDeliveryApiRoute("custom")]
[ApiExplorerSettings(GroupName = "Custom")]
public class MediaDeliveryApiController : MediaApiControllerBase
{
    public MediaDeliveryApiController(
        IPublishedMediaCache publishedMediaCache,
        IApiMediaWithCropsResponseBuilder apiMediaWithCropsResponseBuilder)
        : base(publishedMediaCache, apiMediaWithCropsResponseBuilder)
    {
    }

    [HttpGet("media-api/{id:guid}")]
    [MapToApiVersion("2.0")]
    [ProducesResponseType(typeof(IApiMediaWithCropsResponse), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<IActionResult> Get(Guid id)
    {
        var media = await PublishedMediaCache.GetByIdAsync(id);
        return media is not null
            ? Ok(BuildApiMediaWithCrops(media))
            : NotFound();
    }
}
```
{% endcode %}
