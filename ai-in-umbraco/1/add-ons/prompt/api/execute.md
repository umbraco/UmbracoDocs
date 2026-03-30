---
description: >-
    Execute a prompt template.
---

# Execute Prompt

Executes a prompt with the provided variables and returns the AI response.

## Request

```http
POST /umbraco/ai/management/api/v1/prompt/{idOrAlias}/execute
```

### Path Parameters

| Parameter   | Type   | Description          |
| ----------- | ------ | -------------------- |
| `idOrAlias` | string | Prompt GUID or alias |

### Request Body

{% code title="Request" %}

```json
{
    "variables": {
        "title": "How to Bake Sourdough Bread",
        "content": "This comprehensive guide covers everything from creating your starter..."
    },
    "entityId": "content-guid",
    "entityType": "document"
}
```

{% endcode %}

### Request Properties

| Property        | Type   | Required | Description                            |
| --------------- | ------ | -------- | -------------------------------------- |
| `variables`     | object | No       | Key-value pairs for template variables |
| `entityId`      | string | No       | ID of the content entity               |
| `entityType`    | string | No       | Type of the content entity             |
| `entityContext` | string | No       | Additional context about the entity    |

## Response

### Success

{% code title="200 OK" %}

```json
{
    "response": "Discover the art of sourdough baking with our comprehensive guide. From creating your starter to achieving a perfect crust, learn expert techniques for homemade bread.",
    "promptId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "promptVersion": 3,
    "profileId": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "model": {
        "providerId": "openai",
        "modelId": "gpt-4o"
    },
    "usage": {
        "inputTokens": 85,
        "outputTokens": 42,
        "totalTokens": 127
    },
    "auditLogId": "f512g3hh-8e76-6d23-b2g8-f923960h2073"
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
    "detail": "Prompt not found"
}
```

{% endcode %}

### Prompt Inactive

{% code title="400 Bad Request" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Bad Request",
    "status": 400,
    "detail": "Prompt is not active"
}
```

{% endcode %}

### AI Error

{% code title="502 Bad Gateway" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.6.3",
    "title": "Bad Gateway",
    "status": 502,
    "detail": "AI provider returned an error: Rate limit exceeded"
}
```

{% endcode %}

## Examples

### Basic Execution

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/prompt/meta-description/execute" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "variables": {
      "title": "How to Bake Sourdough Bread",
      "content": "This guide covers everything..."
    }
  }'
```

{% endcode %}

### With Entity Context

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/prompt/summarize-article/execute" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "entityId": "1234",
    "entityType": "document",
    "variables": {
      "format": "bullet points"
    }
  }'
```

{% endcode %}

## Response Properties

| Property        | Type   | Description                      |
| --------------- | ------ | -------------------------------- |
| `response`      | string | The AI-generated response        |
| `promptId`      | guid   | Prompt that was executed         |
| `promptVersion` | int    | Prompt version at execution time |
| `profileId`     | guid   | Profile used for execution       |
| `model`         | object | Model reference                  |
| `usage`         | object | Token usage statistics           |
| `auditLogId`    | guid   | Reference to the audit log entry |
