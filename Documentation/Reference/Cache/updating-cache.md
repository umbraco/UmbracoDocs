#Getting/Adding/Updating/Inserting Into Cache

**Applies to: Umbraco 4.10.0+**

_This section describes how you should be getting/adding/updating/inserting items in the cache. You should always be doing this consistently with the best practices listed below. You shouldn't be using HttpRuntime.Cache or HttpContext.Current.Cache directly, you should always be accessing it via the ApplicationContext.Current.ApplicationCache object._ 


##Adding and retreiving items in the cache

Putting data in and getting data out of the cache is the easy, just use the `ApplicationContext.Current.ApplicationCache` object (`Umbraco.Core.CacheHelper`). The easiest way is to use one of the many overloaded methods of: `GetCacheItem`

The `GetCacheItem` methods (all except one) are designed to "Get or Add" to the cache. For example, the following will retreive an item from the cache and if it doesn't exist will ensure that the item is added to it:

	MyObject cachedItem = ApplicationContext.Current.ApplicationCache
							.GetCacheItem<MyObject>("MyCacheKey",
								() => new MyObject());

Notice 2 things: the `GetCacheItem` method is strongly typed and that we are supplying a callback method which is used to populate the cache if it doesn't exist. The example above is very simple, it will retreive a strongly typed object of `MyObject` from the cache with the key of "MyCacheKey", if the object doesn't exist in the cache a new instance of `MyObject` will be added to it with the same key.

There are many overloads of GetCacheItem allowing you to customize how your object is cached from cache dependencies to expiration times.

###Retrieving an item from the cache without a callback
 
One of the overloads of GetCacheItem doesn't specify a callback, this will allow  you to simply retreive an item from the cache without populating it if it doesn't exist.

The usage is very simple:

	MyObject cachedItem = ApplicationContext.Current.ApplicationCache
							.GetCacheItem<MyObject>("MyCacheKey");

###Inserting an item into the cache without retrieval

Sometimes you might want to just put something in the cache without actually retrieving it. In this case there is an `InsertCacheItem<T>` method with a few overloads. This method will add or update the cache item specified by the key so if the item already exists in the cache, it will be replaced.
