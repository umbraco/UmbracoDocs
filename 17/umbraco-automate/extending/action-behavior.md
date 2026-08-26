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

## Secrets Stripped on Export

Settings marked `IsSensitive = true` on a `[Field]` attribute are already masked in the backoffice and encrypted at rest. `ISensitiveSettingsStripper` is the service that acts on that flag when an automation leaves the system — through the in-app export flow or the [Deploy integration](../add-ons/deploy/README.md). Those values never land in a portable file.

The default implementation strips every setting flagged `IsSensitive` from a trigger's, step's, or connection's settings, based on each one's settings schema. Most projects never need to touch this — mark the setting `IsSensitive` on its `[Field]` attribute and the default stripper handles it.

Replace the default only when a setting is conditionally sensitive in a way `IsSensitive` cannot express on its own. For example, a field whose sensitivity depends on another setting's value:

{% code title="MyProjectComposer.cs" %}
```csharp
builder.Services.AddSingleton<ISensitiveSettingsStripper, MyStripper>();
```
{% endcode %}

{% hint style="warning" %}
Registering a replacement overwrites Automate's own stripper rather than wrapping it. Automate's default implementation is internal and cannot be called from a replacement. A custom `ISensitiveSettingsStripper` needs to strip every `IsSensitive` field itself, not only the extra case it was written for.
{% endhint %}

## Registration

`DynamicOutputActionBase` and `ICmsAction` need no registration beyond the `[Action]` attribute already required for any custom action. `ISensitiveSettingsStripper` needs the explicit `AddSingleton` registration shown above, and only when the default behavior is not enough.

## Verify

Restart your Umbraco site. Configure a dynamic-output action's settings and confirm downstream steps can bind to the fields its schema describes. Run a `ICmsAction` step and check Umbraco's audit log for the entry. Export the automation and confirm sensitive fields are absent from the exported file.
