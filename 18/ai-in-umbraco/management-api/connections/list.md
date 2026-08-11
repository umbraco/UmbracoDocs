---
description: >-
    List all AI connections with optional filtering and pagination.
---

# List Connections

Retrieve a paginated list of all connections.

## Endpoint

{% code title="Endpoint" %}

```
GET /umbraco/ai/management/api/v1/connections
```

{% endcode %}

## Query Parameters

| Parameter    | Type   | Default | Description                                 |
| ------------ | ------ | ------- | ------------------------------------------- |
| `skip`       | int    | 0       | Number of items to skip                     |
| `take`       | int    | 100     | Number of items to return                   |
| `filter`     | string | null    | Filter by name (contains, case-insensitive) |
| `providerId` | string | null    | Filter by provider ID                       |

## Response

### Success (200 OK)

{% code title="Response" %}

```json
{
    "items": [
        {
            "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "alias": "openai-prod",
            "name": "OpenAI Production",
            "providerId": "openai",
            "isActive": true
        },
        {
            "id": "7ca85f64-5717-4562-b3fc-2c963f66afa7",
            "alias": "openai-dev",
            "name": "OpenAI Development",
            "providerId": "openai",
            "isActive": true
        }
    ],
    "total": 2
}
```

{% endcode %}

### Item Properties

| Property     | Type    | Description       |
| ------------ | ------- | ----------------- |
| `id`         | guid    | Unique identifier |
| `alias`      | string  | Unique alias      |
| `name`       | string  | Display name      |
| `providerId` | string  | Provider ID       |
| `isActive`   | boolean | Whether enabled   |

## Examples

### List All Connections

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/connections" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### With Pagination

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/connections?skip=0&take=10" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Filter by Name

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/connections?filter=prod" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Filter by Provider

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/connections?providerId=openai" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### JavaScript

{% code title="JavaScript" %}

```javascript
const response = await fetch("/umbraco/ai/management/api/v1/connections?take=10", {
    credentials: "include",
});

const { items, total } = await response.json();
console.log(`Found ${total} connections`);
```

{% endcode %}
