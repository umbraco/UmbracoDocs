---
versionFrom: 8.0.0
---

# Cache & Distributed Cache

_This section refers to how to implement caching features in the Umbraco application in a consistent way that will work in both single server environments and load balanced (multi-server) environments. The caching described in this section relates to application caching in the context of a web application only._

## IF YOU ARE CACHING, PLEASE READ THIS

Although caching is a pretty standard concept it is very important to make sure that caching is done correctly and consistently. It is always best to ensure performance is at its best before applying any cache and also beware of *over caching* as this can cause degraded performance in your application because of cache turnover.

In normal environments caching seems to be a pretty standard concept. If you are a package developer or developer who is going to publish a codebase to a loadbalanced environment then you need to be aware of how to invalidate your cache properly, so that it works in load balanced environments. If it is not done correctly then your package and/or codebase will not work the way that you would expect in a load balanced scenario.

**If you are caching businesslogic data that changes based on a user's action in the backoffice and you are not using an *ICacheRefresher* then you will need to review your code and update it based on the below documentation.**

## Getting and clearing cached content

[See our example on how to cache tags](examples/tags.md).

## [ApplicationCache](applicationcache.md)
