---
description: >-
    Get details of a specific connection by ID or alias.
---

# Get Connection

Retrieve a single connection by its ID or alias.

## Endpoint

```
GET /connections/{idOrAlias}
```

## Path Parameters

| Parameter   | Type   | Description              |
| ----------- | ------ | ------------------------ |
| `idOrAlias` | string | Connection GUID or alias |

## Response

### Success (200 OK)

{% code title="Response" %}

```json
{
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "alias": "openai-prod",
    "name": "OpenAI Production",
    "providerId": "openai",
    "isActive": true,
    "dateCreated": "2024-01-15T10:30:00Z",
    "dateModified": "2024-01-15T10:30:00Z",
    "settings": {
        "apiKey": "sk-***",
        "organization": null
    }
}
```

{% endcode %}

### 404 Not Found

{% code title="Error Response" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404,
    "detail": "Connection not found"
}
```

{% endcode %}

## Examples

### Get by ID

{% code title="cURL" %}

```bash
curl -X GET "https://localhost:44331/umbraco/ai/management/api/v1/connections/3fa85f64-5717-4562-b3fc-2c963f66afa6"
```

{% endcode %}

### Get by Alias

{% code title="cURL" %}

```bash
curl -X GET "https://localhost:44331/umbraco/ai/management/api/v1/connections/openai-prod"
```

{% endcode %}

### JavaScript

{% code title="JavaScript" %}

```javascript
async function getConnection(idOrAlias) {
    const response = await fetch(`/umbraco/ai/management/api/v1/connections/${idOrAlias}`, { credentials: "include" });

    if (!response.ok) {
        if (response.status === 404) {
            return null;
        }
        throw new Error("Failed to fetch connection");
    }

    return await response.json();
}
```

{% endcode %}
