#ICacheRefresher

_This section describes what ICacheRefresher and ICacheRefresher&lt;T&gt; are and how to use them to invalidate your cache correctly including load balanced environments_ 

## What is an ICacheRefresher

This interface has been in the Umbraco core for quite some time but has really only been used to ensure that content cache is refreshed among all server nodes participating in a load balanced scenario. With the changes in 6.1, this has changed slightly, an ICacheRefresher is now the primary way to invalidate *any* cache that needs to be refreshed or removed regardless of whether we are in an LB environment.

There are now a few different types of ICacheRefreshers in the Umbraco core and it is important to understand the difference between them and how cache invalidation works across multiple server nodes.
