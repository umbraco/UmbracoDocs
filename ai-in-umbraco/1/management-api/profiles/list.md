---
description: >-
    Get a paginated list of all profiles.
---

# List Profiles

Returns a paginated list of all profiles with optional filtering.

## Request

```http
GET /umbraco/ai/management/api/v1/profile
```

### Query Parameters

| Parameter    | Type   | Default | Description                                |
| ------------ | ------ | ------- | ------------------------------------------ |
| `filter`     | string | -       | Filter by name (case-insensitive contains) |
| `capability` | string | -       | Filter by capability (`Chat`, `Embedding`) |
| `skip`       | int    | 0       | Number of items to skip                    |
| `take`       | int    | 100     | Number of items to return                  |

## Response

{% code title="200 OK" %}

```json
{
    "total": 3,
    "items": [
        {
            "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "alias": "content-assistant",
            "name": "Content Assistant",
            "capability": "Chat",
            "model": {
                "providerId": "openai",
                "modelId": "gpt-4o"
            }
        },
        {
            "id": "d290f1ee-6c54-4b01-90e6-d701748f0851",
            "alias": "summarizer",
            "name": "Content Summarizer",
            "capability": "Chat",
            "model": {
                "providerId": "openai",
                "modelId": "gpt-4o-mini"
            }
        },
        {
            "id": "f47ac10b-58cc-4372-a567-0e02b2c3d479",
            "alias": "embeddings",
            "name": "Document Embeddings",
            "capability": "Embedding",
            "model": {
                "providerId": "openai",
                "modelId": "text-embedding-3-small"
            }
        }
    ]
}
```

{% endcode %}

## Examples

### List All Profiles

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/profile" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Filter by Name

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/profile?filter=assistant" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Filter by Capability

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/profile?capability=Chat" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Paginate Results

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/profile?skip=10&take=5" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

## Response Properties

### Item Properties

| Property     | Type   | Description       |
| ------------ | ------ | ----------------- |
| `id`         | guid   | Unique identifier |
| `alias`      | string | Unique alias      |
| `name`       | string | Display name      |
| `capability` | string | Capability type   |
| `model`      | object | Model reference   |

{% hint style="info" %}
The list endpoint returns a lightweight response. Use the [Get Profile](get.md) endpoint to retrieve full details including settings.
{% endhint %}
