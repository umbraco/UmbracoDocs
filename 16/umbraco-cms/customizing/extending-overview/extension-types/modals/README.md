---
description: >-
  A modal is a popup layer that darkens the surroundings and comes with a focus
  lock. There are two types of modals: "dialog" and "sidebar".
---

# Modals

## **Modal Types**

The Dialog modal appears in the middle of the screen and the Sidebar Modal slides in from the right.

## Open a Modal

A modal can be opened in two ways: either directly at runtime or by registering a route for the modal. Registering a route allows deep-linking to the modal, which may be preferred in certain scenarios. Otherwise, opening the modal directly is a simpler option.

### Directly open via the Open Modal method

<pre class="language-ts" data-title="my-element.ts"><code class="lang-ts">import { customElement, html } from '@umbraco-cms/backoffice/external/lit';
import { UmbLitElement } from '@umbraco-cms/backoffice/lit-element'; 
import { MY_MODAL_TOKEN } from './my-modal.token.js';
import { umbOpenModal } from '@umbraco-cms/backoffice/modal';

<strong>@customElement('my-element')
</strong>class MyElement extends UmbLitElement {

    override render() {
        return html`
            &#x3C;uui-button look="primary" label="Open modal" @click=${this._openModal}>&#x3C;/uui-button>
        `;
    }

    private async _openModal() {
        const returnedValue = await umbOpenModal(this, MY_MODAL_TOKEN, {
            data: {
                headline: "My modal headline",
            },
        }).catch(() => undefined);
    }
}

declare global {
    interface HTMLElementTagNameMap {
        'my-element': MyElement;
    }
}
</code></pre>

The Promise returned by `umbOpenModal` is handled for potential rejection. This occurs when the Model is closed without submitting. Use this behavior to carry out a certain action if the modal is cancelled. In this case, `undefined` is returned when the Modal is cancelled (rejected).

See the [Confirm Modal article](confirm-dialog.md) for an example.

### Directly open via the Modal Manager Context

For full control, open a modal via the **Modal Manager Context.** This is what the Open Modal method uses behind the scenes. Using the context directly gives you a bit more control and understanding of the system.

First, consume the `UMB_MODAL_MANAGER_CONTEXT` , then use the modal manager context to open a modal. The following example shows how to consume the Modal Manager Context:

```ts
import { LitElement } from "@umbraco-cms/backoffice/external/lit";
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api';
import {
    UMB_MODAL_MANAGER_CONTEXT,
} from "@umbraco-cms/backoffice/modal";

export class MyElement extends UmbElementMixin(LitElement) {
    #modalManagerContext?: typeof UMB_MODAL_MANAGER_CONTEXT.TYPE;

    constructor() {
        super();
        this.consumeContext(UMB_MODAL_MANAGER_CONTEXT, (instance) => {
            this.#modalManagerContext = instance;
            // modalManagerContext is now ready to be used.
        });
    }
}
```

In this case, the modal token from the previous example is used. It accepts a key as input data and returns the new key if the modal is submitted.

```typescript
const modalContext = this.#modalManagerContext?.open(this, MY_SOMETHING_PICKER_MODAL, {
    value: {
        key: this.selectedKey,
    },
});

modalContext
    ?.onSubmit()
    .then((value) => {
        this.selectedKey = value.key;
    })
    .catch(() => undefined);
```

[See the implementing a Confirm Dialog for an example.](confirm-dialog.md)

### Modal Route Registration

You can register modals with a route, making it possible to link directly to that specific modal. This also means the user can navigate back and forth in the browser history. This makes it an ideal solution for modals containing an editorial experience.

For a more concrete example, check out the [Modal Route Registration article](route-registration.md).

## Make a custom Modal

To create your modal, read the [Implementing a Custom Modal article](custom-modals.md).
