---
description: >-
    List all available context resource types.
---

# List Context Resource Types

Retrieve a list of all available context resource types. Resource types define what kinds of resources can be added to AI contexts.

## Endpoint

{% code title="Endpoint" %}

```
GET /context-resource-types
```

{% endcode %}

## Response

### Success (200 OK)

{% code title="Response" %}

```json
{
    "items": [
        {
            "id": "content",
            "name": "Content",
            "description": "Adds content items as context resources.",
            "icon": "icon-document"
        },
        {
            "id": "media",
            "name": "Media",
            "description": "Adds media items as context resources.",
            "icon": "icon-picture"
        },
        {
            "id": "url",
            "name": "URL",
            "description": "Adds web page content from a URL as a context resource.",
            "icon": "icon-link"
        }
    ],
    "total": 3
}
```

{% endcode %}

### Item Properties

| Property      | Type   | Description                           |
| ------------- | ------ | ------------------------------------- |
| `id`          | string | Unique identifier for the type        |
| `name`        | string | Display name                          |
| `description` | string | Description of the resource type      |
| `icon`        | string | Icon identifier for the backoffice UI |

## Examples

### List All Resource Types

{% code title="cURL" %}

```bash
curl -X GET "https://localhost:44331/umbraco/ai/management/api/v1/context-resource-types"
```

{% endcode %}

### JavaScript

{% code title="JavaScript" %}

```javascript
const response = await fetch("/umbraco/ai/management/api/v1/context-resource-types", {
    credentials: "include",
});

const { items, total } = await response.json();
console.log(`Found ${total} resource types`);
```

{% endcode %}
