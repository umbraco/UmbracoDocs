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

## Frontend Implementation

### Basic Client

{% code title="agent-client.ts" %}

```typescript
class AgentClient {
    private abortController?: AbortController;

    async run(
        url: string,
        messages: Array<{ role: string; content: string }>,
        handlers: {
            onContent?: (content: string) => void;
            onToolCall?: (name: string, args: unknown) => Promise<unknown>;
            onError?: (error: string) => void;
            onFinished?: () => void;
        },
    ) {
        this.abortController = new AbortController();

        const response = await fetch(url, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ messages }),
            signal: this.abortController.signal,
        });

        const reader = response.body!.getReader();
        const decoder = new TextDecoder();
        let buffer = "";
        let currentText = "";

        while (true) {
            const { done, value } = await reader.read();
            if (done) break;

            buffer += decoder.decode(value, { stream: true });
            const lines = buffer.split("\n");
            buffer = lines.pop() || "";

            for (const line of lines) {
                if (line.startsWith("data: ")) {
                    const event = JSON.parse(line.slice(6));
                    await this.handleEvent(event, handlers);
                }
            }
        }
    }

    private async handleEvent(event: any, handlers: any) {
        switch (event.type) {
            case "text_message_content":
                handlers.onContent?.(event.content);
                break;

            case "tool_call_end":
                if (handlers.onToolCall) {
                    const result = await handlers.onToolCall(event.toolName, event.args);
                    // Send result back if needed
                }
                break;

            case "run_error":
                handlers.onError?.(event.error);
                break;

            case "run_finished":
                handlers.onFinished?.();
                break;
        }
    }

    cancel() {
        this.abortController?.abort();
    }
}
```

{% endcode %}

### Usage Example

{% code title="agent-client-usage.ts" %}

```typescript
const client = new AgentClient();
const outputElement = document.getElementById("output");

await client.run("/api/agent/assistant/run", [{ role: "user", content: "Help me write a title" }], {
    onContent: (content) => {
        outputElement.textContent += content;
    },
    onToolCall: async (name, args) => {
        if (name === "insert_content") {
            insertAtCursor(args.content);
            return { success: true };
        }
    },
    onError: (error) => {
        console.error("Agent error:", error);
    },
    onFinished: () => {
        console.log("Agent finished");
    },
});
```

{% endcode %}

## Error Handling

### Connection Errors

```typescript
try {
    await client.run(url, messages, handlers);
} catch (error) {
    if (error.name === "AbortError") {
        console.log("Request was cancelled");
    } else {
        console.error("Connection error:", error);
        // Implement retry logic
    }
}
```

### Reconnection

```typescript
async function runWithRetry(url: string, messages: any[], maxRetries = 3) {
    for (let attempt = 0; attempt < maxRetries; attempt++) {
        try {
            await client.run(url, messages, handlers);
            return;
        } catch (error) {
            if (attempt === maxRetries - 1) throw error;
            await sleep(1000 * Math.pow(2, attempt)); // Exponential backoff
        }
    }
}
```

## Related

- [Concepts](concepts.md) - AG-UI protocol overview
- [Frontend Tools](frontend-tools.md) - Handling tool calls
