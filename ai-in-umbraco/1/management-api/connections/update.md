---
description: >-
    Update an existing AI provider connection.
---

# Update Connection

Update an existing connection's settings.

## Endpoint

```
PUT /connections/{id}
```

## Path Parameters

| Parameter | Type | Description                          |
| --------- | ---- | ------------------------------------ |
| `id`      | guid | Connection ID (GUID only, not alias) |

## Request

### Headers

| Header       | Value              |
| ------------ | ------------------ |
| Content-Type | `application/json` |

### Body

{% code title="Request Body" %}

```json
{
    "name": "OpenAI Production (Updated)",
    "isActive": true,
    "settings": {
        "apiKey": "$OpenAI:ApiKey",
        "organization": "org-123"
    }
}
```

{% endcode %}

### Updatable Fields

| Field      | Type    | Description                   |
| ---------- | ------- | ----------------------------- |
| `name`     | string  | Display name                  |
| `isActive` | boolean | Whether connection is enabled |
| `settings` | object  | Provider-specific settings    |

{% hint style="warning" %}
The `alias` and `providerId` cannot be changed after creation.
{% endhint %}

## Response

### Success (200 OK)

{% code title="Response" %}

```json
{
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "alias": "openai-prod",
    "name": "OpenAI Production (Updated)",
    "providerId": "openai",
    "isActive": true,
    "dateCreated": "2024-01-15T10:30:00Z",
    "dateModified": "2024-01-16T14:00:00Z",
    "settings": {
        "apiKey": "sk-***",
        "organization": "org-123"
    }
}
```

{% endcode %}

### 404 Not Found

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404,
    "detail": "Connection not found"
}
```

### 400 Bad Request

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Bad Request",
    "status": 400,
    "detail": "Invalid settings for provider 'openai'"
}
```

## Examples

### cURL

{% code title="cURL" %}

```bash
curl -X PUT "https://localhost:44331/umbraco/ai/management/api/v1/connections/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "OpenAI Production (Updated)",
    "isActive": true,
    "settings": {
      "apiKey": "$OpenAI:ApiKey"
    }
  }'
```

{% endcode %}

### JavaScript

{% code title="JavaScript" %}

```javascript
async function updateConnection(id, updates) {
    const response = await fetch(`/umbraco/ai/management/api/v1/connections/${id}`, {
        method: "PUT",
        headers: {
            "Content-Type": "application/json",
        },
        credentials: "include",
        body: JSON.stringify(updates),
    });

    if (!response.ok) {
        const error = await response.json();
        throw new Error(error.detail);
    }

    return await response.json();
}

// Usage
const updated = await updateConnection("3fa85f64-5717-4562-b3fc-2c963f66afa6", {
    name: "OpenAI Production (Updated)",
    isActive: false,
});
```

{% endcode %}
