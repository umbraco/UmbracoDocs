---
description: Learn about notification handlers lifetime, async notification handler and how to register the notification handlers.
---

# Notification handlers lifetime

It's important to note that the handlers you create and register to receive notifications will be transient, this means that they will be initialized every time they receive a notification, so you cannot rely on them having a specific state based on previous notifications. For instance, you cannot create a list in a handler and add something when a notification is received, and then check if that list contains what you added in an earlier notification, that list will always be empty because the object has just been initialized.

If you need persistence between notifications, we recommend that you move that functionality into a service or similar, and register it with the DI container, and then inject that into your handler.

As previously mentioned a lot of notifications exist in pairs, with a "before" and "after" notification, there may be cases where you want to add some information to the "before" notification, which will then be available to your "after" notification handler, in order to support this, the notification "pairs" are stateful. This means that the notifications contain a dictionary that is shared between the "before" and "after" notification that you can add values to, and later get them from like this:

```C#
public void Handle(TemplateSavingNotification notification)  
{  
 notification.State["SomeKey"] = "Some Value Relevant to the \"after\" notification handler";  
}  
  
  
public void Handle(TemplateSavedNotification notification)  
{  
  var valueFromSaving = notification.State["SomeKey"];  
}
```

# Registering notification handlers

Once you've made your notification handlers you need to register them with the `AddNotificationHandler` extension method on the `IUmbracoBuilder`, so they're run whenever a notification they subscribe to is published. There are two ways to do this: In the Startup class, if you're making handlers for your site, or a composer if you're a package developer subscribing to notifications.

#### Registering notification handlers in the startup class

In the Startup class register your notification handler in the `ConfigureServices` after `AddComposers()` but before `Build()`:

```C#
public void ConfigureServices(IServiceCollection services)
{
#pragma warning disable IDE0022 // Use expression body for methods
    services.AddUmbraco(_env, _config)
        .AddBackOffice()             
        .AddWebsite()
        .AddComposers()
        .AddNotificationHandler<ContentPublishingNotification, DontShout>()
        .Build();
#pragma warning restore IDE0022 // Use expression body for methods

}
```

The extension method takes two generic type parameters, the first `ContentPublishingNotification` is the notification you wish to subscribe to, the second `DontShout` is the class that handles the notification. This class must implement `INotificationHandler<>` with the type of notification it handles as the generic type parameter, in this case, the DontShout class definition looks like this:

```C#
public class DontShout : INotificationHandler<ContentPublishingNotification>
```

For the full handler implementation see [ContentService Notifications](contentservice-notifications.md).

## Registering notification handlers in a composer

If you're writing a package for Umbraco you won't have access to the Startup class, you can instead use a composer which gives you access to the  `IUmbracoBuilder`, the rest is the same as when doing it in the Startup class:

```C#
public class DontShoutComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AddNotificationHandler<ContentPublishingNotification, DontShout>();
    }
}
```

## Registering many notification handlers

You may want to subscribe to a lot of notifications, in this case, your `ConfigureServices` method or composer might end up being quite cluttered. You can avoid this by creating your own `IUmbracoBuilder` extension method for your events, keeping everything neatly wrapped up in one place, such an extension method can look like this:

```C#
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Services.Notifications;

namespace MySite
{
    public static class UmbracoBuilderNotificationExtensions
    {
        public static IUmbracoBuilder AddDontShoutNotifications(this IUmbracoBuilder builder)
        {
            builder
                .AddNotificationHandler<ContentPublishingNotification, DontShout>()
                .AddNotificationHandler<TemplateSavingNotification, DontShout>()
                .AddNotificationHandler<MediaSavingNotification, DontShout>();
            
            return builder;
        }
    }
}
```

You can then register all these notifications by calling `AddDontShoutNotifications` in `ConfigureServices` or your composer, just like you would `AddNotificationHandler`:

```C#
public void ConfigureServices(IServiceCollection services)
{
#pragma warning disable IDE0022 // Use expression body for methods
    services.AddUmbraco(_env, _config)
        .AddBackOffice()             
        .AddWebsite()
        .AddComposers()
        .AddDontShoutNotifications()
        .Build();
#pragma warning restore IDE0022 // Use expression body for methods

}
```
