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
            "tags": ["quality", "summarization"],
            "runCount": 3,
            "dateCreated": "2024-06-15T10:30:00Z",
            "dateModified": "2024-06-15T10:30:00Z",
            "version": 1
        },
        {
            "id": "b4c96a75-6828-5673-c4ad-3d074a77bfb7",
            "alias": "test-seo-length",
            "name": "SEO Description Length",
            "description": "Validates meta descriptions are 50-160 characters",
            "testFeatureId": "prompt",
            "tags": ["seo", "format"],
            "runCount": 1,
            "dateCreated": "2024-06-10T08:00:00Z",
            "dateModified": "2024-06-12T14:20:00Z",
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
