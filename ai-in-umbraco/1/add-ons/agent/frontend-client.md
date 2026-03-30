---
description: >-
    Build custom agent-driven UIs using the UaiAgentClient base client.
---

# Frontend Client (UaiAgentClient)

The `UaiAgentClient` is a TypeScript client for building custom agent-driven user interfaces in the Umbraco backoffice. It provides a callback-based interface for consuming the AG-UI protocol with automatic event handling and message management.

## Overview

`UaiAgentClient` is exported from the `@umbraco-ai/agent` package and serves as the foundation for building agent-based chat interfaces. It's the same client that powers the Agent Copilot sidebar.

**Key features:**

- Callback-based event handling for streaming responses
- Automatic message conversion to AG-UI format
- Tool call argument accumulation during streaming
- Interrupt handling for human-in-the-loop workflows
- Dependency injection support for testing

## Installation

The client is included in the Agent package:

{% code title="Package Manager Console" %}

```powershell
Install-Package Umbraco.AI.Agent
```

{% endcode %}

Or via .NET CLI:

{% code title="Terminal" %}

```bash
dotnet add package Umbraco.AI.Agent
```

{% endcode %}

## Import

{% code title="TypeScript" %}

```typescript
import { UaiAgentClient, type UaiChatMessage, type AgentClientCallbacks } from "@umbraco-ai/agent";
```

{% endcode %}

## Quick Start

{% code title="Basic Usage" %}

```typescript
import { LitElement, html } from "lit";
import { customElement, state } from "lit/decorators.js";
import { UaiAgentClient, type UaiChatMessage } from "@umbraco-ai/agent";

@customElement("my-agent-chat")
export class MyAgentChat extends LitElement {
    #client?: UaiAgentClient;

    @state()
    private _messages: UaiChatMessage[] = [];

    @state()
    private _streamingContent = "";

    @state()
    private _isRunning = false;

    connectedCallback() {
        super.connectedCallback();

        // Create client with callbacks
        this.#client = UaiAgentClient.create(
            { agentId: "your-agent-id" },
            {
                onTextStart: () => {
                    this._isRunning = true;
                    this._streamingContent = "";
                },
                onTextDelta: (delta) => {
                    this._streamingContent += delta;
                },
                onTextEnd: () => {
                    // Add completed message
                    this._messages = [
                        ...this._messages,
                        {
                            id: crypto.randomUUID(),
                            role: "assistant",
                            content: this._streamingContent,
                            timestamp: new Date(),
                        },
                    ];
                    this._streamingContent = "";
                },
                onRunFinished: () => {
                    this._isRunning = false;
                },
                onError: (error) => {
                    console.error("Agent error:", error);
                    this._isRunning = false;
                },
            },
        );
    }

    #sendMessage(content: string) {
        if (!this.#client || !content.trim()) return;

        const userMessage: UaiChatMessage = {
            id: crypto.randomUUID(),
            role: "user",
            content,
            timestamp: new Date(),
        };

        this._messages = [...this._messages, userMessage];
        this.#client.sendMessage(this._messages);
    }

    render() {
        return html`
            <div class="chat-container">
                ${this._messages.map((msg) => html` <div class="message ${msg.role}">${msg.content}</div> `)}
                ${this._streamingContent
                    ? html` <div class="message assistant streaming">${this._streamingContent}</div> `
                    : ""}
                <input
                    @keydown=${(e: KeyboardEvent) => {
                        if (e.key === "Enter") {
                            const input = e.target as HTMLInputElement;
                            this.#sendMessage(input.value);
                            input.value = "";
                        }
                    }}
                    ?disabled=${this._isRunning}
                    placeholder="Type your message..."
                />
            </div>
        `;
    }
}
```

{% endcode %}

## API Reference

### Factory Method

#### `UaiAgentClient.create(config, callbacks?)`

Creates a new client instance with the default HTTP transport.

**Parameters:**

| Parameter   | Type                   | Required | Description          |
| ----------- | ---------------------- | -------- | -------------------- |
| `config`    | `UaiAgentClientConfig` | Yes      | Client configuration |
| `callbacks` | `AgentClientCallbacks` | No       | Event callbacks      |

