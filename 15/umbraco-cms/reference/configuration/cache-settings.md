---
description: Information on the Cache settings section
---

# Cache Settings

{% hint style="info" %}
Are you looking for the **NuCache Settings**?

While most cache configurations are under the `Umbraco:CMS:Cache` settings node, a few remain under `Umbraco:CMS:NuCache`. [Learn more about this at the bottom of this article](#nucache-settings).
{% endhint %}

## HybridCacheOptions

Umbraco's cache is implemented using Microsofts `HybridCache`, which also has its own settings. For more information [see the HybridCache documentation](https://learn.microsoft.com/en-us/aspnet/core/performance/caching/hybrid?view=aspnetcore-9.0#options).

### MaximumPayLoadBytes

One `HybridCache` setting of particular interest is the `MaximumPayloadBytes` setting. This setting specifies the maximum size of a cache entry in bytes and replaces the `BTreeBlockSize` setting from NuCache.
The default from Microsoft is 1MB. However, this limit could quickly be reached, especially when using multiple languages or property editors like the block grid.
To avoid this Umbraco overrides the setting to 100MB by default. You can also configure this manually using a composer:

```csharp
using Microsoft.Extensions.Caching.Hybrid;
using Umbraco.Cms.Core.Composing;

namespace MySite.Caching;

public class ConfigureCacheComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddOptions<HybridCacheOptions>().Configure(x =>
        {
            x.MaximumPayloadBytes = 1024 * 1024 * 10; // 10MB
        });
    }
}
```

## Seeding settings

The Seeding settings allow you to specify which content should be seeded into your cache. For more information on cache seeding see the [Cache Seeding.](../cache/cache-seeding.md) article.

### ContentTypeKeys

The `ContentTypeKeys` setting specifies which Document Types should be seeded into the cache. The setting is a comma-separated list of Document Type keys.

```json
"Umbraco": {
  "CMS": {
    "Cache": {
      "ContentTypeKeys": ["e811405e-0190-4d3e-8387-7558521eec81", "419e89fb-8cff-4549-a074-9f8a30687828", "e0d71146-8205-4cf4-8236-f982b392259f"],
    }
  }
}
```

### DocumentBreadthFirstSeedCount

The `DocumentBreadthFirstSeedCount` setting specifies how many documents should be seeded into the cache when doing a breadth-first traversal. The default value is 100.

```json
"Umbraco": {
  "CMS": {
    "Cache": {
      "DocumentBreadthFirstSeedCount": 500
    }
  }
}
```

## MediaBreadthFirstSeedCount

The `MediaBreadthFirstSeedCount` setting specifies how many media items should be seeded into the cache when doing a breadth-first traversal. The default value is 100.

```json
"Umbraco": {
  "CMS": {
    "Cache": {
      "MediaBreadthFirstSeedCount": 500
    }
  }
}
```

## Cache Entry settings

The Entry settings allow you to specify how long cache entries should be kept. The cache entry settings are identical for documents and media.

## LocalCacheDuration

Specifies the duration for which cache entries should be kept in the local memory cache. The default value is 24 hours.

```json
"Umbraco": {
  "CMS": {
    "Cache": {
      "Entry": {
        "Document": {
          "LocalCacheDuration": "2.00:00:00"
        },
        "Media": {
          "LocalCacheDuration": "50.00:00:00"
        }
      }
    }
  }
}
```

## RemoteCacheDuration

Specifies the duration that cache entries should be kept in the remote cache, second level cache. This setting is only relevant if a second-level cache is configured. The default value is 1 year.

```json
"Umbraco": {
  "CMS": {
    "Cache": {
      "Entry": {
        "Document": {
          "RemoteCacheDuration": "100.00:00:00"
        },
        "Media": {
          "RemoteCacheDuration": "150.00:00:00"
        }
      }
    }
  }
}
```

## SeedCacheDuration

Specifies the duration for which seeded cache entries should be kept in the cache. The default value is 1 year.

```json
"Umbraco": {
  "CMS": {
    "Cache": {
      "Entry": {
        "Document": {
          "SeedCacheDuration": "200.00:00:00"
        },
        "Media": {
          "SeedCacheDuration": "250.00:00:00"
        }
      }
    }
  }
}
```

# NuCache Settings

For backward compatibility reasons, certain settings are under the `Umbraco:CMS:NuCache` settings node.

## UsePagedSqlQuery

Setting `UsePagedSqlQuery` to `False` your project will use the `Fetch` method instead of the `QueryPaged` method when rebuilding the NuCache files. This will increase performance on bigger Umbraco websites with a lot of content when rebuilding the NuCache.

```json
"Umbraco": {
  "CMS": {
    "NuCache": {
      "UsePagedSqlQuery": false
    }
   }
 }

```
## SqlPageSize

Specifying the `SqlPageSize` will change the size of the paged SQL queries. The default value is 1000.

```json
"Umbraco": {
  "CMS": {
    "NuCache": {
      "SqlPageSize": 500
    }
   }
 }
```
