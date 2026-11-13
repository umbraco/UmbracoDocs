---
description: >-
  Extract typed values such as text, numbers, dates, and lists from custom
  backoffice elements (experimental).
---

# Extraction Controller

{% hint style="warning" %}
Extraction is experimental. The server returns 404 unless the `Umbraco:AI:Experimental:Extraction` feature flag is enabled. The controller returns that 404 as `error` and does not throw. See [Enabling Extraction](../using-the-api/extraction.md#enabling-extraction).
{% endhint %}

`UaiExtractionController` provides a frontend API for reading typed values out of text with an Extraction profile, through the Management API. It follows the same controller pattern as [UaiChatController](chat-controller.md).

One call can extract multiple fields. They are all answered in a single model call.

## Import

{% code title="Import" %}
```typescript
import {
    UaiExtractionController,
    type UaiExtractionRequest,
    type UaiExtractionOptions,
    type UaiExtractionResult,
} from "@umbraco-ai/core";
```
{% endcode %}

## Constructor

{% code title="Constructor" %}
```typescript
new UaiExtractionController(host: UmbControllerHost)
```
{% endcode %}

| Parameter | Type                | Description                                            |
| --------- | ------------------- | ------------------------------------------------------ |
| `host`    | `UmbControllerHost` | The controller host (usually `this` in a Lit element). |

## Methods

### extract

Extracts the requested fields from the text, and returns one answer per field.

{% code title="Signature" %}
```typescript
async extract(
    request: UaiExtractionRequest,
    options?: UaiExtractionOptions
): Promise<{ data?: UaiExtractionResult; error?: unknown }>;
```
{% endcode %}

| Parameter | Type                   | Description                                                                            |
| --------- | ---------------------- | -------------------------------------------------------------------------------------- |
| `request` | `UaiExtractionRequest` | The text and the fields to extract. See [Extraction Types](types.md#extraction-types). |
| `options` | `UaiExtractionOptions` | Optional configuration (see below).                                                    |

## Request

{% code title="UaiExtractionRequest" %}
```typescript
interface UaiExtractionRequest {
    /** The text to extract from. */
    state: string;
    /** The date relative expressions like "yesterday" resolve against (yyyy-MM-dd). */
    referenceDate?: string;
    /** The fields to extract. Each id must be unique. */
    fields: UaiExtractionField[];
}
```
{% endcode %}

Each field has a `kind`, an `id`, and `instructions`. The `kind` decides the extra properties the field can have, and the shape of its answer:

| `kind`       | Extra properties                         | Answer value                     |
| ------------ | ---------------------------------------- | -------------------------------- |
| `"text"`     | None                                     | `value` (string), `span`         |
| `"number"`   | `decimals`, `integer`, `unit`            | `value` (number)                 |
| `"date"`     | None                                     | `value` (`yyyy-MM-dd` string)    |
| `"time"`     | None                                     | `value` (`HH:mm:ss` string)      |
| `"datetime"` | None                                     | `value` (ISO 8601 string)        |
| `"duration"` | `unit` (required), `decimals`, `integer` | `value` (number), `unit`         |
| `"list"`     | `itemType`                               | `values` (string array), `spans` |

The rules for each property are the same as for the [Management API](../management-api/extraction/extract.md#request-body).

## Options

{% code title="UaiExtractionOptions" %}
```typescript
interface UaiExtractionOptions {
    /** Profile ID (GUID) or alias. If omitted, uses the default Extraction profile. */
    profileIdOrAlias?: string;
    /** AbortSignal for cancellation. */
    signal?: AbortSignal;
}
```
{% endcode %}

## Result

`answers` is keyed by field `id`, exactly as sent. Every answer has a `kind` that matches its field, an `isFound` flag, and an optional `confidence` and `nullProbability`. A value that is not in the text comes back as `null`, or an empty list, with `isFound` set to `false`.

## Examples

### Extracting Multiple Fields

{% code title="Multiple fields" %}
```typescript
const controller = new UaiExtractionController(this);

const { data, error } = await controller.extract({
    state: ticketText,
    referenceDate: new Date().toISOString().slice(0, 10),
    fields: [
        { kind: "text", id: "orderId", instructions: "The order number" },
        { kind: "number", id: "amount", instructions: "The amount the customer paid", unit: "DKK", decimals: 2 },
        { kind: "date", id: "deliveredOn", instructions: "The date the order was delivered" },
        { kind: "list", id: "damagedProducts", instructions: "Every product that arrived damaged" },
    ],
});

if (data) {
    const amount = data.answers.amount;
    if (amount.kind === "number" && amount.isFound) {
        console.log("Paid", amount.value);
    }
}
```
{% endcode %}

Check an answer's `kind` before you read its value. TypeScript then knows which properties the answer has.

### Using a Specific Profile and Cancellation

{% code title="Options" %}
```typescript
const controller = new UaiExtractionController(this);
const abortController = new AbortController();

const { data, error } = await controller.extract(
    {
        state: text,
        fields: [{ kind: "duration", id: "notice", instructions: "The notice period", unit: "days" }],
    },
    { profileIdOrAlias: "support-extraction", signal: abortController.signal },
);

// Later, to cancel:
abortController.abort();
```
{% endcode %}

## Handling Errors

`extract` resolves with `error` set, and no `data`, when the request fails. It does not throw. Common causes are:

* The Extraction feature flag is off, so the server returns 404.
* The profile given in `profileIdOrAlias` does not exist (404).
* The request is invalid, no default Extraction profile is set, or the provider call failed (400).

{% code title="Error handling" %}
```typescript
const { data, error } = await controller.extract(request);

if (error || !data) {
    // Extraction is unavailable or the request failed. Fall back to other behavior.
    return;
}
```
{% endcode %}

## Full Example

The following element reads a contact's name and email address out of pasted text:

{% code title="contact-reader.element.ts" %}
```typescript
import { html, customElement, property, state } from "@umbraco-cms/backoffice/external/lit";
import { UmbLitElement } from "@umbraco-cms/backoffice/lit-element";
import { UaiExtractionController } from "@umbraco-ai/core";

@customElement("my-contact-reader")
export class MyContactReaderElement extends UmbLitElement {
    #extractionController = new UaiExtractionController(this);

    @property()
    text = "";

    @state()
    private _result?: string;

    async #read() {
        const { data, error } = await this.#extractionController.extract({
            state: this.text,
            fields: [
                { kind: "text", id: "name", instructions: "The full name of the person writing" },
                { kind: "text", id: "email", instructions: "Their email address" },
            ],
        });

        if (error || !data) {
            this._result = "Could not read this text.";
            return;
        }

        const name = data.answers.name;
        const email = data.answers.email;
        this._result =
            name.kind === "text" && email.kind === "text"
                ? `${name.value ?? "No name found"} (${email.value ?? "no email found"})`
                : "Unexpected answer.";
    }

    render() {
        return html`
            <uui-button look="primary" @click=${this.#read}>Read contact</uui-button>
            ${this._result ? html`<p>${this._result}</p>` : ""}
        `;
    }
}
```
{% endcode %}

## Related

* [Extraction Types](types.md#extraction-types) - Field and answer types
* [Extraction Management API](../management-api/extraction/) - REST endpoint
* [Using the Extraction API](../using-the-api/extraction.md) - Backend C# API
