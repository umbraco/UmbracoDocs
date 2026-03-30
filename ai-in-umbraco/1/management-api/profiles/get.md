---
description: >-
    Get a profile by ID or alias.
---

# Get Profile

Returns the full details of a specific profile.

## Request

```http
GET /umbraco/ai/management/api/v1/profile/{idOrAlias}
```

### Path Parameters

| Parameter   | Type   | Description           |
| ----------- | ------ | --------------------- |
| `idOrAlias` | string | Profile GUID or alias |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "alias": "content-assistant",
    "name": "Content Assistant",
    "capability": "Chat",
    "model": {
        "providerId": "openai",
        "modelId": "gpt-4o"
    },
    "connectionId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "settings": {
        "$type": "chat",
        "temperature": 0.7,
        "maxTokens": 4096,
        "systemPromptTemplate": "You are a helpful content assistant for a website."
    },
    "tags": ["content", "assistant"]
}
```

{% endcode %}

### Not Found

{% code title="404 Not Found" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404,
    "detail": "Profile not found"
}
```

{% endcode %}

## Examples

### Get by ID

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/profile/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

### Get by Alias

{% code title="cURL" %}

```bash
curl -X GET "https://your-site.com/umbraco/ai/management/api/v1/profile/content-assistant" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

{% endcode %}

## Response Properties

| Property       | Type   | Description                                     |
| -------------- | ------ | ----------------------------------------------- |
| `id`           | guid   | Unique identifier                               |
| `alias`        | string | Unique alias for code references                |
| `name`         | string | Display name                                    |
| `capability`   | string | Capability type (`Chat`, `Embedding`)           |
| `model`        | object | Model reference with `providerId` and `modelId` |
| `connectionId` | guid   | ID of the connection used                       |
| `settings`     | object | Capability-specific settings                    |
| `tags`         | array  | Optional categorization tags                    |

## Settings by Capability

### Chat Profile

{% code title="Chat Settings" %}

```json
{
    "settings": {
        "$type": "chat",
        "temperature": 0.7,
        "maxTokens": 4096,
        "systemPromptTemplate": "You are a helpful assistant."
    }
}
```

{% endcode %}

### Embedding Profile

{% code title="Embedding Settings" %}

```json
{
    "settings": {
        "$type": "embedding"
    }
}
```

{% endcode %}
