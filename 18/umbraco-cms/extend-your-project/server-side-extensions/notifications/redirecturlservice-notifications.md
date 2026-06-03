---
description: Example of how to use a RedirectUrlService Notification
---

# RedirectUrlService Notifications Example

The RedirectUrlService manages the redirect URLs that Umbraco tracks automatically. A redirect is created when published content changes its URL. For more information, see the [URL Redirect Management](../../../develop-with-umbraco/application-code/backend-and-custom-logic/routing/url-tracking.md) article.

The service publishes four notifications. The "before" notifications are cancelable, which lets a handler stop a redirect from being created or deleted.

| Notification | Published | Cancelable |
| --- | --- | --- |
| `RedirectUrlSavingNotification` | Before a redirect is created or updated | Yes |
| `RedirectUrlSavedNotification` | After a redirect is created or updated | No |
| `RedirectUrlDeletingNotification` | Before a redirect is deleted | Yes |
| `RedirectUrlDeletedNotification` | After a redirect is deleted | No |

The entities in each notification are `IRedirectUrl` objects. Each one exposes the `Url`, `Culture`, `ContentId`, and `ContentKey` of the affected redirect.

## Usage

The following example handles the `RedirectUrlSavingNotification` to stop redirects from being created for a specific part of the site. The redirects being created are available through the `SavedEntities` property.

{% code title="PreventRedirectCreationHandler.cs" %}
```csharp
using System;
using Umbraco.Cms.Core.Notifications;

namespace MySite;

public class PreventRedirectCreationHandler : INotificationHandler<RedirectUrlSavingNotification>
{
    public void Handle(RedirectUrlSavingNotification notification)
    {
        foreach (var redirect in notification.SavedEntities)
        {
            if (redirect.Url.StartsWith("/example/", StringComparison.OrdinalIgnoreCase))
            {
                notification.Cancel = true;
            }
        }
    }
}
```
{% endcode %}

{% hint style="info" %}
Canceling a `RedirectUrlSavingNotification` shows no message in the backoffice. Redirects are created silently in the background when content is published. There is no editor action for a message to respond to, so any message added in the handler is discarded.

Canceling a `RedirectUrlDeletingNotification` does show the message. An editor triggers the deletion explicitly from the Redirect URL Management dashboard.
{% endhint %}

## Canceling a redirect deletion

Because deletions are triggered by an editor, a canceled `RedirectUrlDeletingNotification` can return a message explaining why. Use `CancelOperation` to cancel the operation and pass the message at the same time.

{% code title="PreventRedirectDeletionHandler.cs" %}
```csharp
using System;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;

namespace MySite;

public class PreventRedirectDeletionHandler : INotificationHandler<RedirectUrlDeletingNotification>
{
    public void Handle(RedirectUrlDeletingNotification notification)
    {
        foreach (var redirect in notification.DeletedEntities)
        {
            if (redirect.Url.StartsWith("/example/", StringComparison.OrdinalIgnoreCase))
            {
                notification.CancelOperation(new EventMessage(
                    "Redirect not deleted",
                    $"The redirect for {redirect.Url} is protected and cannot be removed.",
                    EventMessageType.Error));
            }
        }
    }
}
```
{% endcode %}

{% hint style="info" %}
`CancelOperation` cancels the whole notification. When more than one redirect is deleted at once, canceling stops the deletion for all of them, not only the one that matched.
{% endhint %}

## Logging deleted redirects

The "after" notifications cannot be canceled. Use them to react once an operation has completed, for example to write an audit log entry. The following example handles the `RedirectUrlDeletedNotification` and logs each deleted redirect through the `DeletedEntities` property.

{% code title="LogDeletedRedirectsHandler.cs" %}
```csharp
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Notifications;

namespace MySite;

public class LogDeletedRedirectsHandler : INotificationHandler<RedirectUrlDeletedNotification>
{
    private readonly ILogger<LogDeletedRedirectsHandler> _logger;

    public LogDeletedRedirectsHandler(ILogger<LogDeletedRedirectsHandler> logger)
        => _logger = logger;

    public void Handle(RedirectUrlDeletedNotification notification)
    {
        foreach (var redirect in notification.DeletedEntities)
        {
            // Keep an audit trail of which redirects were removed.
            _logger.LogInformation(
                "Redirect for {Url} (culture: {Culture}) was deleted.",
                redirect.Url,
                redirect.Culture);
        }
    }
}
```
{% endcode %}

## Registering the handlers

Register the notification handlers in a composer using `AddNotificationHandler`.

{% code title="RedirectUrlNotificationsComposer.cs" %}
```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Notifications;

namespace MySite;

public class RedirectUrlNotificationsComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AddNotificationHandler<RedirectUrlSavingNotification, PreventRedirectCreationHandler>();
        builder.AddNotificationHandler<RedirectUrlDeletingNotification, PreventRedirectDeletionHandler>();
        builder.AddNotificationHandler<RedirectUrlDeletedNotification, LogDeletedRedirectsHandler>();
    }
}
```
{% endcode %}

{% hint style="info" %}
If you call `IRedirectUrlService` directly, use the `RegisterWithStatus`, `DeleteWithStatus`, and `DeleteContentRedirectUrlsWithStatus` methods. These return a `RedirectUrlOperationStatus`, which reports `CancelledByNotification` when a handler cancels the operation. The previous `Register` and `Delete` methods are obsolete and are scheduled for removal in Umbraco 20.
{% endhint %}
