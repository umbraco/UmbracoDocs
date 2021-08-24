---
versionFrom: 9.0.0
verified-against: rc001
---

# Accessing the cache

You should always be doing this consistently with the best practices listed below. You shouldn't be using HttpRuntime.Cache or HttpContext.Current.Cache directly. Instead, you should always be accessing it via the AppCaches cache helper (`Umbraco.Cms.Core.Cache`).

## Cache types

The `AppCaches` which can be found in namespace `Umbraco.Cms.Core.Cache` contains several types of cache: Runtime Cache, Request Cache and Isolated Caches.

**Runtime Cache** is the most commonly used and is synonymous with HttpRuntime.Cache.
**Request cache** is cache that exists only for the current request. This is synonymous with HttpContext.Current.Items and **isolated caches** which are used by e.g. repositories, to ensure that each cached entity type has its own cache. When they have their own cache, lookups are fast and the repository does not need to search through all keys on a global scale.

## Getting the AppCaches

### AppCaches property

### Dependency Injection

```csharp
public class MyClass
{

    private readonly IAppPolicyCache _runtimeCache;
    private readonly IAppCache _requestCache;
    private readonly IsolatedCaches _isolatedCaches;
    
    public MyClass(AppCaches appCaches)
    {
        _runtimeCache = appCaches.RuntimeCache;
        _requestCache = appCaches.RequestCache;
        _isolatedCaches = appCaches.IsolatedCaches;
    }

}
```

### Static accessor

```csharp
IAppPolicyCache runtimeCache = Umbraco.Core.Composing.Current.AppCaches.RuntimeCache;
IAppCache requestCache = Umbraco.Core.Composing.Current.AppCaches.RequestCache;
IsolatedCaches isolatedCaches = Umbraco.Core.Composing.Current.AppCaches.IsolatedCaches;
```

You can [access and update the cache items](updating-cache.md), using the provided methods.
