---
description: >-
    Run an agent with SSE streaming.
---

# Run Agent

Runs an agent and streams the response using Server-Sent Events (SSE) with the AG-UI protocol.

## Request

```http
POST /umbraco/ai/management/api/v1/agent/{idOrAlias}/run
```

### Path Parameters

| Parameter   | Type   | Description         |
| ----------- | ------ | ------------------- |
| `idOrAlias` | string | Agent GUID or alias |

### Request Body

{% code title="Request" %}

```json
{
    "messages": [
        {
            "role": "user",
            "content": "Help me write a blog post about AI"
        }
    ],
    "frontendTools": [
        {
            "name": "insert_content",
            "description": "Insert content at the cursor",
            "parameters": {
                "type": "object",
                "properties": {
                    "content": { "type": "string" }
                },
                "required": ["content"]
            }
        }
    ]
}
```

{% endcode %}

### Request Properties

| Property             | Type   | Required | Description                                    |
| -------------------- | ------ | -------- | ---------------------------------------------- |
| `messages`           | array  | Yes      | Conversation messages                          |
| `messages[].role`    | string | Yes      | Message role: `user`, `assistant`, or `system` |
| `messages[].content` | string | Yes      | Message content                                |
| `frontendTools`      | array  | No       | Frontend tool definitions                      |

## Response

This endpoint returns an SSE stream. The `Content-Type` is `text/event-stream`.

### Event Stream

```
event: run_started
data: {"type":"run_started","runId":"abc123"}

event: text_message_start
data: {"type":"text_message_start","messageId":"msg1"}

event: text_message_content
data: {"type":"text_message_content","content":"Here's a"}

event: text_message_content
data: {"type":"text_message_content","content":" blog post"}

event: text_message_end
data: {"type":"text_message_end","messageId":"msg1"}

event: run_finished
data: {"type":"run_finished","runId":"abc123"}
```

### Event Types

| Event                  | Description                 |
| ---------------------- | --------------------------- |
| `run_started`          | Agent run has begun         |
| `text_message_start`   | Beginning of a text message |
| `text_message_content` | Text content chunk          |
| `text_message_end`     | End of a text message       |
| `tool_call_start`      | Tool call initiated         |
| `tool_call_args`       | Tool argument chunk         |
| `tool_call_end`        | Tool call complete          |
| `run_finished`         | Agent run completed         |
| `run_error`            | Agent run failed            |

### Error Response

{% code title="404 Not Found" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404,
    "detail": "Agent not found"
}
```

{% endcode %}

{% code title="400 Bad Request" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Bad Request",
    "status": 400,
    "detail": "Agent is not active"
}
```

{% endcode %}

## Examples

### Basic Run

{% code title="cURL" %}

```bash
curl -N -X POST "https://your-site.com/umbraco/ai/management/api/v1/agent/content-assistant/run" \
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
curl -N -X POST "https://your-site.com/umbraco/ai/management/api/v1/agent/content-assistant/run" \
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

### With Frontend Tools

{% code title="cURL" %}

```bash
curl -N -X POST "https://your-site.com/umbraco/ai/management/api/v1/agent/content-assistant/run" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "messages": [
      { "role": "user", "content": "Insert a greeting" }
    ],
    "frontendTools": [
      {
        "name": "insert_content",
        "description": "Insert content at the cursor",
        "parameters": {
          "type": "object",
          "properties": {
            "content": { "type": "string" }
          },
          "required": ["content"]
        }
      }
    ]
  }'
```

{% endcode %}

## Related

- [Streaming](../streaming.md) - Event handling details
- [Frontend Tools](../frontend-tools.md) - Tool definitions
