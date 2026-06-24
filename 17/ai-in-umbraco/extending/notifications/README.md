---
description: >-
    Subscribe to entity lifecycle events in Umbraco.AI to add custom validation, audit logging, and automation.
---

# Notifications

Umbraco.AI publishes notifications during entity lifecycle operations (save, delete, rollback, execution) using Umbraco CMS's notification infrastructure. Subscribe to these notifications to:

- **Validate operations** before they execute (with cancellation support)
- **Audit changes** after they complete
- **Trigger automation** in response to entity events
- **Maintain consistency** across your application

## Notification Types

All entity operations publish notifications following Umbraco CMS patterns:

| Notification Type | When Published | Cancelable | Use Cases |
|-------------------|----------------|------------|-----------|
| **Saving** | Before entity is saved | ✅ Yes | Validation, business rules, pre-save modifications |
| **Saved** | After entity is saved | ❌ No | Audit logging, cache invalidation, webhooks |
| **Deleting** | Before entity is deleted | ✅ Yes | Dependency checks, confirmation prompts |
| **Deleted** | After entity is deleted | ❌ No | Cleanup, cascade deletes, audit logs |
| **Rolling Back** | Before version rollback | ✅ Yes | Permission checks, validation |
| **Rolled Back** | After version rollback | ❌ No | Audit logging, notifications |
| **Executing** | Before execution starts | ✅ Yes | Rate limiting, authorization, resource checks |
| **Executed** | After execution completes | ❌ No | Usage tracking, performance metrics, billing |

## Entities with Notifications

### Core Entities (Umbraco.AI)

- **AIProfile** - Save/Delete/Rollback
- **AIConnection** - Save/Delete/Rollback
- **AIContext** - Save/Delete/Rollback
- **AIGuardrail** - Save/Delete/Rollback
- **AITest** - Save/Delete/Rollback
- **AISettings** - Save
- **AIChat** (Inline) - Executing/Executed
- **AISpeechToText** (Inline) - Executing/Executed
- **AIEmbedding** (Inline) - Executing/Executed

### Prompt Add-on (Umbraco.AI.Prompt)

- **AIPrompt** - Save/Delete/Executing/Executed

### Agent Add-on (Umbraco.AI.Agent)

- **AIAgent** - Save/Delete/Executing/Executed

## Quick Example

Subscribe to a notification in an Umbraco Composer:

{% code title="ProfileNotificationComposer.cs" %}

```csharp
using Umbraco.AI.Core.Profiles;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Notifications;

public class ProfileNotificationComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder
            .AddNotificationAsyncHandler<AIProfileSavingNotification, ProfileValidationHandler>()
            .AddNotificationAsyncHandler<AIProfileSavedNotification, ProfileAuditHandler>();
    }
}

public class ProfileValidationHandler : INotificationAsyncHandler<AIProfileSavingNotification>
{
    public Task HandleAsync(AIProfileSavingNotification notification, CancellationToken ct)
    {
        // Cancel save if profile alias is reserved
        if (notification.Entity.Alias == "system")
        {
            notification.Cancel = true;
            notification.Messages.Add(new EventMessage(
                "Validation",
                "Cannot use reserved alias 'system'",
                EventMessageType.Error));
        }

        return Task.CompletedTask;
    }
}
```

{% endcode %}

## Cancelable vs Stateful Notifications

### Cancelable Notifications (Before Operations)

Published **before** an operation executes. Set `Cancel = true` to prevent the operation:

{% code title="CancelableNotificationExample.cs" %}

```csharp
public async Task HandleAsync(AIProfileDeletingNotification notification, CancellationToken ct)
{
    if (await HasDependentProfiles(notification.EntityId))
    {
        notification.Cancel = true;
        notification.Messages.Add(new EventMessage(
            "Dependency",
            "Cannot delete profile with dependent profiles",
            EventMessageType.Error));
    }
}
```

{% endcode %}

### Stateful Notifications (After Operations)

Published **after** an operation completes. The handler cannot cancel because the operation already happened:

{% code title="StatefulNotificationExample.cs" %}

```csharp
public Task HandleAsync(AIProfileSavedNotification notification, CancellationToken ct)
{
    // Log the change
    _auditService.LogProfileChange(notification.Entity);

    // Invalidate cache
    _cache.Remove($"profile:{notification.Entity.Alias}");

    return Task.CompletedTask;
}
```

{% endcode %}

### State Propagation

Stateful notifications inherit state from their cancelable counterparts using `WithStateFrom()`. The method lets you pass data between before/after notifications:

{% code title="StatePropagationExample.cs" %}

```csharp
// In service code (example from AIProfileService)
var savingNotification = new AIProfileSavingNotification(profile, messages);
await _notificationPublisher.PublishAsync(savingNotification, ct);

// ... perform save ...

var savedNotification = new AIProfileSavedNotification(profile, messages)
    .WithStateFrom(savingNotification);  // Propagates state
await _notificationPublisher.PublishAsync(savedNotification, ct);
```

{% endcode %}

## Architecture

Notifications follow Umbraco CMS patterns exactly:

```mermaid
graph BT
    A["Umbraco.AI Services\n(AIProfileService, AIConnectionService, AIAgentService)"] -->|publishes| B["Umbraco Notification System\n(IEventAggregator)"]
    B -->|subscribes| C["Your Notification Handlers\n(INotificationAsyncHandler)"]
```

## In This Section

{% content-ref url="entity-notifications.md" %}
[Entity Lifecycle Notifications](entity-notifications.md)
{% endcontent-ref %}
