---
description: Integrate one of the built-in Umbraco Contexts.
---

# Integrating services with a Property Editor

## Overview

This is the fourth step in the Property Editor tutorial. In this part, we will integrate one of the built-in Umbraco Contexts. For this sample, we will use the `UmbNotificationContext` for some pop-ups and the `UmbModalManagerContext`. This is to show a dialog when clicking the Trim button and the textbox's input length is longer than the maxChars configuration.

The steps we will go through in this part are:

* [Setting up the contexts](integrating-services-with-a-property-editor.md#setting-up-the-contexts)
* [Using the notification context](integrating-services-with-a-property-editor.md#using-the-notification-context)
* [Adding more logic to the context](integrating-services-with-a-property-editor.md#adding-more-logic-to-the-context)

## Setting up the contexts

1. Update the class to extend from `UmbElementMixin`. This allows us to consume the contexts that we need:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
import { UmbElementMixin } from "@umbraco-cms/backoffice/element-api";
```
{% endcode %}

2. Create the constructor where we can consume the contexts:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
export default class MySuggestionsPropertyEditorUIElement
  extends UmbElementMixin(LitElement)
  implements UmbPropertyEditorExtensionElement
```
{% endcode %}

Let's start with the notification context.

3. Import the notification context and UmbNotificationDefaultData:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
import {
    UMB_NOTIFICATION_CONTEXT,
    UmbNotificationDefaultData,
} from "@umbraco-cms/backoffice/notification";
```
{% endcode %}

4. Consume the contexts in the constructor:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
  #notificationContext?: typeof UMB_NOTIFICATION_CONTEXT.TYPE;

  constructor() {
    super();
    this.consumeContext(UMB_NOTIFICATION_CONTEXT, (instance) => {
      this.#notificationContext = instance;
    });
  }
```
{% endcode %}

## Using the notification context

Now we can use the notification context when the trim text button is being clicked.

We want to check if the length of our input is smaller or equal to our `maxChars` configuration. If it is, we have nothing to trim and will send a notification saying there is nothing to trim if the user clicks the button.

* Here we can use the NotificationContext's peek method. It has two parameters `UmbNotificationColor` and an`UmbNotificationDefaultData` object.

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

2. Add some logic for the `onTextTrim` method:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
#onTextTrim() {
  if (!this._maxChars) return;
  if (!this.value || (this.value as string).length <= this._maxChars) {
    const data: UmbNotificationDefaultData = {
      message: `Nothing to trim!`,
    };
    this.#notificationContext?.peek('danger', { data });
    return;
  }
}
```
{% endcode %}

Now if our input length is less or equal to our `maxChars` configuration, we will get a notification when pressing the Trim button.

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
 #modalManagerContext?: typeof UMB_MODAL_MANAGER_CONTEXT.TYPE;
 #notificationContext?: typeof UMB_NOTIFICATION_CONTEXT.TYPE;

 constructor() {
    super();
    this.consumeContext(UMB_MODAL_MANAGER_CONTEXT, (instance) => {
      this.#modalManagerContext = instance;
    });

    this.consumeContext(UMB_NOTIFICATION_CONTEXT, (instance) => {
      this.#notificationContext = instance;
    });
  }
```
{% endcode %}

3. Add more logic to the `onTextTrim` method:

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
#onTextTrim() {
  ...

  const trimmed = (this.value as string).substring(0, this._maxChars);
  const modalHandler = this.#modalManagerContext?.open(UMB_CONFIRM_MODAL, {
    headline: `Trim text`,
    content: `Do you want to trim the text to "${trimmed}"?`,
    color: 'danger',
    confirmLabel: 'Trim',
  });
  modalHandler?.onSubmit().then(() => {
    this.value = trimmed;
    this.#dispatchEvent();
    const data: UmbNotificationDefaultData = {
      headline: `Text trimmed`,
      message: `You trimmed the text!`,
    };
    this.#notificationContext?.peek('positive', { data });
  }, null);
}
```
{% endcode %}

Now that we have added the logic to the `onTextTrim` method, when we try to trim the text it should look like this:

<figure><img src="../../.gitbook/assets/trim-confirm (1).png" alt=""><figcaption><p>Trim button Text</p></figcaption></figure>

We have now created a working Property editor. Below you can see the full example of how the code for the Property Editor looks like.

<details>

<summary>See the entire file: suggestions-property-editor-ui.element.ts</summary>

{% code title="suggestions-property-editor-ui.element.ts" %}
```typescript
import { LitElement, css, html, customElement, property, state, ifDefined } from "@umbraco-cms/backoffice/external/lit";
import { type UmbPropertyEditorExtensionElement } from "@umbraco-cms/backoffice/extension-registry";
import { type UmbPropertyEditorConfigCollection, UmbPropertyValueChangeEvent } from "@umbraco-cms/backoffice/property-editor";
import { UMB_MODAL_MANAGER_CONTEXT, UMB_CONFIRM_MODAL} from "@umbraco-cms/backoffice/modal";
import { UMB_NOTIFICATION_CONTEXT, UmbNotificationDefaultData} from "@umbraco-cms/backoffice/notification";
import { UmbElementMixin } from "@umbraco-cms/backoffice/element-api";

