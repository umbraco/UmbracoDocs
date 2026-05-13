---
description: >-
    Create a new AI provider connection.
---

# Create Connection

Create a new connection to an AI provider.

## Endpoint

{% code title="Endpoint" %}

```
POST /umbraco/ai/management/api/v1/connections
```

{% endcode %}

## Request

### Headers

| Header       | Value              |
| ------------ | ------------------ |
| Content-Type | `application/json` |

### Body

{% code title="Request Body" %}

```json
{
    "alias": "openai-prod",
    "name": "OpenAI Production",
    "providerId": "openai",
    "isActive": true,
    "settings": {
        "apiKey": "sk-your-api-key",
        "organization": null
    }
}
```

{% endcode %}

### Required Fields

| Field        | Type   | Description                               |
| ------------ | ------ | ----------------------------------------- |
| `alias`      | string | Unique alias (lowercase, hyphens allowed) |
| `name`       | string | Display name                              |
| `providerId` | string | ID of the provider to use                 |

### Optional Fields

| Field      | Type    | Default | Description                   |
| ---------- | ------- | ------- | ----------------------------- |
| `isActive` | boolean | true    | Whether connection is enabled |
| `settings` | object  | null    | Provider-specific settings    |

### Settings with Configuration References

Use `$` prefix to reference values from `appsettings.json`:

{% code title="Request with Config Reference" %}

```json
{
    "alias": "openai-prod",
    "name": "OpenAI Production",
    "providerId": "openai",
    "settings": {
        "apiKey": "$OpenAI:ApiKey"
    }
}
```

{% endcode %}

## Response

### Success (201 Created)

{% code title="Response" %}

```json
{
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "alias": "openai-prod",
    "name": "OpenAI Production",
    "providerId": "openai",
    "isActive": true,
    "version": 1,
    "dateCreated": "2024-01-15T10:30:00Z",
    "dateModified": "2024-01-15T10:30:00Z",
    "createdByUserId": null,
    "modifiedByUserId": null,
    "settings": {
        "apiKey": "sk-***",
        "organization": null
    }
}
```

{% endcode %}

### 400 Bad Request

#### Missing Required Field

{% code title="Response" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Bad Request",
    "status": 400,
    "detail": "Alias is required"
}
```

{% endcode %}

#### Duplicate Alias

{% code title="Response" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Bad Request",
    "status": 400,
    "detail": "A connection with alias 'openai-prod' already exists"
}
```

{% endcode %}

#### Invalid Provider

{% code title="Response" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Bad Request",
    "status": 400,
    "detail": "Provider 'invalid-provider' not found"
}
```

{% endcode %}

## Examples

### cURL

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/connections" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "alias": "openai-prod",
    "name": "OpenAI Production",
    "providerId": "openai",
    "settings": {
      "apiKey": "sk-your-api-key"
    }
  }'
```

{% endcode %}

### JavaScript

{% code title="JavaScript" %}

```javascript
async function createConnection(connection) {
    const response = await fetch("/umbraco/ai/management/api/v1/connections", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        credentials: "include",
        body: JSON.stringify(connection),
    });

    if (!response.ok) {
        const error = await response.json();
        throw new Error(error.detail);
    }

    return await response.json();
}

// Usage
const connection = await createConnection({
    alias: "openai-prod",
    name: "OpenAI Production",
    providerId: "openai",
    settings: {
        apiKey: "$OpenAI:ApiKey",
    },
});
```

{% endcode %}
