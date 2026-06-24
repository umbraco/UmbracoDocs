---
description: >-
    Controller and recorder for speech-to-text transcription in custom elements.
---

# Speech-to-Text Controller

`UaiSpeechToTextController` and `UaiAudioRecorder` provide a frontend API for recording audio and transcribing it to text. The two classes separate concerns: the recorder captures audio from the microphone, and the controller sends it to the Management API for transcription.

## Import

{% code title="Import" %}

```typescript
import {
    UaiSpeechToTextController,
    UaiAudioRecorder,
    UaiSpeechToTextOptions,
    UaiSpeechToTextResult,
    UaiAudioRecorderState
} from "@umbraco-ai/core";
```

{% endcode %}

## UaiAudioRecorder

Records audio via the browser's MediaRecorder API. Extends `UmbControllerBase` so the recording is automatically cancelled when the host element is destroyed (for example, when navigating away).

### Constructor

{% code title="Constructor" %}

```typescript
new UaiAudioRecorder(host: UmbControllerHost)
```

{% endcode %}

| Parameter | Type                | Description                                           |
| --------- | ------------------- | ----------------------------------------------------- |
| `host`    | `UmbControllerHost` | The controller host (usually `this` in a Lit element) |

### Properties

| Property | Type                                  | Description                          |
| -------- | ------------------------------------- | ------------------------------------ |
| `state`  | `UaiAudioRecorderState`              | Current state: `"idle"` or `"recording"` |
| `state$` | `Observable<UaiAudioRecorderState>`  | RxJS observable of state changes     |

### Methods

#### start

Requests microphone access and begins recording.

{% code title="Signature" %}

```typescript
async start(): Promise<void>
```

{% endcode %}

#### stop

Stops recording and returns the captured audio as a `Blob`.

{% code title="Signature" %}

```typescript
async stop(): Promise<Blob>
```

{% endcode %}

#### cancel

Stops recording and discards the captured audio.

{% code title="Signature" %}

```typescript
cancel(): void
```

{% endcode %}

### Example

{% code title="BasicRecording.ts" %}

```typescript
// Inside a Lit element
#recorder = new UaiAudioRecorder(this);

connectedCallback() {
    super.connectedCallback();
    // React to state changes via Umbraco's observe helper
    this.observe(this.#recorder.state$, (state) => {
        this._recorderState = state; // "idle" | "recording"
    });
}

async record() {
    await this.#recorder.start();
    const audioBlob = await this.#recorder.stop();
}
```

{% endcode %}

## UaiSpeechToTextController

Handles transcription by sending audio to the Management API. Follows the same controller pattern as [UaiChatController](chat-controller.md).

### Constructor

{% code title="Constructor" %}

```typescript
new UaiSpeechToTextController(host: UmbControllerHost)
```

{% endcode %}

| Parameter | Type                | Description                                           |
| --------- | ------------------- | ----------------------------------------------------- |
| `host`    | `UmbControllerHost` | The controller host (usually `this` in a Lit element) |

### Methods

#### transcribe

Sends an audio blob to the Management API for transcription.

{% code title="Signature" %}

```typescript
async transcribe(
    audioFile: Blob,
    options?: UaiSpeechToTextOptions
): Promise<{ data?: UaiSpeechToTextResult; error?: unknown }>
```

{% endcode %}

| Parameter   | Type                      | Description                    |
| ----------- | ------------------------- | ------------------------------ |
| `audioFile` | `Blob`                    | The recorded audio blob        |
| `options`   | `UaiSpeechToTextOptions` | Optional transcription config  |

**Returns**: Promise resolving to `{ data?, error? }`

## Options

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

## Result

{% code title="UaiSpeechToTextResult" %}

```typescript
interface UaiSpeechToTextResult {
    text: string;
}
```

{% endcode %}

## Complete Example

{% code title="voice-input.element.ts" %}

```typescript
import { LitElement, html, css } from "lit";
import { customElement, state } from "lit/decorators.js";
import {
    UaiSpeechToTextController,
    UaiAudioRecorder,
} from "@umbraco-ai/core";

@customElement("voice-input")
export class VoiceInputElement extends LitElement {
    static styles = css`
        :host { display: block; }
        .transcribing { opacity: 0.5; }
    `;

    #sttController = new UaiSpeechToTextController(this);
    #recorder = new UaiAudioRecorder(this);

    @state()
    private _recording = false;

    @state()
    private _transcribing = false;

    @state()
    private _text?: string;

    async #toggleRecording() {
        if (this._recording) {
            this._recording = false;
            this._transcribing = true;

            const audioBlob = await this.#recorder.stop();

            const { data, error } = await this.#sttController.transcribe(audioBlob, {
                language: "en",
            });

            this._transcribing = false;

            if (data) {
                this._text = data.text;
            } else {
                console.error("Transcription failed:", error);
            }
        } else {
            await this.#recorder.start();
            this._recording = true;
        }
    }

    render() {
        return html`
            <button
                @click=${this.#toggleRecording}
                ?disabled=${this._transcribing}
                class=${this._transcribing ? "transcribing" : ""}>
                ${this._recording ? "Stop" : this._transcribing ? "Transcribing..." : "Record"}
            </button>
            ${this._text ? html`<p>${this._text}</p>` : ""}
        `;
    }
}

declare global {
    interface HTMLElementTagNameMap {
        "voice-input": VoiceInputElement;
    }
}
```

{% endcode %}

## Related

- [Chat Controller](chat-controller.md) - Chat completions in the frontend
- [Speech-to-Text API](../using-the-api/speech-to-text.md) - Backend Speech-to-Text service
- [Types](types.md) - All frontend type definitions
