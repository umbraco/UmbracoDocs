---
description: >-
    Create a new AI context.
---

# Create Context

Creates a new context for storing brand voice, guidelines, or content resources.

## Request

```http
POST /umbraco/ai/management/api/v1/contexts
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
            "settings": "Always use a friendly, professional tone...",
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
| `settings`       | object | No       | Resource content                 |
| `injectionMode`  | string | No       | `Always` (default) or `OnDemand` |

## Response

### Success

Returns the newly created context's ID (as a string) with a `Location` header pointing to the Get Context endpoint.

{% code title="201 Created" %}

```json
"3fa85f64-5717-4562-b3fc-2c963f66afa6"
```

{% endcode %}

### Validation Error

{% code title="400 Bad Request" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Duplicate alias",
    "status": 400,
    "detail": "A context with this alias already exists."
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/contexts" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "alias": "brand-voice",
    "name": "Brand Voice",
    "resources": [
      {
        "resourceTypeId": "text",
        "name": "Tone of Voice",
        "settings": "Always use a friendly, professional tone..."
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
            settings = "Always use a friendly, professional tone..."
        }
    }
};

var response = await httpClient.PostAsJsonAsync("/umbraco/ai/management/api/v1/contexts", context);
```

{% endcode %}
