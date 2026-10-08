---
description: >-
    List all user-configurable AI tools grouped by scope.
---

# List Tools

Retrieve a list of all user-configurable tools grouped by scope. Tools are registered by add-ons (such as Agent) and represent functions that AI agents can call during execution.

## Endpoint

{% code title="Endpoint" %}

```
GET /umbraco/ai/management/api/v1/tools
```

{% endcode %}

## Response

### Success (200 OK)

{% code title="Response" %}

```json
[
    {
        "id": "get-content-by-id",
        "name": "Get Content By Id",
        "description": "Retrieves a content item by its unique identifier.",
        "scopeId": "content-read",
        "isDestructive": false,
        "tags": ["content", "read"]
    },
    {
        "id": "update-content",
        "name": "Update Content",
        "description": "Updates an existing content item with new property values.",
        "scopeId": "content-write",
        "isDestructive": true,
        "tags": ["content", "write"]
    },
    {
        "id": "search-content",
        "name": "Search Content",
        "description": "Searches for content items matching the given query.",
        "scopeId": "search",
        "isDestructive": false,
        "tags": ["search"]
    }
]
```

{% endcode %}

### Item Properties

| Property        | Type     | Description                                      |
| --------------- | -------- | ------------------------------------------------ |
| `id`            | string   | Unique identifier for the tool                   |
| `name`          | string   | Display name                                     |
| `description`   | string   | Description of what the tool does                |
| `scopeId`       | string   | The scope this tool belongs to                   |
| `isDestructive` | boolean  | Whether the tool performs destructive operations |
| `tags`          | string[] | Tags for categorization                          |

## Examples

### List All Tools

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/tools"
```

{% endcode %}

### JavaScript

{% code title="JavaScript" %}

```javascript
const response = await fetch("/umbraco/ai/management/api/v1/tools", {
    credentials: "include",
});

const tools = await response.json();
console.log(`Found ${tools.length} tools`);

// Group by scope
const toolsByScope = tools.reduce((acc, tool) => {
    acc[tool.scopeId] = acc[tool.scopeId] || [];
    acc[tool.scopeId].push(tool);
    return acc;
}, {});
```

{% endcode %}
