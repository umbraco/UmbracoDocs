---
description: Integrate one of the built-in Umbraco Contexts.
---

# Integrating context with a Property Editor

## Overview

This is the third step in the Property Editor tutorial. In this part, we will integrate one of the built-in Umbraco Contexts. For this sample, we will use the `UmbNotificationContext` for some pop-ups and the `UmbMdalContext`. `UmbMdalContext` is used to show a dialog when you click the Trim button and the textbox's input length is longer than the maxLength configuration.

The steps we will go through in this part are:

* [Setting up the contexts](integrating-context-with-a-property-editor.md#setting-up-the-contexts)
* [Using the modal and notification API](integrating-context-with-a-property-editor.md#using-the-modal-and-notification-api)

## Setting up the contexts

1. Replace the imports in the `suggestions-property-editor-ui.element.ts` file.

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
import { LitElement, css, html, customElement, property, state} from "@umbraco-cms/backoffice/external/lit";
import { UUIInputEvent, UUIFormControlMixin} from "@umbraco-cms/backoffice/external/uui";
import { UMB_MODAL_MANAGER_CONTEXT, UMB_CONFIRM_MODAL} from "@umbraco-cms/backoffice/modal";
import { UMB_NOTIFICATION_CONTEXT, UmbNotificationContext, UmbNotificationDefaultData} from "@umbraco-cms/backoffice/notification";
import { UmbElementMixin } from "@umbraco-cms/backoffice/element-api";
```
{% endcode %}

2. Update the class to extend from UmbElementMixin. This allows us to consume the contexts that we need:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
export default class UmbMySuggestionsInputElement extends UmbElementMixin(UUIFormControlMixin(LitElement, '')) {
```
{% endcode %}

3. Create the constructor where we can consume the contexts:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
_modalManagerContext?: typeof UMB_MODAL_MANAGER_CONTEXT.TYPE;
_notificationContext?: UmbNotificationContext;

constructor() {
    super();
    this.consumeContext(UMB_MODAL_MANAGER_CONTEXT, (instance) => {
        this._modalManagerContext = instance;
    });

    this.consumeContext(UMB_NOTIFICATION_CONTEXT, (instance) => {
        this._notificationContext = instance;
    });
}
```
{% endcode %}

4. Add inherited class getFormElement

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
protected getFormElement(): HTMLElement | undefined {
    throw new Error("Method not implemented.");
}
```
{% endcode %}


## Using the modal and notification API

Now we can use the modal and notification API, let's change our `#onTrimText` method.

First, check if the length of our input is smaller or equal to our maxLength configuration. If it is, we have nothing to trim and will send a notification saying there is nothing to trim.

Here we can use the NotificationContext's peek method. It has two parameters `UmbNotificationColor` and an`UmbNotificationDefaultData` object.

1. Add the `#onTextTrim()`code in the `suggestions-property-editor-ui.element.ts`

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
#onTextTrim() {
  if (!this.maxLength) return;
    if (!this.value || (this.value as string).length <= this.maxLength) {
        const data: UmbNotificationDefaultData = {
            message: `Nothing to trim!`,
        };
        this._notificationContext?.peek("danger", { data });
        return;
    }
}
```
{% endcode %}

If our input length is less or equal to our maxLength configuration, we will now get a notification when pressing the Trim button.

Let's add some more logic. If the length is more than the maxLength configuration, we want to show a dialog for the user to confirm the trim. Here we use the modal context's open method.

2. Add the `open` method to the `#onTextTrim()`

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
#onTextTrim() {
  ...

    const trimmed = (this.value as string).substring(0, this.maxLength);
    const modalHandler = this._modalManagerContext?.open(this, UMB_CONFIRM_MODAL,
        {
            data: {
                headline: `Trim text`,
                content: `Do you want to trim the text to "${trimmed}"?`,
                color: "danger",
                confirmLabel: "Trim",
            }
        }
    );
    modalHandler?.onSubmit().then(() => {
        this.value = trimmed;
        this.#dispatchChangeEvent();
        const data: UmbNotificationDefaultData = {
            headline: `Text trimmed`,
            message: `You trimmed the text!`,
        };
        this._notificationContext?.peek("positive", { data });
    }, null);
}
```
{% endcode %}

<details>

<summary>See the entire file: suggestions-property-editor-ui.element.ts</summary>

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
import { LitElement, css, html, customElement, property, state} from "@umbraco-cms/backoffice/external/lit";
import { UUIInputEvent, UUIFormControlMixin} from "@umbraco-cms/backoffice/external/uui";
import { UMB_MODAL_MANAGER_CONTEXT, UMB_CONFIRM_MODAL} from "@umbraco-cms/backoffice/modal";
import { UMB_NOTIFICATION_CONTEXT, UmbNotificationContext, UmbNotificationDefaultData} from "@umbraco-cms/backoffice/notification";
import { UmbElementMixin } from "@umbraco-cms/backoffice/element-api";

@customElement('my-suggestions-property-editor-ui')
export default class UmbMySuggestionsInputElement extends UmbElementMixin(UUIFormControlMixin(LitElement, '')) {
    @property({ type: Boolean })
    disabled = false;

    @property({ type: String })
    placeholder?: string;

    @property({ type: Number })
    maxLength?: number;

    _modalManagerContext?: typeof UMB_MODAL_MANAGER_CONTEXT.TYPE;
    _notificationContext?: UmbNotificationContext;

    constructor() {
        super();
        this.consumeContext(UMB_MODAL_MANAGER_CONTEXT, (instance) => {
            this._modalManagerContext = instance;
        });

        this.consumeContext(UMB_NOTIFICATION_CONTEXT, (instance) => {
            this._notificationContext = instance;
        });
    }

    @state()
    private _suggestions = [
        "You should take a break",
        "I suggest that you visit the Eiffel Tower",
        "How about starting a book club today or this week?",
        "Are you hungry?",
    ];

    protected getFormElement(): HTMLElement | undefined {
        throw new Error("Method not implemented.");
    }

    #onInput(e: UUIInputEvent) {
        this.value = e.target.value as string;
        this.#dispatchChangeEvent();
    }
    #onSuggestion() {
        const randomIndex = (this._suggestions.length * Math.random()) | 0;
        this.value = this._suggestions[randomIndex];
        this.#dispatchChangeEvent();
    }
    #onTextTrim() {
        if (!this.maxLength) return;
        if (!this.value || (this.value as string).length <= this.maxLength) {
            const data: UmbNotificationDefaultData = {
                message: `Nothing to trim!`,
            };
            this._notificationContext?.peek("danger", { data });
            return;
        }
        const trimmed = (this.value as string).substring(0, this.maxLength);
        const modalHandler = this._modalManagerContext?.open(this, UMB_CONFIRM_MODAL,
            {
                data: {
                    headline: `Trim text`,
                    content: `Do you want to trim the text to "${trimmed}"?`,
                    color: "danger",
                    confirmLabel: "Trim",
                }
            }
        );
        modalHandler?.onSubmit().then(() => {
            this.value = trimmed;
            this.#dispatchChangeEvent();
            const data: UmbNotificationDefaultData = {
                headline: `Text trimmed`,
                message: `You trimmed the text!`,
            };
            this._notificationContext?.peek("positive", { data });
        }, null);
    }

    #dispatchChangeEvent() {
        this.dispatchEvent(
            new CustomEvent("change", { bubbles: true, composed: true })
        );
    }

    render() {
        return html`<div class="blue-text">${this.value}</div>
            <uui-input
                id="suggestion-input"
                class="element"
                label="text input"
                .placeholder="${this.placeholder}"
                .maxlength=${this.maxLength}
                .value="${this.value || ""}"
                @input=${this.#onInput}
            ></uui-input>
            <div id="wrapper">
                <uui-button
                    id="suggestion-button"
                    class="element"
                    look="primary"
                    label="give me suggestions"
                    @click=${this.#onSuggestion}
                    ?disabled=${this.disabled}
                >
                    Give me suggestions!
                </uui-button>
                <uui-button
                    id="suggestion-trimmer"
                    class="element"
                    look="outline"
                    label="Trim text"
                    @click=${this.#onTextTrim}
                >
                    Trim text
                </uui-button>
            </div> `;
    }

    static styles = [
        css`
            .blue-text {
                color: var(--uui-color-focus);
            }
            #wrapper {
                margin-top: 10px;
                display: flex;
                gap: 10px;
            }
            .element {
                width: 100%;
            }
        `,
    ];
}

declare global {
    interface HTMLElementTagNameMap {
        "my-suggestions-input": UmbMySuggestionsInputElement;
    }
}
```
{% endcode %}

</details>

## Going further

We have now connected our editor with the `UmbNotificationContext` and `UmbModalContext`. So that it is possible to trim the text as well as show us a pop-up when doing so.

In the next part, we are going to integrate services with a Property Editor.
