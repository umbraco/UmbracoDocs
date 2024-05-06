---
description: Integrate one of the built-in Umbraco Contexts.
---

# Integrating context with a Property Editor

## Overview

This is the third step in the Property Editor tutorial. In this part, we will integrate built-in Umbraco Contexts. For this sample, we will use the `UmbNotificationContext` for some pop-ups and the `UmbModalManagerContext`. `UmbNotificationContext` is used to show a dialog when you click the Trim button and the textbox's input length is longer than the maxLength configuration.

The steps we will go through in this part are:

* [Setting up the contexts](integrating-context-with-a-property-editor.md#setting-up-the-contexts)
* [Using the modal and notification context](integrating-context-with-a-property-editor.md#using-the-modal-and-notification-context)
* [Adding more logic to the context](integrating-context-with-a-property-editor.md#adding-more-logic-to-the-context)

## Setting up the contexts

1. Add the following imports in the `suggestions-property-editor-ui.element.ts` file. This includes the notification context. 

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
import { UMB_NOTIFICATION_CONTEXT, UmbNotificationContext, UmbNotificationDefaultData} from "@umbraco-cms/backoffice/notification";
import { UmbElementMixin } from "@umbraco-cms/backoffice/element-api";
```
{% endcode %}

2. Update the class to extend from UmbElementMixin. This allows us to consume the contexts that we need:

Here we also implement abstract class `getFormElement()` as required by `UUIFormControlMixinInterface`

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
export default class UmbMySuggestionsInputElement extends UmbElementMixin(UUIFormControlMixin(LitElement, '')) {
	protected getFormElement(): HTMLElement | undefined {
	    throw new Error("Method not implemented.");
	}
	...
}
```
{% endcode %}

3. Create the constructor where we can consume the contexts:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
_notificationContext?: UmbNotificationContext;

constructor() {
    super();

    this.consumeContext(UMB_NOTIFICATION_CONTEXT, (instance) => {
        this._notificationContext = instance;
    });
}
```
{% endcode %}




## Using the notification context

Now we can use the notification context, let's change our `#onTrimText` method.

First, check if the length of our input is smaller or equal to our maxLength configuration. If it is, we have nothing to trim and will send a notification saying there is nothing to trim.

Here we can use the NotificationContext's peek method. It has two parameters `UmbNotificationColor` and an`UmbNotificationDefaultData` object.

1. Add a `click` event to the trim text button:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
        <uui-button
          id="suggestion-trimmer"
          class="element"
          look="outline"
          label="Trim text"
          @click=${this.#onTextTrim}
        >
          Trim text
        </uui-button>
```
{% endcode %}

2. Add the `#onTextTrim()`code in the `suggestions-property-editor-ui.element.ts`

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

<figure><img src="../../.gitbook/assets/nothing-to-trim (1) (1).png" alt=""><figcaption><p>Trim Button Notification</p></figcaption></figure>

## Adding more logic to the context

Let's continue to add more logic. If the length is more than the `maxChars` configuration, we want to show a dialog for the user to confirm the trim.

* Here we use the `ModalManagerContext` which has an open method to show a dialog.

Like the notification context, we need to import it and consume it in the constructor.

1. Import the `UMB_MODAL_MANAGER_CONTEXT, UMB_CONFIRM_MODAL` from `@umbraco-cms/backoffice/modal`

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
import {
    UMB_MODAL_MANAGER_CONTEXT,
    UMB_CONFIRM_MODAL,
} from "@umbraco-cms/backoffice/modal";
```
{% endcode %}

2. Consume the `UMB_MODAL_MANAGER_CONTEXT, UMB_CONFIRM_MODAL`:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
 _modalManagerContext?: typeof UMB_MODAL_MANAGER_CONTEXT.TYPE;
 _notificationContext?: typeof UMB_NOTIFICATION_CONTEXT.TYPE;

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

3. Add more logic to the `onTextTrim` method:

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
    protected getFormElement(): HTMLElement | undefined {
        throw new Error("Method not implemented.");
    }
    
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

## Wrap up

Over the four previous steps, we have:

* Created a plugin.
* Defined an editor.
* Registered the Data Type in Umbraco.
* Added configuration to the Property Editor.
* Connected the editor with `UmbNotificationContext` and `UmbModalManagerContext`.
* Looked at some of the methods from notification & modal manager contexts in action.
* Integrated one of the built-in Umbraco Contexts with the Property Editor.
