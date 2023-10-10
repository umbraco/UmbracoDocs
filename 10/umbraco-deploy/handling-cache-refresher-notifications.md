---
meta.Title: "Handling Cache Refresher Notifications"
description: "How to respond to deployment events using cache refresher notifications"
---

# Handling Cache Refresher Notifications

## Background

When you deploy content or other Umbraco data between environments, several notifications that are normally fired in CMS operations are suppressed.

For example, you may handle a `ContentPublishedNotification` to apply some custom logic when a content item is published. This code will run in a normal CMS publish operation. However, when deploying a content item into another environment and triggering it's publishing there, the notification will not be issued. And the custom logic in the notification handler will not run.

This behavior is deliberate and done for performance and reliability reasons. A normal save and publish operation by an editor operates on one item at a time. With deployments, we may have many, and publishing these notifications may lead to at best slow operations, and at worst inconsistent data.

However, what if you do want to run some code on the save of some Umbraco data, even if this is happening as part of a Deploy operation?

There's an option here using cache refresher notifications. Not all events are suppressed by Umbraco Deploy. Some that are batched up and fired after the deploy operation is completed include those related to refreshing the Umbraco cache.

## Implementing a Cache Refresher Notification

The following two code samples illustrate how this can be done.

The first handles a content cache refresher, which takes a payload from where the content ID can be extracted. Using that the content can be retrieved in the local Umbraco instance and used as appropriate.

```csharp
using Umbraco.Cms.Core.Cache;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Sync;

namespace TestSite.Business.NotificationHandlers;

public class ContentCacheRefresherNotificationHandler : INotificationHandler<ContentCacheRefresherNotification>
{
    private readonly ILogger<ContentCacheRefresherNotificationHandler> _logger;
    private readonly IContentService _contentService;

    public ContentCacheRefresherNotificationHandler(
        ILogger<ContentCacheRefresherNotificationHandler> logger,
        IContentService contentService)
    {
        _logger = logger;
        _contentService = contentService;
    }

    public void Handle(ContentCacheRefresherNotification notification)
    {
        // We only want to handle the RefreshByPayload message type.
        if (notification.MessageType != MessageType.RefreshByPayload)
        {
            return;
        }

        // Cast the payload to the expected type.
        var payload = (ContentCacheRefresher.JsonPayload[])notification.MessageObject;

        // Handle each content item in the payload.
        foreach (ContentCacheRefresher.JsonPayload item in payload)
        {
            // Retrieve the content item.
            var contentItemId = item.Id;
            IContent? contentItem = _contentService.GetById(contentItemId);
            if (contentItem is null)
            {
                _logger.LogWarning(
                    "ContentCacheRefresherNotification handled for type {MessageType} but content item with Id {Id} could not be found.",
                    notification.MessageType,
                    contentItemId);
                return;
            }

            // Do something with the content item. Here we'll just log some details.
            _logger.LogInformation(
                "ContentCacheRefresherNotification handled for type {MessageType} and id {Id}. " +
                "Key: {Key}, Name: {Name}",
                notification.MessageType,
                contentItemId,
                contentItem.Key,
                contentItem.Name);
        }
    }
}
```

The second example is similar, but handles an update to a dictionary item. With this one we get a parameter that consists of just the item's ID. Again we can retrieve it and carry out some further processing.

```csharp
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Sync;

namespace TestSite.Business.NotificationHandlers;

public class DictionaryCacheRefresherNotificationHandler : INotificationHandler<DictionaryCacheRefresherNotification>
{
    private readonly ILogger<DictionaryCacheRefresherNotificationHandler> _logger;
    private readonly ILocalizationService _localizationService;

    public DictionaryCacheRefresherNotificationHandler(
        ILogger<DictionaryCacheRefresherNotificationHandler> logger,
        ILocalizationService localizationService)
    {
        _logger = logger;
        _localizationService = localizationService;
    }

    public void Handle(DictionaryCacheRefresherNotification notification)
    {
        // We only want to handle the RefreshById message type.
        if (notification.MessageType != MessageType.RefreshById)
        {
            return;
        }

        // Retrieve the dictionary item.
        var dictionaryItemId = (int)notification.MessageObject;
        IDictionaryItem? dictionaryItem = _localizationService.GetDictionaryItemById(dictionaryItemId);
        if (dictionaryItem is null)
        {
            _logger.LogWarning(
                "DictionaryCacheRefresherNotification handled for type {MessageType} but dictionary item with Id {Id} could not be found.",
                notification.MessageType,
                dictionaryItemId);
            return;
        }

        // Do something with the dictionary item. Here we'll just log some details.
        _logger.LogInformation(
            "DictionaryCacheRefresherNotification handled for type {MessageType} and id {Id}. " +
            "Key: {Key}, Default Value: {DefaultValue}",
            notification.MessageType,
            dictionaryItemId,
            dictionaryItem.ItemKey,
            dictionaryItem.GetDefaultValue());
    }
}
```

In both cases, as is usual for notification handlers, you will need to register them via a composer:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Notifications;
using TestSite.Business.NotificationHandlers;

namespace TestSite.Business;

public class SiteComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AddNotificationHandler<ContentCacheRefresherNotification, ContentCacheRefresherNotificationHandler>();
        builder.AddNotificationHandler<DictionaryCacheRefresherNotification, DictionaryCacheRefresherNotificationHandler>();
    }
}
```

