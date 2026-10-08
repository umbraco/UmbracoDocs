---
description: >-
    Update an existing AI context.
---

# Update Context

Updates an existing context. A new version is created automatically.

## Request

```http
PUT /umbraco/ai/management/api/v1/contexts/{contextIdOrAlias}
```

### Path Parameters

| Parameter           | Type   | Description           |
| ------------------- | ------ | --------------------- |
| `contextIdOrAlias`  | string | Context GUID or alias |

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
            "settings": "Always use a friendly, professional, and engaging tone...",
            "injectionMode": "Always"
        },
        {
            "resourceTypeId": "text",
            "name": "Key Messages",
            "sortOrder": 1,
            "settings": "Our core values are...",
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

```
(empty response body)
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
    "title": "Duplicate alias",
    "status": 400,
    "detail": "A context with this alias already exists."
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X PUT "https://your-site.com/umbraco/ai/management/api/v1/contexts/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
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
        "settings": "Updated content..."
      }
    ]
  }'
```

{% endcode %}
