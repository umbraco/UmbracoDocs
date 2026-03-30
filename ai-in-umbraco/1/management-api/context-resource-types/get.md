---
description: >-
    Get a context resource type with its settings schema.
---

# Get Context Resource Type

Retrieve a specific context resource type by its ID, including the full settings schema that defines how resources of this type are configured.

## Endpoint

{% code title="Endpoint" %}

```
GET /context-resource-types/{id}
```

{% endcode %}

## Path Parameters

| Parameter | Type   | Description                  |
| --------- | ------ | ---------------------------- |
| `id`      | string | The resource type identifier |

## Response

### Success (200 OK)

{% code title="Response" %}

```json
{
    "id": "content",
    "name": "Content",
    "description": "Adds content items as context resources.",
    "icon": "icon-document",
    "settingsSchema": {
        "type": "object",
        "properties": {
            "contentId": {
                "type": "string",
                "format": "uuid",
                "description": "The unique identifier of the content item."
            },
            "includeDescendants": {
                "type": "boolean",
                "default": false,
                "description": "Whether to include descendant content items."
            },
            "depth": {
                "type": "integer",
                "default": 1,
                "description": "Maximum depth when including descendants."
            }
        },
        "required": ["contentId"]
    }
}
```

{% endcode %}

### Properties

| Property         | Type   | Description                                    |
| ---------------- | ------ | ---------------------------------------------- |
| `id`             | string | Unique identifier for the type                 |
| `name`           | string | Display name                                   |
| `description`    | string | Description of the resource type               |
| `icon`           | string | Icon identifier for the backoffice UI          |
| `settingsSchema` | object | JSON Schema defining the resource configuration |

### Not Found (404)

Returned when the specified resource type ID does not exist.

{% code title="Response" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404,
    "detail": "Context resource type not found"
}
```

{% endcode %}

## Examples

### Get a Resource Type

{% code title="cURL" %}

```bash
curl -X GET "https://localhost:44331/umbraco/ai/management/api/v1/context-resource-types/content"
```

{% endcode %}

### JavaScript

{% code title="JavaScript" %}

```javascript
const response = await fetch("/umbraco/ai/management/api/v1/context-resource-types/content", {
    credentials: "include",
});

const resourceType = await response.json();

// Use the settings schema to build a dynamic form
console.log(`Settings schema for ${resourceType.name}:`, resourceType.settingsSchema);
```

{% endcode %}

{% hint style="info" %}
The `settingsSchema` property returns a [JSON Schema](https://json-schema.org/) object that you can use to dynamically render configuration forms in custom backoffice UIs.
{% endhint %}
