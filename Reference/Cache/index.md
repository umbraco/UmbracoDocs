---
versionFrom: 8.0.0
---

# Cache & Distributed Cache

_This section refers to how to implement caching features in the Umbraco application in a consistent way that will work in both single server environments and load balanced (multi-server) environments. The caching described in this section relates to application caching in the context of a web application only._

## IF YOU ARE CACHING, PLEASE READ THIS

Although caching is a pretty standard concept it is very important to make sure that caching is done correctly and consistently. It is always best to ensure performance is at its best before applying any cache and also beware of *over caching* as this can cause degraded performance in your application because of cache turnover.

In normal environments caching seems to be a pretty standard concept. If you are a package developer or developer who is going to publish a codebase to a loadbalanced environment then you need to be aware of how to invalidate your cache properly, so that it works in load balanced environments. If it is not done correctly then your package and/or codebase will not work the way that you would expect in a load balanced scenario.

**If you are caching businesslogic data that changes based on a user's action in the backoffice and you are not using an *ICacheRefresher* then you will need to review your code and update it based on the below documentation.**

## Refreshing/Invalidating cache

### [ICacheRefresher](cache-refresher.md)

The standard way to invalidate cache in Umbraco is to implement an `ICacheRefresher`.

The interface consists of the following methods:

* `Guid RefresherUniqueId { get; }` - which you'd return your own unique GUID identifier
* `string Name { get; }` - the name of the cache refresher (informational purposes)
* `void RefreshAll();` - this would invalidate or refresh all caches of the caching type that this `ICacheRefresher` is created for. For example, if you were caching `Employee` objects, this method would invalidate all `Employee` caches.
* `void Refresh(int Id);` - this would invalidate or refresh a single cache for an object with the provided INT id.
* `void Refresh(Guid Id);` - this would invalidate or refresh a single cache for an object with the provided GUID id.
* `void Remove(int Id);` - this would invalidate a single cache for an object with the provided INT id. In many cases Remove and Refresh perform the same operation but in some cases `Refresh` doesn't remove/invalidate a cache entry, it might update it. `Remove` is specifically used to remove/invalidate a cache entry.

 _Some of these methods may not be relevant to the needs of your own cache invalidation so not all of them may need to perform logic._

There are 2 other base types of `ICacheRefresher` which are:

* [`ICacheRefresher<T>`](cache-refresher-t.md) - this inherits from `ICacheRefresher` and provides a set of strongly typed methods for cache invalidation. This is useful when executing the method to invoke the cache refresher, when you have the instance of the object already since this avoids the overhead of retrieving the object again.
  * `void Refresh(T instance);` - this would invalidate/refresh a single cache for the specified object.
  * `void Remove(T instance);` - this would invalidate a single cache for the specified object.
* `IJsonCacheRefresher` - this inherits from `ICacheRefresher` but provides more flexibility if you need to invalidate cache based on more complex scenarios (e.g. the [MemberGroupCacheRefresher](https://github.com/umbraco/Umbraco-CMS/blob/v8/dev/src/Umbraco.Web/Cache/MemberGroupCacheRefresher.cs)).
  * `void Refresh(string json)` - Invalidates/refreshes any cache based on the information provided in the JSON. The JSON value is any value that is used when executing the method to invoke the cache refresher.

There are several examples of `ICacheRefresher`'s in the core: https://github.com/umbraco/Umbraco-CMS/tree/v8/dev/src/Umbraco.Web/Cache

## Getting and clearing cached content

[See our example on how to cache tags](examples/tags.md).

## [ApplicationCache](applicationcache.md)
