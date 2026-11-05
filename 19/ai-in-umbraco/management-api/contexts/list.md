---
description: >-
    List all AI contexts.
---

# List Contexts

Returns a paginated list of all contexts.

## Request

```http
GET /umbraco/ai/management/api/v1/contexts
```

### Query Parameters

| Parameter | Type   | Default | Description                                                      |
| --------- | ------ | ------- | ---------------------------------------------------------------- |
| `filter`  | string | null    | Filter to search by name or alias (case-insensitive contains)    |
| `skip`    | int    | 0       | Number of items to skip                                          |
| `take`    | int    | 100     | Number of items to return                                        |

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
            "resourceCount": 1,
            "dateCreated": "2024-01-15T10:30:00Z",
            "dateModified": "2024-01-20T14:45:00Z"
        }
    ],
    "total": 5
}
```

{% endcode %}

### Item Properties

| Property        | Type     | Description                        |
| --------------- | -------- | ---------------------------------- |
| `id`            | guid     | Unique identifier                  |
| `alias`         | string   | Unique alias for code references   |
| `name`          | string   | Display name                       |
| `resourceCount` | int      | Number of resources in the context |
| `dateCreated`   | datetime | When the context was created       |
| `dateModified`  | datetime | When the context was last modified |

## Examples

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/contexts?skip=0&take=10" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

{% code title="C#" %}

```csharp
var response = await httpClient.GetAsync("/umbraco/ai/management/api/v1/contexts?skip=0&take=10");
var result = await response.Content.ReadFromJsonAsync<PagedResult<AIContextModel>>();
```

{% endcode %}
