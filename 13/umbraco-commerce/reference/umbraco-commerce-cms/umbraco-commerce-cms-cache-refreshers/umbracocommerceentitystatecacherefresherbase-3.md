---
title: UmbracoCommerceEntityStateCacheRefresherBase<TInstanceType,TService,TEntity>
description: API reference for UmbracoCommerceEntityStateCacheRefresherBase<TInstanceType,TService,TEntity> in Umbraco Commerce
---
## UmbracoCommerceEntityStateCacheRefresherBase&lt;TInstanceType,TService,TEntity&gt;

```csharp
public abstract class 
    UmbracoCommerceEntityStateCacheRefresherBase<TInstanceType, TService, TEntity> : 
    PayloadCacheRefresherBase<UmbracoCommerceCacheRefresherNotification, UmbracoCommerceEntityCacheRefresherPayload>
    where TInstanceType : class, ICacheRefresher
    where TService : ICachedEntityService<TEntity>
    where TEntity : EntityBase
```

**Namespace**
* [Umbraco.Commerce.Cms.Cache.Refreshers](README.md)

### Methods

#### Refresh (1 of 2)

```csharp
public override void Refresh(string json)
```

---

#### Refresh (2 of 2)

```csharp
public override void Refresh(UmbracoCommerceEntityCacheRefresherPayload[] payload)
```


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Cms.dll -->
