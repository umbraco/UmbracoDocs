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

### DocumentBreadthFirstSeedCount and MediaBreadthFirstSeedCount

The `DocumentBreadthFirstSeedCount` setting specifies how many documents should be seeded into the cache when doing a breadth-first traversal. `MediaBreadthFirstSeedCount` provides the same for media. The default value for both is 100.

```json
"Umbraco": {
  "CMS": {
    "Cache": {
      "DocumentBreadthFirstSeedCount": 500,
      "MediaBreadthFirstSeedCount": 500
    }
  }
}
```

## DocumentSeedBatchSize and MediaSeedBatchSize

When populating the cache on startup the content keys defined by the seeding strategy are processed in batches. The batch size for documents and media can be modified via the `DocumentSeedBatchSize` and `MediaSeedBatchSize` respectively. The default value for both is 100.

```json
"Umbraco": {
  "CMS": {
    "Cache": {
      "DocumentSeedBatchSize": 500,
      "MediaSeedBatchSize": 500
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

## Content type rebuild mode

When you save a content type with structural changes, Umbraco rebuilds the database cache for every affected content item. Structural changes include removing a property, changing a property alias, or changing the variation mode.

By default, this rebuild runs during the save operation and blocks it until every content item of the affected types has been re-serialized. On sites with many content items per type, or when multiple related content types are saved in succession, the save can be slow.

### ContentTypeRebuildMode

The `ContentTypeRebuildMode` setting controls whether the database cache rebuild runs immediately or is deferred to a background task. It accepts two values:

* `Immediate` (default): the database cache rebuild runs during the save operation.
* `Deferred`: the database cache rebuild is queued to a background task. The save returns without waiting for the rebuild to complete.

```json
"Umbraco": {
  "CMS": {
    "Cache": {
      "ContentTypeRebuildMode": "Deferred"
    }
  }
}
```

When `Deferred` is set, the content cache is still evicted immediately during the save. The next request reads the previously serialized data from the database. Once the background rebuild completes, the content cache is evicted again, and subsequent requests pick up the fresh data. Content continues to be served throughout the rebuild without errors, but may be temporarily stale.

If multiple content types are saved in quick succession, the affected content type IDs are accumulated and processed together in a single batch. This avoids overlapping rebuild work between related types.

The same setting also controls the deferral of search re-indexing triggered by content type changes.

{% hint style="info" %}
The `ContentTypeRebuildMode` setting is available from Umbraco 17.4.
{% endhint %}

## NuCache Settings

For backward compatibility reasons, certain settings are under the `Umbraco:CMS:NuCache` settings node.

### UsePagedSqlQuery

When `UsePagedSqlQuery` is set to `False`, the `Fetch` method is used instead of the `QueryPaged` method for rebuilding the NuCache files. This will increase performance on larger Umbraco websites with a lot of content when rebuilding the NuCache.

```json
"Umbraco": {
  "CMS": {
    "NuCache": {
      "UsePagedSqlQuery": false
    }
   }
 }

```

### SqlPageSize

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

## NuCacheSerializerType

The `NuCacheSerializerType` setting allows developers to specify the serialization format for cached content.

The fastest and most compact format `MessagePack` is used by default.

An alternate `JSON` option was provided for backward compatibility for the Umbraco cache implementation used from Umbraco 8 to 14 (NuCache).

It is no longer supported with the cache implementation from Umbraco 15+ based on .NET's Hybrid cache.

The option is kept available only for a more readable format suitable for testing purposes.
