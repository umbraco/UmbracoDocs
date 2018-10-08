# Accessing the cache

You should always be doing this consistently with the best practices listed below. You shouldn't be using HttpRuntime.Cache or HttpContext.Current.Cache directly, you should always be accessing it via the ApplicationContext.ApplicationCache object (`Umbraco.Core.CacheHelper`).

## Cache types

The `Umbraco.Core.CacheHelper` contains 3 types of cache: Runtime Cache, Request Cache and Static Cache.

**Runtime Cache** is the most commonly used and is synonymous with HttpRuntime.Cache. **Request cache** is cache that exists only for the current request, this is synonymous with HttpContext.Current.Items and **static cache** is cache that exists globally and never expires. Static cache should be rarely used and should be used with caution since it can cause memory issues.

The various cache types can be referenced on properties of the `Umbraco.Core.CacheHelper`:

      ApplicationContext.ApplicationCache.RuntimeCache
      ApplicationContext.ApplicationCache.RequestCache
      ApplicationContext.ApplicationCache.StaticCache

It's easy to [access and update the cache items](updating-cache.md), using the provided methods.