**Returns:** `UaiAgentClient`

**Example:**

```typescript
const client = UaiAgentClient.create(
    { agentId: "550e8400-e29b-41d4-a716-446655440000" },
    {
        onTextDelta: (delta) => console.log(delta),
        onRunFinished: () => console.log("Done"),
    },
);
```

### Constructor

#### `new UaiAgentClient(transport, callbacks?)`

Creates a client with a custom transport. Useful for testing or custom implementations.

**Parameters:**

| Parameter   | Type                   | Required | Description                     |
| ----------- | ---------------------- | -------- | ------------------------------- |
| `transport` | `AgentTransport`       | Yes      | Custom transport implementation |
| `callbacks` | `AgentClientCallbacks` | No       | Event callbacks                 |

**Example:**

```typescript
import { UaiHttpAgent } from "@umbraco-ai/agent";

const transport = new UaiHttpAgent({ agentId: "my-agent" });
const client = new UaiAgentClient(transport, {
    onTextDelta: (delta) => console.log(delta),
});
```

### Instance Methods

#### `sendMessage(messages, tools?, context?)`

Sends messages to the agent and starts a new run.

**Parameters:**

| Parameter  | Type                                          | Required | Description                     |
| ---------- | --------------------------------------------- | -------- | ------------------------------- |
| `messages` | `UaiChatMessage[]`                            | Yes      | Conversation messages           |
| `tools`    | `AGUITool[]`                                  | No       | Available tools for the agent   |
| `context`  | `Array<{description: string, value: string}>` | No       | Context items for LLM awareness |

**Returns:** `void`

**Example:**

```typescript
client.sendMessage(
    [{ id: "1", role: "user", content: "Hello", timestamp: new Date() }],
    undefined, // No tools
    [{ description: "Current content item", value: "Document: Home Page" }],
);
```

#### `setCallbacks(callbacks)`

Updates the callbacks dynamically.

**Parameters:**

| Parameter   | Type                   | Required | Description   |
| ----------- | ---------------------- | -------- | ------------- |
| `callbacks` | `AgentClientCallbacks` | Yes      | New callbacks |

**Returns:** `void`

**Example:**

```typescript
client.setCallbacks({
    onTextDelta: (delta) => console.log("New handler:", delta),
});
```

#### `reset()`

Resets the client state. Clears pending tool arguments.

**Returns:** `void`

**Example:**

```typescript
client.reset();
```

## Callbacks

The `AgentClientCallbacks` interface defines all available event handlers:

### Text Streaming

| Callback      | Parameters                    | Description                           |
| ------------- | ----------------------------- | ------------------------------------- |
| `onTextStart` | `(messageId: string) => void` | Called when a new text message starts |
| `onTextDelta` | `(delta: string) => void`     | Called when a text chunk is received  |
| `onTextEnd`   | `() => void`                  | Called when text message is complete  |

### Tool Calls

| Callback            | Parameters                             | Description                                             |
| ------------------- | -------------------------------------- | ------------------------------------------------------- |
| `onToolCallStart`   | `(info: UaiToolCallInfo) => void`      | Called when a tool call starts                          |
| `onToolCallArgsEnd` | `(id: string, args: string) => void`   | Called when tool arguments are complete                 |
| `onToolCallEnd`     | `(id: string) => void`                 | Called when tool call completes (args streamed)         |
| `onToolCallResult`  | `(id: string, result: string) => void` | Called when tool result is received (backend execution) |

### Run Lifecycle

| Callback        | Parameters                          | Description                                                 |
| --------------- | ----------------------------------- | ----------------------------------------------------------- |
| `onRunFinished` | `(event: RunFinishedEvent) => void` | Called when the run finishes (success, interrupt, or error) |
| `onError`       | `(error: Error) => void`            | Called on error                                             |

### State Updates

| Callback             | Parameters                                | Description                               |
| -------------------- | ----------------------------------------- | ----------------------------------------- |
| `onStateSnapshot`    | `(state: UaiAgentState) => void`          | Called when a state snapshot is received  |
| `onStateDelta`       | `(delta: Partial<UaiAgentState>) => void` | Called when a state delta is received     |
| `onMessagesSnapshot` | `(messages: UaiChatMessage[]) => void`    | Called when messages snapshot is received |

