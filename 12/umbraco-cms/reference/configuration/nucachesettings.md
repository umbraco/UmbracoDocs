---
description: "Information on the NuCache settings section"
---

# NuCache Settings

This settings section allows you to specify the block size of the BTree used by NuCache. This is configured by default, so you don't need to configure this. However it is possible with something like:

```json
"Umbraco": {
  "CMS": {
    "NuCache": {
      "BTreeBlockSize": 4096
    }
  }
}
```

This is how NuCache is configured by default. It is important to mention that the block size must be a power of two, at least 512, and at most 65536 (64K).

## Additional Settings

It is possible to configure NuCache to work in memory only without reading/writing the NuCache database files.

Startup duration may increase for larger sites during a "warm boot" but smaller sites should see minimal impact.

The settings have not yet been exposed via the new configuration setup, instead you must configure with a composer.

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
