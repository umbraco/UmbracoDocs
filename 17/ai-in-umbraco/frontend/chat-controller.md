---
description: >-
    High-level controller for chat completions in custom elements.
---

# Chat Controller

`UaiChatController` provides a high-level API for performing chat completions from custom backoffice elements.

## Import

{% code title="Import" %}

```typescript
import { UaiChatController } from "@umbraco-ai/core";
```

{% endcode %}

## Constructor

{% code title="Constructor" %}

```typescript
new UaiChatController(host: UmbControllerHost)
```

{% endcode %}

| Parameter | Type                | Description                                           |
| --------- | ------------------- | ----------------------------------------------------- |
| `host`    | `UmbControllerHost` | The controller host (usually `this` in a Lit element) |

## Methods

### complete

Performs a chat completion and returns the full response.

{% code title="Signature" %}

```typescript
async complete(
    messages: UaiChatMessage[],
    options?: UaiChatOptions
): Promise<{ data?: UaiChatResult; error?: unknown }>
```

{% endcode %}

| Parameter  | Type               | Description               |
| ---------- | ------------------ | ------------------------- |
| `messages` | `UaiChatMessage[]` | The conversation messages |
| `options`  | `UaiChatOptions`   | Optional configuration    |

**Returns**: Promise resolving to `{ data?, error? }`

{% code title="Example" %}

```typescript
import { LitElement } from "lit";
import { UaiChatController, UaiChatMessage } from "@umbraco-ai/core";

class MyElement extends LitElement {
    #chat = new UaiChatController(this);

    async askQuestion(question: string) {
        const messages: UaiChatMessage[] = [
            { role: "system", content: "You are a helpful assistant." },
            { role: "user", content: question },
        ];

        const { data, error } = await this.#chat.complete(messages);

        if (error) {
            console.error("Failed:", error);
            return;
        }

        console.log("Response:", data.message.content);
        console.log("Tokens used:", data.usage?.totalTokens);
    }
}
```

{% endcode %}

## Options

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

## Complete Example

{% code title="ai-assistant.element.ts" %}

```typescript
import { LitElement, html, css } from "lit";
import { customElement, state, property } from "lit/decorators.js";
import { UaiChatController, UaiChatMessage, UaiChatResult } from "@umbraco-ai/core";

@customElement("ai-assistant")
export class AIAssistantElement extends LitElement {
    static styles = css`
        :host {
            display: block;
            padding: 1rem;
        }
        .loading {
            opacity: 0.5;
        }
        .error {
            color: red;
        }
    `;

    #chat = new UaiChatController(this);
    #abortController?: AbortController;

    @property()
    profileAlias = "content-assistant";

    @state()
    private _messages: UaiChatMessage[] = [];

    @state()
    private _loading = false;

    @state()
    private _error?: string;

    async #sendMessage(userMessage: string) {
        // Add user message
        this._messages = [...this._messages, { role: "user", content: userMessage }];

        this._loading = true;
        this._error = undefined;

        // Create abort controller for cancellation
        this.#abortController = new AbortController();

        const { data, error } = await this.#chat.complete(this._messages, {
            profileIdOrAlias: this.profileAlias,
            signal: this.#abortController.signal,
        });

        this._loading = false;

        if (error) {
            this._error = "Failed to get response";
            return;
        }

        // Add assistant response
        this._messages = [...this._messages, data!.message];
    }

    #cancel() {
        this.#abortController?.abort();
    }

    #handleSubmit(e: Event) {
        e.preventDefault();
        const form = e.target as HTMLFormElement;
        const input = form.querySelector("input") as HTMLInputElement;
        if (input.value.trim()) {
            this.#sendMessage(input.value);
            input.value = "";
        }
    }

    render() {
        return html`
            <div class="messages">
                ${this._messages.map(
                    (m) => html` <div class="message ${m.role}"><strong>${m.role}:</strong> ${m.content}</div> `,
                )}
            </div>

            ${this._error ? html`<p class="error">${this._error}</p>` : ""}

            <form @submit=${this.#handleSubmit} class=${this._loading ? "loading" : ""}>
                <input type="text" placeholder="Ask something..." ?disabled=${this._loading} />
                <button type="submit" ?disabled=${this._loading}>Send</button>
                ${this._loading ? html` <button type="button" @click=${this.#cancel}>Cancel</button> ` : ""}
            </form>
        `;
    }
}

declare global {
    interface HTMLElementTagNameMap {
        "ai-assistant": AIAssistantElement;
    }
}
```

{% endcode %}
