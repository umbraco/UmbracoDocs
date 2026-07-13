---
description: >-
    Update an existing agent.
---

# Update Agent

Updates an existing agent. A new version is created automatically on each save.

{% hint style="warning" %}
The `agentType` cannot be changed after creation. To switch agent types, delete the agent and create a new one.
{% endhint %}

## Request

```http
PUT /umbraco/ai/management/api/v1/agents/{agentIdOrAlias}
```

### Path Parameters

| Parameter        | Type   | Description         |
| ---------------- | ------ | ------------------- |
| `agentIdOrAlias` | string | Agent GUID or alias |

### Request Body

{% code title="Standard Agent Update" %}

```json
{
    "alias": "content-assistant",
    "name": "Content Assistant (Updated)",
    "description": "Helps users write and improve content with AI",
    "profileId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "guardrailIds": [],
    "surfaceIds": ["copilot"],
    "scope": null,
    "config": {
        "$type": "standard",
        "contextIds": ["e401f2ff-7d65-5c12-a1f7-e812859a1962"],
        "instructions": "Updated instructions...",
        "allowedToolIds": [],
        "allowedToolScopeIds": ["content-read", "content-write", "search"],
        "userGroupPermissions": {}
    },
    "isActive": true
}
```

{% endcode %}

{% code title="Orchestrated Agent Update" %}

```json
{
    "alias": "write-and-edit",
    "name": "Write and Edit Pipeline (Updated)",
    "config": {
        "$type": "orchestrated",
        "workflowId": "write-and-edit",
        "settings": {
            "writingStyle": "casual",
            "editingFocus": "grammar and readability"
        }
    },
    "isActive": true
}
```

{% endcode %}

### Properties

| Property       | Type     | Required | Description                                       |
| -------------- | -------- | -------- | ------------------------------------------------- |
| `alias`        | string   | Yes      | Unique alias (URL-safe, max 100 chars)            |
| `name`         | string   | Yes      | Display name (max 255 chars)                      |
| `description`  | string   | No       | Optional description (max 1000 chars)             |
| `profileId`    | guid     | No       | Associated AI profile (null uses default)         |
| `guardrailIds` | guid[]   | No       | Guardrail IDs for safety and compliance checks    |
| `surfaceIds`   | string[] | No       | Surface IDs for categorization                    |
| `scope`        | object   | No       | Optional scope defining where the agent is available |
| `config`       | object   | No       | Type-specific configuration (see [Create Agent](create.md)) |
| `isActive`     | bool     | No       | Whether the agent is available (default: true)    |

## Response

### Success

The endpoint returns `200 OK` with an empty body on success. Call [Get Agent](get.md) afterward to retrieve the updated state.

{% code title="200 OK" %}

```
(empty response body)
```

{% endcode %}

### Not Found

{% code title="404 Not Found" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "AIAgent not found",
    "status": 404,
    "detail": "The specified agent could not be found."
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X PUT "https://your-site.com/umbraco/ai/management/api/v1/agents/content-assistant" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "alias": "content-assistant",
    "name": "Content Assistant (Updated)",
    "config": {
        "$type": "standard",
        "instructions": "Updated instructions...",
        "allowedToolScopeIds": ["content-read", "search"]
    },
    "isActive": true
  }'
```

{% endcode %}
