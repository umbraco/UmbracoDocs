---
title: SynchronizeUmbracoStockOnSaving
description: API reference for SynchronizeUmbracoStockOnSaving in Umbraco Commerce
---
## SynchronizeUmbracoStockOnSaving

```csharp
public class SynchronizeUmbracoStockOnSaving : INotificationHandler<ContentSavingNotification>
```

**Namespace**
* [Umbraco.Commerce.Cms.Events.Notification.Handlers](README.md)

### Constructors

#### SynchronizeUmbracoStockOnSaving

```csharp
public SynchronizeUmbracoStockOnSaving(UmbracoStockSynchronizer sync)
```


### Methods

#### Handle

```csharp
public void Handle(ContentSavingNotification notification)
```


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Cms.Startup.dll -->
