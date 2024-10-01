# Updating Cache

_This section describes how you should be getting/adding/updating/inserting items in the cache._

## Adding and retrieving items in the cache

The recommended way to put data in and get data out is to use one of the many overloaded methods of: `GetCacheItem`. The `GetCacheItem` methods (all except one) are designed to "Get or Add" to the cache. The following retrieves an item from the cache and adds it if it doesn't already exist:

```csharp
MyObject cachedItem = _appCaches.RuntimeCache.GetCacheItem<MyObject>("MyCacheKey", () => new MyObject());
```

where `_appCaches` is injected as type `AppCaches`.

Notice 2 things:

* The `GetCacheItem` method is strongly typed and
* We are supplying a callback method which is used to populate the cache if it doesn't exist.

The example above will retrieve a strongly typed object of `MyObject` from the cache with the key of "MyCacheKey". If the object doesn't exist in the cache, a new instance of MyObject `MyObject` be added to it with the same key.

There are a couple of overloads of `GetCacheItem` allowing you to customize how your object is cached from cache dependencies to expiration times.

To use this generic implementation, add the `Umbraco.Extensions` namespace to your code.

### Retrieving an item from the cache without a callback

One of the overloads of `GetCacheItem` doesn't specify a callback. This allows you to retrieve an item from the cache without populating it if it doesn't exist.

An example of usage:

```csharp
MyObject cachedItem = _appCaches.RuntimeCache.GetCacheItem<MyObject>("MyCacheKey");
```
where `_appCaches` is injected as type `AppCaches`.

### Inserting an item into the cache without retrieval

Sometimes you might want to put something in the cache without retrieving it.
In this case there is an `InsertCacheItem<T>` method.
This method will add or update the cache item specified by the key. If the item already exists in the cache, it will be replaced.
