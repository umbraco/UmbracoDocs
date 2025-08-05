---
description: >-
  Explore new webhook event options, detailed setup, specific content triggers,
  and improved logging and retry mechanisms
---

# Expanding Webhook Events

## Introduction

With Umbraco, you can create your own webhook events.

This documentation guides you through the process of implementing your webhook events using the `WebhookEventBase<TNotification>` base class.

## Creating an Event with the WebhookEventBase

The `WebhookEventBase<TNotification>` class serves as the foundation for creating custom webhook events. Here's a brief overview of its key components:

* **Alias**: The property that must be overridden to provide a unique identifier for your webhook event.
* **EventName**: A property that represents the name of the event. It is automatically set based on the provided alias unless explicitly specified.
* **EventType**: A property that categorizes the event type. It defaults to "Others" but can be customized using the `WebhookEventAttribute`.
* **WebhookSettings**: The property containing the current webhook settings.
* **ProcessWebhooks**: The method responsible for processing webhooks for a given notification.
* **ShouldFireWebhookForNotification**: The method determining whether webhooks should be fired for a specific notification.
* **ConvertNotificationToRequestPayload**: An optional method allowing customization of the notification payload before sending it to webhooks.

### Creating a Custom Webhook Event

To create a custom webhook event, follow these steps:

1.  **Derive from `WebhookEventBase<TNotification>`**:

    ```csharp
    public class YourCustomEvent : WebhookEventBase<YourNotificationType>
    {
        // Constructor and required overrides go here
    }
    ```
2.  **Override the Alias Property**:

    Provide a unique identifier for your event using the `Alias` property:

    ```csharp
    public override string Alias => "YourUniqueAlias";
    ```
3.  **Apply `WebhookEventAttribute` (Optional)**:

    You can use the `WebhookEventAttribute` to specify the event name and type. Apply this attribute to your custom event class:

    ```csharp
    [WebhookEvent("Your Event Name", "YourEventType")]
    public class YourCustomEvent : WebhookEventBase<YourNotificationType>
    {
        // Constructor and required overrides go here
    }
    ```

    Umbraco already has some types as constants, which you can find at `Constants.WebhookEvents.Types`.\
    If you do not specify this attribute, the event name will default to your alias, and the type will default to `Other`.
4.  **Implement Notification Handling**:

    If needed, customize the handling of the notification in the `HandleAsync` method.
5.  **Register Your Webhook Event**:

    Ensure that Umbraco is aware of your custom event by registering it in a composer:

    ```csharp
    using Umbraco.Cms.Core.Composing;

    public class CustomWebhookComposer : IComposer
     {
         public void Compose(IUmbracoBuilder builder)
         {
             builder.WebhookEvents().Add<YourCustomEvent>();
         }
     }
    ```
6. **Implement Optional Overrides**:\
   Depending on your requirements, you can override methods such as `ConvertNotificationToRequestPayload` and `ShouldFireWebhookForNotification` to customize the behavior of your webhook event.

### Sample Implementation

Here's a basic example of a custom webhook event:

```csharp
[WebhookEvent("Your Custom Event", "CustomEventType")]
public class YourCustomEvent : WebhookEventBase<YourNotificationType>
{
    public YourCustomEvent(IWebhookFiringService webhookFiringService, IWebhookService webhookService, IOptionsMonitor<WebhookSettings> webhookSettings, IServerRoleAccessor serverRoleAccessor)
        : base(webhookFiringService, webhookService, webhookSettings, serverRoleAccessor)
    {
    }

    public override string Alias => "YourCustomAlias";

    // Additional optional overrides
    public override object? ConvertNotificationToRequestPayload(YourNotificationType notification)
    {
        // Custom conversion logic
    }

    public override async Task ProcessWebhooks(YourNotificationType notification, IEnumerable<IWebhook> webhooks, CancellationToken cancellationToken)
    {
        // Custom processing of webhook logic
    }

    public override bool ShouldFireWebhookForNotification(YourNotificationType notificationObject)
    {
        // Custom logic for figuring out if the webhook should fire for a given notification.
    }
}
```

## Creating an Event with the WebhookEventContentBase\<TNotification, TEntity>

For scenarios where your webhook event is content-specific, Umbraco provides another base class: `WebhookEventContentBase<TNotification, TEntity>`. This class is an extension of the generic `WebhookEventBase<TNotification>` and introduces content-related functionalities.

The `WebhookEventContentBase<TNotification, TEntity>` class is designed for content-specific webhook events, where `TEntity` is expected to be a type that implements the `IContentBase` interface.

### Usage

To leverage the `WebhookEventContentBase<TNotification, TEntity>` class, follow these steps:

1.  **Derive from `WebhookEventContentBase<TNotification, TEntity>`**:

    ```csharp
    public class YourContentWebhookEvent : WebhookEventContentBase<YourNotificationType, YourContentBaseType>
    {
    }
    ```
2.  **Override the Required Methods**:

    * **GetEntitiesFromNotification**: Implement this method to extract content entities from the notification.
    * **ConvertEntityToRequestPayload**: Implement this method to customize the content entity payload before sending it to webhooks.

    If we take a look at the `ContentPublishedWebhookEvent`, we can see how these methods are overriden.

{% include "../../.gitbook/includes/obsolete-warning-ipublishedsnapshotaccessor.md" %}

```csharp
protected override IEnumerable<IContent> GetEntitiesFromNotification(ContentPublishedNotification notification) => notification.PublishedEntities;

protected override object? ConvertEntityToRequestPayload(IContent entity)
{
    if (_publishedSnapshotAccessor.TryGetPublishedSnapshot(out IPublishedSnapshot? publishedSnapshot) is false || publishedSnapshot!.Content is null)
    {
        return null;
    }

    IPublishedContent? publishedContent = publishedSnapshot.Content.GetById(entity.Key);
    return publishedContent is null ? null : _apiContentBuilder.Build(publishedContent);
 }
```

3.  **ProcessWebhooks Implementation**:

    The `ProcessWebhooks` method in this class has been enhanced to iterate through content entities obtained from the notification. It checks the content type of each entity against the specified webhook's content type keys, firing webhooks only for matching entities.

    ```csharp
    public override async Task ProcessWebhooks(TNotification notification, IEnumerable<IWebhook> webhooks, CancellationToken cancellationToken)
    {
        foreach (IWebhook webhook in webhooks)
        {
            if (!webhook.Enabled)
            {
                continue;
            }

            foreach (TEntity entity in GetEntitiesFromNotification(notification))
            {
                if (webhook.ContentTypeKeys.Any() && !webhook.ContentTypeKeys.Contains(entity.ContentType.Key))
                {
                    continue;
                }

                await WebhookFiringService.FireAsync(webhook, Alias, ConvertEntityToRequestPayload(entity), cancellationToken);
            }
        }
    }
    ```
