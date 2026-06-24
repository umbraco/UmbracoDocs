---
description: >-
  Enable a managed Redis cache on your Umbraco Cloud project. Compare the available SKUs and tune the cache via the CMS Hybrid Cache reference.
---

# Cache Configuration

You can enable a managed Redis cache on your Umbraco Cloud project. The cache improves performance on a single-instance project and backs [Load Balancing](load-balancing.md) on load-balanced environments.

{% hint style="info" %}
You enable and configure the managed Redis cache in the [Umbraco Cloud Portal](https://www.s1.umbraco.io/) under `Project -> Configuration -> Cache Configuration`.
{% endhint %}

## When to enable Cache

Enable Cache when you need:

* A distributed cache shared by all instances of your environment.
* A SignalR backplane to coordinate backoffice messages across instances.
* Lower database load on read-heavy sites.

{% hint style="info" %}

You do not need to enable Cache before turning on Load Balancing. If Cache is not already enabled on the environment, Umbraco Cloud provisions a managed Redis cache as part of enabling Load Balancing.

{% endhint %}

## How the managed Redis cache is used

When you enable Cache, Umbraco Cloud provisions a managed Redis instance for your environment. Redis serves two roles:

* **Distributed cache** — keeps cached state consistent across instances so every visitor sees the same content.
* **SignalR backplane** — coordinates real-time backoffice messages across all running instances.

Umbraco CMS uses Microsoft's HybridCache for in-memory and distributed caching. See the [HybridCacheOptions reference](https://docs.umbraco.com/umbraco-cms/reference/configuration/cache-settings#hybridcacheoptions) for more details and for how to tune the cache.

## What Umbraco Cloud configures automatically

When you enable Cache, Umbraco Cloud wires Redis into your application for you. You do not need to change `Program.cs` or add any configuration code. The platform configures:

* **Distributed cache** — Redis is registered as the application's `IDistributedCache`. Umbraco's HybridCache uses Redis as its second-level (L2) cache automatically. Cached content and media are shared across all instances.
* **Session state** — ASP.NET Core session state uses the same registered distributed cache, so sessions are shared across instances.

On load-balanced environments, Umbraco Cloud also configures a SignalR backplane and shared Data Protection keys. See [What Umbraco Cloud configures automatically](load-balancing.md#what-umbraco-cloud-configures-automatically) in the Load Balancing article.

## Available Redis SKUs

![Redis SKU selector on the environment settings page](../../.gitbook/assets/redis-sku-selector.png)

Umbraco Cloud offers six Redis SKUs. The entry-level **Extra Small** tier runs without High Availability (HA) and is not covered by a Service Level Agreement (SLA). All other tiers include HA and an SLA on the Redis instance.

| Display Name | High Availability | Cache Size | Description                |
| ------------ | :---------------: | ---------- | -------------------------- |
| Extra Small  | ❌                 | 0.5 GB     | Entry-level cache, no SLA  |
| Extra Small+ | ✅                 | 0.5 GB     | Entry-level cache with SLA |
| Small+       | ✅                 | 1 GB       | Small cache with SLA       |
| Medium+      | ✅                 | 3 GB       | Medium cache with SLA      |
| Large+       | ✅                 | 6 GB       | Large cache with SLA       |
| Extra Large+ | ✅                 | 12 GB      | Extra-large cache with SLA |

The default SKU for your environment is selected automatically based on your Cloud plan. See [Cache Configuration by Cloud Plan](load-balancing.md#cache-configuration-by-cloud-plan) for the default mapping.

## Choose the right SKU

Pick a SKU that fits your working set — the active content, sessions, and backoffice state your environment caches at peak. Choose a larger SKU when:

* Your site has a large catalogue of content or media metadata.
* You serve many concurrent backoffice editors.
* You see frequent cache evictions on the current SKU.

For pricing of each SKU, see the [Umbraco pricing page](https://umbraco.com/pricing/).

## Using Redis in your own code

You can use the same Redis instance for your own caching and cross-instance coordination. Umbraco Cloud registers a shared connection in the dependency injection container. Inject `IConnectionMultiplexer` into your services to work with Redis directly:

{% code caption="ProductCacheService.cs" %}
```csharp
using StackExchange.Redis;

namespace MyProject.Services;

public class ProductCacheService
{
    private readonly IConnectionMultiplexer _redis;

    public ProductCacheService(IConnectionMultiplexer redis) => _redis = redis;

    public async Task CacheProductNameAsync(string sku, string name)
    {
        IDatabase database = _redis.GetDatabase();
        await database.StringSetAsync($"product:{sku}", name);
    }
}
```
{% endcode %}

If you need the connection string directly, read it from the environment variable `UMBRACO:CLOUD:REDIS:CONNECTIONSTRING`. The `Umbraco.Cloud.Cms` package exposes the same key as a constant:

{% code caption="Program.cs" %}
```csharp
using Umbraco.Cloud.Cms;

string? redisConnectionString = builder.Configuration
    .GetValue<string>(Constants.EnvironmentVariables.CloudRedisConnectionString);
```
{% endcode %}

{% hint style="info" %}
Both the registered `IConnectionMultiplexer` and the connection string are only available when Cache is enabled on the environment. On an environment without Cache, `IConnectionMultiplexer` is not registered. A service that takes it as a required dependency fails to resolve. Guard for that case if the same code runs on environments where Cache may be disabled.
{% endhint %}

## Related articles

* [Load Balancing](load-balancing.md) — uses the managed Redis cache as a backplane and distributed cache across instances.
* [HybridCacheOptions](https://docs.umbraco.com/umbraco-cms/reference/configuration/cache-settings#hybridcacheoptions) — CMS reference for the Hybrid Cache implementation.
