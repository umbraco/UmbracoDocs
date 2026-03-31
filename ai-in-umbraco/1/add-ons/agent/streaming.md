---
description: >-
    Handling SSE streaming and AG-UI events.
---

# Streaming

Agents use Server-Sent Events (SSE) to stream responses in real-time using the AG-UI protocol.

## SSE Format

Each event follows the SSE format:

```
event: text_message_content
data: {"type":"text_message_content","content":"Hello"}

event: text_message_content
data: {"type":"text_message_content","content":" world"}

event: run_finished
data: {"type":"run_finished"}
```

## Event Types

### Lifecycle Events

#### run_started

Sent when the agent begins processing.

```json
{
    "type": "run_started",
    "runId": "abc123"
}
```

#### run_finished

Sent when the agent completes successfully.

```json
{
    "type": "run_finished",
    "runId": "abc123"
}
```

#### run_error

Sent when the agent encounters an error.

```json
{
    "type": "run_error",
    "error": "Rate limit exceeded",
    "code": "rate_limit"
}
```

### Text Message Events

#### text_message_start

Indicates the beginning of a text response.

```json
{
    "type": "text_message_start",
    "messageId": "msg123"
}
```

#### text_message_content

Contains a chunk of text content.

```json
{
    "type": "text_message_content",
    "content": "Here's how you can "
}
```

#### text_message_end

Indicates the end of a text response.

```json
{
    "type": "text_message_end",
    "messageId": "msg123"
}
```

### Tool Events

#### tool_call_start

The agent is calling a tool.

```json
{
    "type": "tool_call_start",
    "toolCallId": "tc123",
    "toolName": "insert_content"
}
```

#### tool_call_args

Tool argument chunk (streamed).

```json
{
    "type": "tool_call_args",
    "toolCallId": "tc123",
    "args": "{\"content\":"
}
```

#### tool_call_end

Tool call arguments complete.

```json
{
    "type": "tool_call_end",
    "toolCallId": "tc123",
    "args": { "content": "Hello world" }
}
```

## Related

- [Concepts](concepts.md) - AG-UI protocol overview
- [Frontend Tools](frontend-tools.md) - Handling tool calls
