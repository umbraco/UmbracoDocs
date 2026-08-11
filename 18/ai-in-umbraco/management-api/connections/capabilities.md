---
description: >-
    List available AI capabilities and find connections that support them.
---

# List Capabilities

Get information about available AI capabilities across all connections.

## Endpoints

| Method | Endpoint                                                                  | Description                                      |
| ------ | ------------------------------------------------------------------------- | ------------------------------------------------ |
| GET    | `/umbraco/ai/management/api/v1/connections/capabilities`                  | List all available capabilities                  |
| GET    | `/umbraco/ai/management/api/v1/connections/capabilities/{capability}`     | Get connections that support a capability        |
| GET    | `/umbraco/ai/management/api/v1/connections/{connectionIdOrAlias}/capabilities` | Get capabilities supported by a specific connection |

## List All Capabilities

### Endpoint

```
GET /umbraco/ai/management/api/v1/connections/capabilities
```

### Response (200 OK)

{% code title="Response" %}

```json
{
    "items": ["Chat", "Embedding"]
}
```

{% endcode %}

This returns capabilities that are available from at least one configured connection.

### Example

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/connections/capabilities" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

## Get Connections by Capability

### Endpoint

```
GET /umbraco/ai/management/api/v1/connections/capabilities/{capability}
```

### Path Parameters

| Parameter    | Type   | Description                       |
| ------------ | ------ | --------------------------------- |
| `capability` | string | Capability name (Chat, Embedding) |

### Response (200 OK)

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
        }
    ],
    "total": 1
}
```

{% endcode %}

### Example

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/connections/capabilities/Chat" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

## Get Capabilities for a Connection

### Endpoint

```
GET /umbraco/ai/management/api/v1/connections/{connectionIdOrAlias}/capabilities
```

### Path Parameters

| Parameter             | Type   | Description              |
| --------------------- | ------ | ------------------------ |
| `connectionIdOrAlias` | string | Connection GUID or alias |

### Response (200 OK)

{% code title="Response" %}

```json
{
    "items": ["Chat", "Embedding"]
}
```

{% endcode %}

This returns the capabilities supported by the specified connection's provider.

### Example

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/connections/openai-prod/capabilities" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

## Available Capabilities

| Capability  | Description                           |
| ----------- | ------------------------------------- |
| `Chat`      | Conversational AI and text generation |
| `Embedding` | Vector embeddings for semantic search |

## Use Cases

### Check Before Creating Profile

{% code title="JavaScript" %}

```javascript
async function canCreateChatProfile() {
    const response = await fetch("/umbraco/ai/management/api/v1/connections/capabilities/Chat", {
        credentials: "include",
    });

    const { items } = await response.json();
    return items.length > 0;
}
```

{% endcode %}

### Get Available Capabilities

{% code title="JavaScript" %}

```javascript
async function getAvailableCapabilities() {
    const response = await fetch("/umbraco/ai/management/api/v1/connections/capabilities", { credentials: "include" });

    const { items } = await response.json();
    return items;
}

// Usage
const capabilities = await getAvailableCapabilities();
// ["Chat", "Embedding"]
```

{% endcode %}
