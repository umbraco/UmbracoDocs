---
description: >-
    Update an existing AI profile.
---

# Update Profile

Updates an existing profile with new settings.

## Request

```http
PUT /umbraco/ai/management/api/v1/profile/{idOrAlias}
```

### Path Parameters

| Parameter   | Type   | Description           |
| ----------- | ------ | --------------------- |
| `idOrAlias` | string | Profile GUID or alias |

### Request Body

{% code title="Request Body" %}

```json
{
    "alias": "content-assistant",
    "name": "Content Assistant (Updated)",
    "model": {
        "providerId": "openai",
        "modelId": "gpt-4o"
    },
    "connectionId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "settings": {
        "$type": "chat",
        "temperature": 0.5,
        "maxTokens": 8192,
        "systemPromptTemplate": "You are an expert content assistant."
    },
    "tags": ["content", "expert"]
}
```

{% endcode %}

### Required Fields

| Field              | Type   | Description     |
| ------------------ | ------ | --------------- |
| `alias`            | string | Unique alias    |
| `name`             | string | Display name    |
| `model`            | object | Model reference |
| `model.providerId` | string | Provider ID     |
| `model.modelId`    | string | Model ID        |
| `connectionId`     | guid   | Connection ID   |

### Optional Fields

| Field      | Type   | Description                  |
| ---------- | ------ | ---------------------------- |
| `settings` | object | Capability-specific settings |
| `tags`     | array  | Categorization tags          |

{% hint style="info" %}
The `capability` cannot be changed after creation. To change capability, delete and recreate the profile.
{% endhint %}

## Response

### Success

{% code title="200 OK" %}

```
(empty body)
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

### Validation Error

{% code title="400 Bad Request" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Bad Request",
    "status": 400,
    "detail": "Connection not found"
}
```

{% endcode %}

## Examples

### Update by ID

{% code title="cURL" %}

```bash
curl -X PUT "https://your-site.com/umbraco/ai/management/api/v1/profile/3fa85f64-5717-4562-b3fc-2c963f66afa6" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "alias": "content-assistant",
    "name": "Content Assistant (Updated)",
    "model": {
      "providerId": "openai",
      "modelId": "gpt-4o"
    },
    "connectionId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "settings": {
      "$type": "chat",
      "temperature": 0.5,
      "maxTokens": 8192,
      "systemPromptTemplate": "You are an expert content assistant."
    }
  }'
```

{% endcode %}

### Update by Alias

{% code title="cURL" %}

```bash
curl -X PUT "https://your-site.com/umbraco/ai/management/api/v1/profile/content-assistant" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "alias": "content-assistant",
    "name": "Content Assistant v2",
    "model": {
      "providerId": "openai",
      "modelId": "gpt-4o-mini"
    },
    "connectionId": "d290f1ee-6c54-4b01-90e6-d701748f0851"
  }'
```

{% endcode %}

### Change Model

{% code title="cURL" %}

```bash
curl -X PUT "https://your-site.com/umbraco/ai/management/api/v1/profile/content-assistant" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "alias": "content-assistant",
    "name": "Content Assistant",
    "model": {
      "providerId": "openai",
      "modelId": "gpt-4o-mini"
    },
    "connectionId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "settings": {
      "$type": "chat",
      "temperature": 0.7,
      "maxTokens": 4096
    }
  }'
```

{% endcode %}

### Update Tags

{% code title="cURL" %}

```bash
curl -X PUT "https://your-site.com/umbraco/ai/management/api/v1/profile/content-assistant" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "alias": "content-assistant",
    "name": "Content Assistant",
    "model": {
      "providerId": "openai",
      "modelId": "gpt-4o"
    },
    "connectionId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "tags": ["content", "production", "primary"]
  }'
```

{% endcode %}

## Common Updates

### Adjusting Temperature

Lower temperature (0.0-0.3) for more consistent, factual responses:

```json
{
    "settings": {
        "$type": "chat",
        "temperature": 0.2
    }
}
```

Higher temperature (0.7-1.0) for more creative responses:

```json
{
    "settings": {
        "$type": "chat",
        "temperature": 0.9
    }
}
```

### Updating System Prompt

```json
{
    "settings": {
        "$type": "chat",
        "systemPromptTemplate": "You are a helpful assistant for {{siteName}}. Always be concise and helpful."
    }
}
```
