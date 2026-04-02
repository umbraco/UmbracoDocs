---
description: >-
    Complete reference for all entity lifecycle notifications in Umbraco.AI.
---

# Entity Lifecycle Notifications

Umbraco.AI publishes notifications for all entity lifecycle operations. Subscribe to these events to add custom validation, audit logging, and automation.

## Notification Categories

| Entity | Save/Delete | Rollback | Execution |
|--------|-------------|----------|-----------|
| **AIProfile** | ✅ | ✅ | - |
| **AIConnection** | ✅ | ✅ | - |
| **AIContext** | ✅ | ✅ | - |
| **AIGuardrail** | ✅ | - | - |
| **AISettings** | ✅ (Save only) | - | - |
| **AIPrompt** | ✅ | - | ✅ |
| **AIAgent** | ✅ | - | ✅ |
| **AIChat** (Inline) | - | - | ✅ |

## AIProfile Notifications

### AIProfileSavingNotification (Cancelable)

**Namespace:** `Umbraco.AI.Core.Profiles`

Published **before** a profile is saved (create or update).

**Properties:**
- `Entity` (AIProfile) - The profile being saved
- `Messages` (EventMessages) - Add messages for cancellation reasons
- `Cancel` (bool) - Set to true to prevent the save

**Example:**

{% code title="ProfileSavingHandler.cs" %}

```csharp
public class ProfileSavingHandler : INotificationAsyncHandler<AIProfileSavingNotification>
{
    public Task HandleAsync(AIProfileSavingNotification notification, CancellationToken ct)
    {
        var profile = notification.Entity;

        // Enforce alias naming convention
        if (!Regex.IsMatch(profile.Alias, "^[a-z][a-z0-9-]*$"))
        {
            notification.Cancel = true;
            notification.Messages.Add(new EventMessage(
                "Validation",
                "Profile alias must start with lowercase letter and contain only lowercase letters, numbers, and hyphens",
                EventMessageType.Error));
        }

        // Validate temperature range for specific providers
        if (profile.Temperature.HasValue &&
            (profile.Temperature < 0 || profile.Temperature > 2))
        {
            notification.Cancel = true;
            notification.Messages.Add(new EventMessage(
                "Validation",
                "Temperature must be between 0 and 2",
                EventMessageType.Error));
        }

        return Task.CompletedTask;
    }
}
```

{% endcode %}

### AIProfileSavedNotification (Non-Cancelable)

**Namespace:** `Umbraco.AI.Core.Profiles`

Published **after** a profile is saved.

**Properties:**
- `Entity` (AIProfile) - The saved profile
- `Messages` (EventMessages) - Event messages from the operation

**Example:**

{% code title="ProfileSavedHandler.cs" %}

```csharp
public class ProfileSavedHandler : INotificationAsyncHandler<AIProfileSavedNotification>
{
    private readonly IAuditService _auditService;
    private readonly IMemoryCache _cache;

    public async Task HandleAsync(AIProfileSavedNotification notification, CancellationToken ct)
    {
        var profile = notification.Entity;

        // Log the change
        await _auditService.LogAsync(new AuditEntry
        {
            EntityType = "AIProfile",
            EntityId = profile.Id,
            EntityAlias = profile.Alias,
            Action = "Saved",
            Timestamp = DateTime.UtcNow
        });

        // Invalidate cache
        _cache.Remove($"profile:{profile.Id}");
        _cache.Remove($"profile:{profile.Alias}");
    }
}
```

{% endcode %}

### Other AIProfile Notifications

| Notification | Cancelable | Properties |
|---|---|---|
| `AIProfileDeletingNotification` | Yes | `EntityId` (Guid), `Messages`, `Cancel` |
| `AIProfileDeletedNotification` | No | `EntityId` (Guid), `Messages` |
| `AIProfileRollingBackNotification` | Yes | `ProfileId` (Guid), `TargetVersion` (int), `Messages`, `Cancel` |
| `AIProfileRolledBackNotification` | No | `Profile` (AIProfile), `TargetVersion` (int), `Messages` |

## AIConnection Notifications

**Namespace:** `Umbraco.AI.Core.Connections`

| Notification | Cancelable | Key Properties |
|---|---|---|
| `AIConnectionSavingNotification` | Yes | `Entity` (AIConnection), `Messages`, `Cancel` |
| `AIConnectionSavedNotification` | No | `Entity` (AIConnection), `Messages` |
| `AIConnectionDeletingNotification` | Yes | `EntityId` (Guid), `Messages`, `Cancel` |
| `AIConnectionDeletedNotification` | No | `EntityId` (Guid), `Messages` |
| `AIConnectionRollingBackNotification` | Yes | `ConnectionId` (Guid), `TargetVersion` (int), `Messages`, `Cancel` |
| `AIConnectionRolledBackNotification` | No | `Connection` (AIConnection), `TargetVersion` (int), `Messages` |

## AIContext Notifications

**Namespace:** `Umbraco.AI.Core.Contexts`

