#Resolvers

**Applies to: Umbraco 4.10.0+**

_A Resolver is an class that returns a plugin object or multiple plugin objects. There are 2 types of Resolvers: A single object resolver and a multiple object resolver._ 

##Single object resolver
A resolver that returns a single object. The best way to explain this is by example:

`IContentStore routesCache = ContentStoreResolver.Current.ContentStore;`

In the example above we get the currently assigned IContentStore from the ContentStoreResolver. This is a single object registered resolver and therefore it only returns one object. Developers can register a custom object in single object resolvers so long as the resolver is created to allow this. 

As an example, to set a different IContentStore, we would execute this code:

`ContentStoreResolver.Current.SetContentStore(new CustomContentStore("12355"));`

**All single object resolvers return an object that will exist as a *singleton* and one instance will exist for the lifetime of the application.**

##Multiple object resolver

A resolver that returns multiple objects of one type. Again, an example works best to explain:

`IEnumerable<ICacheRefresher> cacheRefreshers = CacheRefreshersResolver.Current.CacheResolvers;`

In the example above we get all ICacheRefresher object that have been found and/or registered. As this is a multiple object resolver, it returns many objects not just one. Developers can modify the list of types in a multiple object resolver during application startup. For example to add a custom cache refresher of type 'CustomCacheRefresher' the following code can be executed:

`CacheRefreshersResolver.Current.AddType<CustomCacheRefresher>();`

Some multiple object resolvers need to maintain a specific order of objects such as the DocumentLookupsResolver. Developers have full control over the order of registered objects since the base class `Umbraco.Core.ObjectResolution.ManyObjectsResolverBase` supports multiple methods just like a list:

* void RemoveType(Type value)
* void RemoveType<T>()
* void AddType(Type value)
* void AddType<T>()
* void Clear()
* void InsertType(int index, Type value)
* void InsertType<T>(int index)

**Multiple object resolvers can return instances based on different lifetime scopes. The lifetime scope of a resolver is determined by the developer of the resolver.**

