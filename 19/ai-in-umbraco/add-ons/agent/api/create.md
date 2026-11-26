---
description: >-
    Create a new agent.
---

# Create Agent

Creates a new AI agent. The `agentType` determines the shape of the `config` object.

## Request

```http
POST /umbraco/ai/management/api/v1/agents
```

### Request Body (Standard Agent)

{% code title="Standard Agent Request" %}

```json
{
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
        "instructions": "You are a helpful content assistant.\n\nYour role is to help users write and improve content.",
        "allowedToolIds": [],
        "allowedToolScopeIds": ["content-read", "search"],
        "userGroupPermissions": {}
    }
}
```

{% endcode %}

### Request Body (Orchestrated Agent)

{% code title="Orchestrated Agent Request" %}

```json
{
    "alias": "write-and-edit",
    "name": "Write and Edit Pipeline",
    "description": "Drafts content then edits it for clarity",
    "agentType": "orchestrated",
    "profileId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "surfaceIds": ["copilot"],
    "config": {
        "$type": "orchestrated",
        "workflowId": "write-and-edit",
        "settings": {
            "writingStyle": "professional",
            "editingFocus": "clarity and conciseness"
        }
    }
}
```

{% endcode %}

### Common Properties

| Property       | Type     | Required | Description                                       |
| -------------- | -------- | -------- | ------------------------------------------------- |
| `alias`        | string   | Yes      | Unique alias (URL-safe, max 100 chars, letters, numbers, hyphens, underscores) |
| `name`         | string   | Yes      | Display name (max 255 chars)                      |
| `description`  | string   | No       | Optional description (max 1000 chars)             |
| `agentType`    | string   | Yes      | `standard` or `orchestrated`                      |
| `profileId`    | guid     | No       | Associated AI profile (null uses default)         |
| `guardrailIds` | guid[]   | No       | Guardrail IDs for safety and compliance checks    |
| `surfaceIds`   | string[] | No       | Surface IDs for categorization                    |
| `scope`        | object   | No       | Optional scope defining where the agent is available |
| `config`       | object   | No       | Type-specific configuration (see below)           |

### Standard Config (`$type: "standard"`)

| Property               | Type     | Description                                        |
| ---------------------- | -------- | -------------------------------------------------- |
| `contextIds`           | guid[]   | AI Contexts to inject                              |
| `instructions`         | string   | Agent system prompt                                |
| `allowedToolIds`       | string[] | Explicit tool permissions                          |
| `allowedToolScopeIds`  | string[] | Scope-based tool permissions                       |
| `outputSchema`         | object   | Optional JSON Schema constraining agent output     |
| `userGroupPermissions` | object   | Per-user-group overrides (keyed by group ID)       |

### Orchestrated Config (`$type: "orchestrated"`)

| Property     | Type   | Description                        |
| ------------ | ------ | ---------------------------------- |
| `workflowId` | string | ID of the registered workflow      |
| `settings`   | object | Workflow-specific settings (JSON)  |

## Response

### Success

On success, the API returns the ID of the newly created agent and a `Location` header pointing to the new resource.

{% code title="201 Created" %}

```
Location: /umbraco/ai/management/api/v1/agents/3fa85f64-5717-4562-b3fc-2c963f66afa6

3fa85f64-5717-4562-b3fc-2c963f66afa6
```

{% endcode %}

### Alias Conflict

{% code title="409 Conflict" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.8",
    "title": "Alias already exists",
    "status": 409,
    "detail": "A agent with alias 'content-assistant' already exists."
}
```

{% endcode %}

### Validation Error

{% code title="400 Bad Request" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "One or more validation errors occurred.",
    "status": 400,
    "errors": {
        "Alias": ["The Alias field is required."]
    }
}
```

{% endcode %}

## Examples

### Create Standard Agent

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/agents" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "alias": "content-assistant",
    "name": "Content Assistant",
    "agentType": "standard",
    "config": {
        "$type": "standard",
        "instructions": "You are a helpful content assistant.",
        "allowedToolScopeIds": ["content-read", "search"]
    }
  }'
```

{% endcode %}

### Create Orchestrated Agent

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/agents" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "alias": "write-and-edit",
    "name": "Write and Edit",
    "agentType": "orchestrated",
    "config": {
        "$type": "orchestrated",
        "workflowId": "write-and-edit",
        "settings": {
            "writingStyle": "professional",
            "editingFocus": "clarity"
        }
    }
  }'
```

{% endcode %}
