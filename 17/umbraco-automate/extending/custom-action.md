---
description: Create a custom action that automations can use as a step.
---

# Create a Custom Action

A custom action adds a new unit of work to the action catalogue. Actions run as steps inside an automation and can produce output that downstream steps bind to.

## Settings Model

The settings Plain Old CLR Object (POCO) defines the configuration UI. Mark settings that can use [bindings](../concepts/bindings.md) with `SupportsBindings = true`.

{% code title="GreetUserSettings.cs" %}
```csharp
using Umbraco.Automate.Core.Settings;

namespace MyProject.Automate;

public sealed class GreetUserSettings
{
    [Field(
        Label = "User name",
        Description = "The name of the user to greet.",
        SupportsBindings = true)]
    public string UserName { get; set; } = string.Empty;
}
```
{% endcode %}

A non-nullable `string` or object property is required by default. A collection, such as `List<T>`, isn't, so an empty list is a valid value. Add `[Required]` to make the backoffice ask for at least one row. The server accepts an empty list either way, so check the row count yourself if you need rows. See [Validating Settings on Save and Publish](action-behavior.md#validating-settings-on-save-and-publish).

A field marked `IsSensitive = true` is encrypted at rest, masked in the run view, redacted from log entries, and left out of exports. It is also the only kind of field that can reference `Umbraco:Automate:Secrets`. Only string values are encrypted. If you mark an existing field sensitive in a later release, stored values are encrypted the next time each automation is saved.

### Showing a Field Conditionally

To show a field only for certain values of another field, set `VisibleWhen` to the controlling property's name and list the values in `VisibleWhenValues`. Values are compared by name for an enum, ignoring case.

{% code title="SendGreetingSettings.cs" %}
```csharp
using Umbraco.Automate.Core.Settings;

namespace MyProject.Automate;

public enum GreetingChannel
{
    Log,
    Email,
}

public sealed class SendGreetingSettings
{
    [Field(
        Label = "Channel",
        Description = "Where to send the greeting.",
        EditorUiAlias = "Umb.PropertyEditorUi.Dropdown",
        EditorConfig = """[{ "alias": "items", "value": ["Log", "Email"] }]""")]
    public GreetingChannel Channel { get; set; } = GreetingChannel.Log;

    [Field(
        Label = "Email address",
        Description = "The address to send the greeting to.",
        SupportsBindings = true,
        VisibleWhen = nameof(Channel),
        VisibleWhenValues = [nameof(GreetingChannel.Email)])]
    public string? EmailAddress { get; set; }
}
```
{% endcode %}

A hidden field is skipped by validation, so a required field only needs a value while it is visible. Its stored value is kept, so switching back restores it. If `VisibleWhen` names a property that doesn't exist, or `VisibleWhenValues` is empty, Automate throws an `InvalidOperationException` when it builds the settings schema. The mistake fails loudly instead of leaving a field that never hides.

Automate doesn't pick an editor for an enum, so set `EditorUiAlias` to a dropdown and list the enum names as its items. A field is hidden while its controlling field has no value. `VisibleWhen` also works on trigger, connection, and webhook authenticator settings.

### Collecting Key/Value Pairs

Use the `UmbracoAutomate.PropertyEditorUi.KeyValueEditor` editor to collect rows of names and values, such as headers or query parameters. Bind it to a list of a class with `Key` and `Value` string properties.

{% code title="CallApiSettings.cs" %}
```csharp
using Umbraco.Automate.Core.Settings;

namespace MyProject.Automate;

public sealed class ApiParameter
{
    public string Key { get; set; } = string.Empty;

    public string? Value { get; set; }
}

public sealed class CallApiSettings
{
    [Field(
        Label = "Query parameters",
        Description = "One row per parameter.",
        SupportsBindings = true,
        EditorUiAlias = "UmbracoAutomate.PropertyEditorUi.KeyValueEditor",
        EditorConfig = """[{ "alias": "keyPlaceholder", "value": "Name" }]""")]
    public List<ApiParameter> QueryParameters { get; set; } = [];

    [Field(
        Label = "Credentials",
        Description = "Values are encrypted when stored.",
        IsSensitive = true,
        SupportsBindings = true,
        EditorUiAlias = "UmbracoAutomate.PropertyEditorUi.KeyValueEditor")]
    public List<ApiParameter> Credentials { get; set; } = [];
}
```
{% endcode %}

