---
description: Boosting Delivery API performance with output caching.
---

# Output caching

Umbraco provides opt-in output caching for Delivery API responses. When enabled, the server caches API responses and serves them for subsequent requests. The API pipeline is not re-executed until the cache expires or is evicted.

Under the hood, the Delivery API uses the built-in [output caching middleware in ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/performance/caching/output) to handle the cache.

{% hint style="info" %}
This article covers output caching for the Content Delivery API. For output caching of server-side rendered (Razor) pages, see the [Website Output Caching](../website-output-caching.md) article.
{% endhint %}

## Why use output caching?

Output caching is designed to increase performance. While the Delivery API is performant on its own, output caching takes the performance to another level.

Another aspect to consider is the overall server load. Uncached requests require more processing time than cached requests. For high-traffic sites, even a short-lived output cache makes a significant difference in the server load. This can result in a lesser need to scale instances, and thus a greener footprint for the site.

However, output caching does come with trade-offs:

- The cache consumes additional server memory.
- Editors may experience a short delay between publishing and the updated response appearing. Active eviction on publish keeps this minimal.

## When _not_ to use output caching

Output caching can be a poor fit in some cases:

- Responses where editors require guaranteed zero delay between publishing and the update appearing.
- When using personalization in the API output.
- If a custom property editor requires re-rendering for every request. For example, if a property value converter outputs the current time.

{% hint style="info" %}
Output caching is **disabled by default**. Enabling it is an opt-in decision.
{% endhint %}

## Configuring output caching

Enable output caching by adding the `OutputCache` section to the `DeliveryApi` configuration in `appsettings.json`:

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "CMS": {
      "DeliveryApi": {
        "Enabled": true,
        "OutputCache": {
          "Enabled": true,
          "ContentDuration": "00:15:00",
          "MediaDuration": "01:00:00"
        }
      }
    }
  }
}
```
{% endcode %}

| Property | Type | Default | Description |
|---|---|---|---|
| `Enabled` | `bool` | `false` | Enables or disables Delivery API output caching. |
| `ContentDuration` | `TimeSpan` | `00:00:10` (10 seconds) | Cache duration for Content Delivery API responses. |
| `MediaDuration` | `TimeSpan` | `00:00:10` (10 seconds) | Cache duration for Media Delivery API responses. |

## Default behavior

### What is not cached

The following requests are excluded from caching by default:

- **Preview mode** requests.
- Requests without **public access** to the Delivery API.

### Automatic cache eviction

Cached responses are automatically evicted when content changes. This works through a tagging system. When a response is cached, it is tagged with identifiers. When content changes, the relevant tags are targeted for eviction.

Each cached content response is automatically tagged with:

- Its own **content key**.
- The keys of all its **ancestors** in the content tree.
- Its **content type** alias.

Each cached media response is tagged with its own **media key**.

These tags enable eviction at multiple levels:

- **By content item**: When a content item is published, unpublished, moved, or deleted, cached responses for that item are evicted via its content key tag.
- **By branch**: Branch operations evict all descendants via the ancestor tags.
- **By relations**: When content, media, or a member is saved, responses for content that references the changed item via picker properties are evicted.
- **Global**: A full content cache refresh evicts all cached responses.

## Load balancing considerations

The Delivery API's output caching supports the same two approaches available for the website rendering pipeline:

- **Per-instance in-memory cache (the default)**: each server maintains its own cache, with eviction notifications distributed across the cluster so cached responses stay consistent.
- **Shared distributed cache**: a single cache shared across all servers, typically backed by [Redis](https://redis.io/) via the [Microsoft.AspNetCore.OutputCaching.StackExchangeRedis](https://www.nuget.org/packages/Microsoft.AspNetCore.OutputCaching.StackExchangeRedis) package.

The trade-offs and the guidance on when to choose one over the other are the same as for website rendering. For a full discussion, see [Load balancing considerations](../website-output-caching.md#load-balancing-considerations) in the Website Output Caching article.

## Extending output caching

The feature provides extension points for customizing caching behavior. Each is registered through dependency injection.

### Filtering cacheable requests

**Interface:** `IDeliveryApiOutputCacheRequestFilter`
**Registration:** Single — replace the default with `builder.Services.AddUnique<IDeliveryApiOutputCacheRequestFilter, YourFilter>()`.

Controls whether a request is eligible for output caching. The interface has two methods:

- `IsCacheable(HttpContext)` — called before the controller runs, for request-level decisions.
- `IsCacheable(HttpContext, IPublishedContent)` — called after the controller resolves content, for content-aware decisions.

The default implementation (`DefaultDeliveryApiOutputCacheRequestFilter`) returns `false` for preview mode requests and requests without public access. It exposes `virtual` methods for each check, so you can inherit and override individual concerns.

**Example — skip caching when a query parameter is present:**

{% code title="NoCacheQueryFilter.cs" %}
```csharp
using Microsoft.AspNetCore.Http;
using Umbraco.Cms.Api.Delivery.Caching;
using Umbraco.Cms.Core.DeliveryApi;

