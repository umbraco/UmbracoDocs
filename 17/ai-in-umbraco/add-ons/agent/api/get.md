---
description: >-
    Get an agent by ID or alias.
---

# Get Agent

Returns the full details of a specific agent, including type-specific configuration.

## Request

```http
GET /umbraco/ai/management/api/v1/agents/{agentIdOrAlias}
```

### Path Parameters

| Parameter        | Type   | Description         |
| ---------------- | ------ | ------------------- |
| `agentIdOrAlias` | string | Agent GUID or alias |

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
    "guardrailIds": [],
    "surfaceIds": ["copilot"],
    "scope": null,
    "config": {
        "$type": "orchestrated",
        "workflowId": "write-and-edit",
        "settings": {
            "writingStyle": "professional",
            "editingFocus": "clarity and conciseness"
        }
    },
    "isActive": true,
    "dateCreated": "2024-01-18T09:00:00Z",
    "dateModified": "2024-01-18T09:00:00Z",
    "version": 1
}
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
# By ID
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/agents/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"

# By alias
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/agents/content-assistant" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}
