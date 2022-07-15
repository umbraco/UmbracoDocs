---
versionFrom: 7.0.0
needsV8Update: "true"
---

# ICacheRefresher

_This section describes what ICacheRefresher and ICacheRefresher&lt;T&gt; are and how to use them to invalidate your cache correctly including load balanced environments_

:::warning
Please be aware that **this article has not yet been verified and updated against Umbraco 8**.

The documentation available around caching in the current Umbraco version can be found here: [Caching](../Cache).
:::

## What is an ICacheRefresher

This interface has been in the Umbraco core for quite some time but has really only been used to ensure that content cache is refreshed among all server nodes participating in a load balanced scenario.

With changes in 6.1, this has changed slightly, an `ICacheRefresher` is now the primary way to invalidate *any* cache that needs to be refreshed or removed regardless of whether we are in a load balanced environment.

There are now a few different types of `ICacheRefreshers` in the Umbraco core and it is important to understand the differences between them and how cache invalidation works across multiple server nodes.
