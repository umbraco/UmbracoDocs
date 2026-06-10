---
description: Create a custom action that automations can use as a step.
---

# Create a Custom Action

A custom action adds a new unit of work to the action catalogue. Actions run as steps inside an automation and can produce output that downstream steps bind to.

## Settings Model

The settings POCO defines the configuration UI. Mark settings that can use [bindings](../concepts/bindings.md) with `SupportsBindings = true`.

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

## Authorization and Access

### Declaring Section Requirements

The `RequiredSections` array on the `[Action]` attribute tells Automate which Umbraco backoffice sections the workspace's service account must have access to.

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

## Registration

No manual registration is required. The action is discovered at startup by its `[Action]` attribute and the base class.

## Verify

Restart your Umbraco site. The new action appears in the action picker under the **My Project** group. Add it to an automation, bind its settings to upstream values, and inspect the run's step output to verify it works.
