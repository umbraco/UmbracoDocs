---
description: >-
    Core concepts for Agent Runtime.
---

# Agent Concepts

## What is an Agent?

An agent is a configured AI assistant that can:

- **Follow instructions** - Custom system prompts defining behavior
- **Stream responses** - Real-time text generation via SSE
- **Call tools** - Execute functions during conversation
- **Maintain context** - Include brand voice and guidelines
- **Orchestrate workflows** - Compose multiple agents into pipelines

## Agent Types

Every agent has an **agent type** that determines its configuration shape and behavior. The agent type is set at creation and cannot be changed.

### Standard Agent

A **standard agent** is a single AI agent with instructions, context injection, and tool permissions. This is the default agent type and is suitable for most use cases.

Standard agents have:
- Custom instructions (system prompt)
- AI Context injection for brand voice
- Guardrails for safety and compliance
- Fine-grained tool permissions (scope-based and explicit)
- User group permission overrides

### Orchestrated Agent

An **orchestrated agent** composes multiple agents into a workflow graph using a registered [workflow](workflows.md). Instead of instructions and tools, orchestrated agents reference a workflow implementation that defines how sub-agents collaborate.

Orchestrated agents have:
- A workflow ID referencing a registered workflow implementation
- Optional workflow-specific settings (configured in the backoffice)

{% hint style="info" %}
Workflows are code-based extension points. See [Creating Workflows](workflows.md) for how to build custom workflows.
{% endhint %}

## Agent Properties

### Common Properties

These properties are shared by all agent types:

| Property      | Description                                 |
| ------------- | ------------------------------------------- |
| `Alias`       | Unique identifier for code references       |
| `Name`        | Display name in the backoffice              |
| `Description` | Optional description                        |
| `AgentType`   | `Standard` or `Orchestrated` (immutable)    |
| `ProfileId`   | Associated AI profile (or uses default)     |
| `SurfaceIds`  | Surface IDs for categorization (e.g., "copilot") |
| `Scope`       | Optional scoping rules (sections, entity types) |
| `GuardrailIds`| Guardrails applied during agent execution   |
| `IsActive`    | Whether the agent is available              |

### Standard Agent Configuration

| Property               | Description                                    |
| ---------------------- | ---------------------------------------------- |
| `Instructions`         | System prompt defining agent behavior          |
| `ContextIds`           | AI Contexts to inject                          |
| `AllowedToolIds`       | Explicit tool permissions                      |
| `AllowedToolScopeIds`  | Scope-based tool permissions                   |
| `UserGroupPermissions` | Per-user-group permission overrides            |

### Orchestrated Agent Configuration

| Property     | Description                                    |
| ------------ | ---------------------------------------------- |
| `WorkflowId` | ID of the registered workflow to use           |
| `Settings`   | Workflow-specific settings (JSON)              |

## AG-UI Protocol

Agents communicate using the AG-UI (Agent UI) protocol, a standardized event format for streaming AI interactions.

### Event Categories

```
┌─────────────────────────────────────────────────────────────┐
│                    AG-UI Event Flow                         │
│                                                             │
│  run_started                                                │
│       │                                                     │
│       ├──► text_message_start ──► content* ──► end          │
│       │                                                     │
│       ├──► tool_call_start ──► args* ──► end                │
│       │         │                                           │
│       │         └──► tool_call_result                       │
│       │                                                     │
│       └──► run_finished / run_error                         │
└─────────────────────────────────────────────────────────────┘
```

### Lifecycle Events

| Event          | Description                      |
| -------------- | -------------------------------- |
| `run_started`  | Agent run has begun              |
| `run_finished` | Agent run completed successfully |
| `run_error`    | Agent run failed with error      |

### Text Message Events

| Event                  | Description                 |
| ---------------------- | --------------------------- |
| `text_message_start`   | Beginning of a text message |
| `text_message_content` | Text content chunk          |
| `text_message_end`     | End of a text message       |

### Tool Events

| Event              | Description           |
| ------------------ | --------------------- |
| `tool_call_start`  | Tool call initiated   |
| `tool_call_args`   | Tool argument chunk   |
| `tool_call_end`    | Tool call complete    |
| `tool_call_result` | Tool execution result |

### State Events

| Event            | Description              |
| ---------------- | ------------------------ |
| `state_snapshot` | Complete state update    |
| `state_delta`    | Incremental state change |

## Agent vs Prompt

| Aspect         | Prompt                  | Agent                     |
| -------------- | ----------------------- | ------------------------- |
| **Execution**  | Single request/response | Streaming conversation    |
| **Protocol**   | Simple HTTP             | SSE with AG-UI events     |
| **Tools**      | No tool support         | Frontend tool definitions |
| **Use Case**   | One-shot generation     | Interactive assistance    |
| **Complexity** | Simple                  | More complex              |

## How Agents Work

### Standard Agent Execution

When you run a standard agent:

1. **Agent is loaded** - Configuration and instructions retrieved
2. **Context assembled** - Contexts and instructions combined
3. **Messages prepared** - User messages formatted
4. **Streaming begins** - SSE connection established
5. **Events emitted** - AG-UI events sent as generated
6. **Tools handled** - Frontend tools executed and results returned
7. **Run completes** - Final event sent

### Orchestrated Agent Execution

When you run an orchestrated agent:

1. **Agent is loaded** - Configuration and workflow ID retrieved
2. **Workflow resolved** - Registered workflow implementation found
3. **Workflow built** - `BuildWorkflowAsync` creates the agent graph with settings
4. **Streaming begins** - SSE connection established
5. **Agents execute** - Sub-agents run according to the workflow pattern (sequential, parallel, etc.)
6. **Events emitted** - AG-UI events sent from each sub-agent
7. **Run completes** - Final event sent

## Frontend Tools

Agents can define tools that execute in the browser:

{% code title="Tool Definition" %}

```json
{
    "name": "insert_content",
    "description": "Insert content at the cursor position",
    "parameters": {
        "type": "object",
        "properties": {
            "content": {
                "type": "string",
                "description": "The content to insert"
            }
        },
        "required": ["content"]
    }
}
```

{% endcode %}

When the agent calls this tool, the frontend receives the event and executes the action.

## Version History

Every change to an agent creates a new version:

- View the complete history of changes
- Compare any two versions
- Rollback to a previous version
- Track who made each change

## Best Practices

- **Be specific in instructions** - Define the agent's role, boundaries, and expected behavior clearly.
- **Keep tools focused** - One action per tool with clear descriptions and validated parameters.
- **Associate profiles explicitly** - Do not rely on defaults; link a profile to control model and settings.
- **Minimize contexts** - Only include necessary content to reduce token usage.

## Related

- [Instructions](instructions.md) - Configuring standard agent behavior
- [Workflows](workflows.md) - Creating orchestrated agent workflows
- [Permissions](permissions.md) - Tool permissions and user group overrides
- [Streaming](streaming.md) - SSE event handling
- [Scopes](scopes.md) - Categorizing agents
- [Frontend Tools](frontend-tools.md) - Defining tools
- [Guardrails](../../concepts/guardrails.md) - Safety and compliance rules
