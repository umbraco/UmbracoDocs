---
description: Learn about notification handlers lifetime, async notification handler and how to register the notification handlers.
---

# Notification handlers lifetime

It's important to know that the handlers you create and register to receive notifications will be **transient**. This means that they will be initialized every time they receive a notification. You can therefore not rely on them having a specific state based on previous notifications.

As an example, you cannot do the following:

1. Create a list in a handler.
2. Add something when a notification is received.
3. Check if that list contains what you added in an earlier notification.

When following the steps above, the list will always be empty because the object has only been initialized.

If you need persistence between notifications, we recommend you move that functionality into a service or similar. You can then register it with the DI container, and inject it into your handler.

As previously mentioned, many notifications exist in pairs, with a "before" and "after" notification. There may be cases where you want to add some information to the "before" notification, which will then be available to your "after" notification handler. In order to support this, the notification "pairs" are **stateful**. This means the notifications contain a dictionary that is shared between the "before" and "after" notifications. You can add values to the dictionary, and later retrieve them like this:

```csharp
public void Handle(TemplateSavingNotification notification)
{
 notification.State["SomeKey"] = "Some Value Relevant to the \"after\" notification handler";
}


public void Handle(TemplateSavedNotification notification)
{
  var valueFromSaving = notification.State["SomeKey"];
}
```

## Registering notification handlers

Once you have made your notification handlers, you need to register them with the `AddNotificationHandler` extension method on the `IUmbracoBuilder`. This enables them to run whenever a notification they subscribe to is published. There are two ways to do this:

1. In the **Program** class, if you're making handlers for your site
2. In a **composer**, if you're a package developer subscribing to notifications

{% hint style="info" %}
Learn more about the different ways of registering your handlers and other extensions in the [Dependency Injection](../using-ioc.md) article.
{% endhint %}

### Registering notification handlers in the program class

In the `Program.cs` file, register your notification in the `CreateUmbracoBuilder()` builder chain:

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    // Add your extension methods here, before Build().
    .AddNotificationHandler<ContentPublishingNotification, DontShout>()
    .Build();
```

The extension method takes two generic type parameters. The first, `ContentPublishingNotification`, is the notification you wish to subscribe to. The second, `DontShout`, is the class that handles the notification. This class must implement `INotificationHandler<>` with the type of notification it handles as the generic type parameter. In this case, the `DontShout` class definition looks like this:

```csharp
public class DontShout : INotificationHandler<ContentPublishingNotification>
```

For the full handler implementation, see [ContentService Notifications](contentservice-notifications.md).

### Registering notification handlers in a composer

If you are writing a package for Umbraco you will not have access to the Program class. You can instead use a composer, which gives you access to the `IUmbracoBuilder`.

```csharp
public class DontShoutComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AddNotificationHandler<ContentPublishingNotification, DontShout>();
    }
}
```

## Async Notification Handler

If you need to do anything asynchronously when handling a notification, you can achieve this using the `INotificationAsyncHandler`.

### Notification handler

Create an asynchronous handler by implementing the `INotificationAsyncHandler`:

```csharp
public class ContentDeletedHandler : INotificationAsyncHandler<ContentDeletedNotification>
{
    public async Task HandleAsync(ContentDeletedNotification notification, CancellationToken cancellationToken)
    {
        // await anything
        await Task.Delay(1000);
    }
}
```

### Notification registration

When using the `INotificationAsyncHandler`, register it using the `IUmbracoBuilder` and the `AddNotificationAsyncHandler` extension method. This can be done in the Program class or with a composer.

{% code title="Program.cs" %}

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .AddNotificationAsyncHandler<ContentDeletedNotification, ContentDeletedHandler>()
    .Build();
```

{% endcode %}

{% code title="NotificationHandlersComposer.cs" %}

```csharp
public class NotificationHandlersComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AddNotificationAsyncHandler<ContentDeletedNotification, ContentDeletedHandler>();
    }
}
```

{% endcode %}
