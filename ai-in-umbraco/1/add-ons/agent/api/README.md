---
description: >-
    Management API endpoints for Agent add-on.
---

# Agent API

The Agent Runtime API provides endpoints for creating, managing, and running AI agents.

## Endpoints

| Method | Endpoint                           | Description                  |
| ------ | ---------------------------------- | ---------------------------- |
| GET    | [`/agent`](list.md)                | List all agents              |
| GET    | [`/agent/{idOrAlias}`](get.md)     | Get an agent by ID or alias  |
| POST   | [`/agent`](create.md)              | Create a new agent           |
| PUT    | [`/agent/{id}`](update.md)         | Update an existing agent     |
| DELETE | [`/agent/{id}`](delete.md)         | Delete an agent              |
| POST   | [`/agent/{idOrAlias}/run`](run.md) | Run an agent (SSE streaming) |

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
    "profileId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "contextIds": ["e401f2ff-7d65-5c12-a1f7-e812859g1962"],
    "instructions": "You are a helpful content assistant...",
    "isActive": true,
    "version": 2,
    "dateCreated": "2024-01-15T10:30:00Z",
    "dateModified": "2024-01-20T14:45:00Z"
}
```

{% endcode %}

## Properties

| Property       | Type   | Description                               |
| -------------- | ------ | ----------------------------------------- |
| `id`           | guid   | Unique identifier                         |
| `alias`        | string | Unique alias for code references          |
| `name`         | string | Display name                              |
| `description`  | string | Optional description                      |
| `profileId`    | guid   | Associated AI profile (null uses default) |
| `contextIds`   | guid[] | AI Contexts to inject                     |
| `instructions` | string | Agent system prompt                       |
| `isActive`     | bool   | Whether the agent is available            |
| `version`      | int    | Current version number                    |

## Related

- [Agent Concepts](../concepts.md)
- [Streaming](../streaming.md)
