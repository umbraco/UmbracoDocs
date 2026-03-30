---
description: >-
    TypeScript type definitions for chat operations.
---

# Types

The Umbraco.AI frontend exports TypeScript types for type-safe chat integration.

## Import

{% code title="Import" %}

```typescript
import type {
    UaiChatRole,
    UaiChatMessage,
    UaiChatUsage,
    UaiChatResult,
    UaiChatStreamChunk,
    UaiChatOptions,
    UaiChatRequest,
} from "@umbraco-ai/backoffice";
```

{% endcode %}

## Message Types

### UaiChatRole

The role of a message participant.

{% code title="UaiChatRole" %}

```typescript
type UaiChatRole = "user" | "assistant" | "system";
```

{% endcode %}

| Value         | Description           |
| ------------- | --------------------- |
| `'user'`      | Message from the user |
| `'assistant'` | Message from the AI   |
| `'system'`    | System instructions   |

### UaiChatMessage

Represents a single message in the conversation.

{% code title="UaiChatMessage" %}

```typescript
interface UaiChatMessage {
    /** The role of the message author. */
    role: UaiChatRole;
    /** The message content. */
    content: string;
}
```

{% endcode %}

{% code title="Example" %}

```typescript
const messages: UaiChatMessage[] = [
    { role: "system", content: "You are a helpful assistant." },
    { role: "user", content: "What is Umbraco?" },
    { role: "assistant", content: "Umbraco is an open-source CMS built on .NET." },
    { role: "user", content: "Tell me more about its features." },
];
```

{% endcode %}

## Response Types

### UaiChatUsage

Token usage statistics from a completion.

{% code title="UaiChatUsage" %}

```typescript
interface UaiChatUsage {
    /** Number of tokens in the input/prompt. */
    inputTokens?: number | null;
    /** Number of tokens in the output/response. */
    outputTokens?: number | null;
    /** Total tokens used (input + output). */
    totalTokens?: number | null;
}
```

{% endcode %}

### UaiChatResult

The result of a chat completion.

{% code title="UaiChatResult" %}

```typescript
interface UaiChatResult {
    /** The assistant's response message. */
    message: UaiChatMessage;
    /** Why the response ended (e.g., 'stop', 'length'). */
    finishReason?: string | null;
    /** Token usage statistics. */
    usage?: UaiChatUsage | null;
}
```

{% endcode %}

{% code title="Example" %}

```typescript
const { data } = await chat.complete(messages);

if (data) {
    console.log("Response:", data.message.content);
    console.log("Role:", data.message.role); // 'assistant'
    console.log("Finish reason:", data.finishReason); // 'stop'
    console.log("Total tokens:", data.usage?.totalTokens);
}
```

{% endcode %}

### UaiChatStreamChunk

A chunk from a streaming response.

{% code title="UaiChatStreamChunk" %}

```typescript
interface UaiChatStreamChunk {
    /** The content fragment. */
    content: string;
    /** Set on the final chunk with reason. */
    finishReason?: string | null;
}
```

{% endcode %}

## Request Types

### UaiChatOptions

Options for the `UaiChatController` methods.

{% code title="UaiChatOptions" %}

```typescript
interface UaiChatOptions {
    /** Profile ID (GUID) or alias. If omitted, uses the default chat profile. */
    profileIdOrAlias?: string;
    /** AbortSignal for cancellation. */
    signal?: AbortSignal;
}
```

{% endcode %}

{% code title="Example" %}

```typescript
// Using default profile
await chat.complete(messages);

// Using specific profile
await chat.complete(messages, {
    profileIdOrAlias: "content-assistant",
});

// With cancellation support
const controller = new AbortController();
await chat.complete(messages, {
    profileIdOrAlias: "content-assistant",
    signal: controller.signal,
});

// Cancel the request
controller.abort();
```

{% endcode %}

### UaiChatRequest

Internal request type used by `UaiChatRepository`.

{% code title="UaiChatRequest" %}

```typescript
interface UaiChatRequest {
    /** Profile ID or alias. Null uses default profile. */
    profileIdOrAlias?: string | null;
    /** The conversation messages. */
    messages: UaiChatMessage[];
    /** AbortSignal for cancellation. */
    signal?: AbortSignal;
}
```

{% endcode %}

## Finish Reasons

Common values for `finishReason`:

| Value              | Description              |
| ------------------ | ------------------------ |
| `'stop'`           | Model finished naturally |
| `'length'`         | Hit max tokens limit     |
| `'content_filter'` | Content was filtered     |
| `null`             | Reason not provided      |

## Type Guards

{% code title="Type Guard Examples" %}

```typescript
function isUserMessage(msg: UaiChatMessage): boolean {
    return msg.role === "user";
}

function hasUsage(result: UaiChatResult): result is UaiChatResult & { usage: UaiChatUsage } {
    return result.usage !== null && result.usage !== undefined;
}

// Usage
const { data } = await chat.complete(messages);

if (data && hasUsage(data)) {
    console.log(`Used ${data.usage.totalTokens} tokens`);
}
```

{% endcode %}

## Building Conversations

{% code title="Conversation Helper" %}

```typescript
import type { UaiChatMessage } from "@umbraco-ai/backoffice";

class Conversation {
    #messages: UaiChatMessage[] = [];

    constructor(systemPrompt?: string) {
        if (systemPrompt) {
            this.#messages.push({ role: "system", content: systemPrompt });
        }
    }

    addUser(content: string): this {
        this.#messages.push({ role: "user", content });
        return this;
    }

    addAssistant(content: string): this {
        this.#messages.push({ role: "assistant", content });
        return this;
    }

    get messages(): UaiChatMessage[] {
        return [...this.#messages];
    }

    get lastMessage(): UaiChatMessage | undefined {
        return this.#messages[this.#messages.length - 1];
    }
}

// Usage
const convo = new Conversation("You are a helpful assistant.").addUser("What is Umbraco?");

const { data } = await chat.complete(convo.messages);

if (data) {
    convo.addAssistant(data.message.content);
    // Continue conversation...
    convo.addUser("Tell me more");
}
```

{% endcode %}
