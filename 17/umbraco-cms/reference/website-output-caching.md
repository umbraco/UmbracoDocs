---
description: >-
  Boost website performance with opt-in server-side output caching for
  Umbraco pages that are rendered with Razor templates.
---

# Website Output Caching

Umbraco provides opt-in output caching for server-side rendered pages. When enabled, the server caches the full rendered HTML response and serves it directly for subsequent requests. The Razor pipeline, and whatever logic is triggered from that, is not re-executed until the cache expires or is evicted.

Under the hood, the feature uses the built-in [output caching middleware in ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/performance/caching/output).

{% hint style="info" %}
**Output caching vs. response caching**

Output caching and [Response Caching](response-caching.md) serve different purposes:

- **Output caching** caches the rendered response **on the server**. Subsequent requests are served from cache without re-executing the rendering pipeline. This is what reduces server load.
- **Response caching** sets `Cache-Control` HTTP headers that tell **browsers and proxies** to cache the response. The server still processes every request that reaches it.

The two are complementary — you can use both together.
{% endhint %}

{% hint style="info" %}
The Content Delivery API has its own output caching support. For details, see the [Output caching](content-delivery-api/output-caching.md) article in the Delivery API section.
{% endhint %}

## Why use output caching?

Every front-end page request on a typical Umbraco site runs the full Razor rendering pipeline. For most sites, content changes infrequently relative to how often it is read. A site might be published a few times a day but serve thousands of requests per hour.

Even a short cache duration is effective. A 10-second cache collapses all concurrent requests within that window into a single Razor execution. During traffic spikes, the server CPU stays flat instead of scaling linearly with requests.

However, output caching does come with trade-offs:

- The cache consumes additional server memory.
- Editors may experience a short delay between publishing and the updated page appearing. Active eviction on publish, via the built-in defaults and custom use of extension points, keeps this minimal.

## When _not_ to use output caching

Output caching can be a poor fit in some cases:

- Pages that vary per user due to server-side personalization (for example, member-specific content rendered in Razor). If personalization is handled client-side via JavaScript, output caching can still be used.
- Pages where editors require immediate publishing with guaranteed zero delay.

{% hint style="info" %}
Output caching is **disabled by default**. Enabling it is an opt-in decision.
{% endhint %}

## Configuring output caching

