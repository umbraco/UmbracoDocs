---
description: Information on the NuCache settings section
---

# NuCache Settings

The NuCache settings allow you to configure different aspects of how cached content is stored and retrieved. Below are the details of the available settings and how they can be configured to optimize performance and compatibility with your project needs.

## BTreeBlockSize

```json
"Umbraco": {
  "CMS": {
    "NuCache": {
      "BTreeBlockSize": 4096
    }
  }
}
```

{% hint style="info" %}
The block size must be a power of two. It should be at least 512 and at most 65536 (64K).
{% endhint %}

## UsePagedSqlQuery

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

## NuCacheSerializerType

The `NuCacheSerializerType` setting allows developers to specify the serialization format for NuCache content. This setting is particularly relevant for projects migrating from older versions of Umbraco that relied on JSON formats.

To use JSON serialization instead of the default MessagePack:

### Using 'Program.cs'

```csharp
builder.Services.Configure<NuCacheSettings>(options =>
{
    options.NuCacheSerializerType = NuCacheSerializerType.JSON;
});
```

### Using 'appsettings.json'

```csharp
{
  "Umbraco": {
    "CMS": {
      "NuCache": {
        "NuCacheSerializerType": "JSON"
      }
    }
  }
}
```

## Additional Settings

You can configure NuCache to work in memory only without reading/writing to the NuCache database files. Startup duration may increase for larger sites during a "warm boot" but smaller sites should see minimal impact. The settings have not yet been exposed via the new configuration setup, instead you must configure with a composer.

```csharp
public class DisableNuCacheDatabaseComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        var settings = new Umbraco.Cms.Infrastructure.PublishedCache.PublishedSnapshotServiceOptions
        {
            IgnoreLocalDb = true
        };
        builder.Services.AddSingleton(settings);
    }
}
```
