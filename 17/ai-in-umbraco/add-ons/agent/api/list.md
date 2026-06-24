---
description: >-
    List agents, surfaces, workflows, and check alias availability.
---

# List Agents

Returns a paginated list of all agents.

## Request

```http
GET /umbraco/ai/management/api/v1/agents
```

### Query Parameters

| Parameter   | Type   | Default | Description                                                            |
| ----------- | ------ | ------- | ---------------------------------------------------------------------- |
| `skip`      | int    | 0       | Number of items to skip                                                |
| `take`      | int    | 100     | Number of items to return                                              |
| `filter`    | string | null    | Filter by name or alias (contains)                                     |
| `profileId` | guid   | null    | Filter by associated profile                                           |
| `surfaceId` | string | null    | Filter by surface (e.g., `copilot`)                                    |
| `isActive`  | bool   | null    | If true, returns only active agents; if false, only inactive           |
| `agentType` | string | null    | Filter by agent type (`standard` or `orchestrated`)                    |

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
            "scope": null,
            "isActive": true,
            "dateCreated": "2024-01-15T10:30:00Z",
            "dateModified": "2024-01-20T14:45:00Z"
        },
        {
            "id": "7b4c2e89-1234-5678-abcd-def012345678",
            "alias": "write-and-edit",
            "name": "Write and Edit Pipeline",
            "description": "Drafts content then edits it",
            "agentType": "orchestrated",
            "profileId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
            "surfaceIds": ["copilot"],
            "scope": null,
            "isActive": true,
            "dateCreated": "2024-01-18T09:00:00Z",
            "dateModified": "2024-01-18T09:00:00Z"
        }
    ],
    "total": 5
}
```

{% endcode %}

{% hint style="info" %}
The list endpoint returns a summary item for each agent. Use [Get Agent](get.md) to retrieve the full configuration (including `config`, `guardrailIds`, and `version`).
{% endhint %}

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/agents?skip=0&take=10" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Filter by Surface

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/agents?surfaceId=copilot" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

## Check Alias Exists

Checks whether an agent with the given alias already exists. Useful for validating uniqueness when creating a new agent.

```http
GET /umbraco/ai/management/api/v1/agents/{alias}/exists
```

### Path Parameters

| Parameter | Type   | Description              |
| --------- | ------ | ------------------------ |
| `alias`   | string | The agent alias to check |

### Query Parameters

| Parameter   | Type | Description                                              |
| ----------- | ---- | -------------------------------------------------------- |
| `excludeId` | guid | Optional agent ID to exclude from the check (for edits)  |

### Response

{% code title="200 OK" %}

```json
true
```

{% endcode %}

## List Surfaces

Returns all registered agent surfaces. Surfaces are defined by add-on packages and categorize agents for specific purposes.

```http
GET /umbraco/ai/management/api/v1/agents/surfaces
```

### Response

{% code title="200 OK" %}

```json
[
    {
        "id": "copilot",
        "icon": "icon-chat",
        "supportedScopeDimensions": ["section", "entityType"]
    }
]
```

{% endcode %}

### Properties

| Property                   | Type     | Description                                                   |
| -------------------------- | -------- | ------------------------------------------------------------- |
| `id`                       | string   | Unique identifier for this surface                            |
| `icon`                     | string   | Icon to display for this surface                              |
| `supportedScopeDimensions` | string[] | Scope dimensions that agents on this surface can be scoped by |

{% hint style="info" %}
Surface names and descriptions are localized on the frontend using the convention `uaiAgentSurface_{id}Label` and `uaiAgentSurface_{id}Description`.
{% endhint %}

## List Workflows

Returns all registered agent workflows. Workflows are used by orchestrated agents.

```http
GET /umbraco/ai/management/api/v1/agents/workflows
```

### Response

{% code title="200 OK" %}

```json
[
    {
        "id": "write-and-edit",
        "name": "Write and Edit",
        "description": "Drafts content then edits it for clarity",
        "settingsSchema": {
            "properties": [
                {
                    "alias": "writingStyle",
                    "label": "Writing Style",
                    "propertyEditorUiAlias": "Umb.PropertyEditorUi.TextBox"
                }
            ]
        }
    }
]
```

{% endcode %}

### Properties

| Property         | Type   | Description                                              |
| ---------------- | ------ | -------------------------------------------------------- |
| `id`             | string | Unique identifier for this workflow                      |
| `name`           | string | Display name                                             |
| `description`    | string | Optional description                                     |
| `settingsSchema` | object | Settings schema for this workflow (null if not required) |
