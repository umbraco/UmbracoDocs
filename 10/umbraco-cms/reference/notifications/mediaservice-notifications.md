---
description: Example of how to use a MediaService Notification
---

# MediaService Notifications

The MediaService class implements IMediaService. It provides access to operations involving IMedia.

## Usage

Example usage of the MediaService notifications:

```C#
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

You can return a custom message to the user. Use this to show information, a warning or maybe an error.
This is achieved using the ```Messages``` property of the notification and a composer.

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

### What happened to Creating and Created events?

Both the MediaService.Creating and MediaService.Created events have been obsoleted. Because of this, these were not moved over to notifications, and no longer exist. Why? Because these events were not guaranteed to trigger and therefore should not have been used. This is because these events *only* triggered when the MediaService.CreateMedia method was used which is an entirely optional way to create media entities. It is also possible to construct a new media item - which is generally the preferred and consistent way - and therefore the Creating/Created events would not execute when constructing media that way.

Furthermore, there was no reason to listen for the Creating/Created events because they were misleading. They didn't trigger before and after the entity had been persisted. Instead they triggered inside the CreateMedia method which never persists the entity. It constructs a new media object.

#### What do we use instead?

The MediaSavingNotification and MediaSavedNotification will always be published before and after an entity has been persisted. You can determine if an entity is brand new with either of those notifications. With the Saving notification - before the entity is persisted - you can check the entity's HasIdentity property which will be 'false' if it is brand new. In the Saved event you can [check to see if the entity 'remembers being dirty'](determining-new-entity.md)
