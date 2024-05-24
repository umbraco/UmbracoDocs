# Cache & Distributed Cache

_This section refers to how to implement caching features in the Umbraco application in a consistent way that will work in both single server environments and load balanced (multi-server) environments. The caching described in this section relates to application caching in the context of a web application only._

{% hint style="warning" %} **Please read this if you are Caching**

Although caching is a pretty standard concept it is very important to make sure that caching is done correctly and consistently. It is always best to ensure performance is at its best before applying any cache and also beware of _over caching_ as this can cause degraded performance in your application because of cache turnover.

In normal environments caching seems to be a pretty standard concept. If you are a package developer or developer who is going to publish a codebase to a load balanced environment then you need to be aware of how to invalidate your cache properly, so that it works in load balanced environments. If it is not done correctly then your package and/or codebase will not work the way that you would expect in a load balanced scenario.

**If you are caching business logic data that changes based on a user's action in the backoffice and you are not using an **_**ICacheRefresher**_** then you will need to review your code and update it based on the below documentation.** 
{% endhint %}

## Retrieving and Adding items in the cache

You can [update and insert items in the cache](updating-cache.md).

## Refreshing/Invalidating cache

### [ICacheRefresher](icacherefresher.md)

The standard way to invalidate cache in Umbraco is to implement an `ICacheRefresher`.

The interface consists of the following methods:

* `Guid RefresherUniqueId { get; }`
  * Which you'd return your own unique GUID identifier
* `string Name { get; }`
  * The name of the cache refresher (informational purposes)
* `void RefreshAll();`
  * This would invalidate or refresh all caches of the caching type that this `ICacheRefresher` is created for. For example, if you were caching `Employee` objects, this method would invalidate all `Employee` caches.
* `void Refresh(int Id);`
  * This would invalidate or refresh a single cache for an object with the provided `int` id.
* `void Refresh(Guid Id);`
  * This would invalidate or refresh a single cache for an object with the provided GUID id.
* `void Remove(int Id);`
  * This would invalidate a single cache for an object with the provided `int` id. In many cases Remove and Refresh perform the same operation but in some cases `Refresh` doesn't remove/invalidate a cache entry, it might update it. `Remove` is specifically used to remove/invalidate a cache entry.

_Some of these methods may not be relevant to the needs of your own cache invalidation so not all of them may need to perform logic._

There are 2 other base types of `ICacheRefresher` which are:

* `ICacheRefresher<T>` - this inherits from `ICacheRefresher` and provides a set of strongly typed methods for cache invalidation. This is useful when executing the method to invoke the cache refresher, when you have the instance of the object already since this avoids the overhead of retrieving the object again.
  * `void Refresh(T instance);` - this would invalidate/refresh a single cache for the specified object.
  * `void Remove(T instance);` - this would invalidate a single cache for the specified object.
