---
description: >-
    New modals can be added to the system via the extension registry. This article goes through how this is done.
---

# Create and register a custom modal

## Register in the extension registry

The manifest:

```json
{
    "type": "modal",
    "alias": "My.Modal",
    "name": "My Modal",
    "element": "../path/to/my-modal.element.js"
}
```

## Create a modal token

A modal token is a string that identifies a modal. It should be the modal extension alias. It is used to open a modal and is also to set default options for the modal.

```ts
interface MyModalData = {
	headline: string;
}

interface MyModalValue = {
	myData: string;
}

const MY_MODAL_TOKEN = new ModalToken<MyModalData, MyModalValue>('My.Modal', {
	type: 'sidebar',
	size: 'small'
});
```

The Modal element:

```ts
import { html, LitElement } from "@umbraco-cms/backoffice/external/lit";
import { UmbElementMixin } from "@umbraco-cms/element";
import type { UmbModalContext } from "@umbraco-cms/modal";

class MyDialog extends UmbElementMixin(LitElement) {
    // the modal context will be injected into the element when the modal is opened.
    @property({ attribute: false })
    modalContext?: UmbModalContext<MyModalData, MyModalValue>;

    private _handleCancel() {
        this.modalContext?.close();
    }

    private _handleSubmit() {
        this.modalContext?.updateValue({ myData: "hello world" });
        this.modalContext?.submit();
    }

    render() {
        return html`
            <div>
                <h1>My Modal</h1>
                <button @click=${this._handleCancel}>Cancel</button>
                <button @click=${this._handleSubmit}>Submit</button>
            </div>
        `;
    }
}
```
