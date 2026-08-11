---
description: >-
    Management API endpoints for the Agent add-on.
---

# Agent API

The Agent Management API provides endpoints for creating, managing, and running AI agents.

## Endpoints

| Method | Endpoint                                                | Description                                |
| ------ | ------------------------------------------------------- | ------------------------------------------ |
| GET    | [`/agents`](list.md)                                    | List all agents                            |
| GET    | [`/agents/{agentIdOrAlias}`](get.md)                    | Get an agent by ID or alias                |
| POST   | [`/agents`](create.md)                                  | Create a new agent                         |
| PUT    | [`/agents/{agentIdOrAlias}`](update.md)                 | Update an existing agent                   |
| DELETE | [`/agents/{agentIdOrAlias}`](delete.md)                 | Delete an agent                            |
| GET    | [`/agents/{alias}/exists`](list.md#check-alias-exists)  | Check if an agent alias exists             |
| GET    | [`/agents/surfaces`](list.md#list-surfaces)             | List all registered agent surfaces         |
| GET    | [`/agents/workflows`](list.md#list-workflows)           | List all registered agent workflows        |
| POST   | [`/agents/{agentIdOrAlias}/run`](run.md)                | Run an agent (non-streaming JSON response) |
| POST   | [`/agents/{agentIdOrAlias}/stream`](stream.md)          | Stream agent updates (SSE)                 |
| POST   | [`/agents/{agentIdOrAlias}/stream-agui`](stream-agui.md) | Stream agent events using the AG-UI protocol (SSE) |

## Base URL

```
/umbraco/ai/management/api/v1
```

## Agent Object

{% code title="Agent" %}

```json
{
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "alias": "content-assistant",
    "name": "Content Assistant",
    "description": "Helps users write and improve content",
    "agentType": "standard",
    "profileId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "guardrailIds": [],
    "surfaceIds": ["copilot"],
    "scope": null,
    "config": {
        "$type": "standard",
        "contextIds": ["e401f2ff-7d65-5c12-a1f7-e812859a1962"],
        "instructions": "You are a helpful content assistant...",
        "allowedToolIds": [],
        "allowedToolScopeIds": ["content-read", "search"],
        "outputSchema": null,
        "userGroupPermissions": {}
    },
    "isActive": true,
    "dateCreated": "2024-01-15T10:30:00Z",
    "dateModified": "2024-01-20T14:45:00Z",
    "version": 2
}
```

{% endcode %}

## Properties

| Property       | Type     | Description                                       |
| -------------- | -------- | ------------------------------------------------- |
| `id`           | guid     | Unique identifier                                 |
| `alias`        | string   | Unique alias for code references                  |
| `name`         | string   | Display name                                      |
| `description`  | string   | Optional description                              |
| `agentType`    | string   | `standard` or `orchestrated`                      |
| `profileId`    | guid     | Associated AI profile (null uses default)         |
| `guardrailIds` | guid[]   | Guardrail IDs for safety and compliance checks    |
| `surfaceIds`   | string[] | Surface IDs for categorization                    |
| `scope`        | object   | Optional scope defining where the agent is available (see below) |
| `config`       | object   | Type-specific configuration (see below)           |
| `isActive`     | bool     | Whether the agent is available                    |
| `dateCreated`  | datetime | When the agent was created (UTC)                  |
| `dateModified` | datetime | When the agent was last modified (UTC)            |
| `version`      | int      | Current version number                            |

### Scope (`scope`)

Defines where the agent is available using allow and deny rules. When `null`, the agent is available in all contexts.

| Property     | Type   | Description                                          |
| ------------ | ------ | ---------------------------------------------------- |
| `allowRules` | rule[] | Rules where the agent is available (OR between rules) |
| `denyRules`  | rule[] | Rules where the agent is denied (takes precedence)   |

Each rule has the following properties (AND between properties, OR within an array):

| Property      | Type     | Description                                       |
| ------------- | -------- | ------------------------------------------------- |
| `sections`    | string[] | Section pathnames (e.g., `content`, `media`)      |
| `entityTypes` | string[] | Entity types (e.g., `document`, `media`)          |

### Standard Config (`config` when `agentType` is `standard`)

| Property               | Type     | Description                                        |
| ---------------------- | -------- | -------------------------------------------------- |
| `$type`                | string   | Always `"standard"`                                |
| `contextIds`           | guid[]   | AI Contexts to inject                              |
| `instructions`         | string   | Agent system prompt                                |
| `allowedToolIds`       | string[] | Explicit tool permissions                          |
| `allowedToolScopeIds`  | string[] | Scope-based tool permissions                       |
| `outputSchema`         | object   | Optional JSON Schema constraining agent output     |
| `userGroupPermissions` | object   | Per-user-group permission overrides (keyed by group ID) |

### Orchestrated Config (`config` when `agentType` is `orchestrated`)

| Property     | Type   | Description                       |
| ------------ | ------ | --------------------------------- |
| `$type`      | string | Always `"orchestrated"`           |
| `workflowId` | string | ID of the registered workflow     |
| `settings`   | object | Workflow-specific settings (JSON) |

## Related

- [Agent Concepts](../concepts.md)
- [Streaming](../streaming.md)
