---
description: >-
  New modals can be added to the system via the extension registry. This article
  goes through how this is done.
---

# Custom Modals

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

There are two parts to creating a custom modal:

* First, you need to create a modal element which you need to register in the extension registry.&#x20;
* Second, you need to create and export a modal token.

## Create a modal token

A modal token is a string that identifies a modal. This is the modal extension alias. It is used to open a modal and is also to set default options for the modal. It should also have a unique alias to avoid conflicts with other modals.

```ts
import { UmbModalToken } from "@umbraco-cms/backoffice/modal";

export type MyModalData = {
    headline: string;
}

export type MyModalValue = {
    myData: string;
}

export const MY_MODAL_TOKEN = new UmbModalToken<MyModalData, MyModalValue>('My.Modal', {
    modal: {
        type: 'sidebar',
        size: 'small'
    }
});
```

A modal token is a generic type that takes two type arguments. The first is the type of the data that is passed to the modal when it is opened. The second is the type of the value that is returned when the modal is closed.

## Create a modal element

A modal element is a web component that is used to render the modal. It should implement the `UmbModalExtensionElement` interface. The modal context is injected into the element when the modal is opened in the `modalContext` property. The modal context is used to close the modal, update the value and submit the modal.

Additionally, the modal element can see its data parameters through the `modalContext` property. In this example, the modal data is of type `MyModalData` and the modal value is of type `MyModalValue`. The modal context is of type `UmbModalContext<MyModalData, MyModalValue>`. We are using the data to render a headline and the value to update the value and submit the modal.

{% code title="my-modal.element.ts" %}
```ts
import { html, LitElement, property, customElement } from "@umbraco-cms/backoffice/external/lit";
import { UmbElementMixin } from "@umbraco-cms/backoffice/element-api";
import type { UmbModalContext } from "@umbraco-cms/backoffice/modal";
import type { MyModalData, MyModalValue } from "./my-modal.token.ts";
import { UmbModalExtensionElement } from "@umbraco-cms/backoffice/extension-registry";

@customElement('my-dialog')
export default class MyDialogElement
    extends UmbElementMixin(LitElement)
    implements UmbModalExtensionElement<MyModalData, MyModalValue> {

    @property({ attribute: false })
    modalContext?: UmbModalContext<MyModalData, MyModalValue>;

    @property({ attribute: false })
    data?: MyModalData;

    private _handleCancel() {
        this.modalContext?.submit();
    }

    private _handleSubmit() {
        this.modalContext?.updateValue({ myData: "hello world" });
        this.modalContext?.submit();
    }

    render() {
        return html`
            <div>
                <h1>${this.modalContext?.data.headline ?? "Default headline"}</h1>
                <button @click=${this._handleCancel}>Cancel</button>
                <button @click=${this._handleSubmit}>Submit</button>
            </div>
        `;
    }
}
```
{% endcode %}

## Register in the extension registry

The modal element needs to be registered in the extension registry. This is done by defining the modal in the manifest file. The `element` property should point to the file that contains the modal element.

```json
{
    "type": "modal",
    "alias": "My.Modal",
    "name": "My Modal",
    "element": "../path/to/my-modal.element.js"
}
```

## Open the modal

To open the modal, you need to consume the `UmbModalManagerContext` and then use the modal manager context to open a modal. This example shows how to consume the Modal Manager Context:

{% code title="my-element.ts" %}
```ts
import { MY_MODAL_TOKEN } from './my-modal.token';
import { UMB_MODAL_MANAGER_CONTEXT } from '@umbraco-cms/backoffice/modal';
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api';
import { LitElement, html } from 'lit';
import { customElement } from 'lit/decorators.js';

@customElement('my-element')
class MyElement extends UmbElementMixin(LitElement) {
    #modalManagerContext?: typeof UMB_MODAL_MANAGER_CONTEXT.TYPE;

    constructor() {
        super();
        this.consumeContext(UMB_MODAL_MANAGER_CONTEXT, (instance) => {
            this.#modalManagerContext = instance;
            // modalManagerContext is now ready to be used.
        });
    }

    render() {
        return html`
            <uui-button look="primary" label="Open modal" @click=${this._openModal}></uui-button>
        `;
    }

    private _openModal() {
        this.#modalManagerContext?.open(this, MY_MODAL_TOKEN, {
            data: {
                headline: "My modal headline",
            },
        });
    }
}
```
{% endcode %}
