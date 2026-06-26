---
description: >-
    Stream AG-UI protocol events as Server-Sent Events.
---

# Stream Agent (AG-UI)

Runs an agent and streams events using the [AG-UI protocol](https://docs.ag-ui.com/) over Server-Sent Events (SSE). This endpoint is designed for AG-UI-compatible clients such as CopilotKit.

Use [Stream Agent](stream.md) if you need a simpler Microsoft.Extensions.AI stream, or [Run Agent](run.md) for a non-streaming JSON response.

## Request

```http
POST /umbraco/ai/management/api/v1/agents/{agentIdOrAlias}/stream-agui
```

### Path Parameters

| Parameter        | Type   | Description                                                              |
| ---------------- | ------ | ------------------------------------------------------------------------ |
| `agentIdOrAlias` | string | Agent GUID, alias, or the special value `auto` for automatic selection   |

{% hint style="info" %}
Passing the alias `auto` enables automatic agent selection based on the user's prompt and the provided AG-UI context. When using `auto`, the AG-UI context must include a surface.
{% endhint %}

### Request Body

The request body follows the AG-UI `RunAgentInput` shape:

{% code title="AG-UI Run Request" %}

```json
{
    "threadId": "thread-123",
    "runId": "run-456",
    "messages": [
        {
            "id": "msg-1",
            "role": "user",
            "content": "Help me write a blog post about AI"
        }
    ],
    "tools": [
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
    ],
    "context": [
        { "description": "surface", "value": "copilot" }
    ],
    "state": null,
    "forwardedProps": {
        "toolMetadata": [
            { "toolName": "insert_content", "scope": "content-write", "isDestructive": false }
        ]
    }
}
```

{% endcode %}

### Request Properties

| Property         | Type   | Required | Description                                                       |
| ---------------- | ------ | -------- | ----------------------------------------------------------------- |
| `threadId`       | string | Yes      | The conversation thread identifier                                |
| `runId`          | string | Yes      | The run identifier                                                |
| `messages`       | array  | Yes      | Conversation messages in AG-UI format                             |
| `tools`          | array  | No       | Frontend tool definitions available to the agent                  |
| `context`        | array  | No       | AG-UI context items (each has `description` and `value`)          |
| `state`          | object | No       | Current state as JSON                                             |
| `resume`         | object | No       | Resume information for continuing from an interrupt               |
| `forwardedProps` | object | No       | Additional properties forwarded to the agent                      |

AG-UI message `role` values are: `user`, `assistant`, `system`, `tool`, or `developer`.

## Response

The endpoint returns `Content-Type: text/event-stream`. Each event is emitted as a single SSE `data:` line containing the JSON-serialized event, followed by a blank line. There is no `event:` line - the event type is embedded in the JSON payload as a `type` discriminator:

```
data: {"type":"RUN_STARTED","threadId":"thread-123","runId":"run-456"}

data: {"type":"TEXT_MESSAGE_START","messageId":"msg-1","role":"assistant"}

data: {"type":"TEXT_MESSAGE_CONTENT","messageId":"msg-1","delta":"Here's a"}

data: {"type":"TEXT_MESSAGE_CONTENT","messageId":"msg-1","delta":" blog post"}

data: {"type":"TEXT_MESSAGE_END","messageId":"msg-1"}

data: {"type":"RUN_FINISHED","threadId":"thread-123","runId":"run-456"}
```

### Event Types

Event type values are UPPER\_SNAKE\_CASE and match the official AG-UI specification.

| Event type              | Category  | Description                                         |
| ----------------------- | --------- | --------------------------------------------------- |
| `RUN_STARTED`           | Lifecycle | Agent run has begun                                 |
| `RUN_FINISHED`          | Lifecycle | Agent run completed successfully                    |
| `RUN_ERROR`             | Lifecycle | Agent run failed                                    |
| `STEP_STARTED`          | Lifecycle | A step within the run has begun                     |
| `STEP_FINISHED`         | Lifecycle | A step within the run has finished                  |
| `TEXT_MESSAGE_START`    | Message   | Beginning of a text message                         |
| `TEXT_MESSAGE_CONTENT`  | Message   | Text content delta                                  |
| `TEXT_MESSAGE_END`      | Message   | End of a text message                               |
| `TEXT_MESSAGE_CHUNK`    | Message   | Combined message chunk                              |
| `TOOL_CALL_START`       | Tools     | Tool call initiated                                 |
| `TOOL_CALL_ARGS`        | Tools     | Tool arguments delta                                |
| `TOOL_CALL_END`         | Tools     | Tool call arguments complete                        |
| `TOOL_CALL_RESULT`      | Tools     | Tool result                                         |
| `TOOL_CALL_CHUNK`       | Tools     | Combined tool call chunk                            |
| `STATE_SNAPSHOT`        | State     | Full state snapshot                                 |
| `STATE_DELTA`           | State     | State change (JSON Patch)                           |
| `MESSAGES_SNAPSHOT`     | State     | Full messages snapshot                              |
| `ACTIVITY_SNAPSHOT`     | Activity  | Activity snapshot                                   |
| `ACTIVITY_DELTA`        | Activity  | Activity change                                     |
| `CUSTOM`                | Special   | Custom event (used for e.g. `agent_selected` in auto mode) |
| `RAW`                   | Special   | Passthrough raw event                               |

### Auto Agent Selection

When `agentIdOrAlias` is `auto`, the stream is prepended with a `CUSTOM` event named `agent_selected` describing which agent was chosen:

```
data: {"type":"CUSTOM","name":"agent_selected","value":{"agentId":"3fa85f64-...","agentName":"Content Assistant","agentAlias":"content-assistant"}}
```

### Error Responses

HTTP-level errors are returned as problem details (not as SSE). Errors that occur during streaming are emitted as `RUN_ERROR` events in the stream.

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

{% code title="400 Bad Request (auto mode without surface)" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Surface is required for auto agent selection",
    "status": 400,
    "detail": "The AG-UI context must include a surface to use 'auto' agent selection."
}
```

{% endcode %}

## Examples

### Consume with cURL

{% code title="cURL" %}

```bash
curl -N -X POST "https://your-site.com/umbraco/ai/management/api/v1/agents/content-assistant/stream-agui" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -H "Accept: text/event-stream" \
  -d '{
    "threadId": "thread-123",
    "runId": "run-456",
    "messages": [
      { "id": "msg-1", "role": "user", "content": "Help me write a title" }
    ]
  }'
```

{% endcode %}

## Related

- [Run Agent](run.md) - Non-streaming JSON response
- [Stream Agent](stream.md) - Microsoft.Extensions.AI SSE stream
- [Streaming](../streaming.md) - AG-UI event handling details
- [Frontend Tools](../frontend-tools.md) - Tool definitions
