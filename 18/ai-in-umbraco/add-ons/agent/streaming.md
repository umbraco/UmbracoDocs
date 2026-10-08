---
description: >-
    Handling SSE streaming and AG-UI events.
---

# Streaming

Agents expose two streaming endpoints that both return Server-Sent Events (SSE) with `Content-Type: text/event-stream`:

- [`POST /agents/{agentIdOrAlias}/stream`](api/stream.md) streams `AgentResponseUpdate` objects from Microsoft.Extensions.AI.
- [`POST /agents/{agentIdOrAlias}/stream-agui`](api/stream-agui.md) streams [AG-UI protocol](https://docs.ag-ui.com/) events.

This page describes the AG-UI event types. AG-UI event `type` values are `UPPER_SNAKE_CASE` strings that match the official AG-UI specification.

## SSE Format

Each event is serialised as a single SSE `data:` line containing the full event JSON, followed by a blank line. The event type is embedded in the JSON payload as the `type` property (via a polymorphic type discriminator) — there is no separate `event:` line.

```
data: {"type":"RUN_STARTED","threadId":"t-1","runId":"r-1"}

data: {"type":"TEXT_MESSAGE_START","messageId":"m-1","role":"assistant"}

data: {"type":"TEXT_MESSAGE_CONTENT","messageId":"m-1","delta":"Hello"}

data: {"type":"TEXT_MESSAGE_CONTENT","messageId":"m-1","delta":" world"}

data: {"type":"TEXT_MESSAGE_END","messageId":"m-1"}

data: {"type":"RUN_FINISHED","threadId":"t-1","runId":"r-1","outcome":"success"}
```

All events inherit from `BaseAGUIEvent` and therefore also carry two optional common fields:

| Property    | Type     | Description                                            |
| ----------- | -------- | ------------------------------------------------------ |
| `timestamp` | `number` | Optional Unix milliseconds timestamp.                  |
| `rawEvent`  | `object` | Optional passthrough of the underlying provider event. |

## Event Types

### Lifecycle Events

#### RUN_STARTED

Sent when an agent run begins.

```json
{
    "type": "RUN_STARTED",
    "threadId": "t-1",
    "runId": "r-1",
    "parentRunId": "parent-r-0",
    "input": { "custom": "data" }
}
```

| Property      | Type          | Required | Description                                         |
| ------------- | ------------- | -------- | --------------------------------------------------- |
| `threadId`    | `string`      | Yes      | Conversation thread identifier.                     |
| `runId`       | `string`      | Yes      | Identifier for this run.                            |
| `parentRunId` | `string`      | No       | Set when this run is nested inside another run.     |
| `input`       | `JsonElement` | No       | Optional input payload captured at the start.       |

#### RUN_FINISHED

Sent when an agent run completes (successfully or via an interrupt).

```json
{
    "type": "RUN_FINISHED",
    "threadId": "t-1",
    "runId": "r-1",
    "outcome": "success"
}
```

| Property    | Type     | Required | Description                                                        |
| ----------- | -------- | -------- | ------------------------------------------------------------------ |
| `threadId`  | `string` | Yes      | Conversation thread identifier.                                    |
| `runId`     | `string` | Yes      | Identifier for the completed run.                                  |
| `outcome`   | `string` | Yes      | `success` or `interrupt`. Defaults to `success`.                   |
| `interrupt` | `object` | No       | Set when `outcome` is `interrupt`.                                 |
| `error`     | `string` | No       | Optional error message string.                                     |
| `result`    | `object` | No       | Optional result payload.                                           |

#### RUN_ERROR

Sent when an agent run fails.

```json
{
    "type": "RUN_ERROR",
    "message": "Rate limit exceeded",
    "code": "rate_limit"
}
```

| Property  | Type     | Required | Description                                    |
| --------- | -------- | -------- | ---------------------------------------------- |
| `message` | `string` | Yes      | Human-readable error message.                  |
| `code`    | `string` | No       | Optional machine-readable error code.          |

#### STEP_STARTED

Sent when a named step inside a run begins. Useful for orchestrated workflows that emit progress per sub-agent.

```json
{
    "type": "STEP_STARTED",
    "stepName": "Researcher"
}
```

#### STEP_FINISHED

Sent when a named step inside a run completes.

```json
{
    "type": "STEP_FINISHED",
    "stepName": "Researcher"
}
```

### Text Message Events

#### TEXT_MESSAGE_START

Marks the start of a streaming text message.

```json
{
    "type": "TEXT_MESSAGE_START",
    "messageId": "m-1",
    "role": "assistant"
}
```

| Property    | Type     | Required | Description                                                |
| ----------- | -------- | -------- | ---------------------------------------------------------- |
| `messageId` | `string` | Yes      | Identifier of the message being streamed.                  |
| `role`      | `string` | Yes      | Message role (`user`, `assistant`, `system`, `tool`, etc.) |

#### TEXT_MESSAGE_CONTENT

Carries a text delta for the message.

```json
{
    "type": "TEXT_MESSAGE_CONTENT",
    "messageId": "m-1",
    "delta": "Here's how you can "
}
```

| Property    | Type     | Required | Description                              |
| ----------- | -------- | -------- | ---------------------------------------- |
| `messageId` | `string` | Yes      | Identifier of the message being streamed |
| `delta`     | `string` | Yes      | Text fragment to append to the message.  |

#### TEXT_MESSAGE_END

Marks the end of a streaming text message.

```json
{
    "type": "TEXT_MESSAGE_END",
    "messageId": "m-1"
}
```

#### TEXT_MESSAGE_CHUNK

Convenience event that combines start + content + end in a single event for simpler streaming scenarios. All fields are optional.

```json
{
    "type": "TEXT_MESSAGE_CHUNK",
    "messageId": "m-1",
    "role": "assistant",
    "delta": "Hello world"
}
```

### Tool Events

#### TOOL_CALL_START

Sent when the agent begins calling a tool.

```json
{
    "type": "TOOL_CALL_START",
    "toolCallId": "tc-1",
    "toolCallName": "insert_content",
    "parentMessageId": "m-1"
}
```

| Property          | Type     | Required | Description                                              |
| ----------------- | -------- | -------- | -------------------------------------------------------- |
| `toolCallId`      | `string` | Yes      | Unique identifier for this tool call.                    |
| `toolCallName`    | `string` | Yes      | Name of the tool being invoked.                          |
| `parentMessageId` | `string` | No       | Optional ID of the assistant message this call belongs to. |

#### TOOL_CALL_ARGS

Streams argument deltas for a tool call. Arguments are typically a JSON object streamed as string fragments; clients concatenate the deltas and parse the final string.

```json
{
    "type": "TOOL_CALL_ARGS",
    "toolCallId": "tc-1",
    "delta": "{\"content\":"
}
```

#### TOOL_CALL_END

Signals that the tool call arguments are complete. Clients should now execute the tool with the accumulated arguments.

```json
{
    "type": "TOOL_CALL_END",
    "toolCallId": "tc-1"
}
```

#### TOOL_CALL_RESULT

Carries the result of a tool execution (typically emitted by the backend for server-side tools).

```json
{
    "type": "TOOL_CALL_RESULT",
    "messageId": "m-2",
    "toolCallId": "tc-1",
    "content": "{\"status\":\"ok\"}",
    "role": "tool"
}
```

| Property     | Type     | Required | Description                                   |
| ------------ | -------- | -------- | --------------------------------------------- |
| `messageId`  | `string` | Yes      | Identifier of the tool result message.        |
| `toolCallId` | `string` | Yes      | Identifier of the tool call being answered.   |
| `content`    | `string` | Yes      | Serialised result content.                    |
| `role`       | `string` | No       | Role for the result (typically `"tool"`).     |

#### TOOL_CALL_CHUNK

Convenience event combining tool call start + args + end. All fields are optional.

```json
{
    "type": "TOOL_CALL_CHUNK",
    "toolCallId": "tc-1",
    "toolCallName": "insert_content",
    "delta": "{\"content\":\"Hello\"}"
}
```

### State Events

#### STATE_SNAPSHOT

Carries a full snapshot of the current agent state. Consumers should replace their local state with this snapshot.

```json
{
    "type": "STATE_SNAPSHOT",
    "snapshot": {
        "status": "thinking",
        "currentStep": "Researcher"
    }
}
```

#### STATE_DELTA

Carries a JSON Patch (RFC 6902) to apply to the current state.

```json
{
    "type": "STATE_DELTA",
    "delta": [
        { "op": "replace", "path": "/status", "value": "executing" }
    ]
}
```

#### MESSAGES_SNAPSHOT

Carries the full list of messages (useful after reconnect or recovery).

```json
{
    "type": "MESSAGES_SNAPSHOT",
    "messages": [
        { "id": "m-1", "role": "user", "content": "Hello" }
    ]
}
```

### Activity Events

Activity messages are frontend-only UI updates (such as "thinking", "searching", "processing") that do not become part of the conversation history.

#### ACTIVITY_SNAPSHOT

```json
{
    "type": "ACTIVITY_SNAPSHOT",
    "messageId": "act-1",
    "activityType": "thinking",
    "content": "Analysing the request...",
    "replace": true
}
```

| Property       | Type      | Required | Description                                                         |
| -------------- | --------- | -------- | ------------------------------------------------------------------- |
| `messageId`    | `string`  | Yes      | Identifier of the activity message.                                 |
| `activityType` | `string`  | Yes      | Activity category (e.g., `thinking`, `searching`, `processing`).    |
| `content`      | `string`  | Yes      | Activity content to display.                                        |
| `replace`      | `boolean` | No       | When `true`, replaces any existing activity with the same `messageId`. |

#### ACTIVITY_DELTA

Applies incremental updates to an activity snapshot using JSON Patch.

```json
{
    "type": "ACTIVITY_DELTA",
    "messageId": "act-1",
    "activityType": "thinking",
    "patch": [
        { "op": "replace", "path": "/content", "value": "Updated thinking..." }
    ]
}
```

### Special Events

#### CUSTOM

An application-specific event. The `name` identifies the custom event and `value` carries arbitrary data.

```json
{
    "type": "CUSTOM",
    "name": "confetti",
    "value": { "intensity": "high" }
}
```

#### RAW

Passes an unprocessed provider event through to the client.

```json
{
    "type": "RAW",
    "event": { "originalType": "x", "data": "..." },
    "source": "provider-name"
}
```

## Related

- [Concepts](concepts.md) - AG-UI protocol overview
- [Frontend Tools](frontend-tools.md) - Handling tool calls
- [Frontend Client](frontend-client.md) - `UaiAgentClient` for consuming these events
