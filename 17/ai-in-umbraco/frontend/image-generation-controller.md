---
description: >-
    Generate images from a text prompt in custom backoffice elements (experimental).
---

# Image Generation Controller

{% hint style="warning" %}
Image Generation is experimental. `generate` returns an error result (server 404) unless the `Umbraco:AI:Experimental:ImageGeneration` feature flag is enabled. See [Enabling image generation](../using-the-api/image-generation/README.md#enabling-image-generation).
{% endhint %}

`UaiImageGenerationController` provides a frontend API for generating images by calling the Management API. It follows the same controller pattern as [UaiChatController](chat-controller.md).

## Import

{% code title="Import" %}

```typescript
import {
    UaiImageGenerationController,
    type UaiImageGenerationOptions,
    type UaiImageGenerationResult,
    type UaiGeneratedImage,
    type UaiImageInput,
} from "@umbraco-ai/core";
```

{% endcode %}

## Constructor

{% code title="Constructor" %}

```typescript
new UaiImageGenerationController(host: UmbControllerHost)
```

{% endcode %}

| Parameter | Type | Description |
| --- | --- | --- |
| `host` | `UmbControllerHost` | The controller host (usually `this` in a Lit element). |

## Methods

### generate

Sends a prompt to the Management API and returns the generated image(s).

{% code title="Signature" %}

```typescript
async generate(
    prompt: string,
    options?: UaiImageGenerationOptions
): Promise<{ data?: UaiImageGenerationResult; error?: unknown }>
```

{% endcode %}

| Parameter | Type | Description |
| --- | --- | --- |
| `prompt` | `string` | The text prompt describing the desired image(s). |
| `options` | `UaiImageGenerationOptions` | Optional configuration (see below). |

## Options

{% code title="UaiImageGenerationOptions" %}

```typescript
interface UaiImageGenerationOptions {
    /** Profile ID (GUID) or alias. If omitted, uses the default image-generation profile. */
    profileIdOrAlias?: string;
    /** Number of images to generate. */
    count?: number;
    /** Image size as "{width}x{height}" (e.g. "1024x1024"). */
    size?: string;
    /** Response format: "url", "data", or "hosted". */
    responseFormat?: string;
    /** Original images to edit (maskless edit). */
    originalImages?: UaiImageInput[];
    /** AbortSignal for cancellation. */
    signal?: AbortSignal;
}
```

{% endcode %}

## Result

{% code title="UaiImageGenerationResult" %}

```typescript
interface UaiGeneratedImage {
    data?: string;      // base64, when returned inline
    url?: string;       // URL, when hosted
    mediaType?: string; // e.g. "image/png"
}

interface UaiImageGenerationResult {
    images: UaiGeneratedImage[];
    usage?: {
        inputTokens?: number;
        outputTokens?: number;
        totalTokens?: number;
    };
}
```

{% endcode %}

## Example

{% code title="image-prompt.element.ts" %}

```typescript
import { LitElement, html } from "lit";
import { customElement, state } from "lit/decorators.js";
import { UaiImageGenerationController } from "@umbraco-ai/core";

@customElement("image-prompt")
export class ImagePromptElement extends LitElement {
    #controller = new UaiImageGenerationController(this);

    @state() private _src?: string;
    @state() private _busy = false;

    async #generate() {
        this._busy = true;
        const { data, error } = await this.#controller.generate(
            "A serene mountain landscape at dawn",
            { size: "1024x1024" },
        );
        this._busy = false;

        if (data?.images.length) {
            const img = data.images[0];
            this._src = img.url ?? `data:${img.mediaType};base64,${img.data}`;
        } else {
            console.error("Image generation failed:", error);
        }
    }

    render() {
        return html`
            <button @click=${this.#generate} ?disabled=${this._busy}>
                ${this._busy ? "Generating…" : "Generate"}
            </button>
            ${this._src ? html`<img src=${this._src} alt="Generated" />` : ""}
        `;
    }
}

declare global {
    interface HTMLElementTagNameMap {
        "image-prompt": ImagePromptElement;
    }
}
```

{% endcode %}

## Related

- [Chat Controller](chat-controller.md) - Chat completions in the frontend
- [Image Generation API](../using-the-api/image-generation/README.md) - Backend image-generation service
- [Types](types.md) - All frontend type definitions
