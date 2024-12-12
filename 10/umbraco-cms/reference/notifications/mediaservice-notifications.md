---
description: Example of how to use a MediaService Notification
---

# MediaService Notifications Example

The MediaService class implements IMediaService. It provides access to operations involving IMedia.

## Usage

Example usage of the MediaService notifications:

```csharp
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;

namespace MySite
{
    public class MediaNotificationHandler : INotificationHandler<MediaSavedNotification>
    {
        private readonly ILogger<MediaNotificationHandler> _logger;

        public MediaNotificationHandler(ILogger<MediaNotificationHandler> logger)
        {
            _logger = logger;
        }
        
        public void Handle(MediaSavedNotification notification)
        {
            foreach (var mediaItem in notification.SavedEntities)
            {
                if (mediaItem.ContentType.Alias.Equals("Image"))
                {
                    // Do something with the image, maybe send to Azure for AI analysis of image contents or something.
                    _logger.LogDebug($"Sending {mediaItem.Name} to analysis");
                    SendToAzure(mediaItem);
                }
            }
        }
    }
}
```

## Returning messages to the user

You can return a custom message to the user. Use this to show information, a warning or maybe an error. This is achieved using the `Messages` property of the notification and a composer.

### Example

This example returns an informational message to the user when a Media item is saved.

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;

namespace MyProject
{
 public class CustomComposer : IComposer
 {
  public void Compose(IUmbracoBuilder builder)
  {
   builder.AddNotificationHandler<MediaSavedNotification, MediaNotificationTest>();
  }
 }

 public class MediaNotificationTest : INotificationHandler<MediaSavedNotification>
 {  
  public void Handle(MediaSavedNotification notification)
  {
   notification.Messages.Add(new EventMessage(
    "Notification",
    "You can return a message to the user, using the messages property on the notification.",
    EventMessageType.Info));
  }
 }
}
```

![image](https://github.com/umbraco/UmbracoDocs/assets/6904597/67696298-2710-4aeb-bd0a-33c6d8414216)

<details>

<summary>What happened to Creating and Created events?</summary>

Both the MediaService.Creating and MediaService.Created events have been obsoleted. Because of this, these were not moved over to notifications, and no longer exist. Why? Because these events were not guaranteed to trigger and therefore should not have been used. This is because these events _only_ triggered when the MediaService.CreateMedia method was used which is an entirely optional way to create media entities. It is also possible to construct a new media item - which is generally the preferred and consistent way - and therefore the Creating/Created events would not execute when constructing media that way.

Furthermore, there was no reason to listen for the Creating/Created events because they were misleading. They didn't trigger before and after the entity had been persisted. Instead they triggered inside the CreateMedia method which never persists the entity. It constructs a new media object.

**What do we use instead?**

The MediaSavingNotification and MediaSavedNotification will always be published before and after an entity has been persisted. You can determine if an entity is brand new with either of those notifications. With the Saving notification - before the entity is persisted - you can check the entity's HasIdentity property which will be 'false' if it is brand new. In the Saved event you can [check to see if the entity 'remembers being dirty'](determining-new-entity.md)

</details>

<details>

<summary>What happened to <code>raiseEvent</code>method parameters?</summary>

RaiseEvent method service parameters have been removed from v9 and to name some reasons why:

* Because it's entirely inconsistent, not all services have this as method parameters and maintaining that consistency is impossible especially if 3rd party libraries support events/notifications.
* It's hacky. There's no good way to suppress events/notifications this way at a higher (scoped) level.
* There's also hard-coded logic to ignore these parameters sometimes which makes it even more inconsistent.
* There are events below services at the repository level that cannot be controlled by this flag.

**What do we use instead?**

We can suppress notifications at the scope level which makes things consistent and will work for all services that use a Scope. Also, there's no required maintenance to make sure that new service methods will also work.

**How to use scopes**:

* Create an explicit scope and call scope.Notifications.Suppress().
* The result of Suppress() is IDisposable, so until it is disposed, notifications will not be added to the queue.

[Example](https://github.com/umbraco/Umbraco-CMS/blob/b69afe81f3f6fcd37480b3b0295a62af44ede245/tests/Umbraco.Tests.Integration/Umbraco.Infrastructure/Scoping/SupressNotificationsTests.cs#L35):

```csharp
using (IScope scope = ScopeProvider.CreateScope(autoComplete: true))
using (IDisposable _ = scope.Notifications.Suppress())
{
    // TODO: Calls to service methods here will not have notifications
}
```

Child scope will inherit the parent Scope's notification object which means if a parent scope has notifications suppressed, then so does the child scope. You cannot call Suppress() more than once for the same outer scope instance else an exception will be thrown. This ensures that you cannot un-suppress notifications at a child level for an outer scope. It also ensures that suppressing events is an explicit thing to do.

**Why would one want to suppress events?**

The main reason for ever doing this would be performance for bulk operations. The callers hould be aware that suppressing events will lead to an inconsistent content cache state (if notifications are suppressed for content or media services). This is because notifications are used by NuCache to populate the cmsContentNu table and populate the content caches. They are also used to populate the Examine indexes.

So if you did suppress events, it will require you to rebuild the NuCache and examine data manually.

</details>