## Message Format

Messages use the `UaiChatMessage` interface:

```typescript
interface UaiChatMessage {
    id: string;
    role: "user" | "assistant" | "tool";
    content: string;
    toolCalls?: UaiToolCallInfo[];
    toolCallId?: string; // Required for tool role messages
    timestamp: Date;
}
```

**Example messages:**

{% code title="User Message" %}

```typescript
const userMessage: UaiChatMessage = {
    id: crypto.randomUUID(),
    role: "user",
    content: "Help me write a blog post",
    timestamp: new Date(),
};
```

{% endcode %}

{% code title="Assistant Message with Tool Call" %}

```typescript
const assistantMessage: UaiChatMessage = {
    id: crypto.randomUUID(),
    role: "assistant",
    content: "",
    toolCalls: [
        {
            id: "call_123",
            name: "search_content",
            arguments: '{"query": "blog posts"}',
            status: "completed",
        },
    ],
    timestamp: new Date(),
};
```

{% endcode %}

{% code title="Tool Result Message" %}

```typescript
const toolMessage: UaiChatMessage = {
    id: crypto.randomUUID(),
    role: "tool",
    content: "Found 5 blog posts",
    toolCallId: "call_123",
    timestamp: new Date(),
};
```

{% endcode %}

## Complete Example

{% code title="Full Agent Chat Component" %}

