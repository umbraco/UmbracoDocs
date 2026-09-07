---
description: >-
  Create a custom trigger that fires when a specific Umbraco notification is
  published.
---

# Create a Custom Trigger

A custom trigger lets you start an automation from any event in your project. The most common pattern is reacting to an Umbraco CMS notification.

## Settings Model

A trigger usually has a settings Plain Old CLR Object (POCO) that defines the configuration UI. Each property is decorated with `[Field]`:

{% code title="MyCustomTriggerSettings.cs" %}
```csharp
using Umbraco.Automate.Core.Settings;

namespace MyProject.Automate;

public sealed class MyCustomTriggerSettings
{
    [Field(
        Label = "Filter",
        Description = "Only fire when the entity name matches this prefix.")]
    public string? NamePrefix { get; set; }
}
```
{% endcode %}

## Output Model

The output model describes the data downstream steps can bind to. Property names are exposed to bindings in camelCase, so `EntityKey` becomes `${ trigger.entityKey }`.

{% code title="MyCustomTriggerOutput.cs" %}
```csharp
namespace MyProject.Automate;

public sealed class MyCustomTriggerOutput
{
    public Guid EntityKey { get; init; }
    public string? Name { get; init; }
}
```
{% endcode %}

## Trigger Class

Inherit from `NotificationTriggerBase<TSettings, TOutput, TNotification>` to fire on an Umbraco notification. Override `MapEvent` to convert each notification into one or more `TriggerEvent` items. Override `CanHandle` to filter events using the resolved trigger settings.

{% code title="MyCustomTrigger.cs" %}
```csharp
using Umbraco.Automate.Core.Triggers;
using Umbraco.Cms.Core.Notifications;

namespace MyProject.Automate;

[Trigger("myProject.myCustomTrigger", "My Custom Trigger",
    Description = "Fires when a content item is saved.",
    Group = "My Project",
    Icon = "icon-flash",
    RequiredSections = [Umbraco.Cms.Core.Constants.Applications.Content])]
public sealed class MyCustomTrigger
    : NotificationTriggerBase<MyCustomTriggerSettings, MyCustomTriggerOutput, ContentSavedNotification>
{
    public MyCustomTrigger(TriggerInfrastructure infrastructure)
        : base(infrastructure)
    {
    }

    public override IEnumerable<TriggerEvent> MapEvent(ContentSavedNotification notification)
    {
        foreach (var content in notification.SavedEntities)
        {
            yield return new TriggerEvent<MyCustomTriggerOutput>
            {
                TriggerAlias = Alias,
                InitiatorType = TriggerInitiatorType.System,
                IdempotencyKey = GenerateIdempotencyKey(
                    content.Key, content.VersionId, content.UpdateDate),
                Output = new MyCustomTriggerOutput
                {
                    EntityKey = content.Key,
                    Name = content.Name,
                },
            };
        }
    }

    protected override bool CanHandle(
        MyCustomTriggerOutput output,
        MyCustomTriggerSettings? settings)
    {
        if (string.IsNullOrEmpty(settings?.NamePrefix))
        {
            return true;
        }

        return output.Name is not null
            && output.Name.StartsWith(settings.NamePrefix, StringComparison.OrdinalIgnoreCase);
    }
}
```
{% endcode %}

## Declaring Section Requirements

The `RequiredSections` array on the `[Trigger]` attribute tells Automate which Umbraco backoffice sections the workspace service account must have access to.

Workspaces whose service account is missing any listed section don't see the trigger in the picker. Dispatch silently skips events for already-published automations until the section is restored.

```csharp
RequiredSections = [
    Umbraco.Cms.Core.Constants.Applications.Content,
    Umbraco.Cms.Core.Constants.Applications.Media
]
```

The check is all-of: the service account must have every listed section. Omit the property for triggers that have no CMS data dependency, for example a webhook that receives external input.

See [Service-Account Permissions](../concepts/workspaces.md#service-account-permissions) for the runtime effects.

## Supporting Run Now

Editors can start an automation on demand from the backoffice, without waiting for its trigger to fire naturally, using **Run now**. A trigger opts into this by implementing `ISupportsManualRun`:

```csharp
public interface ISupportsManualRun
{
    ManualRunOutput CreateManualRunOutput(object? settings);
}
```

`CreateManualRunOutput` returns one of three things:

* `ManualRunOutput.None` — the trigger needs no payload, so the automation just starts.
* `ManualRunOutput.From(data)` — stand-in output built from the trigger's own saved settings, used in place of the payload the real event would carry.
* `ManualRunOutput.Invalid(reason)` — the saved settings can't produce a payload. Automate refuses the run and shows `reason` to the author, instead of starting it with data they didn't mean.

`MyCustomTrigger` above is a case for **not** implementing this interface. Its output carries a real content node from `ContentSavedNotification`, and a fake node would mislead any step that reads it. Implement `ISupportsManualRun` only when the trigger's own settings can convincingly stand in for the real event, such as a webhook trigger with a saved test payload. See [Trigger from a Webhook](schedule-and-webhook-triggers.md#supporting-run-now) for a worked example.

Automate reports which triggers support this on their catalogue entry, which is what makes **Run now** appear in the backoffice for the trigger. See [Running a Trigger On Demand](../concepts/triggers.md#running-a-trigger-on-demand) for the editor-facing behavior.

## Registration

No manual registration is required. The trigger is discovered at startup by its `[Trigger]` attribute and the base class.

## Verify

Restart your Umbraco site. The new trigger appears in the trigger picker under the **My Project** group. Pick it, configure the filter, and publish the automation.