namespace YourProject.Caching;

public class NoCacheQueryFilter : DefaultDeliveryApiOutputCacheRequestFilter
{
    public NoCacheQueryFilter(
        IRequestPreviewService requestPreviewService,
        IApiAccessService apiAccessService)
        : base(requestPreviewService, apiAccessService) { }

    public override bool IsCacheable(HttpContext context)
    {
        if (context.Request.Query.ContainsKey("nocache"))
        {
            return false;
        }

        return base.IsCacheable(context);
    }
}
```
{% endcode %}

Register the filter in a composer:

{% code title="CacheComposer.cs" %}
```csharp
using Umbraco.Cms.Api.Delivery.Caching;
using Umbraco.Cms.Core.Composing;

namespace YourProject.Caching;

public class CacheComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.Services.AddUnique<IDeliveryApiOutputCacheRequestFilter, NoCacheQueryFilter>();
}
```
{% endcode %}

**Example — skip caching for a specific content type:**

{% code title="SkipContactCachingFilter.cs" %}
```csharp
using Microsoft.AspNetCore.Http;
using Umbraco.Cms.Api.Delivery.Caching;
using Umbraco.Cms.Core.DeliveryApi;
using Umbraco.Cms.Core.Models.PublishedContent;

namespace YourProject.Caching;

public class SkipContactCachingFilter : DefaultDeliveryApiOutputCacheRequestFilter
{
    public SkipContactCachingFilter(
        IRequestPreviewService requestPreviewService,
        IApiAccessService apiAccessService)
        : base(requestPreviewService, apiAccessService) { }

    public override bool IsCacheable(HttpContext context, IPublishedContent content)
        => content.ContentType.Alias != "contact";
}
```
{% endcode %}

### Custom cache tags and eviction

**Interfaces:** `IDeliveryApiOutputCacheTagProvider` and `IDeliveryApiOutputCacheEvictionProvider`.
**Registration:** Multiple — add with `builder.Services.AddSingleton<>()`. Multiple providers of each type are additive.

These two interfaces work as a pair to support cross-content eviction scenarios:

- `IDeliveryApiOutputCacheTagProvider` adds custom tags to cached responses when they are stored.
- `IDeliveryApiOutputCacheEvictionProvider` returns tags to evict when a content change occurs.

Tags can also be targeted from custom code using `IDeliveryApiOutputCacheManager.EvictByTagAsync()`.

**Example — evict a blog category response when one of its blog posts is published:**

In this example, a blog site has two Document Types: `blogCategory` and `blogPost`. Each blog post has a content picker property with the alias `blogCategory` that references its category. When a blog post is published, the selected category response is evicted so it reflects the change.

The tag provider tags each category response with a tag that includes the category content key. The eviction provider checks whether the changed content is a blog post. If so, it reads the picker value to return the tag for the selected category.

{% code title="BlogCacheTagProvider.cs" %}
```csharp
using Umbraco.Cms.Core.Cache;
using Umbraco.Cms.Core.Models.PublishedContent;

namespace YourProject.Caching;

// Tag each blog category response with a unique tag.
public class BlogCacheTagProvider : IDeliveryApiOutputCacheTagProvider
{
    public IEnumerable<string> GetTags(IPublishedContent content)
    {
        if (content.ContentType.Alias == "blogCategory")
        {
            yield return $"blog-category-{content.Key}";
        }
    }
}
```
{% endcode %}

{% code title="BlogEvictionProvider.cs" %}
```csharp
using Umbraco.Cms.Core.Cache;
using Umbraco.Cms.Core.Services;

namespace YourProject.Caching;

// When a blog post changes, evict the category response selected in its "blogCategory" picker.
public class BlogEvictionProvider : IDeliveryApiOutputCacheEvictionProvider
{
    private readonly IContentService _contentService;

    public BlogEvictionProvider(IContentService contentService)
        => _contentService = contentService;