@customElement('my-suggestions-property-editor-ui')
export default class MySuggestionsPropertyEditorUIElement
    extends UmbElementMixin(LitElement)
    implements UmbPropertyEditorExtensionElement
{
    @property({ type: String })
    public value = "";

    @state()
    private _disabled?: boolean;

    @state()
    private _placeholder?: string;

    @state()
    private _maxChars?: number;

    @state()
    private _suggestions = [
        "You should take a break",
        "I suggest that you visit the Eiffel Tower",
        "How about starting a book club today or this week?",
        "Are you hungry?",
    ];

    #modalManagerContext?: typeof UMB_MODAL_MANAGER_CONTEXT.TYPE;
    #notificationContext?: typeof UMB_NOTIFICATION_CONTEXT.TYPE;

    constructor() {
        super();
        this.consumeContext(UMB_MODAL_MANAGER_CONTEXT, (instance) => {
            this.#modalManagerContext = instance;
        });

        this.consumeContext(UMB_NOTIFICATION_CONTEXT, (instance) => {
            this.#notificationContext = instance;
        });
    }

    @property({ attribute: false })
    public set config(config: UmbPropertyEditorConfigCollection) {
        this._disabled = config.getValueByAlias("disabled");
        this._placeholder = config.getValueByAlias("placeholder");
        this._maxChars = config.getValueByAlias("maxChars");
    }

    #onInput(e: InputEvent) {
        this.value = (e.target as HTMLInputElement).value;
        this.#dispatchChangeEvent();
    }

    #onSuggestion() {
        const randomIndex = (this._suggestions.length * Math.random()) | 0;
        this.value = this._suggestions[randomIndex];
        this.#dispatchChangeEvent();
    }

    #onTextTrim() {
        if (!this._maxChars) return;
        if (!this.value || (this.value as string).length <= this._maxChars) {
            const data: UmbNotificationDefaultData = {
                message: `Nothing to trim!`,
            };
            this._notificationContext?.peek("danger", { data });
            return;
        }

        const trimmed = (this.value as string).substring(0, this._maxChars);
        const modalHandler = this._modalManagerContext?.open(
            UMB_CONFIRM_MODAL,
            {
                headline: `Trim text`,
                content: `Do you want to trim the text to "${trimmed}"?`,
                color: "danger",
                confirmLabel: "Trim",
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
        this.dispatchEvent(new UmbPropertyValueChangeEvent());
    }

    render() {
        return html`
            <uui-input
                id="suggestion-input"
                class="element"
                label="text input"
                placeholder=${ifDefined(this._placeholder)}
                maxlength=${ifDefined(this._maxChars)}
                .value=${this.value || ""}
                @input=${this.#onInput}
            >
            </uui-input>
            <div id="wrapper">
                <uui-button
                    id="suggestion-button"
                    class="element"
                    look="primary"
                    label="give me suggestions"
                    ?disabled=${this._disabled}
                    @click=${this.#onSuggestion}
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
            </div>
        `;
    }

    static styles = [
        css`
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
        'my-suggestions-property-editor-ui': MySuggestionsPropertyEditorUIElement;
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