| Notification | Cancelable | Key Properties |
|---|---|---|
| `AIContextSavingNotification` | Yes | `Entity` (AIContext), `Messages`, `Cancel` |
| `AIContextSavedNotification` | No | `Entity` (AIContext), `Messages` |
| `AIContextDeletingNotification` | Yes | `EntityId` (Guid), `Messages`, `Cancel` |
| `AIContextDeletedNotification` | No | `EntityId` (Guid), `Messages` |
| `AIContextRollingBackNotification` | Yes | `ContextId` (Guid), `TargetVersion` (int), `Messages`, `Cancel` |
| `AIContextRolledBackNotification` | No | `Context` (AIContext), `TargetVersion` (int), `Messages` |

## AIPrompt Notifications

**Namespace:** `Umbraco.AI.Prompt.Core.Prompts`

| Notification | Cancelable | Key Properties |
|---|---|---|
| `AIPromptSavingNotification` | Yes | `Entity` (AIPrompt), `Messages`, `Cancel` |
| `AIPromptSavedNotification` | No | `Entity` (AIPrompt), `Messages` |
| `AIPromptDeletingNotification` | Yes | `EntityId` (Guid), `Messages`, `Cancel` |
| `AIPromptDeletedNotification` | No | `EntityId` (Guid), `Messages` |
| `AIPromptExecutingNotification` | Yes | `Prompt` (AIPrompt), `Request` (AIPromptExecutionRequest), `Messages`, `Cancel` |
| `AIPromptExecutedNotification` | No | `Prompt` (AIPrompt), `Request` (AIPromptExecutionRequest), `Result` (AIPromptExecutionResult), `Messages` |

## AIAgent Notifications

**Namespace:** `Umbraco.AI.Agent.Core.Agents`

| Notification | Cancelable | Key Properties |
|---|---|---|
| `AIAgentSavingNotification` | Yes | `Entity` (AIAgent), `Messages`, `Cancel` |
| `AIAgentSavedNotification` | No | `Entity` (AIAgent), `Messages` |
| `AIAgentDeletingNotification` | Yes | `EntityId` (Guid), `Messages`, `Cancel` |
| `AIAgentDeletedNotification` | No | `EntityId` (Guid), `Messages` |
| `AIAgentExecutingNotification` | Yes | `Agent` (AIAgent), `Request` (AGUIRunRequest), `FrontendTools` (IEnumerable\<AIFrontendTool\>?), `Messages`, `Cancel` |
| `AIAgentExecutedNotification` | No | `Agent` (AIAgent), `Request` (AGUIRunRequest), `FrontendTools` (IEnumerable\<AIFrontendTool\>?), `Duration` (TimeSpan), `IsSuccess` (bool), `Messages` |

## AIGuardrail Notifications

**Namespace:** `Umbraco.AI.Core.Guardrails`

| Notification | Cancelable | Key Properties |
|---|---|---|
| `AIGuardrailSavingNotification` | Yes | `Entity` (AIGuardrail), `Messages`, `Cancel` |
| `AIGuardrailSavedNotification` | No | `Entity` (AIGuardrail), `Messages` |
| `AIGuardrailDeletingNotification` | Yes | `EntityId` (Guid), `Messages`, `Cancel` |
| `AIGuardrailDeletedNotification` | No | `EntityId` (Guid), `Messages` |

## AISettings Notifications

**Namespace:** `Umbraco.AI.Core.Settings`

| Notification | Cancelable | Key Properties |
|---|---|---|
| `AISettingsSavingNotification` | Yes | `Entity` (AISettings), `Messages`, `Cancel` |
| `AISettingsSavedNotification` | No | `Entity` (AISettings), `Messages` |

## Inline Chat Notifications

**Namespace:** `Umbraco.AI.Core.Chat`

| Notification | Cancelable | Key Properties |
|---|---|---|
| `AIChatExecutingNotification` | Yes | `ChatId` (Guid), `Alias` (string), `Name` (string), `ProfileId` (Guid?), `Messages`, `Cancel` |
| `AIChatExecutedNotification` | No | `ChatId` (Guid), `Alias` (string), `Name` (string), `ProfileId` (Guid?), `Duration` (TimeSpan), `IsSuccess` (bool), `Messages` |

## Registration

Register handlers in a Composer:

{% code title="NotificationComposer.cs" %}

```csharp
public class NotificationComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder
            .AddNotificationAsyncHandler<AIProfileSavingNotification, ProfileValidationHandler>()
            .AddNotificationAsyncHandler<AIProfileSavedNotification, ProfileAuditHandler>()
            .AddNotificationAsyncHandler<AIPromptExecutingNotification, PromptRateLimitHandler>()
            .AddNotificationAsyncHandler<AIAgentExecutedNotification, AgentMetricsCollector>();
    }
}
```

{% endcode %}

Handlers support constructor injection for any registered service.

## Best Practices

- **Keep handlers fast.** For expensive operations, queue background work instead of executing inline.
- **Use `Cancel` + `Messages` in Saving/Deleting handlers** to provide clear feedback. Do not throw exceptions.
- **Avoid circular dependencies** by ensuring handlers do not trigger operations that publish the same notification.
