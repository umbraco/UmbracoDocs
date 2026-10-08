---
description: >-
    Stream agent response updates as Server-Sent Events.
---

# Stream Agent

Runs an agent and streams incremental response updates as Server-Sent Events (SSE). Each event carries a serialized `AgentResponseUpdate` from Microsoft.Extensions.AI.

Use [Stream Agent (AG-UI)](stream-agui.md) when you need the AG-UI protocol (for example, for CopilotKit-compatible clients). Use [Run Agent](run.md) when you only need the final response.

## Request

```http
POST /umbraco/ai/management/api/v1/agents/{agentIdOrAlias}/stream
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

| Property             | Type   | Required | Description                                                      |
| -------------------- | ------ | -------- | ---------------------------------------------------------------- |
| `messages`           | array  | Yes      | Conversation messages (must contain at least one message)        |
| `messages[].role`    | string | Yes      | Message role: `user`, `assistant`, `system`, `tool`, `developer` |
| `messages[].content` | string | No       | Plain-text message content                                       |
| `messages[].contentParts` | array | No  | Multimodal content parts (takes precedence over `content`)       |

## Response

The endpoint returns `Content-Type: text/event-stream`. Each update is emitted as a single SSE `data:` line containing the JSON-serialized update, followed by a blank line:

```
data: {"role":"assistant","contents":[{"$type":"text","text":"Here's"}]}

data: {"role":"assistant","contents":[{"$type":"text","text":" a draft"}]}

data: {"role":"assistant","contents":[{"$type":"text","text":" blog post..."}]}
```

{% hint style="info" %}
The stream uses only `data:` lines - there is no `event:` line. The event payload follows the `AgentResponseUpdate` shape from Microsoft.Extensions.AI, serialized with camelCase property names.
{% endhint %}

### Error Handling

If the agent cannot be resolved, the endpoint returns `404 Not Found` with a problem details response (not SSE). Errors raised during streaming are emitted as a final SSE `data:` line in the form `{"error":"..."}`.

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

## Examples

### Consume with cURL

{% code title="cURL" %}

```bash
curl -N -X POST "https://your-site.com/umbraco/ai/management/api/v1/agents/content-assistant/stream" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -H "Accept: text/event-stream" \
  -d '{
    "messages": [
      { "role": "user", "content": "Help me write a title" }
    ]
  }'
```

{% endcode %}

## Related

- [Run Agent](run.md) - Non-streaming JSON response
- [Stream Agent (AG-UI)](stream-agui.md) - Stream AG-UI protocol events
- [Streaming](../streaming.md) - Event handling details
