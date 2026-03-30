---
description: >-
    Update an existing AI context.
---

# Update Context

Updates an existing context. A new version is created automatically.

## Request

```http
PUT /umbraco/ai/management/api/v1/context/{id}
```

### Path Parameters

| Parameter | Type | Description               |
| --------- | ---- | ------------------------- |
| `id`      | guid | Context unique identifier |

### Request Body

{% code title="Request" %}

```json
{
    "alias": "brand-voice",
    "name": "Brand Voice Updated",
    "resources": [
        {
            "id": "d290f1ee-6c54-4b01-90e6-d701748f0851",
            "resourceTypeId": "text",
            "name": "Tone of Voice",
            "description": "Updated writing style guidelines",
            "sortOrder": 0,
            "data": "Always use a friendly, professional, and engaging tone...",
            "injectionMode": "Always"
        },
        {
            "resourceTypeId": "text",
            "name": "Key Messages",
            "sortOrder": 1,
            "data": "Our core values are...",
            "injectionMode": "Always"
        }
    ]
}
```

{% endcode %}

{% hint style="info" %}
Include existing resource IDs to update them. Resources without IDs are created as new. Omitting an existing resource removes it.
{% endhint %}

## Response

### Success

{% code title="200 OK" %}

```json
{
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "alias": "brand-voice",
    "name": "Brand Voice Updated",
    "version": 4,
    "resources": [
        {
            "id": "d290f1ee-6c54-4b01-90e6-d701748f0851",
            "resourceTypeId": "text",
            "name": "Tone of Voice",
            "description": "Updated writing style guidelines",
            "sortOrder": 0,
            "data": "Always use a friendly, professional, and engaging tone...",
            "injectionMode": "Always"
        },
        {
            "id": "e401f2ff-7d65-5c12-a1f7-e812859g1962",
            "resourceTypeId": "text",
            "name": "Key Messages",
            "sortOrder": 1,
            "data": "Our core values are...",
            "injectionMode": "Always"
        }
    ],
    "dateCreated": "2024-01-15T10:30:00Z",
    "dateModified": "2024-01-25T09:15:00Z"
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
    "detail": "Context not found"
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
curl -X PUT "https://your-site.com/umbraco/ai/management/api/v1/context/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "alias": "brand-voice",
    "name": "Brand Voice Updated",
    "resources": [
      {
        "id": "d290f1ee-6c54-4b01-90e6-d701748f0851",
        "resourceTypeId": "text",
        "name": "Tone of Voice",
        "data": "Updated content..."
      }
    ]
  }'
```

{% endcode %}
