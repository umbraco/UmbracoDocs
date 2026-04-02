---
description: >-
    Create a new agent.
---

# Create Agent

Creates a new AI agent. The `agentType` determines the configuration shape.

## Request

```http
POST /umbraco/ai/management/api/v1/agent
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
    "surfaceIds": ["copilot"],
    "config": {
        "$type": "standard",
        "contextIds": ["e401f2ff-7d65-5c12-a1f7-e812859g1962"],
        "instructions": "You are a helpful content assistant.\n\nYour role is to help users write and improve content.",
        "allowedToolScopeIds": ["content-read", "search"],
        "allowedToolIds": [],
        "userGroupPermissions": {}
    },
    "isActive": true
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
    },
    "isActive": true
}
```

{% endcode %}

### Common Properties

| Property      | Type     | Required | Description                                      |
| ------------- | -------- | -------- | ------------------------------------------------ |
| `alias`       | string   | Yes      | Unique alias (URL-safe)                          |
| `name`        | string   | Yes      | Display name                                     |
| `description` | string   | No       | Optional description                             |
| `agentType`   | string   | No       | `standard` (default) or `orchestrated`           |
| `profileId`   | guid     | No       | Associated AI profile (null uses default)        |
| `surfaceIds`  | string[] | No       | Surface IDs for categorization                   |
| `config`      | object   | No       | Type-specific configuration (see below)          |
| `isActive`    | bool     | No       | Whether agent is available (default: true)       |

### Standard Config (`$type: "standard"`)

| Property               | Type     | Description                                |
| ---------------------- | -------- | ------------------------------------------ |
| `contextIds`           | guid[]   | AI Contexts to inject                      |
| `instructions`         | string   | Agent system prompt                        |
| `allowedToolIds`       | string[] | Explicit tool permissions                  |
| `allowedToolScopeIds`  | string[] | Scope-based tool permissions               |
| `userGroupPermissions` | object   | Per-user-group overrides (keyed by group ID) |

### Orchestrated Config (`$type: "orchestrated"`)

| Property     | Type   | Description                        |
| ------------ | ------ | ---------------------------------- |
| `workflowId` | string | ID of the registered workflow      |
| `settings`   | object | Workflow-specific settings (JSON)  |

## Response

### Success

{% code title="201 Created" %}

```json
{
  "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "alias": "content-assistant",
  "name": "Content Assistant",
  "agentType": "standard",
  "version": 1,
  ...
}
```

{% endcode %}

### Validation Error

{% code title="400 Bad Request" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Bad Request",
    "status": 400,
    "errors": {
        "alias": ["An agent with this alias already exists"]
    }
}
```

{% endcode %}

## Examples

### Create Standard Agent

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/agent" \
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
    },
    "isActive": true
  }'
```

{% endcode %}

### Create Orchestrated Agent

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/agent" \
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
    },
    "isActive": true
  }'
```

{% endcode %}
