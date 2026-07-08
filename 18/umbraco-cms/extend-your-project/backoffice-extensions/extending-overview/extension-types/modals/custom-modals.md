---
description: New modals can be added to the system via the extension registry.
---

# Custom Modals

This article goes through adding new modals to the system. There are three steps to creating a custom modal:

* Create a modal element
* Declare an Extension Manifest
* (Optional) Create a Modal Token&#x20;

After completing these steps, refer to the example on how to open the modal.

## Create a modal element

A modal element is a web component that is used to render a modal. It should implement the `UmbModalExtensionElement` interface. The modal context is injected into the element when the modal is opened in the `modalContext` property. The modal context is used to close the modal, update the value and submit the modal.

Additionally, the modal element can see its data parameters through the `modalContext` property. In this example, the modal data is of type `MyModalData` , and the modal value is of type `MyModalValue`. The modal context is of type `UmbModalContext<MyModalData, MyModalValue>`. We are using the data to render a headline and the value to update the value and submit the modal.

{% code title="my-modal.element.ts" %}
```ts
import { customElement, html, property } from '@umbraco-cms/backoffice/external/lit';
import { UmbLitElement } from '@umbraco-cms/backoffice/lit-element';
import { UmbModalExtensionElement } from '@umbraco-cms/backoffice/modal';
import type { UmbModalContext } from '@umbraco-cms/backoffice/modal';
import type { MyModalData, MyModalValue } from './my-modal.token.js';

@customElement('my-dialog')
export class MyDialogElement
    extends UmbLitElement
    implements UmbModalExtensionElement<MyModalData, MyModalValue> {

    @property({ attribute: false })
    modalContext?: UmbModalContext<MyModalData, MyModalValue>;

    @property({ attribute: false })
    data?: MyModalData;

    private _handleCancel() {
        this.modalContext?.submit();
    }

    private _handleSubmit() {
        this.modalContext?.updateValue({ myData: 'hello world' });
        this.modalContext?.submit();
    }

    render() {
        return html`
            <div>
                <h1>${this.modalContext?.data.headline ?? 'Default headline'}</h1>
                <button @click=${this._handleCancel}>Cancel</button>
                <button @click=${this._handleSubmit}>Submit</button>
            </div>
        `;
    }
}

export const element = MyDialogElement;
```
{% endcode %}

The class must be exported as an `element` or `default` for the Extension Registry to be able to pick up the class.

## Declare an Extension Manifest

The modal element needs to be registered in the extension registry. This is done by defining the modal in the manifest file. The `element` property should point to the file that contains the modal element.

```typescript
{
    type: 'modal',
    alias: 'My.Modal',
    name: 'My Modal',
    element: '../path/to/my-modal.element.js'
}
```

## Create a modal token

{% hint style="info" %}
For type safety, it's recommended to use Modal Tokens. Using a Modal Token gives knowledge about the data that can be parsed to the Modal and as well as the type of the value coming back when submitted.
{% endhint %}

A Modal Token works as a constant that identifies the modal. It is used to open the modal and knows the types of the modal data and modal value. As well, it can contain a preset, containing default data and modal options.

The first argument passed to `UmbModalToken` is the extension alias; the second is the preset configuration.

```ts
import { UmbModalToken } from '@umbraco-cms/backoffice/modal';

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

A modal token is a generic type that takes two arguments(`<MyModalData, MyModalValue>`):

* The first defines the type of data passed to the modal when opened.
* The second defines the type of value returned when the modal is submitted.

## Open the modal

To open the modal, call the `umbOpenModal` method with the Modal Token and data of choice:

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

The Promise of `umbOpenModal` is caught if it gets rejected. This is because if the Model gets closed without submission, the Promise is rejected. YThis can be used to carry out a certain action if the modal is cancelled. In this case, `undefined` is returned when the Modal is cancelled (rejected).
