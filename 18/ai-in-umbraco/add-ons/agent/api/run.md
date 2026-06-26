---
description: >-
    Run an agent and get the complete response as JSON.
---

# Run Agent

Runs an agent and returns the complete response as a single JSON payload. This endpoint is non-streaming - use [Stream Agent](stream.md) or [Stream Agent (AG-UI)](stream-agui.md) when you need incremental updates.

## Request

```http
POST /umbraco/ai/management/api/v1/agents/{agentIdOrAlias}/run
```

### Path Parameters

| Parameter        | Type   | Description         |
| ---------------- | ------ | ------------------- |
| `agentIdOrAlias` | string | Agent GUID or alias |

### Request Body

{% code title="Request" %}

```json
{
    "messages": [
        {
            "role": "user",
            "content": "Help me write a blog post about AI"
        }
    ]
}
```

{% endcode %}

### Request Properties

| Property                | Type   | Required | Description                                                      |
| ----------------------- | ------ | -------- | ---------------------------------------------------------------- |
| `messages`              | array  | Yes      | Conversation messages (must contain at least one message)        |
| `messages[].role`       | string | Yes      | Message role: `user`, `assistant`, `system`, `tool`, `developer` |
| `messages[].content`    | string | No       | Plain-text message content                                       |
| `messages[].contentParts` | array | No      | Multimodal content parts (takes precedence over `content`)       |

Each content part uses a polymorphic shape with a `type` discriminator:

```json
{ "type": "text", "text": "Describe this image:" }
{ "type": "binary", "mimeType": "image/png", "data": "<base64>", "filename": "chart.png" }
```

## Response

### Success

Returns the agent's final `AgentRunResponse` as JSON.

{% code title="200 OK" %}

```json
{
    "messages": [
        {
            "role": "assistant",
            "contents": [
                { "$type": "text", "text": "Here's a draft blog post about AI..." }
            ]
        }
    ],
    "responseId": "...",
    "usage": {
        "inputTokenCount": 42,
        "outputTokenCount": 128,
        "totalTokenCount": 170
    }
}
```

{% endcode %}

### Error Responses

{% code title="404 Not Found" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "AIAgent not found",
    "status": 404,
    "detail": "The specified agent could not be found."
}
```

{% endcode %}

{% code title="400 Bad Request" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Agent execution failed",
    "status": 400,
    "detail": "Agent is not active"
}
```

{% endcode %}

## Examples

### Basic Run

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/agents/content-assistant/run" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "messages": [
      { "role": "user", "content": "Help me write a title" }
    ]
  }'
```

{% endcode %}

### With Conversation History

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/agents/content-assistant/run" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "messages": [
      { "role": "user", "content": "Write a title about AI" },
      { "role": "assistant", "content": "Here are some options:\n1. The Rise of AI\n2. AI in Everyday Life" },
      { "role": "user", "content": "I like the second one, expand on it" }
    ]
  }'
```

{% endcode %}

## Related

- [Stream Agent](stream.md) - Stream agent response updates as SSE
- [Stream Agent (AG-UI)](stream-agui.md) - Stream AG-UI protocol events as SSE
- [Streaming](../streaming.md) - Event handling details
