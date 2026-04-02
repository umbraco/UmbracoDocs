---
description: >-
    Service for managing and running agents.
---

# IAIAgentService

Service for agent CRUD operations and streaming execution.

## Namespace

```csharp
using Umbraco.AI.Agent.Core.Agents;
```

## Interface

{% code title="IAIAgentService" %}

```csharp
public interface IAIAgentService
{
    Task<AIAgent?> GetAgentAsync(Guid id, CancellationToken cancellationToken = default);

    Task<AIAgent?> GetAgentByAliasAsync(string alias, CancellationToken cancellationToken = default);

    Task<IEnumerable<AIAgent>> GetAgentsAsync(CancellationToken cancellationToken = default);

    Task<PagedModel<AIAgent>> GetAgentsPagedAsync(
        int skip = 0,
        int take = 100,
        string? filter = null,
        Guid? profileId = null,
        string? scopeId = null,
        CancellationToken cancellationToken = default);

    Task<IEnumerable<AIAgent>> GetAgentsByScopeAsync(
        string scopeId,
        CancellationToken cancellationToken = default);

    Task<AIAgent> SaveAgentAsync(AIAgent agent, CancellationToken cancellationToken = default);

    Task<bool> DeleteAgentAsync(Guid id, CancellationToken cancellationToken = default);

    Task<bool> AgentAliasExistsAsync(string alias, Guid? excludeId = null, CancellationToken cancellationToken = default);

    IAsyncEnumerable<IAGUIEvent> StreamAgentAsync(
        Guid agentId,
        AIAgentRunRequest request,
        IEnumerable<AIFrontendToolDefinition>? frontendToolDefinitions = null,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

## Methods

### GetAgentAsync

Gets an agent by its unique identifier.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `id`                | `Guid`              | The agent ID       |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: The agent if found, otherwise `null`.

### GetAgentByAliasAsync

Gets an agent by its alias.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `alias`             | `string`            | The agent alias    |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: The agent if found, otherwise `null`.

### GetAgentsAsync

Gets all agents.

**Returns**: All agents in the system.

### GetAgentsPagedAsync

Gets agents with pagination and filtering.

| Parameter           | Type                | Description                       |
| ------------------- | ------------------- | --------------------------------- |
| `skip`              | `int`               | Items to skip                     |
| `take`              | `int`               | Items to take                     |
| `filter`            | `string?`           | Filter by name                    |
| `profileId`         | `Guid?`             | Filter by profile                 |
| `scopeId`           | `string?`           | Filter by scope (e.g., "copilot") |
| `cancellationToken` | `CancellationToken` | Cancellation token                |

**Returns**: Paged result with items and total count.

### GetAgentsByScopeAsync

Gets all agents belonging to a specific scope.

| Parameter           | Type                | Description               |
| ------------------- | ------------------- | ------------------------- |
| `scopeId`           | `string`            | The scope ID to filter by |
| `cancellationToken` | `CancellationToken` | Cancellation token        |

**Returns**: All agents with the specified scope.

### SaveAgentAsync

Creates or updates an agent.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `agent`             | `AIAgent`           | The agent to save  |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: The saved agent with ID and version.

### DeleteAgentAsync

Deletes an agent by ID.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `id`                | `Guid`              | The agent ID       |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: `true` if deleted, `false` if not found.

### AgentAliasExistsAsync

Checks if an alias is in use.

| Parameter           | Type                | Description            |
| ------------------- | ------------------- | ---------------------- |
| `alias`             | `string`            | The alias to check     |
| `excludeId`         | `Guid?`             | Optional ID to exclude |
| `cancellationToken` | `CancellationToken` | Cancellation token     |

**Returns**: `true` if alias exists.

### StreamAgentAsync

Runs an agent and streams AG-UI events.

| Parameter                 | Type                                     | Description        |
| ------------------------- | ---------------------------------------- | ------------------ |
| `agentId`                 | `Guid`                                   | The agent ID       |
| `request`                 | `AIAgentRunRequest`                      | Run parameters     |
| `frontendToolDefinitions` | `IEnumerable<AIFrontendToolDefinition>?` | Frontend tools     |
| `cancellationToken`       | `CancellationToken`                      | Cancellation token |

**Returns**: Async enumerable of AG-UI events.

{% code title="StreamAgentAsync.cs" %}

```csharp
await foreach (var evt in _agentService.StreamAgentAsync(
    agentId,
    new AIAgentRunRequest
    {
        Messages = new List<AIAgentMessage>
        {
            new AIAgentMessage { Role = "user", Content = "Hello!" }
        }
    }))
{
    switch (evt)
    {
        case AGUITextMessageContentEvent textEvt:
            Console.Write(textEvt.Content);
            break;
        case AGUIRunFinishedEvent:
            Console.WriteLine("\nDone!");
            break;
    }
}
```

{% endcode %}

### SelectAgentForPromptAsync

Selects the best agent for a user prompt from a given surface. When multiple agents are available, uses an LLM classifier to determine the best match.

| Parameter           | Type                       | Description                              |
| ------------------- | -------------------------- | ---------------------------------------- |
| `userPrompt`        | `string`                   | The user's message                       |
| `surfaceId`         | `string`                   | The surface to search for agents         |
| `context`           | `AgentAvailabilityContext`  | Context for agent availability filtering |
| `cancellationToken` | `CancellationToken`        | Cancellation token                       |

**Returns**: The selected agent, or `null` if no agents are available.

**Behavior**:

- Returns `null` if no active agents are available on the surface
- Returns the single agent directly if only one is available (no LLM call)
- Uses the **classifier chat profile** (falls back to default chat profile) when multiple agents need classification
- Falls back to the first available agent if classification fails

See [Settings](../../../concepts/settings.md#classifier-chat-profile) for configuring the classifier profile.

## Related Models

### AIAgentRunRequest

{% code title="AIAgentRunRequest" %}

```csharp
public class AIAgentRunRequest
{
    public IReadOnlyList<AIAgentMessage> Messages { get; set; } = Array.Empty<AIAgentMessage>();
}
```

{% endcode %}

### AIAgentMessage

{% code title="AIAgentMessage" %}

```csharp
public class AIAgentMessage
{
    public string Role { get; set; } = "user";
    public string Content { get; set; } = string.Empty;
}
```

{% endcode %}

### AIFrontendToolDefinition

{% code title="AIFrontendToolDefinition" %}

```csharp
public class AIFrontendToolDefinition
{
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public JsonNode? Parameters { get; set; }
}
```

{% endcode %}

## Related

- [AIAgent Model](ai-agent.md) - Agent model reference
- [Agent Concepts](../concepts.md) - Concepts overview
- [Scopes](../scopes.md) - Agent categorization
