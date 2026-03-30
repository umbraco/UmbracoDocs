---
description: >-
    List all AI contexts.
---

# List Contexts

Returns a paginated list of all contexts.

## Request

```http
GET /umbraco/ai/management/api/v1/context
```

### Query Parameters

| Parameter | Type | Default | Description               |
| --------- | ---- | ------- | ------------------------- |
| `skip`    | int  | 0       | Number of items to skip   |
| `take`    | int  | 100     | Number of items to return |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "items": [
        {
            "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "alias": "brand-voice",
            "name": "Brand Voice",
            "version": 3,
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
            "dateModified": "2024-01-20T14:45:00Z"
        }
    ],
    "total": 5
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/context?skip=0&take=10" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var response = await httpClient.GetAsync("/umbraco/ai/management/api/v1/context?skip=0&take=10");
var result = await response.Content.ReadFromJsonAsync<PagedResult<AIContextModel>>();
```

{% endcode %}
