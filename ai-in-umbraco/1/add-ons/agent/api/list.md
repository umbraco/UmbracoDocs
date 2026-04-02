---
description: >-
    List all agents.
---

# List Agents

Returns a paginated list of all agents.

## Request

```http
GET /umbraco/ai/management/api/v1/agent
```

### Query Parameters

| Parameter   | Type   | Default | Description                       |
| ----------- | ------ | ------- | --------------------------------- |
| `skip`      | int    | 0       | Number of items to skip           |
| `take`      | int    | 100     | Number of items to return         |
| `filter`    | string | null    | Filter by name (contains)         |
| `profileId` | guid   | null    | Filter by associated profile      |
| `scopeId`   | string | null    | Filter by scope (e.g., "copilot") |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "items": [
        {
            "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "alias": "content-assistant",
            "name": "Content Assistant",
            "description": "Helps users write and improve content",
            "agentType": "standard",
            "profileId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
            "surfaceIds": ["copilot"],
            "isActive": true,
            "version": 2
        },
        {
            "id": "7b4c2e89-1234-5678-abcd-def012345678",
            "alias": "write-and-edit",
            "name": "Write and Edit Pipeline",
            "description": "Drafts content then edits it",
            "agentType": "orchestrated",
            "profileId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
            "surfaceIds": ["copilot"],
            "isActive": true,
            "version": 1
        }
    ],
    "total": 5
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/agent?skip=0&take=10" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Filter by Scope

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/agent?scopeId=copilot" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

## List Scopes

Returns all registered agent scopes.

```http
GET /umbraco/ai/management/api/v1/agent/scopes
```

{% code title="200 OK" %}

```json
[
    {
        "id": "copilot",
        "icon": "icon-chat"
    }
]
```

{% endcode %}
