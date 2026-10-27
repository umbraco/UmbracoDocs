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
| GET    | `/umbraco/ai/management/api/v1/connections?capability={capability}`       | Get connections that support a capability        |
| GET    | `/umbraco/ai/management/api/v1/connections/{connectionIdOrAlias}/capabilities` | Get capabilities supported by a specific connection |
| GET    | `/umbraco/ai/management/api/v1/capabilities/enabled`                      | List capabilities enabled on this install        |

## List All Capabilities

### Endpoint

```
GET /umbraco/ai/management/api/v1/connections/capabilities
```

### Response (200 OK)

{% code title="Response" %}

```json
["Chat", "Embedding"]
```

{% endcode %}

The response is a plain JSON array of the capabilities that at least one configured connection supports. Experimental capabilities that are not enabled are left out.

### Example

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/connections/capabilities" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

## Get Connections by Capability

### Endpoint

Use the `capability` query parameter on the [List Connections](list.md) endpoint.

```
GET /umbraco/ai/management/api/v1/connections?capability={capability}
```

### Query Parameters

| Parameter    | Type   | Description                                                  |
| ------------ | ------ | ------------------------------------------------------------ |
| `capability` | string | Capability name, such as `Chat` or `Embedding`. Not case-sensitive. |

The `filter`, `providerId`, `skip`, and `take` parameters from [List Connections](list.md) still apply.

If the value is not a known capability name, the filter is ignored and all connections are returned. If the capability is experimental and not enabled, the list is empty.

### Response (200 OK)

{% code title="Response" %}

```json
{
    "total": 1,
    "items": [
        {
            "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "alias": "openai-prod",
            "name": "OpenAI Production",
            "providerId": "openai",
            "isActive": true,
            "dateCreated": "2024-01-15T10:30:00Z",
            "dateModified": "2024-01-20T14:45:00Z",
            "version": 2
        }
    ]
}
```

{% endcode %}

### Example

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/connections?capability=Chat" \
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
["Chat", "Embedding"]
```

{% endcode %}

The response is a plain JSON array of the capabilities that the connection's provider supports. Experimental capabilities that are not enabled are left out. If the connection does not exist, the endpoint returns `404 Not Found`.

### Example

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/connections/openai-prod/capabilities" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

## List Enabled Capabilities

Returns the capabilities enabled on this install, whether or not any connection supports them. Use it to check whether an experimental capability is switched on.

### Endpoint

```
GET /umbraco/ai/management/api/v1/capabilities/enabled
```

### Response (200 OK)

{% code title="Response" %}

```json
["Chat", "Embedding", "SpeechToText", "Decision"]
```

{% endcode %}

The response is a plain JSON array of capability names:

- Generally available capabilities are always included.
- An experimental capability, such as `Decision`, is only included when its feature flag is enabled.
- Reserved values that have no implementation are never included.

The endpoint requires access to the AI section, like the other capability endpoints.

### Example

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/capabilities/enabled" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

## Available Capabilities

| Capability  | Description                           |
| ----------- | ------------------------------------- |
| `Chat`      | Conversational AI and text generation |
| `Embedding` | Vector embeddings for semantic search |
| `Decision`  | Typed yes/no, pick-one, and score answers (experimental) |

## Use Cases

### Check Before Creating Profile

{% code title="JavaScript" %}

```javascript
async function canCreateChatProfile() {
    const response = await fetch("/umbraco/ai/management/api/v1/connections?capability=Chat", {
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

    return await response.json();
}

// Usage
const capabilities = await getAvailableCapabilities();
// ["Chat", "Embedding"]
```

{% endcode %}