```typescript
import { LitElement, html, css } from "lit";
import { customElement, state } from "lit/decorators.js";
import { UaiAgentClient, type UaiChatMessage, type UaiAgentState } from "@umbraco-ai/agent";

@customElement("uai-custom-chat")
export class UaiCustomChat extends LitElement {
    static styles = css`
        :host {
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        .messages {
            flex: 1;
            overflow-y: auto;
            padding: 1rem;
        }
        .message {
            margin-bottom: 1rem;
            padding: 0.5rem;
            border-radius: 4px;
        }
        .message.user {
            background: #e3f2fd;
        }
        .message.assistant {
            background: #f5f5f5;
        }
        .message.streaming {
            opacity: 0.7;
        }
        .input-container {
            padding: 1rem;
            border-top: 1px solid #ddd;
        }
        input {
            width: 100%;
            padding: 0.5rem;
        }
        .status {
            padding: 0.5rem;
            background: #fff3cd;
            text-align: center;
        }
    `;

    #client?: UaiAgentClient;

    @state()
    private _messages: UaiChatMessage[] = [];

    @state()
    private _streamingContent = "";

    @state()
    private _agentState?: UaiAgentState;

    connectedCallback() {
        super.connectedCallback();
        this.#initializeClient();
    }

    #initializeClient() {
        this.#client = UaiAgentClient.create(
            { agentId: "your-agent-id" },
            {
                onTextStart: (messageId) => {
                    this._streamingContent = "";
                    this._agentState = { status: "thinking" };
                },
                onTextDelta: (delta) => {
                    this._streamingContent += delta;
                },
                onTextEnd: () => {
                    if (this._streamingContent) {
                        this._messages = [
                            ...this._messages,
                            {
                                id: crypto.randomUUID(),
                                role: "assistant",
                                content: this._streamingContent,
                                timestamp: new Date(),
                            },
                        ];
                        this._streamingContent = "";
                    }
                },
                onToolCallStart: (info) => {
                    console.log("Tool call started:", info.name);
                    this._agentState = { status: "executing", currentStep: info.name };
                },
                onToolCallResult: (id, result) => {
                    console.log("Tool result:", result);
                },
                onStateSnapshot: (state) => {
                    this._agentState = state;
                },
                onStateDelta: (delta) => {
                    this._agentState = { ...this._agentState, ...delta } as UaiAgentState;
                },
                onRunFinished: (event) => {
                    if (event.outcome === "success") {
                        this._agentState = undefined;
                    } else if (event.outcome === "error") {
                        console.error("Run error:", event.error);
                        this._agentState = undefined;
                    } else if (event.outcome === "interrupt") {
                        console.log("Run interrupted:", event.interrupt);
                    }
                },
                onError: (error) => {
                    console.error("Agent error:", error);
                    this._agentState = undefined;
                },
            },
        );
    }

    #sendMessage(content: string) {
        if (!this.#client || !content.trim()) return;

        const userMessage: UaiChatMessage = {
            id: crypto.randomUUID(),
            role: "user",
            content,
            timestamp: new Date(),
        };

        this._messages = [...this._messages, userMessage];
        this.#client.sendMessage(this._messages);
    }

    #resetConversation() {
        this._messages = [];
        this._streamingContent = "";
        this._agentState = undefined;
        this.#client?.reset();
    }

    render() {
        return html`
            ${this._agentState
                ? html`
                      <div class="status">
                          ${this._agentState.status === "thinking" ? "Thinking..." : ""}
                          ${this._agentState.status === "executing"
                              ? `Executing: ${this._agentState.currentStep || "tool"}`
                              : ""}
                      </div>
                  `
                : ""}

            <div class="messages">
                ${this._messages.map(
                    (msg) => html`
                        <div class="message ${msg.role}">
                            <strong>${msg.role}:</strong> ${msg.content}
                            ${msg.toolCalls
                                ? html`
                                      <div class="tool-calls">
                                          ${msg.toolCalls.map(
                                              (tc) => html` <div>Tool: ${tc.name} (${tc.status})</div> `,
                                          )}
                                      </div>
                                  `
                                : ""}
                        </div>
                    `,
                )}
                ${this._streamingContent
                    ? html`
                          <div class="message assistant streaming">
                              <strong>assistant:</strong> ${this._streamingContent}
                          </div>
                      `
                    : ""}
            </div>

            <div class="input-container">
                <input
                    @keydown=${(e: KeyboardEvent) => {
                        if (e.key === "Enter") {
                            const input = e.target as HTMLInputElement;
                            this.#sendMessage(input.value);
                            input.value = "";
                        }
                    }}
                    ?disabled=${!!this._agentState}
                    placeholder="Type your message and press Enter..."
                />
                <button @click=${this.#resetConversation}>Reset</button>
            </div>
        `;
    }
}
```

{% endcode %}

## Advanced: Custom Transport

For testing or custom implementations, you can provide your own transport:

{% code title="Custom Transport" %}

```typescript
import { Observable } from "rxjs";
import type { AgentTransport, BaseEvent, Message } from "@umbraco-ai/agent";
import type { RunAgentInput } from "@ag-ui/client";

class MockTransport implements AgentTransport {
    #messages: Message[] = [];

    run(input: RunAgentInput): Observable<BaseEvent> {
        return new Observable((observer) => {
            // Simulate text streaming
            observer.next({ type: "text_message_start", messageId: "1" });
            observer.next({ type: "text_message_content", delta: "Hello" });
            observer.next({ type: "text_message_content", delta: " world" });
            observer.next({ type: "text_message_end" });
            observer.next({ type: "run_finished", outcome: "success" });
            observer.complete();
        });
    }

    setMessages(messages: Message[]): void {
        this.#messages = messages;
    }

    abortRun(): void {
        // Handle abort
    }
}

// Use the mock transport
const client = new UaiAgentClient(new MockTransport(), {
    onTextDelta: (delta) => console.log(delta),
});
```

{% endcode %}

## TypeScript Types

All types are exported from `@umbraco-ai/agent`:

```typescript
import type {
    UaiAgentClient,
    UaiAgentClientConfig,
    UaiChatMessage,
    UaiToolCallInfo,
    UaiToolCallStatus,
    UaiInterruptInfo,
    UaiAgentState,
    AgentClientCallbacks,
    AgentTransport,
    RunFinishedEvent,
    AGUITool,
} from "@umbraco-ai/agent";
```

## Related

- [Agent Copilot](../agent-copilot/README.md) - Reference implementation using UaiAgentClient
- [Streaming](streaming.md) - AG-UI protocol and event types
- [Frontend Tools](../agent-copilot/frontend-tools.md) - Browser-executable tools
