---
versionFrom: 8.6.0
meta.Title: "Umbraco NuCache Settings"
meta.Description: "Information on the NuCache settings section"
meta.RedirectLink: "/umbraco-cms/reference/configuration/nucachesettings"
---

# NuCache Settings

NuCache uses the BPlusTree library for storing the cache of published content. It has a default 'block' size for where data is stored in memory. It is possible for a Umbraco content item to have a footprint that is too large. In these cases, it will cause an error when being stored in the BPlusTree block. In these circumstances it is possible to configure BPlusTree to use larger size blocks.

Add the following AppSetting to your `web.config` file:

```xml
<appSettings>
	<add key="Umbraco.Web.PublishedCache.NuCache.BTree.BlockSize" value="4096" />
</appSettings>
```

This is how NuCache is configured by default. It is important to mention that the block size must be a power of two, at least 512, and at most 65536 (64K).

## Additional Settings

It is possible to configure NuCache to work in memory only without reading/writing the NuCache database files.

For larger sites this is likely to increase startup duration for a "warm boot". However, for a smaller site there should be little to no impact.

This is configurable by adding the following composer:

```csharp
public class DisableNuCacheDatabaseComposer : IComposer
    {
        public void Compose(Composition composition)
        {
            var settings = new Umbraco.Web.PublishedCache.NuCache.PublishedSnapshotServiceOptions
            {
                IgnoreLocalDb = true
            };
            composition.Register(factory => settings, Lifetime.Singleton);
        }
    }
```

:::note
The example above applies to Umbraco 8.6+.

Are you using Umbraco 9+ or later versions, please refer to the article on [NuCache Settings for Umbraco 9+](../Configuration/NuCacheSettings/).
:::