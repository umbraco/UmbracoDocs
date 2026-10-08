---
description: >-
  Give an action a settings-driven output schema, write it to the audit
  trail automatically, and control what gets stripped from it on export.
---

# Additional Action Behavior

[Create a Custom Action](custom-action.md) covers the settings, output, and `ExecuteAsync` an action needs to run as a step. The extension points on this page add behavior most actions get for free, or opt into with a single interface.

## A Settings-Driven Output Schema

`ActionBase<TSettings, TOutput>` declares a fixed output shape from `TOutput`. Some actions cannot know their output shape until the step is configured. For example, an action that calls a user-defined API returns whatever that API responds with. Inherit from `DynamicOutputActionBase<TSettings>` instead, and compute the output schema from the resolved settings:

{% code title="CallApiSettings.cs" %}
```csharp
using Umbraco.Automate.Core.Settings;

namespace MyProject.Automate;

public sealed class CallApiSettings
{
    [Field(Label = "URL", SupportsBindings = true)]
    public string Url { get; set; } = string.Empty;

    [Field(Label = "Response Schema", Description = "A JSON Schema describing the response body.")]
    public string? ResponseSchemaJson { get; set; }
}
```
{% endcode %}

{% code title="CallApiAction.cs" %}
```csharp
using Json.Schema;
using Umbraco.Automate.Core.Actions;

namespace MyProject.Automate;

[Action("myProject.callApi", "Call API",
    Description = "Calls a user-configured endpoint and returns its response shape.",
    Group = "My Project",
    Icon = "icon-code")]
public sealed class CallApiAction : DynamicOutputActionBase<CallApiSettings>
{
    public CallApiAction(ActionInfrastructure infrastructure)
        : base(infrastructure)
    {
    }

    protected override Task<JsonSchema?> GetOutputSchemaAsync(
        CallApiSettings? settings,
        CancellationToken cancellationToken = default)
    {
        // Required setting not yet configured — no schema to offer downstream steps.
        if (string.IsNullOrEmpty(settings?.ResponseSchemaJson))
        {
            return Task.FromResult<JsonSchema?>(null);
        }

        return Task.FromResult<JsonSchema?>(JsonSchema.FromText(settings.ResponseSchemaJson));
    }

    public override async Task<ActionResult> ExecuteAsync(
        ActionContext context,
        CancellationToken cancellationToken)
    {
        var settings = context.GetSettings<CallApiSettings>();

        // ...call settings.Url and shape the response to match the schema above...

        return Success(new object());
    }
}
```
{% endcode %}

Downstream steps bind to whatever fields the resolved schema describes, the same way they bind to a fixed `TOutput`'s properties. Return `null` from `GetOutputSchemaAsync` while a required setting is unset — Automate treats a null schema as "not configured yet" rather than an error.

## An Audit Trail, From One Marker Interface

Actions that modify CMS content or media can implement `ICmsAction`, a marker interface with no members:

```csharp
public interface ICmsAction;
```

Add it to an action that changes content. Automate's built-in audit trail middleware then writes a structured entry to Umbraco's audit log automatically, once the action completes successfully:

{% code title="ArchivePageSettings.cs" %}
```csharp
using Umbraco.Automate.Core.Settings;

namespace MyProject.Automate;

public sealed class ArchivePageSettings
{
    [Field(Label = "Content Key", SupportsBindings = true)]
    public string ContentKey { get; set; } = string.Empty;
}
```
{% endcode %}

{% code title="ArchivePageOutput.cs" %}
```csharp
namespace MyProject.Automate;

public sealed class ArchivePageOutput
{
}
```
{% endcode %}

{% code title="ArchivePageAction.cs" %}
```csharp
using Umbraco.Automate.Core.Actions;

namespace MyProject.Automate;

[Action("myProject.archivePage", "Archive Page",
    Group = "My Project",
    Icon = "icon-box",
    RequiredSections = [Umbraco.Cms.Core.Constants.Applications.Content])]
public sealed class ArchivePageAction
    : ActionBase<ArchivePageSettings, ArchivePageOutput>, ICmsAction
{
    public ArchivePageAction(ActionInfrastructure infrastructure)
        : base(infrastructure)
    {
    }

    public override async Task<ActionResult> ExecuteAsync(
        ActionContext context,
        CancellationToken cancellationToken)
    {
        // ...move the content node...

        return Success(new ArchivePageOutput());
    }
}
```
{% endcode %}

Leave `ICmsAction` off actions that only read data — a **Get Content** action, for example — since a read produces nothing worth auditing. Automate writes the entry against the automation's service account, tagged with the action's alias and step. The step never fails if the audit write itself fails.

## Validating Settings on Save and Publish

