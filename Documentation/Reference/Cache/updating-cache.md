#Getting/Adding/Updating/Inserting Into Cache

_This section describes how you should be getting/adding/updating/inserting items in the cache. You should always be doing this consistently with the best practices listed below. You shouldn't be using HttpRuntime.Cache or HttpContext.Current.Cache directly, you should always be accessing it via the ApplicationContext.ApplicationCache object (`Umbraco.Core.CacheHelper`)._ 
## Cache types

The `Umbraco.Core.CacheHelper` contains 3 types of cache: Runtime Cache, Request Cache and Static Cache. Runtime Cache is the most commonly used and is synonymous with HttpRuntime.Cache. Request cache is cache that exists only for the current request, this is synonymous with HttpContext.Current.Items and static cache is cache that exists globally and never expires. Static cache should be rarely used and should be used with caution since it can cause memory issues. The various cache types can be referenced on properties of the `Umbraco.Core.CacheHelper`:

      ApplicationContext.ApplicationCache.RuntimeCache
      ApplicationContext.ApplicationCache.RequestCache
      ApplicationContext.ApplicationCache.StaticCache

##Adding and retreiving items in the cache

Putting data in and getting data out of the cache is the easy, the easiest way is to use one of the many overloaded methods of: `GetCacheItem`. The `GetCacheItem` methods (all except one) are designed to "Get or Add" to the cache. For example, the following will retreive an item from the cache and if it doesn't exist will ensure that the item is added to it:

	MyObject cachedItem = ApplicationContext.ApplicationCache.RuntimeCache
				.GetCacheItem<MyObject>("MyCacheKey",
					() => new MyObject());

Notice 2 things: the `GetCacheItem` method is strongly typed and that we are supplying a callback method which is used to populate the cache if it doesn't exist. The example above is very simple, it will retreive a strongly typed object of `MyObject` from the cache with the key of "MyCacheKey", if the object doesn't exist in the cache a new instance of `MyObject` will be added to it with the same key.

There are many overloads of GetCacheItem allowing you to customize how your object is cached from cache dependencies to expiration times.

###Retrieving an item from the cache without a callback
 
One of the overloads of GetCacheItem doesn't specify a callback, this will allow  you to simply retreive an item from the cache without populating it if it doesn't exist.

The usage is very simple:

	MyObject cachedItem = ApplicationContext.ApplicationCache.RuntimeCache
				.GetCacheItem<MyObject>("MyCacheKey");

###Inserting an item into the cache without retrieval

Sometimes you might want to just put something in the cache without actually retrieving it. In this case there is an `InsertCacheItem<T>` method with a few overloads. This method will add or update the cache item specified by the key so if the item already exists in the cache, it will be replaced.
