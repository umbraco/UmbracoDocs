---
description: >-
  Add a notification channel that tells people when an automation's runs fail,
  pause, resume, complete, or change health.
---

# Create a Custom Notification Channel

A notification channel delivers a message when something happens to an automation's runs. Automate ships with an **Email** channel and a **Webhook** channel. Add your own channel to send notifications to another service, such as a chat room or an incident tool.

Each notification channel defines:

* A **settings model** — the fields an editor fills in when they add the channel to an automation.
* A **send method** — how the message reaches the service.

Editors add channels per automation, on the automation's **Notifications** tab. For each channel, they pick the events that send a message.

## Settings Model

The settings Plain Old CLR Object (POCO) defines the channel's configuration UI. It uses the same `[Field]` attribute as action and connection settings.

Mark secret values with `IsSensitive = true`. The value is encrypted in the stored automation and in its version history. The version comparison view masks it, and exports leave it out. Your channel receives the decrypted value.

{% code title="ChatNotificationChannelSettings.cs" %}
```csharp
using System.ComponentModel.DataAnnotations;
using Umbraco.Automate.Core.Settings;

namespace MyProject.Automate;

public sealed class ChatNotificationChannelSettings
{
    [Field(
        Label = "Webhook URL",
        Description = "The incoming webhook URL of the chat room. The URL contains a token, so keep it secret.",
        IsSensitive = true)]
    [Required]
    public string? WebhookUrl { get; set; }
}
```
{% endcode %}

