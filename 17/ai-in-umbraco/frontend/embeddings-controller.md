---
description: >-
    Controller for generating text embeddings from custom backoffice elements.
---

# Embeddings Controller

`UaiEmbeddingsController` provides a frontend API for generating text embeddings from custom backoffice elements. It follows the same controller pattern as [UaiChatController](chat-controller.md).

## Import

{% code title="Import" %}

```typescript
import { UaiEmbeddingsController, UaiEmbeddingOptions } from "@umbraco-ai/core";
```

{% endcode %}

## Constructor

{% code title="Constructor" %}

```typescript
new UaiEmbeddingsController(host: UmbControllerHost)
```

{% endcode %}

| Parameter | Type                | Description                                           |
| --------- | ------------------- | ----------------------------------------------------- |
| `host`    | `UmbControllerHost` | The controller host (usually `this` in a Lit element) |

## Methods

### generate

Generates an embedding for a single text value.

{% code title="Signature" %}

```typescript
async generate(
    value: string,
    options?: UaiEmbeddingOptions
): Promise<{ data?: number[]; error?: unknown }>
```

{% endcode %}

| Parameter | Type                 | Description               |
| --------- | -------------------- | ------------------------- |
| `value`   | `string`             | The text to embed         |
| `options` | `UaiEmbeddingOptions`| Optional configuration    |

**Returns**: Promise resolving to `{ data?, error? }` where `data` is a `number[]` vector.

### `generateMany`

Generates embeddings for multiple text values in a batch.

{% code title="Signature" %}

```typescript
async generateMany(
    values: string[],
    options?: UaiEmbeddingOptions
): Promise<{ data?: UaiEmbeddingResult; error?: unknown }>
```

{% endcode %}

| Parameter | Type                 | Description                 |
| --------- | -------------------- | --------------------------- |
| `values`  | `string[]`           | The texts to embed          |
| `options` | `UaiEmbeddingOptions`| Optional configuration      |

**Returns**: Promise resolving to `{ data?, error? }` where `data` contains an `embeddings` array.

## Options

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

## Result Types

{% code title="UaiEmbeddingResult" %}

```typescript
interface UaiEmbeddingResult {
    embeddings: UaiEmbeddingItem[];
}

interface UaiEmbeddingItem {
    index: number;
    vector: number[];
}
```

{% endcode %}

## Example

{% code title="similarity-checker.element.ts" %}

```typescript
import { LitElement, html } from "lit";
import { customElement, state } from "lit/decorators.js";
import { UaiEmbeddingsController } from "@umbraco-ai/core";

@customElement("similarity-checker")
export class SimilarityCheckerElement extends LitElement {
    #embeddings = new UaiEmbeddingsController(this);

    @state()
    private _similarity?: number;

    async #compare(text1: string, text2: string) {
        const { data: result } = await this.#embeddings.generateMany(
            [text1, text2],
            { profileIdOrAlias: "text-embedding" },
        );

        if (result) {
            this._similarity = cosineSimilarity(
                result.embeddings[0].vector,
                result.embeddings[1].vector,
            );
        }
    }

    render() {
        return html`
            ${this._similarity != null
                ? html`<p>Similarity: ${(this._similarity * 100).toFixed(1)}%</p>`
                : ""}
        `;
    }
}
```

{% endcode %}

## Related

- [Chat Controller](chat-controller.md) - Chat completions in the frontend
- [Embeddings API](../using-the-api/embeddings/README.md) - Backend embeddings service
- [Types](types.md) - All frontend type definitions
