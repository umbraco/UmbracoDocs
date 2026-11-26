# ICacheRefresher

_This section describes what ICacheRefresher and ICacheRefresher&lt;T&gt; are and how to use them to invalidate your cache correctly including load balanced environments_

## What is an ICacheRefresher

This interface has been in the Umbraco core for a significant period. However, it has really only been used to ensure that content cache is refreshed among all server nodes participating in a load balanced scenario.

An `ICacheRefresher` is the primary method that invalidates *any* cache needing refreshment or removal. This applies regardless of a load balanced environment.

There are now a few different types of `ICacheRefreshers` in the Umbraco core. It is important to understand the differences between them and how cache invalidation works across multiple server nodes.