Keep the following in mind:

* Always set `EditorUiAlias` on a collection. Without it, the field renders as a single text box.
* With `SupportsBindings = true`, each value gets a binding picker. Bindings and configuration references resolve in every string property of each row.
* On a sensitive list, Automate encrypts each row's `Value` when it stores the settings. Keys and other properties are stored as plain text, so keep secrets in `Value`. For a list of strings, each item is encrypted.
* The run view masks the whole sensitive list as `********`, and exports leave it out. The editor shows values to anyone who can edit the step.
* A `$Umbraco:Automate:Secrets:` reference in a row resolves only when the field is sensitive.

## Output Model

{% code title="GreetUserOutput.cs" %}
```csharp
namespace MyProject.Automate;

public sealed class GreetUserOutput
{
    public string Greeting { get; set; } = string.Empty;
}
```
{% endcode %}

## Action Class

Inherit from `ActionBase<TSettings, TOutput>` and override `ExecuteAsync`:

{% code title="GreetUserAction.cs" %}
```csharp
using Umbraco.Automate.Core.Actions;

namespace MyProject.Automate;

[Action("myProject.greetUser", "Greet User",
    Description = "Produces a greeting for a user.",
    Group = "My Project",
    Icon = "icon-user",
    RequiredSections = [Umbraco.Cms.Core.Constants.Applications.Users])]
public sealed class GreetUserAction : ActionBase<GreetUserSettings, GreetUserOutput>
{
    public GreetUserAction(ActionInfrastructure infrastructure)
        : base(infrastructure) { }

    public override Task<ActionResult> ExecuteAsync(
        ActionContext context,
        CancellationToken cancellationToken)
    {
        var settings = context.GetSettings<GreetUserSettings>();

        var output = new GreetUserOutput
        {
            Greeting = $"Hello, {settings.UserName}!",
        };

        return Task.FromResult(Success(output));
    }
}
```
{% endcode %}

## Writing Run Log Entries

Call the log methods on `ActionContext` to record what the action did. Entries appear in the step's **Logs** tab in the run view. See [Reviewing Runs](../backoffice/runs.md#log-entries).

{% code title="GreetUserAction.cs" %}
```csharp
using Umbraco.Automate.Core.Actions;

namespace MyProject.Automate;

[Action("myProject.greetUser", "Greet User",
    Description = "Produces a greeting for a user.",
    Group = "My Project",
    Icon = "icon-user")]
public sealed class GreetUserAction : ActionBase<GreetUserSettings, GreetUserOutput>
{
    public GreetUserAction(ActionInfrastructure infrastructure)
        : base(infrastructure) { }

    public override Task<ActionResult> ExecuteAsync(
        ActionContext context,
        CancellationToken cancellationToken)
    {
        var settings = context.GetSettings<GreetUserSettings>();

        if (string.IsNullOrWhiteSpace(settings.UserName))
        {
            context.LogWarning("No user name was provided, so the greeting is generic");
        }

        var name = string.IsNullOrWhiteSpace(settings.UserName) ? "there" : settings.UserName;
        context.LogInfo("Produced the greeting");

        return Task.FromResult(Success(new GreetUserOutput { Greeting = $"Hello, {name}!" }));
    }
}
```
{% endcode %}

The methods are `LogDebug`, `LogInfo`, `LogWarning`, and `LogError`, or `Log(ActionLogLevel, string)`. Keep the following in mind:

* Only actions write log entries. Action middleware can also write them, because it receives the same `ActionContext`. Triggers, control flow steps, connection types, and webhook authenticators have no log API.
* Entries are kept when the action throws, fails, or times out. They appear next to the step's error, so log what you know before you return a failure.
* Entries are separate from the application log. Automate doesn't copy them to `ILogger`, and `ILogger` output doesn't appear on the **Logs** tab. Use an injected `ILogger` for diagnostics aimed at developers. To log from a helper service, pass it the `ActionContext`.
* Entries below `Execution:MinimumLogLevel` are dropped. Each step keeps its first `Execution:MaxLogEntriesPerStep` entries, and later ones are dropped. See [Configuration](../getting-started/configuration.md).
* Automate redacts the step's sensitive setting values from each message and truncates messages over 4,000 characters. Redaction only covers the step's own settings, and only values of four or more characters. Connection settings and step output are not redacted, so never log a connection's credentials.
* The log methods aren't thread-safe. Write entries from one thread, for example after `Task.WhenAll` completes.
* Don't log personal data or request and response bodies. Don't repeat what the step's output already shows. Log what happened and why, such as timings, decisions, and anything skipped.

