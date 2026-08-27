---
description: >-
  Build triggers that fire on a schedule, respond to webhooks, or react to
  any .NET event using ScheduledTriggerBase, WebhookTriggerBase, and
  IEventTrigger.
---

# Schedule and Webhook Triggers

[Create a Custom Trigger](custom-trigger.md) covers the most common case: a trigger that reacts to an Umbraco notification. Automate also ships base classes for two other common cases, and an interface for events that come from neither Umbraco nor a schedule.

## Trigger on a Schedule

Inherit from `ScheduledTriggerBase<TSettings, TOutput>` to build a trigger that fires on a cron expression instead of an event. Override `GetCronExpression` to read the expression from the trigger's own settings.

{% code title="DailyDigestTriggerSettings.cs" %}
```csharp
using Umbraco.Automate.Core.Settings;

namespace MyProject.Automate;

public sealed class DailyDigestTriggerSettings
{
    [Field(Label = "Cron Expression", Description = "When the digest should run.")]
    public string CronExpression { get; set; } = "0 6 * * *";

    [Field(Label = "Time Zone", Description = "An IANA or Windows time zone ID.")]
    public string TimeZoneId { get; set; } = "UTC";
}
```
{% endcode %}

{% code title="DailyDigestTriggerOutput.cs" %}
```csharp
namespace MyProject.Automate;

public sealed class DailyDigestTriggerOutput
{
    public DateTimeOffset FiredAtUtc { get; init; }
}
```
{% endcode %}

{% code title="DailyDigestTrigger.cs" %}
```csharp
using Umbraco.Automate.Core.Triggers;

namespace MyProject.Automate;

[Trigger("myProject.dailyDigest", "Daily Digest",
    Description = "Fires on a cron schedule.",
    Group = "My Project",
    Icon = "icon-time")]
public sealed class DailyDigestTrigger
    : ScheduledTriggerBase<DailyDigestTriggerSettings, DailyDigestTriggerOutput>
{
    public DailyDigestTrigger(TriggerInfrastructure infrastructure)
        : base(infrastructure)
    {
    }

    public override string GetCronExpression(object? settings)
        => (settings as DailyDigestTriggerSettings)?.CronExpression ?? "0 6 * * *";
}
```
{% endcode %}

`GetTimeZone` defaults to UTC. Override it to evaluate the cron expression against the settings' configured time zone instead:

```csharp
public override TimeZoneInfo GetTimeZone(object? settings)
    => TimeZoneInfo.FindSystemTimeZoneById(
        (settings as DailyDigestTriggerSettings)?.TimeZoneId ?? "UTC");
```

## Trigger from a Webhook

Inherit from `WebhookTriggerBase<TSettings, TOutput>` to build a trigger that starts an automation from an inbound HTTP request, instead of a CMS event.

{% code title="OrderPaidTriggerSettings.cs" %}
```csharp
namespace MyProject.Automate;

public sealed class OrderPaidTriggerSettings
{
}
```
{% endcode %}

{% code title="OrderPaidTriggerOutput.cs" %}
```csharp
namespace MyProject.Automate;

public sealed class OrderPaidTriggerOutput
{
    public string OrderReference { get; init; } = string.Empty;

    public decimal AmountPaid { get; init; }
}
```
{% endcode %}

{% code title="OrderPaidTrigger.cs" %}
```csharp
using Umbraco.Automate.Core.Triggers;

namespace MyProject.Automate;

[Trigger("myProject.orderPaid", "Order Paid",
    Description = "Fires when the payment provider posts a paid webhook.",
    Group = "My Project",
    Icon = "icon-coins")]
public sealed class OrderPaidTrigger
    : WebhookTriggerBase<OrderPaidTriggerSettings, OrderPaidTriggerOutput>
{
    public OrderPaidTrigger(TriggerInfrastructure infrastructure)
        : base(infrastructure)
    {
    }
}
```
{% endcode %}

A webhook trigger receives its payload through Automate's webhook endpoint. Map the posted body to trigger output the same way a notification-based trigger maps a notification — see [Create a Custom Trigger](custom-trigger.md) for the `MapEvent` and `CanHandle` pattern.

### Verifying the Request Came From Your Vendor

An inbound webhook URL is public. Verify the request before trusting its payload by implementing `IWebhookAuthenticator`, or by inheriting the convenience base class `WebhookAuthenticatorBase<TSettings>`. It reads discovery metadata from a `[WebhookAuthenticator]` attribute and derives the settings schema from `TSettings` automatically.

{% code title="StripeWebhookAuthenticator.cs" %}
```csharp
using Umbraco.Automate.Core.Settings;
using Umbraco.Automate.Core.Triggers.Webhooks;

namespace MyProject.Automate;

public sealed class StripeWebhookAuthenticatorSettings
{
    [Field(Label = "Signing Secret", IsSensitive = true)]
    public string? SigningSecret { get; set; }
}

[WebhookAuthenticator("stripe", "Stripe Signature")]
public sealed class StripeWebhookAuthenticator
    : WebhookAuthenticatorBase<StripeWebhookAuthenticatorSettings>
{
    protected override bool Validate(
        WebhookAuthenticationContext context,
        StripeWebhookAuthenticatorSettings settings)
    {
        // Read the "Stripe-Signature" header from context.Request,
        // recompute it from context.Body and settings.SigningSecret,
        // and compare using a constant-time comparison.
        return true;
    }
}
```
{% endcode %}

Set `RequiresBody` to `false` when a scheme validates against headers alone. Automate skips reading the request body before calling `Validate`. Callers get a fast 401 response for unauthorized requests on large payloads instead of waiting on a body read that gets discarded anyway.

Unlike triggers and actions, webhook authenticators are not auto-discovered from the `[WebhookAuthenticator]` attribute alone. Register each one explicitly:

{% code title="MyProjectComposer.cs" %}
```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;

namespace MyProject.Automate;

public sealed class MyProjectComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AutomateWebhookAuthenticators()
            .Add<StripeWebhookAuthenticator>();
    }
}
```
{% endcode %}

The attribute supplies the alias, display name, and description shown in the authentication strategy picker on the webhook trigger's settings. The collection registration is what makes the authenticator selectable.

## Trigger from Any .NET Event

Umbraco notifications are the most common event source, but not the only one. `IEventTrigger<TEvent>` declares that a trigger responds to events of type `TEvent`. `NotificationTriggerBase<TSettings, TOutput, TNotification>`, the base class used in [Create a Custom Trigger](custom-trigger.md), implements this interface for Umbraco notifications specifically:

```csharp
public interface IEventTrigger<in TEvent>
{
    IEnumerable<TriggerEvent> MapEvent(TEvent @event);
}
```

For an Umbraco notification, `NotificationTriggerBase` already wires up the dispatcher. A trigger that inherits from it and overrides `MapEvent` is discovered and connected automatically, as shown in [Create a Custom Trigger](custom-trigger.md).

For an event that is not an Umbraco notification, `MapEvent` still describes how to turn one event into zero or more `TriggerEvent` instances. Nothing in the framework calls it automatically — publish the event and invoke the trigger's `MapEvent` from your own listener.

## Registration

Scheduled and webhook triggers are discovered at startup the same way as notification triggers — by their `[Trigger]` attribute and base class. Webhook authenticators are the exception and need the explicit `AutomateWebhookAuthenticators()` registration shown above.

## Verify

Restart your Umbraco site. A scheduled trigger appears in the trigger picker and fires on its cron expression once an automation using it is published. A webhook trigger exposes a webhook URL on the automation, and a registered authenticator appears as an option in that trigger's authentication strategy picker.
