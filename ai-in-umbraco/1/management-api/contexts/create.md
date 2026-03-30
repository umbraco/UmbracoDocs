---
description: >-
    Create a new AI context.
---

# Create Context

Creates a new context for storing brand voice, guidelines, or content resources.

## Request

```http
POST /umbraco/ai/management/api/v1/context
```

### Request Body

{% code title="Request" %}

```json
{
    "alias": "brand-voice",
    "name": "Brand Voice",
    "resources": [
        {
            "resourceTypeId": "text",
            "name": "Tone of Voice",
            "description": "Writing style guidelines",
            "sortOrder": 0,
            "data": "Always use a friendly, professional tone...",
            "injectionMode": "Always"
        }
    ]
}
```

{% endcode %}

### Request Properties

| Property    | Type   | Required | Description             |
| ----------- | ------ | -------- | ----------------------- |
| `alias`     | string | Yes      | Unique alias (URL-safe) |
| `name`      | string | Yes      | Display name            |
| `resources` | array  | No       | Collection of resources |

### Resource Properties

| Property         | Type   | Required | Description                      |
| ---------------- | ------ | -------- | -------------------------------- |
| `resourceTypeId` | string | Yes      | Type of resource                 |
| `name`           | string | Yes      | Display name                     |
| `description`    | string | No       | Optional description             |
| `sortOrder`      | int    | No       | Order for injection (default: 0) |
| `data`           | object | No       | Resource content                 |
| `injectionMode`  | string | No       | `Always` (default) or `OnDemand` |

## Response

### Success

{% code title="201 Created" %}

```json
{
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "alias": "brand-voice",
    "name": "Brand Voice",
    "version": 1,
    "resources": [
        {
            "id": "d290f1ee-6c54-4b01-90e6-d701748f0851",
            "resourceTypeId": "text",
            "name": "Tone of Voice",
            "description": "Writing style guidelines",
            "sortOrder": 0,
            "data": "Always use a friendly, professional tone...",
            "injectionMode": "Always"
        }
    ],
    "dateCreated": "2024-01-15T10:30:00Z",
    "dateModified": "2024-01-15T10:30:00Z"
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
        "alias": ["A context with this alias already exists"]
    }
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/context" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "alias": "brand-voice",
    "name": "Brand Voice",
    "resources": [
      {
        "resourceTypeId": "text",
        "name": "Tone of Voice",
        "data": "Always use a friendly, professional tone..."
      }
    ]
  }'
```

{% endcode %}

{% code title="C#" %}

```csharp
var context = new
{
    alias = "brand-voice",
    name = "Brand Voice",
    resources = new[]
    {
        new
        {
            resourceTypeId = "text",
            name = "Tone of Voice",
            data = "Always use a friendly, professional tone..."
        }
    }
};

var response = await httpClient.PostAsJsonAsync("/umbraco/ai/management/api/v1/context", context);
```

{% endcode %}
