---
description: >-
    Ask typed yes/no, pick-one, and score questions from custom backoffice elements (experimental).
---

# Decision Controller

{% hint style="warning" %}
Decision is experimental. The server returns 404 unless the `Umbraco:AI:Experimental:Decision` feature flag is enabled. The controller returns that 404 as `error` and does not throw. See [Enabling Decision](../using-the-api/decision/README.md#enabling-decision).
{% endhint %}

`UaiDecisionController` provides a frontend API for asking a Decision profile a typed question through the Management API. It follows the same controller pattern as [UaiChatController](chat-controller.md).

Each call asks one question. Pass the content to judge as the `state` option.

## Import

{% code title="Import" %}

```typescript
import {
    UaiDecisionController,
    type UaiBinaryDecisionQuestion,
    type UaiChoiceDecisionQuestion,
    type UaiScoreDecisionQuestion,
    type UaiDecisionOptions,
} from "@umbraco-ai/core";
```

{% endcode %}

## Constructor

{% code title="Constructor" %}

```typescript
new UaiDecisionController(host: UmbControllerHost)
```

{% endcode %}

| Parameter | Type | Description |
| --- | --- | --- |
| `host` | `UmbControllerHost` | The controller host (usually `this` in a Lit element). |

## Methods

### ask

Asks a question and returns the typed result. The question's `kind` decides the result type, so a binary question returns a `UaiBinaryDecisionResult`, and so on.

{% code title="Signature" %}

```typescript
async ask(
    question: UaiBinaryDecisionQuestion,
    options?: UaiDecisionOptions
): Promise<{ data?: UaiBinaryDecisionResult; error?: unknown }>;

async ask(
    question: UaiChoiceDecisionQuestion,
    options?: UaiDecisionOptions
): Promise<{ data?: UaiChoiceDecisionResult; error?: unknown }>;

async ask(
    question: UaiScoreDecisionQuestion,
    options?: UaiDecisionOptions
): Promise<{ data?: UaiScoreDecisionResult; error?: unknown }>;

async ask(
    question: UaiDecisionQuestion,
    options?: UaiDecisionOptions
): Promise<{ data?: UaiDecisionResult; error?: unknown }>;
```

{% endcode %}

| Parameter | Type | Description |
| --- | --- | --- |
| `question` | `UaiDecisionQuestion` | The question to ask. See [Decision Types](types.md#decision-types). |
| `options` | `UaiDecisionOptions` | Optional configuration (see below). |

## Options

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

## Examples

### Yes/No Question

{% code title="Binary question" %}

```typescript
const controller = new UaiDecisionController(this);

const { data, error } = await controller.ask(
    {
        kind: "binary",
        instructions: "Is this comment spam?",
        trueCriteria: "Promotional, a scam, or unrelated links",
    },
    { state: commentText },
);

if (data) {
    // Choose your own threshold for "yes"
    const isSpam = data.trueProbability >= 0.5;
    console.log(isSpam, data.trueProbability);
}
```

{% endcode %}

### Pick-One Question

{% code title="Choice question" %}

```typescript
const { data } = await controller.ask(
    {
        kind: "choice",
        instructions: "Which team should handle this message?",
        options: [
            { key: "billing", description: "Invoices, payments, and refunds" },
            { key: "technical", description: "Errors, bugs, and how-to questions" },
            { key: "sales" },
        ],
    },
    { state: message },
);

if (data) {
    // confidence is undefined when the provider does not report one
    console.log(data.choice, data.probabilities, data.confidence);
}
```

{% endcode %}

### Score Question

{% code title="Score question" %}

```typescript
const levels = [{ description: "poor" }, { description: "ok" }, { description: "good" }];

const { data } = await controller.ask(
    {
        kind: "score",
        instructions: "How easy is this summary to read for a general audience?",
        levels,
    },
    { state: summary },
);

if (data) {
    // probabilities are keyed by level index, from 0 for the lowest level
    const nearest = Math.min(Math.max(Math.round(data.score), 0), levels.length - 1);
    console.log(levels[nearest].description, data.score, data.probabilities[0]);
}
```

{% endcode %}

### Using a Specific Profile and Cancellation

{% code title="Options" %}

```typescript
const abortController = new AbortController();

const { data, error } = await controller.ask(
    { kind: "binary", instructions: "Does this text mention a price?" },
    { state: text, profileIdOrAlias: "moderation", signal: abortController.signal },
);

// Later, to cancel:
abortController.abort();
```

{% endcode %}

## Handling Errors

`ask` resolves with `error` set, and no `data`, when the request fails. It does not throw. Common causes are:

- The Decision feature flag is off, so the server returns 404.
- The profile given in `profileIdOrAlias` does not exist (404).
- The question is invalid, no default Decision profile is set, or the provider call failed (400).

{% code title="Error handling" %}

```typescript
const { data, error } = await controller.ask({ kind: "binary", instructions: "Is this spam?" });

if (error || !data) {
    // Decision is unavailable or the request failed. Fall back to other behavior.
    return;
}
```

{% endcode %}

## Full Example

{% code title="spam-check.element.ts" %}

```typescript
import { LitElement, html } from "lit";
import { customElement, property, state } from "lit/decorators.js";
import { UaiDecisionController } from "@umbraco-ai/core";

@customElement("my-spam-check")
export class MySpamCheckElement extends LitElement {
    #decisionController = new UaiDecisionController(this);

    @property()
    comment = "";

    @state()
    private _result?: string;

    async #check() {
        const { data, error } = await this.#decisionController.ask(
            { kind: "binary", instructions: "Is this comment spam?" },
            { state: this.comment },
        );

        if (error || !data) {
            this._result = "Could not check this comment.";
            return;
        }

        const percent = Math.round(data.trueProbability * 100);
        this._result = data.trueProbability >= 0.5 ? `Spam (${percent}% likely)` : `Not spam (${percent}% likely spam)`;
    }

    render() {
        return html`
            <uui-button look="primary" @click=${this.#check}>Check for spam</uui-button>
            ${this._result ? html`<p>${this._result}</p>` : ""}
        `;
    }
}
```

{% endcode %}

## Related

- [Decision Types](types.md#decision-types) - Question and result types
- [Decision Management API](../management-api/decision/README.md) - REST endpoint
- [Using the Decision API](../using-the-api/decision/README.md) - Backend C# API
