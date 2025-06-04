# Accessing the cache

You should always be doing this consistently with the best practices listed below. You shouldn't be using HttpRuntime.Cache or HttpContext.Current.Cache directly. Instead, you should always be accessing it via the AppCaches cache helper (`Umbraco.Cms.Core.Cache`).

## Cache types

The `AppCaches` which can be found in namespace `Umbraco.Cms.Core.Cache` contains types of cache: Runtime Cache, Request Cache and Isolated Caches.

**Runtime Cache** is the most commonly used and is synonymous with HttpRuntime.Cache. **Request cache** is cache that exists only for the current request. This is synonymous with HttpContext.Current.Items and **isolated caches**. These are used by for example repositories, to ensure that each cached entity type has its own cache. When they have their own cache, lookups are fast and the repository does not need to search through all keys on a global scale.

## Getting the AppCaches

If you wish to use the AppCaches in a class, you need to use Dependency Injection (DI) in your constructor:

```csharp
public class MyClass
{
    private readonly IRelationService _relationService;

    private readonly IAppPolicyCache _runtimeCache;
    private readonly IAppCache _requestCache;
    private readonly IsolatedCaches _isolatedCaches;
    
    public MyClass(AppCaches appCaches, IRelationService relationService)
    {
        _relationService = relationService;
        _runtimeCache = appCaches.RuntimeCache;
        _requestCache = appCaches.RequestCache;
        _isolatedCaches = appCaches.IsolatedCaches;
    }

    // One example would be to get relations based on a node id. The RelationService hits the database each time and is not something you should call fx from a view that could get hit many times.
    // To get around that limitation you can wrap it in the cache so it only has to retrieve the value from the db once every minute (or whatever you set the timespan to).
    public void DocsService(int nodeId)
    {
        // Gets child relations from the cache if it exists, otherwise gets them and caches them for 1 min.
        var relations = _runtimeCache.GetCacheItem(
            $"ChildRelations_{nodeId}",
            () => _relationService.GetByChildId(nodeId, "umbDocument"), 
            TimeSpan.FromMinutes(1));
    }
}
```
