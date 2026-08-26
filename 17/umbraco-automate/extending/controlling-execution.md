---
description: >-
  Gate trigger dispatch against your own permission model; stop automations
  from re-triggering each other, and wrap every action with custom
  cross-cutting logic.
---

# Control What Runs

The building blocks in [Create a Custom Trigger](custom-trigger.md) and [Create a Custom Action](custom-action.md) decide what a trigger or action does. The extension points on this page decide whether it gets to run at all, and what happens around it when it does.

## Gate Dispatch With Your Own Permission Model

A trigger's own `CanHandle` method filters events by business logic — for example, only entities whose name matches a prefix. `ITriggerDispatchAuthorizer` is a separate, later check: it runs per automation at dispatch time, after `CanHandle` has already matched.

Automate ships a built-in authorizer that checks the workspace service account's CMS start-node access. Register your own to gate against a permission model that CMS start nodes cannot express, such as a per-tenant or per-store allowlist.

{% code title="StoreScopedTriggerDispatchAuthorizer.cs" %}
```csharp
using Umbraco.Automate.Core.Dispatch;
using Umbraco.Automate.Core.Dispatch.Authorization;
using Umbraco.Automate.Core.Security;

namespace MyProject.Automate;

public sealed class StoreScopedTriggerDispatchAuthorizer : ITriggerDispatchAuthorizer
{
    public Task<AutomationAuthorizationResult> AuthorizeAsync(
        TriggerDispatchAuthorizationContext context,
        CancellationToken cancellationToken)
    {
        // Return Success when this authorizer has nothing to say about the
        // given trigger or output — the dispatcher treats Success as "not
        // blocking", not "explicitly approved".
        if (context.TypedOutput is not MyStoreScopedTriggerOutput output)
        {
            return Task.FromResult(AutomationAuthorizationResult.Success);
        }

        var allowed = /* look up whether context.Automation.WorkspaceId may act on output.StoreId */ true;

        return Task.FromResult(allowed
            ? AutomationAuthorizationResult.Success
            : AutomationAuthorizationResult.Fail("Workspace is not scoped to this store."));
    }
}
```
{% endcode %}

Register it on the authorizer collection:

{% code title="MyProjectComposer.cs" %}
```csharp
builder.AutomateTriggerDispatchAuthorizers()
    .Add<StoreScopedTriggerDispatchAuthorizer>();
```
{% endcode %}

Authorizers run in registration order. The first result with `Authorized = false` skips the run for that automation, and no further authorizer is consulted for it.

## Stop Automations From Re-Triggering Each Other

An action that publishes content can itself raise the notification a **Content Published** trigger listens for. Left unchecked, that lets one automation's actions start another automation, which can start another, and so on.

Trigger settings that implement `IAutomationOriginatedEventBehavior` control this per trigger. Automate consults it whenever an incoming event was itself caused by an automation run:

```csharp
public interface IAutomationOriginatedEventBehavior
{
    AutomationOriginatedEventBehavior OnAutomationOriginated { get; }
}
```

`AutomationOriginatedEventBehavior` has three values:

| Value | Effect |
| --- | --- |
| `Run` | The trigger fires normally, even for automation-originated events. |
| `SkipOnCycle` | The trigger skips only when firing would re-enter the same automation. This is the default. |
| `SkipAlways` | The trigger never fires for automation-originated events. |

Implement the interface explicitly on the settings Plain Old CLR Object (POCO) so a string-backed dropdown property can still satisfy it:

{% code title="MyCustomTriggerSettings.cs" %}
```csharp
using Umbraco.Automate.Core.Settings;
using Umbraco.Automate.Core.Triggers;

namespace MyProject.Automate;

public sealed class MyCustomTriggerSettings : IAutomationOriginatedEventBehavior
{
    [Field(Label = "On automation-originated event")]
    public string OnAutomationOriginatedEvent { get; set; }
        = nameof(AutomationOriginatedEventBehavior.SkipOnCycle);

    AutomationOriginatedEventBehavior IAutomationOriginatedEventBehavior.OnAutomationOriginated
        => Enum.TryParse<AutomationOriginatedEventBehavior>(
            OnAutomationOriginatedEvent, ignoreCase: true, out var value)
            ? value
            : AutomationOriginatedEventBehavior.SkipOnCycle;
}
```
{% endcode %}

## Wrap Every Action With Custom Logic

`IActionMiddleware` wraps action execution the way ASP.NET Core middleware wraps a request. Each registered middleware can inspect or modify the context before calling the action, react to the result afterwards, or short-circuit entirely.

Automate's own audit trail, error handling, and settings validation are all built as middleware. Add your own for logging, metrics, or a cross-cutting policy that every action should honor.

{% code title="StepTimingMiddleware.cs" %}
```csharp
using Umbraco.Automate.Core.Actions.Middleware;

namespace MyProject.Automate;

public sealed class StepTimingMiddleware : IActionMiddleware
{
    private readonly ILogger<StepTimingMiddleware> _logger;

    public StepTimingMiddleware(ILogger<StepTimingMiddleware> logger)
    {
        _logger = logger;
    }

    public async Task<ActionResult> ApplyAsync(
        ActionContext context,
        ActionMiddlewareDelegate next,
        CancellationToken cancellationToken)
    {
        var start = DateTimeOffset.UtcNow;

        var result = await next(context, cancellationToken);

        _logger.LogInformation(
            "{ActionAlias} took {Elapsed}",
            context.ActionAlias,
            DateTimeOffset.UtcNow - start);

        return result;
    }
}
```
{% endcode %}

Middleware is not auto-discovered. Append it to the collection in registration order, alongside the built-in middleware:

{% code title="MyProjectComposer.cs" %}
```csharp
builder.AutomateActionMiddleware()
    .Append<StepTimingMiddleware>();
```
{% endcode %}

Registration order sets the nesting order: middleware appended earlier wraps middleware appended later, with the action itself innermost. Because `Append` always adds to the end of the list, custom middleware ends up inside the built-in error-handling middleware, not wrapping it. An unhandled exception from the action reaches custom middleware as a raw exception through its own call to `next`. Automate's error-handling middleware only converts it to a failed `ActionResult` afterward, once the exception has propagated back out past your middleware. Wrap your own call to `next` in a try/catch if your middleware needs to guarantee it always sees an `ActionResult`.

## Registration

`ITriggerDispatchAuthorizer` and `IActionMiddleware` implementations both need explicit registration on their collection builders — `AutomateTriggerDispatchAuthorizers()` and `AutomateActionMiddleware()`. `IAutomationOriginatedEventBehavior` needs no registration: implement it on a trigger settings class, and Automate calls it directly during dispatch.

## Verify

Restart your Umbraco site. Trigger the event your authorizer or middleware targets, then check the automation's run history. A blocked dispatch produces no run. A re-triggered cycle produces no second run once `SkipOnCycle` or `SkipAlways` is set.
