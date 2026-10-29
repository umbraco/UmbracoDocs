---
description: >-
    TypeScript type definitions for all frontend AI operations.
---

# Types

The Umbraco.AI frontend exports TypeScript types for type-safe AI integration across chat, embeddings, speech-to-text, decisions, and tools.

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
    UaiEmbeddingOptions,
    UaiEmbeddingResult,
    UaiEmbeddingItem,
    UaiSpeechToTextOptions,
    UaiSpeechToTextResult,
    UaiDecisionQuestion,
    UaiDecisionResult,
    UaiDecisionOptions,
    UaiToolScope,
    UaiToolItem,
} from "@umbraco-ai/core";
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
import type { UaiChatMessage } from "@umbraco-ai/core";

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

## Embedding Types

### UaiEmbeddingOptions

Options for the `UaiEmbeddingsController` methods.

{% code title="UaiEmbeddingOptions" %}

```typescript
interface UaiEmbeddingOptions {
    /** Profile ID (GUID) or alias. If omitted, uses the default embedding profile. */
    profileIdOrAlias?: string;
    /** AbortSignal for cancellation. */
    signal?: AbortSignal;
}
```

{% endcode %}

### UaiEmbeddingResult

The result of a batch embedding generation.

{% code title="UaiEmbeddingResult" %}

```typescript
interface UaiEmbeddingResult {
    embeddings: UaiEmbeddingItem[];
}
```

{% endcode %}

### UaiEmbeddingItem

A single embedding vector with its index in the batch.

{% code title="UaiEmbeddingItem" %}

```typescript
interface UaiEmbeddingItem {
    index: number;
    vector: number[];
}
```

{% endcode %}

## Speech-to-Text Types

### UaiSpeechToTextOptions

Options for the `UaiSpeechToTextController.transcribe` method.

{% code title="UaiSpeechToTextOptions" %}

```typescript
interface UaiSpeechToTextOptions {
    /** Profile ID (GUID) or alias. If omitted, uses the default speech-to-text profile. */
    profileIdOrAlias?: string;
    /** BCP-47 language hint (e.g., "en", "de"). */
    language?: string;
    /** AbortSignal for cancellation. */
    signal?: AbortSignal;
}
```

{% endcode %}

### UaiSpeechToTextResult

The result of a speech-to-text transcription.

{% code title="UaiSpeechToTextResult" %}

```typescript
interface UaiSpeechToTextResult {
    text: string;
}
```

{% endcode %}

## Decision Types

{% hint style="warning" %}
Decision is experimental. See [Enabling Decision](../using-the-api/decision/README.md#enabling-decision).
{% endhint %}

Types used by the [Decision Controller](decision-controller.md). The `kind` property discriminates both the question and its matching result.

### UaiDecisionQuestion

A union of the three question types.

{% code title="UaiDecisionQuestion" %}

```typescript
type UaiDecisionQuestion = UaiBinaryDecisionQuestion | UaiChoiceDecisionQuestion | UaiScoreDecisionQuestion;

interface UaiBinaryDecisionQuestion {
    kind: "binary";
    instructions: string;
    trueCriteria?: string;
    falseCriteria?: string;
}

interface UaiChoiceDecisionQuestion {
    kind: "choice";
    instructions: string;
    /** 2 to 255 options with unique, non-empty keys. */
    options: UaiDecisionOption[];
}

interface UaiDecisionOption {
    key: string;
    description?: string;
}

interface UaiScoreDecisionQuestion {
    kind: "score";
    instructions: string;
    /** 2 to 10 levels, lowest first. A level's position is its index. */
    levels: UaiDecisionScoreLevel[];
}

interface UaiDecisionScoreLevel {
    description: string;
}
```

{% endcode %}

### UaiDecisionResult

A union of the three result types. Each result has the same `kind` as its question. `confidence` is only reported for choice and score results, and is left out when the provider does not report one.

{% code title="UaiDecisionResult" %}

```typescript
type UaiDecisionResult = UaiBinaryDecisionResult | UaiChoiceDecisionResult | UaiScoreDecisionResult;

interface UaiBinaryDecisionResult {
    kind: "binary";
    /** Probability that the answer is "yes", from 0.0 to 1.0. */
    trueProbability: number;
    modelId?: string | null;
    usage?: UaiDecisionUsage | null;
}

interface UaiChoiceDecisionResult {
    kind: "choice";
    choice: string;
    /** Keyed by option key. */
    probabilities: Record<string, number>;
    confidence?: number | null;
    modelId?: string | null;
    usage?: UaiDecisionUsage | null;
}

interface UaiScoreDecisionResult {
    kind: "score";
    score: number;
    /** Keyed by level index, from 0 for the lowest level. */
    probabilities: Record<number, number>;
    confidence?: number | null;
    modelId?: string | null;
    usage?: UaiDecisionUsage | null;
}

interface UaiDecisionUsage {
    inputTokens?: number | null;
    outputTokens?: number | null;
    totalTokens?: number | null;
}
```

{% endcode %}

### UaiDecisionOptions

Options for the `UaiDecisionController.ask` method.

{% code title="UaiDecisionOptions" %}

```typescript
interface UaiDecisionOptions {
    /** The content being judged. Optional; omitted means the question stands alone. */
    state?: string;
    /** Profile ID (GUID) or alias. If omitted, uses the default Decision profile. */
    profileIdOrAlias?: string;
    /** AbortSignal for cancellation. */
    signal?: AbortSignal;
}
```

{% endcode %}

## Tool Types

### UaiToolScope

Represents a tool scope that groups related tools.

{% code title="UaiToolScope" %}

```typescript
interface UaiToolScope {
    id: string;
    icon: string;
    isDestructive: boolean;
    domain: string;
}
```

{% endcode %}

### UaiToolItem

Represents a single AI tool.

{% code title="UaiToolItem" %}

```typescript
interface UaiToolItem {
    id: string;
    name: string;
    description: string;
    scopeId: string;
    isDestructive: boolean;
    tags: string[];
}
```

{% endcode %}