* `IJsonCacheRefresher` - this inherits from `ICacheRefresher` but provides more flexibility if you need to invalidate cache based on more complex scenarios (e.g. the [MemberGroupCacheRefresher](https://github.com/umbraco/Umbraco-CMS/blob/v9/contrib/src/Umbraco.Core/Cache/MemberGroupCacheRefresher.cs)).
  * `void Refresh(string jsonPayload)` - Invalidates/refreshes any cache based on the information provided in the JSON. The JSON value is any value that is used when executing the method to invoke the cache refresher.

There are several examples of `ICacheRefresher`'s in the core: https://github.com/umbraco/Umbraco-CMS/tree/v9/dev/src/Umbraco.Core/Cache

### Executing an ICacheRefresher

To execute your `ICacheRefresher` you call these methods on the `DistributedCache` instance (the `DistributedCache` object exists in the `Umbraco.Cms.Core.Cache` namespace):

* `void Refresh<T>(Guid cacheRefresherId, Func<T, int> getNumericId, params T[] instances)`
  * This executes an `ICacheRefresher<T>.Refresh(T instance)` of the specified cache refresher Id
* `void Refresh(Guid cacheRefresherId, int id)`
  * This executes an `ICacheRefresher.Refresh(int id)` of the specified cache refresher Id
* `void Refresh(Guid cacheRefresherId, Guid id)`
  * This executes an `ICacheRefresher.Refresh(Guid id)` of the specified cache refresher Id
* `void Remove(Guid refresherGuid, int id)`
  * This executes an `ICacheRefresher.Remove(int id)` of the specified cache refresher Id
* `void Remove<T>(Guid refresherGuid, Func<T, int> getNumericId, params T[] instances)`
  * This executes an `ICacheRefresher<T>.Remove(T instance)` of the specified cache refresher Id
* `void RefreshAll(Guid refresherGuid)`
  * This executes an `ICacheRefresher.RefreshAll()` of the specified cache refresher Id

**So when do you use these methods to invalidate your cache?**

This really comes down to what you are caching and when it needs to be invalidated.

### What happens when an ICacheRefresher is executed?

When an `ICacheRefresher` is executed via the `DistributedCache` a notification is sent out to all servers that are hosting your web application to execute the specified cache refresher. When not load balancing, this means that the single server hosting your web application executes the `ICacheRefresher` directly. However when load balancing, this means that Umbraco will ensure that each server hosting your web application executes the `ICacheRefresher` so that each server's cache stays in sync.

## Custom cache refresher notifications

### CacheRefresherNotification
Create a custom `CacheRefresherNotification`

```c#
namespace Our.Umbraco.FavouriteThings.Sync.Notifications;

/// <summary>
/// Notification used when cache should be refreshed
/// </summary>
public class FavouriteThingsNotification(object messageObject, MessageType messageType)
		: CacheRefresherNotification(messageObject, messageType)
{
}


```

### Add a basic cache refresher notification handler (`CacheRefresherBase<T>`)

CacheRefresherBase inherits from CacheRefresherBase ICacheRefresher, but allows to pass a generic type parameter `T` where `T` is of type `CacheRefresherNotification`.
 
```c#
using System;
using Our.Umbraco.FavouriteThings.Services.Interfaces;
using Our.Umbraco.FavouriteThings.Sync.Notifications;
using Umbraco.Cms.Core.Cache;
using Umbraco.Cms.Core.Events;

namespace Our.Umbraco.FavouriteThings.Sync.NotificationHandlers;

/// <summary>
/// Cache refreshers are used as notification handlers for cache refresher notifications
/// </summary>
internal sealed class FavouriteThingsCacheRefresher(AppCaches appCaches,
								IEventAggregator eventAggregator,
								ICacheRefresherNotificationFactory factory,
								IFavouriteThingsService favouriteThingsService)
		: CacheRefresherBase<CacheRefresherNotification>(appCaches, eventAggregator, factory)
{

    // Static field can be used to execute the cache refresher
    public static Guid GuidId = new("935839b1-557b-5a03-c5c9-4f8cfec5e351");

    public override Guid RefresherUniqueId => GuidId;

    public override string Name => "FavouriteThings Cache Refresher";

    /// <summary>
    /// Refresh all cache
    /// </summary>
    public override void RefreshAll()
    {
        _favouriteThingsService.InitCache();
        base.RefreshAll();
    }

    /// <summary>
    /// Refresh single item by int
    /// </summary>    
    public override void Refresh(int id)
    {
      _favouriteThingsService.RefreshCache(id);
        base.Refresh(id);
    }

    /// <summary>
    /// Refresh single item by guid
    /// </summary>
    public override void Refresh(Guid id)
    {
      _favouriteThingsService.RefreshCache(id);
        base.Refresh(id);
    }

    /// <summary>
    /// Remove single item by int
    /// </summary>
    public override void Remove(int id)
    {
      _favouriteThingsService.RemoveFromCache(id);
        base.Remove(id);
    }
}
```


## Events handling to refresh cache

You can then invoke them on the injected `DistributedCache` object.

```c#
using Serilog;
using Umbraco.Cms.Core.Cache;

namespace Our.Umbraco.FavouriteThings.Sync.NotificationHandlers;
internal sealed class FavouriteThingsService(IApiService apiService,
											 IFavouriteThingsRepository favouriteThingsRepository,
											 DistributedCache distributedCache)
	: IFavouriteThingsService
{
	private readonly IApiService _apiService = apiService;
	private readonly IFavouriteThingsRepository _favouriteThingsRepository = favouriteThingsRepository;
	private readonly DistributedCache _distributedCache = distributedCache;

	public async Task SyncSpecificFavoriteThing(int id)
	{
        //Sync logic
		FavoriteThing? favThing = await _apiService.FetchSpecificFavoriteThing(id);

		if (favThing != null)
		{
			await _favouriteThingsRepository.SaveFavoriteThing(favThing);
			return;
		}

        //This will call the Refresh(int id) function of FavouriteThingsCacheRefresher on each server.
		_distributedCache.Refresh(FavouriteThingsCacheRefresher.GuidId, id);
	}
}
```

## IServerMessenger

The server messenger broadcasts 'distributed cache notifications' to each server in the load balanced environment. The server messenger ensures that the notification is processed on the local environment.

## Getting and clearing cached content

[See our example on how to cache tags](examples/tags.md).

## [ApplicationCache](application-cache.md)