Settings values starting with `$` are resolved from configuration before your channel receives them. See [Configuration References](../getting-started/configuration.md#configuration-references).

A channel with no settings uses `object` as its settings type. The editor then sees only the enabled toggle and the **Notify on** options.

## Notification Channel Class

Inherit from `NotificationChannelBase<TSettings>` and override `NotifyAsync`. The `[NotificationChannel]` attribute sets the alias, name, description, and icon shown in the channel picker. The alias must be unique.

{% code title="ChatNotificationChannel.cs" %}
```csharp
using System.Net.Http.Json;
using Microsoft.Extensions.Logging;
using Umbraco.Automate.Core.Notifications.Channels;
using Umbraco.Automate.Core.Runs;

namespace MyProject.Automate;

[NotificationChannel("myProject.chat", "Chat",
    Description = "Posts a message to a chat room.",
    Icon = "icon-message")]
public sealed class ChatNotificationChannel : NotificationChannelBase<ChatNotificationChannelSettings>
{
    private readonly IHttpClientFactory _httpClientFactory;
    private readonly ILogger<ChatNotificationChannel> _logger;

    public ChatNotificationChannel(
        NotificationChannelInfrastructure infrastructure,
        IHttpClientFactory httpClientFactory,
        ILogger<ChatNotificationChannel> logger)
        : base(infrastructure)
    {
        _httpClientFactory = httpClientFactory;
        _logger = logger;
    }

    protected override async Task NotifyAsync(
        NotificationMessage message,
        ChatNotificationChannelSettings settings,
        CancellationToken cancellationToken)
    {
        if (string.IsNullOrWhiteSpace(settings.WebhookUrl))
        {
            return;
        }

        // Run events carry structured data. Health and resume events only have a subject and body.
        var text = message.Data is RunNotification run
            ? $"{run.AutomationName}: run {run.RunId} is {run.Status}. {run.Error}"
            : message.Subject ?? "Umbraco Automate notification";

        // The Automate client applies the outbound request rules.
        using var client = _httpClientFactory.CreateClient(Umbraco.Automate.Core.Constants.HttpClients.Default);
        using var response = await client.PostAsJsonAsync(settings.WebhookUrl, new { text }, cancellationToken);

        if (!response.IsSuccessStatusCode)
        {
            _logger.LogWarning("Chat notification returned {StatusCode}", response.StatusCode);
        }
    }
}
```
{% endcode %}

The base class resolves the stored settings into your settings type. When an editor saved no settings, `NotifyAsync` receives a new, empty instance.

Automate creates one instance of each channel and shares it. Inject only services that are safe to use as singletons, such as `IHttpClientFactory` and `ILogger<T>`.

### Sending Outbound Requests

Create the HTTP client with the name `Umbraco.Automate.Core.Constants.HttpClients.Default`. Requests from that client follow the same rules as the built-in **Webhook** channel and the **HTTP Request** action. Automate refuses requests to private and internal addresses. See [Outbound Requests](../getting-started/configuration.md#outbound-requests).

A client created without that name doesn't apply these rules.

## The Notification Message

`NotifyAsync` receives a `NotificationMessage`. Automate fills in the fields, and your channel uses the ones it needs.

| Property   | Type      | Content                                                          |
| ---------- | --------- | ---------------------------------------------------------------- |
| `Subject`  | `string?` | A subject line, such as `[Umbraco Automate] Sync products — Failed`. |
| `HtmlBody` | `string?` | An HTML summary of the event.                                    |
| `TextBody` | `string?` | A plain-text body. The built-in events don't set it.             |
| `Data`     | `object?` | Structured data for run events. `null` for other events.         |

For run events, `Data` is a `RunNotification` with these properties:

| Property         | Type                  | Content                                   |
| ---------------- | --------------------- | ----------------------------------------- |
| `AutomationId`   | `Guid`                | The automation's ID.                      |
| `AutomationName` | `string`              | The automation's name.                    |
| `RunId`          | `Guid`                | The run's ID.                             |
| `Status`         | `AutomationRunStatus` | The run's status when the event fired.    |
| `Error`          | `string?`             | The run's error message, if it has one.   |
| `WorkspaceId`    | `Guid`                | The ID of the automation's workspace.     |
| `CompletedUtc`   | `DateTime?`           | When the run finished, in UTC.            |

## When Channels Are Called

Each channel on an automation has a set of **Notify on** options. A new channel starts enabled, with only **Failed** selected. Automate calls the channel when an event matches one of its selected options.

| Notify on      | Event                                                                        | `Data`            |
| -------------- | ---------------------------------------------------------------------------- | ----------------- |
| **Failed**     | A run finishes with an error.                                                | `RunNotification` |
| **Suspended**  | A run pauses, waiting for input or an approval.                              | `RunNotification` |
| **Resumed**    | A paused run continues.                                                      | `null`            |
| **Completed**  | A run finishes successfully.                                                 | `RunNotification` |
| **Rejected**   | A run ends because someone refused an approval.                              | `RunNotification` |
| **Recovered**  | A run finishes successfully, and the previous finished run failed.           | `RunNotification` |
| **Warning**    | The circuit breaker warns that the automation's error rate is climbing.       | `null`            |
| **Disabled**   | The circuit breaker turns the automation off after repeated failures.        | `null`            |
| **Re-enabled** | Someone turns an automation back on after the circuit breaker turned it off. | `null`            |

Keep the following in mind:

* A rejected run doesn't match **Failed** or **Completed**. Select **Rejected** to hear about it.
* A cancelled run doesn't send a notification.
* Each event sends at most one message per channel. A run that matches both **Completed** and **Recovered** sends one message.
* A disabled channel, or one with no options selected, receives nothing.

## Delivery and Errors

Automate calls channels in process, after it records the change that caused the event. It calls the automation's channels one at a time, in the order they are listed. It waits for each channel to finish before it continues.

There is no queue and no retry. If your channel throws an exception, Automate logs an error and moves on to the next channel. The run's status doesn't change.

Automate also logs an error and skips the channel when the stored settings fail validation, for example when a `[Required]` field is empty. When an automation uses a channel alias that no longer exists, Automate logs a warning and skips it.

Keep `NotifyAsync` short. Set a timeout on calls to slow services, because Automate waits for your channel before it finishes processing the event.

## Registration

No manual registration is required. The channel is discovered at startup by its `[NotificationChannel]` attribute and the base class.

## Verify

Restart your Umbraco site. Open an automation, go to the **Notifications** tab, and select **Add notification channel**. Your channel appears in the list as **Chat**.

Add the channel, fill in its settings, and select **Completed** under **Notify on**. Save the automation, then run it. Confirm the message arrives in the chat room. If it doesn't, check the Umbraco log for errors from the channel.

## See Also

* [Create a Custom Action](custom-action.md)
* [Create a Custom Connection Type](custom-connection-type.md)
* [Configuration](../getting-started/configuration.md)