Enable output caching by adding the `OutputCache` section to the `Website` configuration in `appsettings.json`:

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "CMS": {
      "Website": {
        "OutputCache": {
          "Enabled": true,
          "ContentDuration": "00:00:30"
        }
      }
    }
  }
}
```
{% endcode %}

| Property | Type | Default | Description |
|---|---|---|---|
| `Enabled` | `bool` | `false` | Enables or disables website output caching. |
| `ContentDuration` | `TimeSpan` | `00:00:10` (10 seconds) | Default cache duration for rendered pages. Can be overridden per content item using `IWebsiteOutputCacheDurationProvider`. |

## Default behavior

### What is cached

All standard Umbraco pages are cached. This covers every page routed through the default Umbraco rendering pipeline. Pages rendered by custom controllers that inherit from `RenderController` are also cached (see [Custom MVC controllers (Umbraco Route Hijacking)](routing/custom-controllers.md)).

### What is not cached

The following requests are excluded from caching by default:

- **Preview mode** requests.
- **Authenticated member** requests.
- Responses where the server sets `Cache-Control: no-store`. This includes pages that render `@Html.AntiForgeryToken()`, because the anti-forgery middleware sets this header automatically.
- Responses that include `Set-Cookie` headers.
- Pages where the routing pipeline sets `SetNoCacheHeader` on the published request.
- Controllers that implement `IRenderController` directly without inheriting from `RenderController`.

### Automatic cache eviction

Cached pages are automatically evicted when content changes. This works through a tagging system: when a page is cached, it is tagged with identifiers that describe the page. When content changes, the relevant tags are targeted for eviction.

Each cached page is automatically tagged with:

- Its own **content key**.
- The keys of all its **ancestors** in the content tree.
- Its **content type** alias.
- The keys of any **related items** referenced through picker properties (content pickers, media pickers, member pickers), tracked through Umbraco's automatic relations.

These tags enable eviction at multiple levels:

- **By content item**: When a content item is published, unpublished, moved, or deleted, the cached page for that item is evicted via its content key tag.
- **By branch**: Branch operations, such as moving a node with children, evict all descendants via the ancestor tags.
- **By relations**: When content, media, or a member is saved, any pages that reference the changed item are evicted via the relation tags.
- **By content type**: All pages of a given content type can be evicted via the content type tag.
- **Global**: A full content cache refresh evicts all cached pages.

## Load balancing considerations

Output caching works in load-balanced setups through one of two approaches. Either keep a separate in-memory cache on each server, or share a single cache across all servers via a distributed store. Each comes with trade-offs around memory, latency, and operational complexity.

### Per-instance in-memory cache (the default)

The default `IOutputCacheStore` implementation is in-process memory. Each server maintains its own cache, and eviction is distributed across the cluster through `ContentCacheRefresherNotification`. When content changes on one server, every server in the cluster receives the notification and evicts the relevant entries from its local cache. This keeps cached content consistent without requiring any shared infrastructure.

The trade-offs of this approach:

- **Memory duplication**: Each server holds its own copy of the same cached pages. Total memory across the cluster scales with the number of servers, although per-server memory is unaffected.
- **Per-server warm-up**: A visitor routed to a server that has not yet served a particular page experiences a cache miss, even if other servers have it cached.
- **Cache lost on restart**: When a server process restarts (deployment, app pool recycle), its cache starts empty until requests rebuild it.

This is a reasonable choice for many load-balanced sites. It requires no additional infrastructure, and the cost of per-server warm-up is small relative to the savings over uncached rendering.

### Shared distributed cache (Redis)

For a single shared cache across all instances, you can swap the default in-memory store for any `IOutputCacheStore` implementation. The most common option is [Redis](https://redis.io/), via Microsoft's [Microsoft.AspNetCore.OutputCaching.StackExchangeRedis](https://www.nuget.org/packages/Microsoft.AspNetCore.OutputCaching.StackExchangeRedis) package. Hosted Redis offerings include [Azure Cache for Redis](https://learn.microsoft.com/azure/azure-cache-for-redis/) and [Azure Managed Redis](https://learn.microsoft.com/azure/redis/), with equivalents available from other cloud providers.

To use Redis as the backing store, install the package and register it in `Program.cs` before `AddOutputCache`:

{% code title="Program.cs" %}
```csharp
builder.Services.AddStackExchangeRedisOutputCache(options =>
{
    options.Configuration = builder.Configuration.GetConnectionString("Redis");
    options.InstanceName = "umbraco-output-cache:";
});
```
{% endcode %}

For full configuration details, see the [Microsoft documentation on Redis output cache](https://learn.microsoft.com/aspnet/core/performance/caching/output#redis-cache).

The trade-offs of this approach:

- **Network round-trip per request**: Each cache lookup reads from Redis over the network. Redis is fast, but there is a small added latency on every cached response compared to in-process memory.
- **External dependency**: A Redis outage stops cached responses from being served on every server. Requests fall back to the uncached rendering pipeline, so the site remains available, but the performance benefits disappear until Redis recovers.
- **Operational cost**: A managed Redis service is an additional running cost, and a self-hosted Redis cluster requires monitoring and maintenance.
- **Lower total memory**: Cached content is stored once, regardless of how many servers are in the cluster.
- **Single shared warm-up**: A new server joining the cluster benefits immediately from the existing cache, and the cache survives individual server restarts and deployments.

### Choosing between the two

Defaulting to the in-memory approach unless you have a specific reason to switch is a reasonable first step. It is simpler, faster on a per-request basis, and works without any extra moving parts.

Consider Redis when one or more of the following apply:

- The cluster has many servers (typically four or more), so the duplicated memory cost across instances becomes significant.
- Cached pages are large enough that holding a copy on each server is expensive — for example, long content-heavy pages cached for extended durations.
- New servers join the cluster frequently (auto-scaling), and starting with an empty cache on each new instance produces noticeable load spikes on origins or downstream systems.
- You want cached content to survive deployments and restarts.

## Extending output caching

The feature provides extension points for customizing caching behavior. Each is registered through dependency injection.

### Filtering cacheable requests

**Interface:** `IWebsiteOutputCacheRequestFilter`
**Registration:** Single — replace the default with `builder.Services.AddUnique<IWebsiteOutputCacheRequestFilter, YourFilter>()`.

Controls whether a request is eligible for output caching. The default implementation (`DefaultWebsiteOutputCacheRequestFilter`) returns `false` for preview mode and authenticated member requests. It exposes `virtual` methods for each check, so you can inherit and override individual concerns.

**Example — allow caching for authenticated members:**

{% code title="AllowAuthenticatedCachingFilter.cs" %}
```csharp
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Web.Website.Caching;

namespace YourProject.Caching;

public class AllowAuthenticatedCachingFilter : DefaultWebsiteOutputCacheRequestFilter
{
    public AllowAuthenticatedCachingFilter(IUmbracoContextAccessor umbracoContextAccessor)
        : base(umbracoContextAccessor) { }

    protected override bool ShouldExcludeAuthenticated(HttpContext context) => false;
}
```
{% endcode %}

Register the filter in a composer:

{% code title="CacheComposer.cs" %}
```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Web.Website.Caching;