Implement `IValidatableStepType` to reject malformed settings when an author saves an automation. Implement `IPublishValidatableStepType` for checks that would block saving work in progress, such as a required setting or a referenced item that must exist. Automate only runs those checks when the automation is published. Each message you return blocks the save or publish, and is shown with the step's name.

{% code title="NotifyTeamAction.cs" %}
```csharp
using Umbraco.Automate.Core.Actions;
using Umbraco.Automate.Core.Automations;
using Umbraco.Automate.Core.Settings;
using Umbraco.Automate.Core.StepTypes;

namespace MyProject.Automate;

public sealed class NotifyTeamSettings
{
    [Field(Label = "Team key", Description = "The team to notify.", SupportsBindings = true)]
    public string? TeamKey { get; set; }
}

public sealed class NotifyTeamOutput
{
    public bool Sent { get; set; }
}

[Action("myProject.notifyTeam", "Notify Team", Group = "My Project", Icon = "icon-users")]
public sealed class NotifyTeamAction
    : ActionBase<NotifyTeamSettings, NotifyTeamOutput>, IValidatableStepType, IPublishValidatableStepType
{
    public NotifyTeamAction(ActionInfrastructure infrastructure)
        : base(infrastructure) { }

    // Runs on every save: reject only values that can never work.
    public Task<IReadOnlyList<string>> ValidateSettingsAsync(
        object? settings,
        CancellationToken cancellationToken = default)
    {
        if (settings is not NotifyTeamSettings { TeamKey: { Length: > 0 } key }
            || key.Contains("${", StringComparison.Ordinal)
            || Guid.TryParse(key, out _))
        {
            return Task.FromResult<IReadOnlyList<string>>([]);
        }

        return Task.FromResult<IReadOnlyList<string>>([$"'{key}' is not a valid team key."]);
    }

    // Runs on publish only: require the value to be filled in.
    public Task<IReadOnlyList<string>> ValidateSettingsForPublishAsync(
        object? settings,
        Automation automation,
        CancellationToken cancellationToken = default)
    {
        if (settings is NotifyTeamSettings typed && !string.IsNullOrWhiteSpace(typed.TeamKey))
        {
            return Task.FromResult<IReadOnlyList<string>>([]);
        }

        return Task.FromResult<IReadOnlyList<string>>(["Select a team to notify."]);
    }

    public override Task<ActionResult> ExecuteAsync(ActionContext context, CancellationToken cancellationToken)
        => Task.FromResult(Success(new NotifyTeamOutput { Sent = true }));
}
```
{% endcode %}

Keep the following in mind:

* Settings reach both methods with configuration references resolved. `${ }` bindings are still unresolved text, so skip format checks on a bound value.
* Declare a setting that is only required at publish as nullable, such as `string?`. A non-nullable string is required by default, and that rule runs whenever Automate resolves the settings.
* Only actions are validated. Automate ignores these interfaces on other step types.

## Secrets Stripped on Export

Settings marked `IsSensitive = true` on a `[Field]` attribute are already masked in the backoffice and encrypted at rest. `ISensitiveSettingsStripper` is the service that acts on that flag when an automation leaves the system — through the in-app export flow or the [Deploy integration](../add-ons/deploy/README.md). Those values never land in a portable file.

The default implementation strips every setting flagged `IsSensitive` from the settings of triggers, steps, connections, and notification channels. It works from each one's settings schema. Most projects never need to touch this — mark the setting `IsSensitive` on its `[Field]` attribute and the default stripper handles it.

Replace the default only when a setting is conditionally sensitive in a way `IsSensitive` cannot express on its own. For example, a field whose sensitivity depends on another setting's value:

{% code title="MyProjectComposer.cs" %}
```csharp
using Umbraco.Automate.Core.Automations.Transfer;

builder.Services.AddSingleton<ISensitiveSettingsStripper, MyStripper>();
```
{% endcode %}

{% hint style="warning" %}
Registering a replacement overwrites Automate's own stripper rather than wrapping it. Automate's default implementation is internal and cannot be called from a replacement. A custom `ISensitiveSettingsStripper` needs to strip every `IsSensitive` field itself, not only the extra case it was written for.

Also implement `StripNotificationSettings`. Its default returns `null`, so exports made with your stripper leave out notification settings.
{% endhint %}

## Registration

`DynamicOutputActionBase` and `ICmsAction` need no registration beyond the `[Action]` attribute already required for any custom action. `ISensitiveSettingsStripper` needs the explicit `AddSingleton` registration shown above, and only when the default behavior is not enough.

## Verify

Restart your Umbraco site. Configure a dynamic-output action's settings and confirm downstream steps can bind to the fields its schema describes. Run a `ICmsAction` step and check Umbraco's audit log for the entry. Export the automation and confirm sensitive fields are absent from the exported file.