## Authorization and Access

### Declaring Section Requirements

The `RequiredSections` array on the `[Action]` attribute tells Automate which Umbraco backoffice sections the workspace service account must have access to.

The check is all-of: every listed section must be present. The action is hidden from the picker and rejected at publish. At runtime, it fails with an authentication error when the section is missing.

Omit the property for actions that have no CMS data dependency (for example, **Log Message** or **HTTP Request**).

### Declaring Permission Requirements

Content actions can also declare granular Umbraco permissions via `RequiredPermissions`. The values are CMS permission letters — use the constants in `Umbraco.Cms.Core.Actions`:

```csharp
[Action("myProject.publishThing", "Publish Thing",
    Group = "My Project",
    Icon = "icon-globe",
    RequiredSections = [Umbraco.Cms.Core.Constants.Applications.Content],
    RequiredPermissions = [Umbraco.Cms.Core.Actions.ActionPublish.ActionLetter])]
```

The catalogue picker hides the action from any workspace whose service account doesn't have the listed letters across its user groups. Permissions don't apply to media actions — media access is binary (section + start node).

### Enforcing Node Access at Runtime

For content and media actions that target a specific node, inject `IAutomationActionAuthorizer` and authorize the resolved key before doing the work. Use the `AuthorizeContentOrFailAsync` / `AuthorizeMediaOrFailAsync` helpers to short-circuit with a step-authentication failure when the service account is not allowed on the node:

```csharp
public sealed class PublishThingAction : ActionBase<PublishThingSettings, PublishThingOutput>
{
    private readonly IAutomationActionAuthorizer _authorizer;

    public PublishThingAction(ActionInfrastructure infrastructure, IAutomationActionAuthorizer authorizer)
        : base(infrastructure)
    {
        _authorizer = authorizer;
    }

    public override async Task<ActionResult> ExecuteAsync(ActionContext context, CancellationToken cancellationToken)
    {
        var settings = context.GetSettings<PublishThingSettings>();

        if (!Guid.TryParse(settings.ContentKey, out var contentKey))
        {
            return ActionResult.Failed(
                new ArgumentException("A valid Content Key is required."),
                StepRunErrorCategory.Validation);
        }

        if (await _authorizer.AuthorizeContentOrFailAsync(
                contentKey, RequiredPermissions, cancellationToken) is { } failure)
        {
            return failure;
        }

        // ...invoke the CMS service...
    }
}
```

For actions that create or move items, also authorize the destination with `AuthorizeContentParentOrFailAsync` or `AuthorizeMediaParentOrFailAsync`. They also handle a root destination, where the parent key is `null`. Use `AuthorizeContentRootOrFailAsync` or `AuthorizeMediaRootOrFailAsync` to check root access on its own.

If you replace or decorate `IAutomationActionAuthorizer` yourself, implement `AuthorizeContentRootAsync` and `AuthorizeMediaRootAsync` too. Their default implementations deny root access, so creating or moving items at the root fails until you do.

The authorizer runs against the service account's start node and granular permissions. A workspace scoped to `/marketing/` cannot publish content under `/finance/` even when the action's `RequiredSections` check passed.

See [Service-Account Permissions](../concepts/workspaces.md#service-account-permissions) for the full model.

## Using a Connection

If the action talks to an external service, declare the required connection type alias on the `[Action]` attribute:

```csharp
[Action("myProject.sendThing", "Send Thing",
    ConnectionTypeAlias = "myService")]
```

Inside `ExecuteAsync`, read the connection from `context.Connection`:

```csharp
var connection = context.Connection
    ?? throw new InvalidOperationException("A connection is required.");

var settings = connection.GetSettings<MyServiceConnectionSettings>();
```

When the workspace allows more than one connection of the type, authors pick one in the step's settings. The picker appears even if the action has no other settings. When no connection is picked, Automate uses the first allowed connection of that type. When none is allowed, `context.Connection` is `null`, so return a failed result rather than throwing.

## Registration

No manual registration is required. The action is discovered at startup by its `[Action]` attribute and the base class.

## Verify

Restart your Umbraco site. The new action appears in the action picker under the **My Project** group. Add it to an automation, bind its settings to upstream values, and inspect the run's step output to verify it works.