namespace YourProject.Caching;

public class CacheComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.Services.AddUnique<IWebsiteOutputCacheRequestFilter, AllowAuthenticatedCachingFilter>();
}
```
{% endcode %}

**Example — skip caching for a specific content type:**

{% code title="SkipSearchResultsCachingFilter.cs" %}
```csharp
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Web.Website.Caching;

namespace YourProject.Caching;

public class SkipSearchResultsCachingFilter : DefaultWebsiteOutputCacheRequestFilter
{
    public SkipSearchResultsCachingFilter(IUmbracoContextAccessor umbracoContextAccessor)
        : base(umbracoContextAccessor) { }

    public override bool IsCacheable(HttpContext context, IPublishedContent content)
    {
        if (content.ContentType.Alias == "searchResults")
        {
            return false;
        }

        return base.IsCacheable(context, content);
    }
}
```
{% endcode %}

### Custom cache duration

**Interface:** `IWebsiteOutputCacheDurationProvider`
**Registration:** Single — replace the default with `builder.Services.AddUnique<IWebsiteOutputCacheDurationProvider, YourProvider>()`.

Override the cache duration per content item. Return `null` to use the configured default, a positive `TimeSpan` to override, or `TimeSpan.Zero` to disable caching for that content item.

**Example — different durations per content type:**

{% code title="ContentTypeDurationProvider.cs" %}
```csharp
using Umbraco.Cms.Core.Cache;
using Umbraco.Cms.Core.Models.PublishedContent;

namespace YourProject.Caching;

public class ContentTypeDurationProvider : IWebsiteOutputCacheDurationProvider
{
    public TimeSpan? GetDuration(IPublishedContent content)
        => content.ContentType.Alias switch
        {
            "pressRelease" => TimeSpan.FromHours(1),
            "homePage" => TimeSpan.FromMinutes(5),
            _ => null // Use the configured default.
        };
}
```
{% endcode %}

### Custom cache tagging and eviction

**Interfaces:** `IWebsiteOutputCacheTagProvider` and `IWebsiteOutputCacheEvictionProvider`
**Registration:** Multiple — add with `builder.Services.AddSingleton<>()`. Multiple providers of each type are additive.

These two interfaces work as a pair to support cross-content eviction scenarios:

- `IWebsiteOutputCacheTagProvider` adds custom tags to cached pages when they are stored.
- `IWebsiteOutputCacheEvictionProvider` returns tags to evict when a content change occurs.

Tags can also be targeted directly from custom code using `IWebsiteOutputCacheManager.EvictByTagAsync()`.

**Example — evict a blog category page when one of its blog posts is published:**

In this example, a blog site has two Document Types: `blogCategory` and `blogPost`. Each blog post has a content picker property with the alias `blogCategory` that references its category. When a blog post is published, the selected category page should be evicted so it reflects the change.

The tag provider tags each category page with a tag that includes the category's content key. The eviction provider checks whether the changed content is a blog post. If so, it reads the picker value to return the tag for the selected category.

{% code title="BlogCacheTagProvider.cs" %}
```csharp
using Umbraco.Cms.Core.Cache;
using Umbraco.Cms.Core.Models.PublishedContent;

namespace YourProject.Caching;

// Tag each blog category page with a unique tag.
public class BlogCacheTagProvider : IWebsiteOutputCacheTagProvider
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

// When a blog post changes, evict the category page selected in its "blogCategory" picker.
public class BlogEvictionProvider : IWebsiteOutputCacheEvictionProvider
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
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Cache;

namespace YourProject.Caching;

public class BlogCacheComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddSingleton<IWebsiteOutputCacheTagProvider, BlogCacheTagProvider>();
        builder.Services.AddSingleton<IWebsiteOutputCacheEvictionProvider, BlogEvictionProvider>();
    }
}
```
{% endcode %}

### Programmatic eviction

**Interface:** `IWebsiteOutputCacheManager`
**Usage:** Inject via dependency injection. All methods are no-ops when output caching is not enabled.

Evict cache entries from custom code. This is useful when external data changes that affect rendered pages.

{% code title="ExternalDataWebhookController.cs" %}
```csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Core.Cache;

namespace YourProject.Controllers;

[ApiController]
[Route("webhooks")]
public class ExternalDataWebhookController : ControllerBase
{
    private readonly IWebsiteOutputCacheManager _cacheManager;

    public ExternalDataWebhookController(IWebsiteOutputCacheManager cacheManager)
        => _cacheManager = cacheManager;

