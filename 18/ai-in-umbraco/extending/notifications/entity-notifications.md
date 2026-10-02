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
| **AIGuardrail** | ✅ | ✅ | - |
| **AITest** | ✅ | ✅ | - |
| **AISettings** | ✅ (Save only) | - | - |
| **AIPrompt** | ✅ | - | ✅ |
| **AIAgent** | ✅ | - | ✅ |
| **AIChat** (Inline) | - | - | ✅ |
| **AISpeechToText** (Inline) | - | - | ✅ |
| **AIEmbedding** (Inline) | - | - | ✅ |
| **AITool** | - | - | ✅ |

`AIAgent` also publishes `AIAgentSelectedNotification` when Auto mode picks an agent. For details, see [Agent Selection Notifications](#agent-selection-notifications).

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

        // Validate temperature range for chat profiles
        if (profile.Settings is AIChatProfileSettings chatSettings &&
            chatSettings.Temperature.HasValue &&
            (chatSettings.Temperature < 0 || chatSettings.Temperature > 2))
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
| `AIAgentExecutingNotification` | Yes | `Agent` (AIAgent), `ChatMessages` (IReadOnlyList\<ChatMessage\>), `Messages`, `Cancel` |
| `AIAgentExecutedNotification` | No | `Agent` (AIAgent), `ChatMessages` (IReadOnlyList\<ChatMessage\>), `Duration` (TimeSpan), `IsSuccess` (bool), `Messages` |
| `AIAgentSelectedNotification` | No | `Selection` (AIAgentSelectionResult), `Request` (AIAgentSelectionRequest), `Messages` |

## Agent Selection Notifications

### AIAgentSelectedNotification (Non-Cancelable)

**Namespace:** `Umbraco.AI.Agent.Core.Agents`

Published after [Auto mode](../agent-selection.md) picks an agent, and before the agent run starts. Every Auto pick publishes exactly one notification, including picks with the `only-candidate` and `fallback` selector IDs. The notification is not published for requests that name an agent explicitly.

**Properties:**
- `Selection` (AIAgentSelectionResult) - The picked `Agent`, the `SelectorId`, and the optional `Reason`
- `Request` (AIAgentSelectionRequest) - The request exactly as the selectors saw it
- `Messages` (EventMessages) - Event messages from the selection

{% hint style="info" %}
Selected does not mean ran. `AIAgentExecutingNotification` is published afterwards and can still cancel the run.
{% endhint %}

**Example:**

{% code title="AgentSelectedHandler.cs" %}

```csharp
using Microsoft.Extensions.Logging;
using Umbraco.AI.Agent.Core.Agents;
using Umbraco.AI.Agent.Core.Agents.Selection;
using Umbraco.Cms.Core.Events;

namespace MyProject.AI;

public class AgentSelectedHandler : INotificationAsyncHandler<AIAgentSelectedNotification>
{
    private readonly ILogger<AgentSelectedHandler> _logger;

    public AgentSelectedHandler(ILogger<AgentSelectedHandler> logger) => _logger = logger;

    public Task HandleAsync(AIAgentSelectedNotification notification, CancellationToken ct)
    {
        // Track how often no selector could decide
        if (notification.Selection.SelectorId == AIAgentSelectorIds.Fallback)
        {
            _logger.LogInformation(
                "No selector picked an agent on surface {SurfaceId}. Used {AgentAlias}.",
                notification.Request.SurfaceId,
                notification.Selection.Agent.Alias);
        }

        return Task.CompletedTask;
    }
}
```

{% endcode %}

## AIGuardrail Notifications

**Namespace:** `Umbraco.AI.Core.Guardrails`

| Notification | Cancelable | Key Properties |
|---|---|---|
| `AIGuardrailSavingNotification` | Yes | `Entity` (AIGuardrail), `Messages`, `Cancel` |
| `AIGuardrailSavedNotification` | No | `Entity` (AIGuardrail), `Messages` |
| `AIGuardrailDeletingNotification` | Yes | `EntityId` (Guid), `Messages`, `Cancel` |
| `AIGuardrailDeletedNotification` | No | `EntityId` (Guid), `Messages` |
| `AIGuardrailRollingBackNotification` | Yes | `GuardrailId` (Guid), `TargetVersion` (int), `Messages`, `Cancel` |
| `AIGuardrailRolledBackNotification` | No | `Guardrail` (AIGuardrail), `TargetVersion` (int), `Messages` |

## AITest Notifications

**Namespace:** `Umbraco.AI.Core.Tests`

| Notification | Cancelable | Key Properties |
|---|---|---|
| `AITestSavingNotification` | Yes | `Entity` (AITest), `Messages`, `Cancel` |
| `AITestSavedNotification` | No | `Entity` (AITest), `Messages` |
| `AITestDeletingNotification` | Yes | `EntityId` (Guid), `Messages`, `Cancel` |
| `AITestDeletedNotification` | No | `EntityId` (Guid), `Messages` |
| `AITestRollingBackNotification` | Yes | `TestId` (Guid), `TargetVersion` (int), `Messages`, `Cancel` |
| `AITestRolledBackNotification` | No | `TestId` (Guid), `TargetVersion` (int), `Messages` |

{% hint style="info" %}
The `AITestRollingBackNotification` and `AITestRolledBackNotification` expose only `TestId` (not the full entity) because rollback operates on version identifiers. Use `IAITestService` to resolve the test if you need more details.
{% endhint %}

## AISettings Notifications

**Namespace:** `Umbraco.AI.Core.Settings`

| Notification | Cancelable | Key Properties |
|---|---|---|
| `AISettingsSavingNotification` | Yes | `Entity` (AISettings), `Messages`, `Cancel` |
| `AISettingsSavedNotification` | No | `Entity` (AISettings), `Messages` |

## Inline Chat Notifications

**Namespace:** `Umbraco.AI.Core.InlineChat`

| Notification | Cancelable | Key Properties |
|---|---|---|
| `AIChatExecutingNotification` | Yes | `ChatId` (Guid), `Alias` (string), `Name` (string), `ProfileId` (Guid?), `Messages`, `Cancel` |
| `AIChatExecutedNotification` | No | `ChatId` (Guid), `Alias` (string), `Name` (string), `ProfileId` (Guid?), `Duration` (TimeSpan), `IsSuccess` (bool), `Messages` |

## Inline Speech-to-Text Notifications

**Namespace:** `Umbraco.AI.Core.SpeechToText`

| Notification | Cancelable | Key Properties |
|---|---|---|
| `AISpeechToTextExecutingNotification` | Yes | `TranscriptionId` (Guid), `Alias` (string), `Name` (string), `ProfileId` (Guid?), `Messages`, `Cancel` |
| `AISpeechToTextExecutedNotification` | No | `TranscriptionId` (Guid), `Alias` (string), `Name` (string), `ProfileId` (Guid?), `Duration` (TimeSpan), `IsSuccess` (bool), `Messages` |

## Inline Embedding Notifications

**Namespace:** `Umbraco.AI.Core.Embeddings`

| Notification | Cancelable | Key Properties |
|---|---|---|
| `AIEmbeddingExecutingNotification` | Yes | `EmbeddingId` (Guid), `Alias` (string), `Name` (string), `ProfileId` (Guid?), `Messages`, `Cancel` |
| `AIEmbeddingExecutedNotification` | No | `EmbeddingId` (Guid), `Alias` (string), `Name` (string), `ProfileId` (Guid?), `Duration` (TimeSpan), `IsSuccess` (bool), `Messages` |

## Tool Execution Notifications

**Namespace:** `Umbraco.AI.Core.Tools`

Published around each tool call the model makes through the chat pipeline. These notifications cover inline chat, agents, prompts, and Automate.

| Notification | Cancelable | Key Properties |
|---|---|---|
| `AIToolExecutingNotification` | Yes | `ToolName` (string), `Function` (AIFunction), `Tool` (IAITool?), `CallId` (string), `Arguments` (IReadOnlyDictionary\<string, object?\>), `RuntimeContext` (AIRuntimeContext?), `Messages`, `Cancel` |
| `AIToolExecutedNotification` | No | `ToolName`, `Function`, `Tool`, `CallId`, `Arguments`, `RuntimeContext`, `Duration` (TimeSpan), `IsSuccess` (bool), `Result` (object?), `Exception` (Exception?), `Messages` |

`ToolName` is the tool ID for Umbraco tools. `Tool` is `null` when the function is not an Umbraco `IAITool`, for example a frontend tool.

When each notification is published:

- **Backend tools** publish `AIToolExecutingNotification` before the tool runs and `AIToolExecutedNotification` after it runs. `AIToolExecutedNotification` is also published when the tool throws, with `IsSuccess` set to `false` and the `Exception` set.
- **Frontend tools** publish `AIToolExecutingNotification` only, before the call is handed to the browser. The result arrives in a later request.
- **Tools that need approval** publish `AIToolExecutingNotification` when the approved tool runs, so a handler can still block the tool at that point.
- **Tools denied by an approval policy** publish neither notification, because the tool never runs.

### Blocking a Tool Call

Set `Cancel = true` in an `AIToolExecutingNotification` handler to block the call. The tool does not run, and `AIToolExecutedNotification` is not published. Instead of failing the run, the model receives a tool result saying the call was blocked. The run then continues.

{% hint style="warning" %}
Messages you add to `Messages` are included in the blocked tool result as the reason. The reason is **sent to the model**, so keep it free of sensitive details.
{% endhint %}

The following handler blocks the built-in `fetch_webpage` tool for sites that do not allow outbound web requests:

{% code title="BlockWebFetchHandler.cs" %}

```csharp
using Umbraco.AI.Core.Tools;
using Umbraco.Cms.Core.Events;

namespace MyProject.AI;

public class BlockWebFetchHandler : INotificationAsyncHandler<AIToolExecutingNotification>
{
    public Task HandleAsync(AIToolExecutingNotification notification, CancellationToken ct)
    {
        if (notification.ToolName == "fetch_webpage")
        {
            notification.Cancel = true;

            // This message is sent to the model as the reason for the block
            notification.Messages.Add(new EventMessage(
                "Policy",
                "Fetching web pages is disabled on this site.",
                EventMessageType.Error));
        }

        return Task.CompletedTask;
    }
}
```

{% endcode %}

The model receives the following tool result: `The 'fetch_webpage' tool was blocked and was not run. Reason: Fetching web pages is disabled on this site.`

## Base Notification Classes

Most Save/Delete notifications inherit from generic base classes defined in the `Umbraco.AI.Core.Models.Notifications` namespace. You can use these base types to write cross-entity handlers (for example, an audit logger that reacts to every entity save).

| Base Class | Kind | Key Properties |
|---|---|---|
| `AIEntitySavingNotification<T>` | Cancelable | `Entity` (T), `Messages`, `Cancel` |
| `AIEntitySavedNotification<T>` | Stateful | `Entity` (T), `Messages` |
| `AIEntityDeletingNotification<T>` | Cancelable | `EntityId` (Guid), `Messages`, `Cancel` |
| `AIEntityDeletedNotification<T>` | Stateful | `EntityId` (Guid), `Messages` |

For example, `AIProfileSavingNotification` is declared as `AIEntitySavingNotification<AIProfile>` and inherits the `Entity`, `Messages`, and `Cancel` members from the base class.

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
