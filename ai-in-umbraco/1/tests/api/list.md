---
description: >-
    List all tests.
---

# List Tests

Returns a paginated list of all tests.

## Request

```http
GET /umbraco/ai/management/api/v1/tests
```

### Query Parameters

| Parameter | Type   | Default | Description                    |
| --------- | ------ | ------- | ------------------------------ |
| `skip`    | int    | 0       | Number of items to skip        |
| `take`    | int    | 100     | Number of items to return      |
| `filter`  | string | null    | Filter by name or alias (contains) |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "items": [
        {
            "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "alias": "test-summarize-quality",
            "name": "Summarization Quality",
            "description": "Validates summarization output quality and format",
            "testFeatureId": "prompt",
            "testTargetId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
            "tags": ["quality", "summarization"],
            "isActive": true,
            "runCount": 3,
            "version": 1
        },
        {
            "id": "b4c96a75-6828-5673-c4gd-3d074g77bfb7",
            "alias": "test-seo-length",
            "name": "SEO Description Length",
            "description": "Validates meta descriptions are 50-160 characters",
            "testFeatureId": "prompt",
            "testTargetId": "e512h3ii-7e65-6d12-d2h8-g923960i2073",
            "tags": ["seo", "format"],
            "isActive": true,
            "runCount": 1,
            "version": 2
        }
    ],
    "total": 2
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/tests?skip=0&take=10" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Filter by Name

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/tests?filter=seo" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}