    [HttpPost("external-data-changed")]
    public async Task<IActionResult> OnExternalDataChanged(Guid contentKey)
    {
        // Evict the cached page for a specific content item.
        await _cacheManager.EvictContentAsync(contentKey);
        return Ok();
    }
}
```
{% endcode %}

Available methods:

- `EvictContentAsync(Guid contentKey)` — evicts the cached page for a specific content item.
- `EvictAllAsync()` — evicts all cached pages.
- `EvictByTagAsync(string tag)` — evicts all cached pages with a specific tag.

### Custom cache variation

**Interface:** `IWebsiteOutputCacheVaryByProvider`
**Registration:** Multiple — add with `builder.Services.AddSingleton<IWebsiteOutputCacheVaryByProvider, YourProvider>()`. Multiple providers are additive.

Control which request dimensions produce separate cache entries. Each provider receives the `HttpContext` and the ASP.NET Core `CacheVaryByRules` object.

**Example — vary only by specific query parameters, ignoring tracking parameters:**

{% code title="QueryKeyVaryByProvider.cs" %}
```csharp
using Microsoft.AspNetCore.OutputCaching;
using Microsoft.Extensions.Primitives;
using Umbraco.Cms.Web.Website.Caching;

namespace YourProject.Caching;

public class QueryKeyVaryByProvider : IWebsiteOutputCacheVaryByProvider
{
    public void ConfigureVaryBy(HttpContext context, CacheVaryByRules rules)
    {
        rules.QueryKeys = new StringValues(["page", "sort"]);
    }
}
```
{% endcode %}

With this provider registered, `/?utm_source=google` serves the same cached response as `/`, while `/?page=2` produces a separate cache entry.

**Example — vary by a custom culture cookie:**

If your site uses a cookie to store the visitor's preferred culture, you can create separate cache entries per culture value.

{% code title="CultureVaryByProvider.cs" %}
```csharp
using Microsoft.AspNetCore.OutputCaching;
using Umbraco.Cms.Web.Website.Caching;

namespace YourProject.Caching;

public class CultureVaryByProvider : IWebsiteOutputCacheVaryByProvider
{
    public void ConfigureVaryBy(HttpContext context, CacheVaryByRules rules)
    {
        var culture = context.Request.Cookies["preferred_culture"];
        if (culture is not null)
        {
            rules.VaryByValues["culture"] = culture;
        }
    }
}
```
{% endcode %}

## Route hijacking and output caching

Controllers that inherit from `RenderController` inherit output caching automatically. No additional configuration is needed.

To **opt out** of caching for a specific controller, apply the `[OutputCache(NoStore = true)]` attribute:

{% code title="FormPageController.cs" %}
```csharp
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ViewEngines;
using Microsoft.AspNetCore.OutputCaching;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Web.Common.Controllers;

namespace YourProject.Controllers;

public class FormPageController : RenderController
{
    public FormPageController(
        ILogger<FormPageController> logger,
        ICompositeViewEngine compositeViewEngine,
        IUmbracoContextAccessor umbracoContextAccessor)
        : base(logger, compositeViewEngine, umbracoContextAccessor) { }

    [OutputCache(NoStore = true)]
    public override IActionResult Index()
        => CurrentTemplate(new ContentModel(CurrentPage));
}
```
{% endcode %}

Controllers that implement `IRenderController` directly (without inheriting from `RenderController`) are **not** cached by default. To opt in, apply the output cache policy:

{% code title="CustomRenderController.cs" %}
```csharp
[OutputCache(PolicyName = Umbraco.Cms.Core.Constants.Website.OutputCache.ContentCachePolicy)]
public IActionResult Index() => View();
```
{% endcode %}

For more details on route hijacking, see the [Custom MVC controllers (Umbraco Route Hijacking)](routing/custom-controllers.md) article.

## Debugging

The output cache policy logs all cache decisions at `Debug` level. Enable debug logging for the caching namespace:

{% code title="appsettings.json" %}
```json
{
  "Serilog": {
    "MinimumLevel": {
      "Override": {
        "Umbraco.Cms.Web.Website.Caching": "Debug"
      }
    }
  }
}
```
{% endcode %}

Log messages include why caching was skipped (preview mode, authenticated member, no-store header, feature disabled). When caching is applied, the logs show the content key, duration, and tag count.

The `Age` response header on cached responses indicates how long the response has been served from cache.

## Additional considerations

While output caching is a great way to boost performance, it should never be used as a band-aid to solve poor uncached performance. Umbraco's Razor rendering pipeline is generally performant without caching.

If you experience performance issues with page rendering, your first step should be to diagnose and fix the root cause. This could be any number of things, like:

- Expensive or un-performant value converters.
- Slow external API calls made during rendering.
- Inefficient queries or excessive database access in views or controllers.
- Overly complex Razor view logic.
- ...or something else entirely.

Hiding such problems behind output caching should only ever be considered as a short-term solution. In the long run it will not be a sustainable fix.
