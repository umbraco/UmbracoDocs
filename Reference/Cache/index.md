# Cache & Distributed Cache

_This section refers to how to implement caching features in the Umbraco application in a consistent way that will work in both single server environments and load balanced (multi-server) environments. The caching described in this section relates to application caching in the context of a web application only._ 

## IF YOU ARE CACHING, PLEASE READ THIS

Although caching is a pretty standard concept it is very important to make sure that caching is done correctly and consistently. It is always best to ensure performance is at its best before applying any cache and also beware of *over caching* as this can cause degraded performance in your application because of cache turnover.

In normal environments caching seems to be a pretty standard and easy concept, however if you are a package developer or a developer who is going to be publishing a codebase to a load balanced environment then you need to be aware of how to invalidate your cache properly so that it works in load balanced environments. If it is not done correctly then your package and/or codebase will not work the way that you would expect in a load balanced scenario. 

**If you are caching business logic data that changes based on a user's action in the backoffice and you are not using an *ICacheRefresher* then you will need to review your code and update it based on the below documentation.**

## Retrieving and Adding items in the cache

You can [update and insert items in the cache](updating-cache.md).

## Refreshing/Invalidating cache

### [ICacheRefresher](cache-refresher.md)

The standard way to invalidate cache in Umbraco is to implement an `ICacheRefresher`.

The interface consists of the following methods:

* `Guid UniqueIdentifier { get; }` - which you'd return your own unique GUID identifier
* `string Name { get; }` - the name of the cache refresher (informational purposes)
* `void RefreshAll();` - this would invalidate or refresh all caches of the caching type that this `ICacheRefresher` is created for. For example, if you were caching `Employee` objects, this method would invalidate all `Employee` caches.
* `void Refresh(int Id);` - this would invalidate or refresh a single cache for an object with the provided INT id.
* `void Refresh(Guid Id);` - this would invalidate or refresh a single cache for an object with the provided GUID id.
* `void Remove(int Id);` - this would invalidate a single cache for an object with the provided INT id. In many cases Remove and Refresh perform the same operation but in some cases `Refresh` doesn't just remove/invalidate a cache entry, it might update it. `Remove` is specifically used to remove/invalidate a cache entry.

 _Some of these methods may not be relevant to the needs of your own cache invalidation so not all of them may need to perform logic._

There are 2 other base types of `ICacheRefresher` which are:

* [`ICacheRefresher<T>`](cache-refresher-t.md) - this inherits from `ICacheRefresher` and provides a set of strongly typed methods for cache invalidation. This is useful when executing the method to invoke the cache refresher, when you have the instance of the object already since this avoids the overhead of retrieving the object again.
  * `void Refresh(T instance);` - this would invalidate/refresh a single cache for the specified object.
  * `void Remove(T instance);` - this would invalidate a single cache for the specified object.
* `IJsonCacheRefresher` - this inherits from `ICacheRefresher` but provides more flexibility if you need to invalidate cache based on more complex scenarios (e.g. the [MemberGroupCacheRefresher](https://github.com/umbraco/Umbraco-CMS/blob/dev-v7/src/Umbraco.Web/Cache/MemberGroupCacheRefresher.cs)).
  * `void Refresh(string jsonPayload)` - Invalidates/refreshes any cache based on the information provided in the JSON. The JSON value is any value that is used when executing the method to invoke the cache refresher.

There are several examples of `ICacheRefresher`'s in the core: https://github.com/umbraco/Umbraco-CMS/tree/dev-v7/src/Umbraco.Web/Cache

### Executing an ICacheRefresher

To execute your `ICacheRefresher` you call these methods on the `DistributedCache.Instance` instance (the `DistributedCache` object exists in the `Umbraco.Web.Cache` namespace):

* `void Refresh<T>(Guid cacheRefresherId, Func<T, int> getNumericId, params T[] instances)` - this executes an `ICacheRefresher<T>.Refresh(T instance)` of the specified cache refresher Id
* `void Refresh(Guid cacheRefresherId, int id)` - this executes an `ICacheRefresher.Refresh(int id)` of the specified cache refresher Id
* `void Refresh(Guid cacheRefresherId, guid id)` - this executes an `ICacheRefresher.Refresh(int id)` of the specified cache refresher Id
* `void Remove(Guid factoryGuid, int id)` - this executes an `ICacheRefresher.Remove(int id)` of the specified cache refresher Id
* `void Remove<T>(Guid factoryGuid, Func<T, int> getNumericId, params T[] instances)` - this executes an `ICacheRefresher<T>.Remove(T instance)` of the specified cache refresher Id
* `void RefreshAll(Guid factoryGuid)` - this executes an `ICacheRefresher.RefreshAll()` of the specified cache refresher Id
* `void RefreshByJson(Guid factoryGuid, string jsonPayload)` - this executes an `IJsonCacheRefresher.Refresh(string jsonPayload)` of the specified cache refresher Id

**So when do you use these methods to invalidate your cache?**

This really comes down to what you are caching and when it needs to be invalidated. _An example:_ In your web application you are using MVC Donut Caching and you want to make sure this cache is invalidated whenever content in Umbraco is published. To do this, you could create an `ICacheRefresher` and leave the logic for `Remove`, `Refresh` empty since it's not needed in this case. In the `RefreshAll` method, add the logic to clear the Donut Cache. Then add an event handler for `ContentService.Published`, check if there is anything being published and if so execute `DistributedCache.Instance.RefreshAll([The GUID of your ICacheRefresher]);`.

### What happens when an ICacheRefresher is executed?

When an `ICacheRefresher` is executed via the `DistributedCache.Instance` a notification is sent out to all servers that are hosting your web application to execute the specified cache refresher. When not load balancing, this simply means that the single server hosting your web application executes the `ICacheRefresher` directly however when load balancing, this means that Umbraco will ensure that each server hosting your web application executes the `ICacheRefresher` so that each server's cache stays in sync.

## Events handling to refresh cache

To use the extensions add a using to `Umbraco.Web.Cache`;  You can then invoke them on the DistributedCache.Instance object.

## IServerMessenger

The server messenger broadcasts 'distributed cache notifications' to each server in the load balanced environment.
The server messenger ensures that the notification is processed on the local environment.

## [ApplicationContext.Current.ApplicationCache](applicationcache.md)

ApplicationCache is a container for the different cache types

