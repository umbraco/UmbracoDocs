---
versionFrom: 7.0.0
needsV8Update: "true"
---

# ICacheRefresher&lt;T&gt;

:::warning
Please be aware that **this article has not yet been verified and updated against Umbraco 8**.

The documentation available around caching in the current Umbraco version can be found here: [Caching](../Cache).
:::

Cache refreshers inherit from `CacheRefresherBase`. This base class contains methods which ensure the correct 'CacheUpdated' Cache Refresher Event is triggered by your Custom ICacheRefresher implementation and fired on each server configured in your load balancing environment.

Different cache refreshers [are available in the core](https://github.com/umbraco/Umbraco-CMS/tree/v7/dev/src/Umbraco.Web/Cache).
