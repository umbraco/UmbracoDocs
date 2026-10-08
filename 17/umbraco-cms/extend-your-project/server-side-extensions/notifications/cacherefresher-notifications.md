---
description: Example of how to use a CacheRefresher Notification
---

# CacheRefresher Notifications

Before starting with cache refresher notifications it's a good idea to ensure you need to use them. If you want to react to changes in content, for instance, there's no real reason to use these notifications. This is due to the [content service notifications](contentservice-notifications.md) being easier to work with. If you need to react to changes in the cache, then these are the notifications for you.

Cache refresher notifications are sent when the cache has refreshed. There are multiple different types of cache refresher notifications. These types are based on what type has been updated in the cache, for instance, content or media. All these notifications inherit from the same base notification: `CacheRefresherNotification`.

The base notification is implemented in the following way:

```csharp
public abstract class CacheRefresherNotification : INotification
{
    public CacheRefresherNotification(object messageObject, MessageType messageType)
    {
        MessageObject = messageObject ?? throw new ArgumentNullException(nameof(messageObject));
        MessageType = messageType;
    }

    public object MessageObject { get; }

    public MessageType MessageType { get; }
}
```

As you can see this notification contains two properties, a `MessageObject` and a `MessageType`. The `MessageType` specifies what kind of cache operation was performed, for example `RemoveById`. The possible message types is as follows:

```csharp
public enum MessageType
{
    RefreshAll,
    RefreshById,
    RefreshByJson,
    RemoveById,
    RefreshByInstance,
    RemoveByInstance,
    RefreshByPayload,
}
```

The other parameter `MessageObject` will depend on what type of cache refresher notification you're handling. If you for instance handle the `ContentCacheNotification`, the message object will be `ContentCacheRefresher.JsonPayload[]`.

This object contains the Id and key of the item being updated, as well as an enum specifying how the tree is updated:

```csharp
[Flags]
public enum TreeChangeTypes : byte
{
    None = 0,

    // all items have been refreshed
    RefreshAll = 1,

    // an item node has been refreshed
    // with only local impact
    RefreshNode = 2,

    // an item node has been refreshed
    // with branch impact
    RefreshBranch = 4,

    // an item node has been removed
    // never to return
    Remove = 8,
}

```

An example of working with the `ContentCacheNotification` can be seen here:

```csharp
using Umbraco.Cms.Core.Cache;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Services.Changes;

namespace Umbraco.Cms.Web.UI;

public class ContentCacheRefresherExample : INotificationHandler<ContentCacheRefresherNotification>
{
    private readonly IContentService _contentService;

    public ContentCacheRefresherExample(IContentService contentService)
    {
        _contentService = contentService;
    }

    public void Handle(ContentCacheRefresherNotification notification)
    {
        if (notification.MessageObject is not ContentCacheRefresher.JsonPayload[] payloads)
        {
            return;
        }

        foreach (ContentCacheRefresher.JsonPayload payload in payloads)
        {
            if (payload.ChangeTypes is not TreeChangeTypes.RefreshNode or TreeChangeTypes.RefreshBranch)
            {
                return;
            }

            // You can do stuff with the ID of the refreshed content, for instance getting it from the content service.
            var refreshedContent = _contentService.GetById(payload.Id);
        }
    }
}

```
