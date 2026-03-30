---
description: >-
    List all prompts.
---

# List Prompts

Returns a paginated list of all prompts.

## Request

```http
GET /umbraco/ai/management/api/v1/prompt
```

### Query Parameters

| Parameter   | Type   | Default | Description                  |
| ----------- | ------ | ------- | ---------------------------- |
| `skip`      | int    | 0       | Number of items to skip      |
| `take`      | int    | 100     | Number of items to return    |
| `filter`    | string | null    | Filter by name (contains)    |
| `profileId` | guid   | null    | Filter by associated profile |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "items": [
        {
            "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "alias": "meta-description",
            "name": "Generate Meta Description",
            "description": "Creates SEO-friendly meta descriptions",
            "profileId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
            "tags": ["seo", "content"],
            "isActive": true,
            "version": 3
        }
    ],
    "total": 15
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/prompt?skip=0&take=10" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}
