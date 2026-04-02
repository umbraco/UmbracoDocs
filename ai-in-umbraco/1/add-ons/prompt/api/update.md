---
description: >-
    Update an existing prompt.
---

# Update Prompt

Updates an existing prompt. A new version is created automatically.

## Request

```http
PUT /umbraco/ai/management/api/v1/prompt/{id}
```

### Path Parameters

| Parameter | Type | Description              |
| --------- | ---- | ------------------------ |
| `id`      | guid | Prompt unique identifier |

### Request Body

{% code title="Request" %}

```json
{
    "alias": "meta-description",
    "name": "Generate Meta Description (Updated)",
    "description": "Creates SEO-friendly meta descriptions for web pages",
    "instructions": "Write a compelling meta description...",
    "profileId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "contextIds": ["e401f2ff-7d65-5c12-a1f7-e812859g1962"],
    "tags": ["seo", "content", "updated"],
    "isActive": true
}
```

{% endcode %}

## Response

### Success

{% code title="200 OK" %}

```json
{
  "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "alias": "meta-description",
  "name": "Generate Meta Description (Updated)",
  "version": 4,
  "dateModified": "2024-01-25T09:15:00Z",
  ...
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
    "detail": "Prompt not found"
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X PUT "https://your-site.com/umbraco/ai/management/api/v1/prompt/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "alias": "meta-description",
    "name": "Generate Meta Description (Updated)",
    "instructions": "Updated instructions..."
  }'
```

{% endcode %}
