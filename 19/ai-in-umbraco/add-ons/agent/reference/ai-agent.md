---
description: >-
    Model representing an AI agent.
---

# AIAgent

Represents a configured AI agent. Agents come in two types: **Standard** (single agent with instructions and tools) and **Orchestrated** (multi-agent workflow).

## Namespace

```csharp
using Umbraco.AI.Agent.Core.Agents;
```

## Definition

{% code title="AIAgent" %}

```csharp
public sealed class AIAgent : IAIVersionableEntity
{
    public Guid Id { get; internal set; }
    public required string Alias { get; set; }
    public required string Name { get; set; }
    public string? Description { get; set; }
    public AIAgentType AgentType { get; init; } = AIAgentType.Standard;
    public IAIAgentConfig? Config { get; set; }
    public Guid? ProfileId { get; set; }
    public IReadOnlyList<Guid> GuardrailIds { get; set; } = [];
    public IReadOnlyList<string> SurfaceIds { get; set; } = [];
    public AIAgentScope? Scope { get; set; }
    public bool IsActive { get; set; } = true;

    // Audit properties
    public DateTime DateCreated { get; set; } = DateTime.UtcNow;
    public DateTime DateModified { get; set; } = DateTime.UtcNow;
    public Guid? CreatedByUserId { get; set; }
    public Guid? ModifiedByUserId { get; set; }

    // Versioning
    public int Version { get; internal set; } = 1;
}
```

{% endcode %}

## Properties

| Property         | Type                    | Description                                      |
| ---------------- | ----------------------- | ------------------------------------------------ |
| `Id`             | `Guid`                  | Unique identifier                                |
| `Alias`          | `string`                | Unique alias for code references (required)      |
| `Name`           | `string`                | Display name (required)                          |
| `Description`    | `string?`               | Optional description                             |
| `AgentType`      | `AIAgentType`           | `Standard` or `Orchestrated` (immutable)         |
| `Config`         | `IAIAgentConfig?`       | Type-specific configuration (see below)          |
| `ProfileId`      | `Guid?`                 | Associated AI profile (null uses default)        |
| `GuardrailIds`   | `IReadOnlyList<Guid>`   | Guardrails applied during agent execution        |
| `SurfaceIds`     | `IReadOnlyList<string>` | Surface IDs for categorization                   |
| `Scope`          | `AIAgentScope?`         | Optional scoping rules                           |
| `IsActive`       | `bool`                  | Whether agent is available                       |
| `DateCreated`    | `DateTime`              | When created                                     |
| `DateModified`   | `DateTime`              | When last modified                               |
| `Version`        | `int`                   | Current version number                           |

## Agent Types

{% code title="AIAgentType" %}

```csharp
public enum AIAgentType
{
    Standard = 0,
    Orchestrated = 1,
}
```

{% endcode %}

## Configuration

The `Config` property holds type-specific configuration. Use the extension methods to access the typed config:

```csharp
using Umbraco.AI.Agent.Core.Agents;

// For standard agents
AIStandardAgentConfig? standardConfig = agent.GetStandardConfig();

// For orchestrated agents
AIOrchestratedAgentConfig? orchestratedConfig = agent.GetOrchestratedConfig();
```

### Standard Agent Config

{% code title="AIStandardAgentConfig" %}

```csharp
public sealed class AIStandardAgentConfig : IAIAgentConfig
{
    public IReadOnlyList<Guid> ContextIds { get; set; } = [];
    public string? Instructions { get; set; }
    public IReadOnlyList<string> AllowedToolIds { get; set; } = [];
    public IReadOnlyList<string> AllowedToolScopeIds { get; set; } = [];
    public JsonElement? OutputSchema { get; set; }
    public IReadOnlyDictionary<Guid, AIAgentUserGroupPermissions> UserGroupPermissions { get; set; }
        = new Dictionary<Guid, AIAgentUserGroupPermissions>();
}
```

{% endcode %}

| Property               | Type                                                   | Description                         |
| ---------------------- | ------------------------------------------------------ | ----------------------------------- |
| `ContextIds`           | `IReadOnlyList<Guid>`                                  | AI Contexts to inject               |
| `Instructions`         | `string?`                                              | Agent system prompt                 |
| `AllowedToolIds`       | `IReadOnlyList<string>`                                | Explicit tool permissions           |
| `AllowedToolScopeIds`  | `IReadOnlyList<string>`                                | Scope-based tool permissions        |
| `OutputSchema`         | `JsonElement?`                                         | Optional JSON Schema to constrain the agent's output |
| `UserGroupPermissions` | `IReadOnlyDictionary<Guid, AIAgentUserGroupPermissions>` | Per-user-group permission overrides |

### Orchestrated Agent Config

{% code title="AIOrchestratedAgentConfig" %}

```csharp
public sealed class AIOrchestratedAgentConfig : IAIAgentConfig
{
    public string? WorkflowId { get; set; }
    public JsonElement? Settings { get; set; }
}
```

{% endcode %}

| Property     | Type            | Description                            |
| ------------ | --------------- | -------------------------------------- |
| `WorkflowId` | `string?`       | ID of the registered workflow          |
| `Settings`   | `JsonElement?`  | Workflow-specific settings (JSON)      |

## Examples

### Standard Agent

{% code title="Standard Agent Example" %}

```csharp
var agent = new AIAgent
{
    Alias = "content-assistant",
    Name = "Content Assistant",
    Description = "Helps users write and improve content",
    AgentType = AIAgentType.Standard,
    ProfileId = chatProfileId,
    SurfaceIds = ["copilot"],
    Config = new AIStandardAgentConfig
    {
        Instructions = @"You are a helpful content assistant.

Your role is to help users write and improve content for the website.

Guidelines:
- Be concise and helpful
- Maintain the brand voice
- Ask clarifying questions when needed",
        ContextIds = [brandVoiceContextId],
        AllowedToolScopeIds = ["content-read", "search"],
    },
    IsActive = true
};

var saved = await _agentService.SaveAgentAsync(agent);
```

{% endcode %}

### Orchestrated Agent

{% code title="Orchestrated Agent Example" %}

```csharp
var agent = new AIAgent
{
    Alias = "write-and-edit",
    Name = "Write and Edit Pipeline",
    Description = "Drafts content then edits it for clarity",
    AgentType = AIAgentType.Orchestrated,
    ProfileId = chatProfileId,
    SurfaceIds = ["copilot"],
    Config = new AIOrchestratedAgentConfig
    {
        WorkflowId = "write-and-edit",
        Settings = JsonSerializer.SerializeToElement(new
        {
            writingStyle = "professional",
            editingFocus = "clarity and conciseness"
        })
    },
    IsActive = true
};

var saved = await _agentService.SaveAgentAsync(agent);
```

{% endcode %}

## Related

- [IAIAgentService](ai-agent-service.md) - Agent service
- [Agent Concepts](../concepts.md) - Agent types and concepts
- [Instructions](../instructions.md) - Standard agent instructions
- [Workflows](../workflows.md) - Orchestrated agent workflows
- [Scopes](../scopes.md) - Agent categorization
