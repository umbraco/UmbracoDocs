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
| `capability` | string | null    | Return only connections that support a capability, such as `Chat` |

### Capability Filter

The `capability` value is case-insensitive, so `chat` and `Chat` give the same result. Use a capability name, such as `Chat` or `Embedding`.

- An unknown value is ignored. The endpoint returns all connections, as if you left out the parameter.
- An experimental capability that is turned off returns an empty list.
- You can combine `capability` with `filter`, `providerId`, `skip`, and `take`.

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
            "isActive": true,
            "dateCreated": "2025-01-15T10:30:00Z",
            "dateModified": "2025-01-20T14:45:00Z",
            "version": 3
        },
        {
            "id": "7ca85f64-5717-4562-b3fc-2c963f66afa7",
            "alias": "openai-dev",
            "name": "OpenAI Development",
            "providerId": "openai",
            "isActive": true,
            "dateCreated": "2025-01-16T09:00:00Z",
            "dateModified": "2025-01-16T09:00:00Z",
            "version": 1
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
| `dateCreated` | datetime | When the connection was created (UTC) |
| `dateModified` | datetime | When the connection was last modified (UTC) |
| `version`    | int     | Current version of the connection |

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

### Filter by Capability

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/connections?capability=Chat" \
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
