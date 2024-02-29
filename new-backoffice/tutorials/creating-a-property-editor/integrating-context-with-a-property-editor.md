---
description: This page is a work in progress. It will be updated as the software evolves.
---

# Integrating context with a Property Editor

### Overview

This is step 3 in the Property Editor tutorial. In this part, we will integrate one of the built-in Umbraco Contexts. For this sample, we will use the `UmbNotificationContext` for some pop-ups and the `UmbMdalContext`. `UmbMdalContext` is used to show a dialog when you click the Trim button and the textbox's input length is longer than the maxLength configuration.

### Setting up the contexts

In the `suggestions-input.element` file, insert the following imports

```typescript
import {
    UmbModalContext,
    UMB_MODAL_CONTEXT,
    UMB_CONFIRM_MODAL,
} from "@umbraco-cms/backoffice/modal";
import {
    UMB_NOTIFICATION_CONTEXT,
    UmbNotificationContext,
    UmbNotificationDefaultData,
} from "@umbraco-cms/backoffice/notification";
import { UmbElementMixin } from "@umbraco-cms/backoffice/element-api";
```

Update the class to extend from UmbElementMixin. This allows us to consume the contexts that we need. After, we can create the constructor where we can consume the contexts:

```typescript
class MySuggestionsInputElement extends UmbElementMixin(FormControlMixin(LitElement))
```

```typescript
private _modalContext?: UmbModalContext;
private _notificationContext?: UmbNotificationContext;

constructor() {
  super();
  this.consumeContext(UMB_MODAL_CONTEXT, (instance) => {
    this._modalContext = instance;
  });

  this.consumeContext(UMB_NOTIFICATION_CONTEXT, (instance) => {
    this._notificationContext = instance;
    });
}
```

Now we can use the modal and notification API, let's change our `#onTrimText` method!

First, let's check if the length of our input is smaller or equal to our maxLength configuration. If it is, we have nothing to trim and will send a notification saying there is nothing to trim. Here we can use the NotificationContext's peek method. It has two parameters, `UmbNotificationColor` and an`UmbNotificationDefaultData` object.

```typescript
#onTextTrim() {
  if (!this.maxLength) return;
  if (!this.value || (this.value as string).length <= this.maxLength) {
    const data: UmbNotificationDefaultData = {
      message: `Nothing to trim!`,
    };
    this._notificationContext?.peek('danger', { data });
    return;
  }
}
```

If our input length is less or equal to our maxLength configuration, we will now get a notification when pressing the Trim button.

<figure><img src="../.gitbook/assets/nothing-to-trim (1).png" alt=""><figcaption></figcaption></figure>

Let's continue to add more logic. If the length is more than the maxLength configuration, we want to show a dialog for the user to confirm the trim. Here we use the modal context's open method.

```typescript
#onTextTrim() {
  ...

  const trimmed = (this.value as string).substring(0, this.maxLength);
  const modalHandler = this._modalContext?.open(UMB_CONFIRM_MODAL, {
    headline: `Trim text`,
    content: `Do you want to trim the text to "${trimmed}"?`,
    color: 'danger',
    confirmLabel: 'Trim',
  });
  modalHandler?.onSubmit().then(() => {
    this.value = trimmed;
    this.#dispatchChangeEvent();
    const data: UmbNotificationDefaultData = {
      headline: `Text trimmed`,
      message: `You trimmed the text!`,
    };
    this._notificationContext?.peek('positive', { data });
  }, null);
}
```

It should look like this:

<figure><img src="../.gitbook/assets/trim-confirm.png" alt=""><figcaption></figcaption></figure>

<details>

<summary>suggestions-input.element.ts</summary>

```typescript
import {
    LitElement,
    css,
    html,
    customElement,
    property,
    state,
} from "@umbraco-cms/backoffice/external/lit";
import {
    UUIInputEvent,
    FormControlMixin,
} from "@umbraco-cms/backoffice/external/uui";
import {
    UmbModalContext,
    UMB_MODAL_CONTEXT,
    UMB_CONFIRM_MODAL,
} from "@umbraco-cms/backoffice/modal";
import {
    UMB_NOTIFICATION_CONTEXT,
    UmbNotificationContext,
    UmbNotificationDefaultData,
} from "@umbraco-cms/backoffice/notification";
import { UmbElementMixin } from "@umbraco-cms/backoffice/element-api";

@customElement("my-suggestions-input")
export class UmbMySuggestionsInputElement extends UmbElementMixin(
    FormControlMixin(LitElement)
) {
    @property({ type: Boolean })
    disabled = false;

    @property({ type: String })
    placeholder?: string;

    @property({ type: Number })
    maxLength?: number;

    private _modalContext?: UmbModalContext;
    private _notificationContext?: UmbNotificationContext;

    constructor() {
        super();
        this.consumeContext(UMB_MODAL_CONTEXT, (instance) => {
            this._modalContext = instance;
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

    protected getFormElement() {
        return undefined;
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
        const modalHandler = this._modalContext?.open(UMB_CONFIRM_MODAL, {
            headline: `Trim text`,
            content: `Do you want to trim the text to "${trimmed}"?`,
            color: "danger",
            confirmLabel: "Trim",
        });
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

export default UmbMySuggestionsInputElement;

declare global {
    interface HTMLElementTagNameMap {
        "my-suggestions-input": UmbMySuggestionsInputElement;
    }
}
```

</details>

### Wrap up

Over the 3 previous steps, we have:

-   Created a plugin.
-   Defined an editor.
-   Registered the Data Type in Umbraco.
-   Added configuration to the Property Editor.
-   Connected the editor with UmbNotificationContext and UmbModalContext.
-   Looked at some of the methods from notification & modal contexts in action.
