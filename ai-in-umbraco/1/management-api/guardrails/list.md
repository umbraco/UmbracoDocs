---
description: >-
    List all AI guardrails.
---

# List Guardrails

Returns a paginated list of all guardrails.

## Request

```http
GET /umbraco/ai/management/api/v1/guardrails
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
            "alias": "content-safety",
            "name": "Content Safety Policy",
            "version": 2,
            "rules": [
                {
                    "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
                    "evaluatorId": "contains",
                    "name": "Block competitor mentions",
                    "phase": "PostGenerate",
                    "action": "Block",
                    "config": {
                        "searchPattern": "CompetitorBrand",
                        "ignoreCase": true
                    },
                    "sortOrder": 0
                }
            ],
            "dateCreated": "2024-01-15T10:30:00Z",
            "dateModified": "2024-01-20T14:45:00Z"
        }
    ],
    "total": 3
}
```

{% endcode %}

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/guardrails?skip=0&take=10" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var response = await httpClient.GetAsync("/umbraco/ai/management/api/v1/guardrails?skip=0&take=10");
var result = await response.Content.ReadFromJsonAsync<PagedResult<GuardrailResponseModel>>();
```

{% endcode %}
