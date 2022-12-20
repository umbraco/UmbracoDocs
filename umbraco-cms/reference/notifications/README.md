---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# Using notifications

Umbraco uses Notifications, very similar to the Observer pattern, to allow you to hook into the workflow process for the backoffice. For example, you might want to execute some code every time a page is published. Notifications allow you to do that.

## Notifications

All notifications reside in the `Umbraco.Cms.Core.Notifications` namespace and are postfixed with Notification.

Typically, available notifications exist in pairs, with a "before" and "after" notification. For example, the ContentService class has the concept of publishing and published notifications when this occurs. In that case, there is both a ContentPublishingNotification and a ContentPublishedNotification notification.

Which one you want to use depends on what you want to achieve. If you want to be able to cancel the action, you would use the "before" notification, and use the `CancelOperation` method on the notification to cancel it. See the sample in [ContentService Notifications](contentservice-notifications.md). If you want to execute some code after the publishing has succeeded, then you would use the "after" notification.

### Notification handlers lifetime

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

### Registering notification handlers

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

#### Registering notification handlers in a composer

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

#### Registering many notification handlers

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

Now all the notifications you registered in your extension method will be handled by your handler.

## Content, Media, and Member notifications

* See [ContentService Notifications](contentservice-notifications.md) for a listing of the ContentService object notifications.
* See [MediaService Notifications](mediaservice-notifications.md) for a listing of the MediaService object notifications.
* See [MemberService Notifications](membertypeservice-notifications.md) for a listing of the MemberService object notifications.

## Other notifications

* See [ContentTypeService Notifications](contentservice-notifications.md) for a listing of the ContentTypeService object notifications.
* See [MediaTypeService Notifications](mediaservice-notifications.md) for a listing of the MediaTypeService object notifications.
* See [MemberTypeService Notifications](membertypeservice-notifications.md) for a listing of the MemberTypeService object notifications.
* See [DataTypeService Notifications](datatypeservice-notifications.md) for a listing of the DataTypeService object notifications
* See [FileService Notifications](fileservice-notifications.md) for a listing of the FileService object notifications.
* See [LocalizationService Notifications](localizationservice-notifications.md) for a listing of the LocalizationService object notifications.

## Tree notifications

See [Tree Notifications](../../extending/section-trees/) for a listing of the tree notifications.

## Editor Model Notifications

See [EditorModel Notifications](editormodel-notifications/) for a listing of the EditorModel events

{% hint style="info" %}
Useful for manipulating the model before it is sent to an editor in the backoffice - e.g. perhaps to set a default value of a property on a new document.
{% endhint %}

## Creating and publishing your own custom notifications

Umbraco uses notifications to allow people to hook into various workflow processes. This notification pattern is extensible, allowing you to create and publish your own custom notifications, thus allowing other people to observe and hook into your custom processes. This approach can be very useful when creating Umbraco packages. For more information on how you create and publish your own notifications see the [creating and publishing notifications](creating-and-publishing-notifications.md) article.
