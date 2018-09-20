# ICacheRefresher&lt;T&gt;

Cache refreshers inherit from `CacheRefresherBase`. This base class contains methods which ensure the correct 'CacheUpdated' Cache Refresher Event is triggered by your Custom ICacheRefresher implementation and fired on each server configured in your load balancing environment.

Different cacherefreshers [are available in the core](https://github.com/umbraco/Umbraco-CMS/tree/dev-v7/src/Umbraco.Web/Cache).