---
description: >-
    Service for managing and running agents.
---

# IAIAgentService

Service for agent CRUD operations, running persisted agents, and creating inline agents in code.

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

    Task<(IEnumerable<AIAgent> Items, int Total)> GetAgentsPagedAsync(
        int skip,
        int take,
        string? filter = null,
        Guid? profileId = null,
        string? surfaceId = null,
        bool? isActive = null,
        AIAgentType? agentType = null,
        CancellationToken cancellationToken = default);

    Task<IEnumerable<AIAgent>> GetAgentsBySurfaceAsync(
        string surfaceId,
        CancellationToken cancellationToken = default);

    Task<AIAgent> SaveAgentAsync(AIAgent agent, CancellationToken cancellationToken = default);

    Task<bool> DeleteAgentAsync(Guid id, CancellationToken cancellationToken = default);

    Task<bool> AgentAliasExistsAsync(
        string alias,
        Guid? excludeId = null,
        CancellationToken cancellationToken = default);

    Task<bool> AgentsExistWithProfileAsync(
        Guid profileId,
        CancellationToken cancellationToken = default);

    Task<IReadOnlyList<string>> GetAllowedToolIdsAsync(
        AIAgent agent,
        IEnumerable<Guid>? userGroupIds = null,
        CancellationToken cancellationToken = default);

    Task<bool> IsToolAllowedAsync(
        AIAgent agent,
        string toolId,
        IEnumerable<Guid>? userGroupIds = null,
        CancellationToken cancellationToken = default);

    Task<AIAgent?> SelectAgentForPromptAsync(
        string userPrompt,
        string surfaceId,
        AgentAvailabilityContext context,
        CancellationToken cancellationToken = default);

    Task<AgentResponse> RunAgentAsync(
        Guid agentId,
        IEnumerable<ChatMessage> messages,
        AIAgentExecutionOptions? options = null,
        CancellationToken cancellationToken = default);

    Task<AgentResponse> RunAgentAsync(
        string agentAlias,
        IEnumerable<ChatMessage> messages,
        AIAgentExecutionOptions? options = null,
        CancellationToken cancellationToken = default);

    IAsyncEnumerable<AgentResponseUpdate> StreamAgentAsync(
        Guid agentId,
        IEnumerable<ChatMessage> messages,
        AIAgentExecutionOptions? options = null,
        CancellationToken cancellationToken = default);

    IAsyncEnumerable<AgentResponseUpdate> StreamAgentAsync(
        string agentAlias,
        IEnumerable<ChatMessage> messages,
        AIAgentExecutionOptions? options = null,
        CancellationToken cancellationToken = default);

    IAsyncEnumerable<IAGUIEvent> StreamAgentAGUIAsync(
        Guid agentId,
        AGUIRunRequest request,
        IEnumerable<AIFrontendTool>? frontendTools,
        CancellationToken cancellationToken = default);

    IAsyncEnumerable<IAGUIEvent> StreamAgentAGUIAsync(
        Guid agentId,
        AGUIRunRequest request,
        IEnumerable<AIFrontendTool>? frontendTools,
        AIAgentExecutionOptions options,
        CancellationToken cancellationToken = default);

    Task<Microsoft.Agents.AI.AIAgent> CreateInlineAgentAsync(
        Action<AIInlineAgentBuilder> configure,
        CancellationToken cancellationToken = default);

    Task<AgentResponse> RunAgentAsync(
        Action<AIInlineAgentBuilder> configure,
        IEnumerable<ChatMessage> messages,
        CancellationToken cancellationToken = default);

    IAsyncEnumerable<AgentResponseUpdate> StreamAgentAsync(
        Action<AIInlineAgentBuilder> configure,
        IEnumerable<ChatMessage> messages,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

## Read methods

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

Gets a paged list of agents with optional filtering.

| Parameter           | Type                | Description                              |
| ------------------- | ------------------- | ---------------------------------------- |
| `skip`              | `int`               | Items to skip                            |
| `take`              | `int`               | Items to take                            |
| `filter`            | `string?`           | Filter by name or alias                  |
| `profileId`         | `Guid?`             | Filter by profile                        |
| `surfaceId`         | `string?`           | Filter by surface (e.g., "copilot")      |
| `isActive`          | `bool?`             | Filter by active status                  |
| `agentType`         | `AIAgentType?`      | Filter by agent type                     |
| `cancellationToken` | `CancellationToken` | Cancellation token                       |

**Returns**: A tuple `(IEnumerable<AIAgent> Items, int Total)` with the matching agents and the total count for the filter.

### GetAgentsBySurfaceAsync

Gets all agents that belong to a specific surface (categorization).

| Parameter           | Type                | Description                 |
| ------------------- | ------------------- | --------------------------- |
| `surfaceId`         | `string`            | The surface ID to filter by |
| `cancellationToken` | `CancellationToken` | Cancellation token          |

**Returns**: Agents that have the specified surface ID in their `SurfaceIds`.

## Write methods

### SaveAgentAsync

Creates or updates an agent (insert if `Id == Guid.Empty`, otherwise update) with validation.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `agent`             | `AIAgent`           | The agent to save  |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: The saved agent with its assigned ID and incremented `Version`.

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

### AgentsExistWithProfileAsync

Checks whether any agents reference the specified profile.

| Parameter           | Type                | Description                  |
| ------------------- | ------------------- | ---------------------------- |
| `profileId`         | `Guid`              | The profile ID to check      |
| `cancellationToken` | `CancellationToken` | Cancellation token           |

**Returns**: `true` if one or more agents reference the profile.

## Permission methods

### GetAllowedToolIdsAsync

Gets the tool IDs allowed for the specified agent. Includes system tools plus user tools that match the agent's configuration. If user group IDs are supplied, per-user-group overrides are applied.

| Parameter           | Type                  | Description                                                              |
| ------------------- | --------------------- | ------------------------------------------------------------------------ |
| `agent`             | `AIAgent`             | The agent                                                                |
| `userGroupIds`      | `IEnumerable<Guid>?`  | Optional user group IDs. If `null`, uses the current BackOffice user's groups. |
| `cancellationToken` | `CancellationToken`   | Cancellation token                                                       |

**Returns**: Collection of allowed tool IDs.

### IsToolAllowedAsync

Validates that a specific tool call is permitted for the agent.

| Parameter           | Type                  | Description                                                              |
| ------------------- | --------------------- | ------------------------------------------------------------------------ |
| `agent`             | `AIAgent`             | The agent                                                                |
| `toolId`            | `string`              | The tool ID being called                                                 |
| `userGroupIds`      | `IEnumerable<Guid>?`  | Optional user group IDs. If `null`, uses the current BackOffice user's groups. |
| `cancellationToken` | `CancellationToken`   | Cancellation token                                                       |

**Returns**: `true` if the tool is allowed, otherwise `false`.

## Selection and execution

### SelectAgentForPromptAsync

Selects the best agent for a user prompt from agents available in the given surface and context. When multiple agents are available, uses an LLM classifier to choose one.

| Parameter           | Type                       | Description                              |
| ------------------- | -------------------------- | ---------------------------------------- |
| `userPrompt`        | `string`                   | The user's message                       |
| `surfaceId`         | `string`                   | The surface to search (e.g., `"copilot"`) |
| `context`           | `AgentAvailabilityContext` | Context for scope-based filtering        |
| `cancellationToken` | `CancellationToken`        | Cancellation token                       |

**Returns**: The selected agent, or `null` if no agents are available.

**Behavior**:

- Returns `null` if no active agents are available on the surface for the context.
- Returns the single agent directly if only one is available (no LLM call).
- Uses the **classifier chat profile** (falls back to default chat profile) when multiple agents need classification.
- Falls back to the first available agent if classification fails.

See [Settings](../../../concepts/settings.md#classifier-chat-profile) for configuring the classifier profile.

### RunAgentAsync (persisted agent, by ID)

Runs a persisted agent for a one-shot execution, publishing execution notifications.

| Parameter           | Type                         | Description                                  |
| ------------------- | ---------------------------- | -------------------------------------------- |
| `agentId`           | `Guid`                       | The agent ID                                 |
| `messages`          | `IEnumerable<ChatMessage>`   | The chat messages (from `Microsoft.Extensions.AI`) |
| `options`           | `AIAgentExecutionOptions?`   | Optional overrides (profile, context, guardrails) |
| `cancellationToken` | `CancellationToken`          | Cancellation token                           |

**Returns**: An `AgentResponse`.

### RunAgentAsync (persisted agent, by alias)

Same as above but resolves the agent by its alias.

### StreamAgentAsync (persisted agent)

Streams a persisted agent execution using `Microsoft.Extensions.AI` types.

| Parameter           | Type                         | Description                                  |
| ------------------- | ---------------------------- | -------------------------------------------- |
| `agentId` / `agentAlias` | `Guid` / `string`       | The agent ID or alias                        |
| `messages`          | `IEnumerable<ChatMessage>`   | The chat messages                            |
| `options`           | `AIAgentExecutionOptions?`   | Optional overrides                           |
| `cancellationToken` | `CancellationToken`          | Cancellation token                           |

**Returns**: `IAsyncEnumerable<AgentResponseUpdate>`.

### StreamAgentAGUIAsync

Streams a persisted agent execution as AG-UI events for use with the AG-UI protocol (Copilot sidebar, custom AG-UI clients).

| Parameter           | Type                              | Description                                             |
| ------------------- | --------------------------------- | ------------------------------------------------------- |
| `agentId`           | `Guid`                            | The agent ID                                            |
| `request`           | `AGUIRunRequest`                  | AG-UI run request (messages, tools, context, state)     |
| `frontendTools`     | `IEnumerable<AIFrontendTool>?`    | Frontend tools with scope and destructiveness metadata  |
| `options`           | `AIAgentExecutionOptions`         | (Overload) Execution options for overrides              |
| `cancellationToken` | `CancellationToken`               | Cancellation token                                      |

**Returns**: `IAsyncEnumerable<IAGUIEvent>`.

{% code title="StreamAgentAGUIAsync.cs" %}

```csharp
var request = new AGUIRunRequest
{
    ThreadId = Guid.NewGuid().ToString(),
    RunId = Guid.NewGuid().ToString(),
    Messages =
    [
        new AGUIMessage
        {
            Id = Guid.NewGuid().ToString(),
            Role = AGUIMessageRole.User,
            Content = "Hello!"
        }
    ]
};

await foreach (var evt in _agentService.StreamAgentAGUIAsync(
    agentId,
    request,
    frontendTools: null,
    cancellationToken))
{
    switch (evt)
    {
        case AGUITextMessageContentEvent textEvt:
            Console.Write(textEvt.Delta);
            break;
        case AGUIRunFinishedEvent:
            Console.WriteLine("\nDone!");
            break;
    }
}
```

{% endcode %}

## Inline agents

Inline agents run purely in code without being persisted or managed through the backoffice, while still participating in the full middleware pipeline (auditing, tracking, guardrails, telemetry).

### CreateInlineAgentAsync

Creates a reusable inline agent configured via a builder.

| Parameter           | Type                              | Description                              |
| ------------------- | --------------------------------- | ---------------------------------------- |
| `configure`         | `Action<AIInlineAgentBuilder>`    | Builder configuration                    |
| `cancellationToken` | `CancellationToken`               | Cancellation token                       |

**Returns**: A `Microsoft.Agents.AI.AIAgent` ready for `RunAsync` / `RunStreamingAsync`.

{% hint style="info" %}
Calling `RunAsync` / `RunStreamingAsync` directly on the returned agent does not publish `AIAgentExecutingNotification` or `AIAgentExecutedNotification`. Use the `RunAgentAsync` or `StreamAgentAsync` inline overloads below for notification support.
{% endhint %}

### RunAgentAsync (inline)

Convenience method that creates the inline agent, publishes notifications, and runs a one-shot execution.

| Parameter           | Type                              | Description                              |
| ------------------- | --------------------------------- | ---------------------------------------- |
| `configure`         | `Action<AIInlineAgentBuilder>`    | Builder configuration                    |
| `messages`          | `IEnumerable<ChatMessage>`        | The chat messages                        |
| `cancellationToken` | `CancellationToken`               | Cancellation token                       |

**Returns**: `AgentResponse`.

### StreamAgentAsync (inline)

Streams an inline agent execution with notification publishing.

| Parameter           | Type                              | Description                              |
| ------------------- | --------------------------------- | ---------------------------------------- |
| `configure`         | `Action<AIInlineAgentBuilder>`    | Builder configuration                    |
| `messages`          | `IEnumerable<ChatMessage>`        | The chat messages                        |
| `cancellationToken` | `CancellationToken`               | Cancellation token                       |

**Returns**: `IAsyncEnumerable<AgentResponseUpdate>`.

{% code title="Inline agent example" %}

```csharp
var response = await _agentService.RunAgentAsync(
    agent => agent
        .WithAlias("my-summarizer")
        .WithInstructions("Summarize the provided content concisely.")
        .WithToolScopes("content-read")
        .WithProfile("my-chat-profile"),
    new[] { new ChatMessage(ChatRole.User, "Summarize this article...") },
    cancellationToken);
```

{% endcode %}

## Related models

### AIFrontendTool

{% code title="AIFrontendTool" %}

```csharp
public record AIFrontendTool(
    AGUITool Tool,
    string? Scope,
    bool IsDestructive);
```

{% endcode %}

Combines the AG-UI tool definition (`AGUITool`) with Umbraco-specific metadata used for permission filtering and human-in-the-loop prompting.

### AIAgentUserGroupPermissions

{% code title="AIAgentUserGroupPermissions" %}

```csharp
public sealed class AIAgentUserGroupPermissions
{
    public IReadOnlyList<string> AllowedToolIds { get; set; } = [];
    public IReadOnlyList<string> AllowedToolScopeIds { get; set; } = [];
    public IReadOnlyList<string> DeniedToolIds { get; set; } = [];
    public IReadOnlyList<string> DeniedToolScopeIds { get; set; } = [];
}
```

{% endcode %}

Stored on `AIStandardAgentConfig.UserGroupPermissions`, keyed by user group ID. The user group ID is the dictionary key, not a property on this type. Deny entries take precedence over allow entries.

### AIAgentExecutionOptions

{% code title="AIAgentExecutionOptions" %}

```csharp
public class AIAgentExecutionOptions
{
    public Guid? ProfileIdOverride { get; init; }
    public IReadOnlyList<Guid>? ContextIdsOverride { get; init; }
    public IReadOnlyList<Guid>? GuardrailIdsOverride { get; init; }
    public IEnumerable<AIRequestContextItem>? ContextItems { get; init; }
    public IEnumerable<Guid>? UserGroupIds { get; init; }
    public AIOutputSchema? OutputSchema { get; init; }
}
```

{% endcode %}

## Related

- [AIAgent Model](ai-agent.md) - Agent model reference
- [Agent Concepts](../concepts.md) - Concepts overview
- [Scopes](../scopes.md) - Agent availability rules
- [Permissions](../permissions.md) - Tool permissions and user group overrides
