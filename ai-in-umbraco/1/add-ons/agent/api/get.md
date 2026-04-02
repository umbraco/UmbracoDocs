---
description: >-
    Get an agent by ID or alias.
---

# Get Agent

Returns the full details of a specific agent, including type-specific configuration.

## Request

```http
GET /umbraco/ai/management/api/v1/agent/{idOrAlias}
```

### Path Parameters

| Parameter   | Type   | Description         |
| ----------- | ------ | ------------------- |
| `idOrAlias` | string | Agent GUID or alias |

## Response

### Standard Agent

{% code title="200 OK" %}

```json
{
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "alias": "content-assistant",
    "name": "Content Assistant",
    "description": "Helps users write and improve content",
    "agentType": "standard",
    "profileId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "surfaceIds": ["copilot"],
    "config": {
        "$type": "standard",
        "contextIds": ["e401f2ff-7d65-5c12-a1f7-e812859g1962"],
        "instructions": "You are a helpful content assistant...",
        "allowedToolScopeIds": ["content-read", "search"],
        "allowedToolIds": [],
        "userGroupPermissions": {}
    },
    "isActive": true,
    "version": 2,
    "dateCreated": "2024-01-15T10:30:00Z",
    "dateModified": "2024-01-20T14:45:00Z"
}
```

{% endcode %}

### Orchestrated Agent

{% code title="200 OK" %}

```json
{
    "id": "7b4c2e89-1234-5678-abcd-def012345678",
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
    "isActive": true,
    "version": 1,
    "dateCreated": "2024-01-18T09:00:00Z",
    "dateModified": "2024-01-18T09:00:00Z"
}
```

{% endcode %}

### Not Found

{% code title="404 Not Found" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404,
    "detail": "Agent not found"
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
# By ID
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/agent/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"

# By alias
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/agent/content-assistant" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}
