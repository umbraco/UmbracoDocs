---
description: >-
    Create a new AI profile.
---

# Create Profile

Creates a new profile with the specified settings.

## Request

{% code title="Endpoint" %}

```http
POST /umbraco/ai/management/api/v1/profile
```

{% endcode %}

### Request Body

{% code title="Request Body" %}

```json
{
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
        "systemPromptTemplate": "You are a helpful content assistant."
    },
    "tags": ["content", "assistant"]
}
```

{% endcode %}

### Required Fields

| Field              | Type   | Description                         |
| ------------------ | ------ | ----------------------------------- |
| `alias`            | string | Unique alias (used in code)         |
| `name`             | string | Display name                        |
| `capability`       | string | `Chat` or `Embedding`               |
| `model`            | object | Model reference                     |
| `model.providerId` | string | Provider ID (for example, `openai`) |
| `model.modelId`    | string | Model ID (for example, `gpt-4o`)    |
| `connectionId`     | guid   | ID of an existing connection        |

### Optional Fields

| Field      | Type   | Description                  |
| ---------- | ------ | ---------------------------- |
| `settings` | object | Capability-specific settings |
| `tags`     | array  | Categorization tags          |

## Response

### Success

{% code title="201 Created" %}

```
Location: /umbraco/ai/management/api/v1/profile/3fa85f64-5717-4562-b3fc-2c963f66afa6

"3fa85f64-5717-4562-b3fc-2c963f66afa6"
```

{% endcode %}

### Validation Error

{% code title="400 Bad Request" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Bad Request",
    "status": 400,
    "detail": "Duplicate alias"
}
```

{% endcode %}

### Connection Not Found

{% code title="404 Not Found" %}

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

### Create Chat Profile

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/profile" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
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
      "systemPromptTemplate": "You are a helpful content assistant for an Umbraco website."
    },
    "tags": ["content", "assistant"]
  }'
```

{% endcode %}

### Create Embedding Profile

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/profile" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "alias": "document-embeddings",
    "name": "Document Embeddings",
    "capability": "Embedding",
    "model": {
      "providerId": "openai",
      "modelId": "text-embedding-3-small"
    },
    "connectionId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "settings": {
      "$type": "embedding"
    }
  }'
```

{% endcode %}

### Minimal Profile

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/profile" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "alias": "basic-chat",
    "name": "Basic Chat",
    "capability": "Chat",
    "model": {
      "providerId": "openai",
      "modelId": "gpt-4o-mini"
    },
    "connectionId": "d290f1ee-6c54-4b01-90e6-d701748f0851"
  }'
```

{% endcode %}

## Settings Structure

### Chat Settings

| Property               | Type   | Description                   |
| ---------------------- | ------ | ----------------------------- |
| `$type`                | string | Must be `"chat"`              |
| `temperature`          | float  | Response randomness (0.0-1.0) |
| `maxTokens`            | int    | Maximum output tokens         |
| `systemPromptTemplate` | string | Default system prompt         |

### Embedding Settings

| Property | Type   | Description           |
| -------- | ------ | --------------------- |
| `$type`  | string | Must be `"embedding"` |

{% hint style="warning" %}
The `alias` must be unique across all profiles. If a profile with the same alias already exists, the request will fail with a 400 error.
{% endhint %}

{% hint style="info" %}
The `connectionId` must reference an existing connection. The connection determines which API credentials are used when making AI requests with this profile.
{% endhint %}