    public Task<IEnumerable<string>> GetAdditionalEvictionTagsAsync(
        OutputCacheContentChangedContext context,
        CancellationToken cancellationToken = default)
    {
        var content = _contentService.GetById(context.ContentKey);
        if (content?.ContentType.Alias == "blogPost")
        {
            var categoryKey = content.GetValue<Guid?>("blogCategory");
            if (categoryKey.HasValue)
            {
                return Task.FromResult<IEnumerable<string>>(
                    [$"blog-category-{categoryKey.Value}"]);
            }
        }

        return Task.FromResult<IEnumerable<string>>([]);
    }
}
```
{% endcode %}

Register both providers in a composer:

{% code title="BlogCacheComposer.cs" %}
```csharp
using Umbraco.Cms.Core.Cache;
using Umbraco.Cms.Core.Composing;

namespace YourProject.Caching;

public class BlogCacheComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddSingleton<IDeliveryApiOutputCacheTagProvider, BlogCacheTagProvider>();
        builder.Services.AddSingleton<IDeliveryApiOutputCacheEvictionProvider, BlogEvictionProvider>();
    }
}
```
{% endcode %}

### Programmatic eviction

**Interface:** `IDeliveryApiOutputCacheManager`
**Usage:** Inject via dependency injection. All methods are no-ops when output caching is not enabled.

Evict cache entries from custom code. This is useful when external data changes that affect Delivery API responses.

{% code title="ExternalDataWebhookController.cs" %}
```csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Core.Cache;

namespace YourProject.Controllers;

[ApiController]
[Route("webhooks")]
public class ExternalDataWebhookController : ControllerBase
{
    private readonly IDeliveryApiOutputCacheManager _cacheManager;

    public ExternalDataWebhookController(IDeliveryApiOutputCacheManager cacheManager)
        => _cacheManager = cacheManager;

    [HttpPost("external-data-changed")]
    public async Task<IActionResult> OnExternalDataChanged(Guid contentKey)
    {
        // Evict the cached Delivery API response for a specific content item.
        await _cacheManager.EvictContentAsync(contentKey);
        return Ok();
    }
}
```
{% endcode %}

Available methods:

- `EvictContentAsync(Guid contentKey)` — evicts the cached response for a specific content item.
- `EvictMediaAsync(Guid mediaKey)` — evicts the cached response for a specific media item.
- `EvictByTagAsync(string tag)` — evicts all cached responses with a specific tag.
- `EvictAllContentAsync()` — evicts all cached content responses.
- `EvictAllMediaAsync()` — evicts all cached media responses.
- `EvictAllAsync()` — evicts all cached Delivery API responses (content and media).

### Custom vary-by rules

**Interface:** `IDeliveryApiOutputCacheVaryByProvider`
**Registration:** Multiple — add with `builder.Services.AddSingleton<IDeliveryApiOutputCacheVaryByProvider, YourProvider>()`. Multiple providers are additive.

Control which request dimensions produce separate cache entries. Each provider receives the `HttpContext` and the ASP.NET Core `CacheVaryByRules` object.

By default, content responses vary by `Accept-Language`, `Accept-Segment`, and `Start-Item` headers. Media responses vary by `Start-Item` only.

**Example — vary by a custom header:**

{% code title="TestHeaderVaryByProvider.cs" %}
```csharp
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.OutputCaching;
using Microsoft.Extensions.Primitives;
using Umbraco.Cms.Api.Delivery.Caching;

namespace YourProject.Caching;

public class TestHeaderVaryByProvider : IDeliveryApiOutputCacheVaryByProvider
{
    public void ConfigureVaryBy(HttpContext context, CacheVaryByRules rules)
    {
        if (context.Request.Headers.TryGetValue("X-Test-Variant", out StringValues variant))
        {
            rules.VaryByValues["test-variant"] = variant.ToString();
        }
    }
}
```
{% endcode %}

With this provider registered, requests with `X-Test-Variant: A` and `X-Test-Variant: B` produce separate cache entries.

## Debugging

The output cache policy logs all cache decisions at `Debug` level. Enable debug logging for the caching namespace:

{% code title="appsettings.json" %}
```json
{
  "Serilog": {
    "MinimumLevel": {
      "Override": {
        "Umbraco.Cms.Api.Delivery.Caching": "Debug"
      }
    }
  }
}
```
{% endcode %}

Log messages include why caching was skipped (preview mode, public access, content-aware filter). When caching is applied, the logs show the tag count and duration.

The `Age` response header on cached responses indicates how long the response has been served from cache.

## Additional considerations

While output caching is a great way to boost performance, it should never be used as a band-aid to solve poor uncached performance. The Delivery API is generally performant without caching.

If you experience performance issues while querying the Delivery API, your first step should be to diagnose and fix the root cause. This could be any number of things, like:

- Un-performant value converters.
- Overly complex queries.
- An inexpedient content architecture.
- ...or something else entirely.

Hiding such problems behind output caching should only ever be considered as a short-term solution. In the long run, it will not be a sustainable fix.
