---
description: >-
    Integrate AI capabilities into custom backoffice elements.
---

# Frontend Integration

Umbraco.AI provides TypeScript APIs for integrating AI capabilities into custom backoffice elements. The frontend APIs work within the Umbraco backoffice context.

## Package

The AI APIs are exported from the Umbraco.AI client package:

{% code title="Import" %}

```typescript
import { UaiChatController, UaiChatMessage, UaiChatResult } from "@umbraco-ai/core";
```

{% endcode %}

## Quick Start

{% code title="Using Chat in a Custom Element" %}

```typescript
import { LitElement, html } from "lit";
import { customElement, state } from "lit/decorators.js";
import { UaiChatController, UaiChatMessage, UaiChatResult } from "@umbraco-ai/core";

@customElement("my-ai-element")
export class MyAIElement extends LitElement {
    #chatController = new UaiChatController(this);

    @state()
    private _response?: string;

    @state()
    private _loading = false;

    async #handleSubmit() {
        this._loading = true;

        const messages: UaiChatMessage[] = [{ role: "user", content: "Hello, can you help me?" }];

        const { data, error } = await this.#chatController.complete(messages);

        if (data) {
            this._response = data.message.content;
        } else {
            console.error("Chat error:", error);
        }

        this._loading = false;
    }

    render() {
        return html`
            <button @click=${this.#handleSubmit} ?disabled=${this._loading}>
                ${this._loading ? "Loading..." : "Ask AI"}
            </button>
            ${this._response ? html`<p>${this._response}</p>` : ""}
        `;
    }
}
```

{% endcode %}

## Key Concepts

### Controller Pattern

`UaiChatController` follows the Umbraco backoffice controller pattern. It requires a controller host (typically the element itself) for lifecycle management:

{% code title="Controller Initialization" %}

```typescript
class MyElement extends LitElement {
    // Controller is created with 'this' as the host
    #chatController = new UaiChatController(this);
}
```

{% endcode %}

The controller handles:

- API communication with the Management API
- Request lifecycle management
- Automatic cleanup on element disconnect

### Profile Selection

Specify which AI profile to use via `profileIdOrAlias`:

{% code title="Profile Selection" %}

```typescript
// Use default chat profile
await controller.complete(messages);

// Use specific profile by alias
await controller.complete(messages, { profileIdOrAlias: "content-assistant" });

// Use specific profile by ID
await controller.complete(messages, { profileIdOrAlias: "3fa85f64-5717-4562-b3fc-2c963f66afa6" });
```

{% endcode %}

### Cancellation

Pass an `AbortSignal` to cancel requests:

{% code title="Cancellation" %}

```typescript
const abortController = new AbortController();

// Start the request
const promise = controller.complete(messages, { signal: abortController.signal });

// Later, to cancel:
abortController.abort();
```

{% endcode %}

## In This Section

{% content-ref url="chat-controller.md" %}
[Chat Controller](chat-controller.md)
{% endcontent-ref %}

{% content-ref url="embeddings-controller.md" %}
[Embeddings Controller](embeddings-controller.md)
{% endcontent-ref %}

{% content-ref url="speech-to-text-controller.md" %}
[Speech-to-Text Controller](speech-to-text-controller.md)
{% endcontent-ref %}

{% content-ref url="tool-controller.md" %}
[Tool Controller](tool-controller.md)
{% endcontent-ref %}

{% content-ref url="chat-repository.md" %}
[Chat Repository](chat-repository.md)
{% endcontent-ref %}

{% content-ref url="types.md" %}
[Types](types.md)
{% endcontent-ref %}
