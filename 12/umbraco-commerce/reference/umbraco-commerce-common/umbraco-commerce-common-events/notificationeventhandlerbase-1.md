---
title: NotificationEventHandlerBase<TNotificationEvent>
description: API reference for NotificationEventHandlerBase<TNotificationEvent> in Umbraco Commerce
---
## NotificationEventHandlerBase&lt;TNotificationEvent&gt;

```csharp
public abstract class NotificationEventHandlerBase<TNotificationEvent> : 
    IEventHandlerFor<TNotificationEvent>
    where TNotificationEvent : INotificationEvent
```

**Inheritance**

* interface [IEventHandlerFor&lt;T&gt;](ieventhandlerfor-1.md)

**Namespace**
* [Umbraco.Commerce.Common.Events](README.md)

### Methods

#### Handle

```csharp
public abstract void Handle(TNotificationEvent evt)
```


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Common.dll -->
