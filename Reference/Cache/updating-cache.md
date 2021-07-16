---
versionFrom: 7.0.0
needsV8Update: "true"
---

# Getting/Adding/Updating/Inserting Into Cache

_This section describes how you should be getting/adding/updating/inserting items in the cache._

:::warning
Please be aware that **this article has not yet been verified and updated against Umbraco 8**.

The documentation currently available around caching in the current Umbraco version can be found here: [Caching](../Cache)
:::

## Adding and retrieving items in the cache

The recommended way to put data in and get data out is to use one of the many overloaded methods of: `GetCacheItem`. The `GetCacheItem` methods (all except one) are designed to "Get or Add" to the cache. For example, the following will retrieve an item from the cache and if it doesn't exist will ensure that the item is added to it:

```csharp
MyObject cachedItem = ApplicationContext.ApplicationCache.RuntimeCache
    .GetCacheItem<MyObject>("MyCacheKey",
        () => new MyObject());
```

Notice 2 things:

* The `GetCacheItem` method is strongly typed and
* We are supplying a callback method which is used to populate the cache if it doesn't exist.

The example above will retrieve a strongly typed object of `MyObject` from the cache with the key of "MyCacheKey", if the object doesn't exist in the cache a new instance of `MyObject` will be added to it with the same key.

There are many overloads of `GetCacheItem` allowing you to customize how your object is cached from cache dependencies to expiration times.

To use this generic implementation, add the `Umbraco.Core.Cache` namespace to your code.

### Retrieving an item from the cache without a callback

One of the overloads of `GetCacheItem` doesn't specify a callback, this will allow  you to retrieve an item from the cache without populating it if it doesn't exist.

An example of usage:

```csharp
MyObject cachedItem = ApplicationContext.ApplicationCache.RuntimeCache
    .GetCacheItem<MyObject>("MyCacheKey");
```

### Inserting an item into the cache without retrieval

Sometimes you might want to put something in the cache without retrieving it. In this case there is an `InsertCacheItem<T>` method with a few overloads. This method will add or update the cache item specified by the key so if the item already exists in the cache, it will be replaced.
