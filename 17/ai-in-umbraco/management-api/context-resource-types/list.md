---
description: >-
    List all available context resource types.
---

# List Context Resource Types

Retrieve a list of all available context resource types. Resource types define what kinds of resources can be added to AI contexts.

## Endpoint

{% code title="Endpoint" %}

```
GET /umbraco/ai/management/api/v1/context-resource-types
```

{% endcode %}

## Response

### Success (200 OK)

{% code title="Response" %}

```json
[
    {
        "id": "text",
        "name": "Text",
        "description": "Plain text content.",
        "icon": "icon-document"
    },
    {
        "id": "document",
        "name": "Document",
        "description": "Document/content node reference.",
        "icon": "icon-picture"
    },
    {
        "id": "url",
        "name": "URL",
        "description": "Web URL resource.",
        "icon": "icon-link"
    }
]
```

{% endcode %}

### Item Properties

| Property      | Type   | Description                           |
| ------------- | ------ | ------------------------------------- |
| `id`          | string | Unique identifier for the type        |
| `name`        | string | Display name                          |
| `description` | string | Description of the resource type      |
| `icon`        | string | Icon identifier for the backoffice UI |

{% hint style="info" %}
The list endpoint returns basic info only. Use the [Get Context Resource Type](get.md) endpoint to retrieve the settings schema for a specific resource type.
{% endhint %}

## Examples

### List All Resource Types

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/context-resource-types" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### JavaScript

{% code title="JavaScript" %}

```javascript
const response = await fetch("/umbraco/ai/management/api/v1/context-resource-types", {
    credentials: "include",
});

const resourceTypes = await response.json();
console.log(`Found ${resourceTypes.length} resource types`);
```

{% endcode %}
