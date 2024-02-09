---
description: >-
    New modals can be added to the system via the extension registry. This article goes through how that is done
---

# Create and register a custom modal

## Register in the extension registry

The manifest

```json
{
    "type": "modal",
    "alias": "My.Modal",
    "name": "My Modal",
    "js": "../path/to/my-modal.element.js"
}
```

## Create a modal token

A modal token is a string that identifies a modal. It should be the modal extension alias. It is used to open a modal and is also to set default options for the modal.

```ts
interface MyModalData = {
	headline: string;
	content: string;
}

interface MyModalResult = {
	myReturnData: string;
}

const MY_MODAL_TOKEN = new ModalToken<MyModalData, MyModalResult>('My.Modal', {
	type: 'sidebar',
	size: 'small'
});
```

The Modal element:

```ts
import { html, LitElement } from "@umbraco-cms/backoffice/external/lit";
import { UmbElementMixin } from "@umbraco-cms/element";
import type { UmbModalHandler } from "@umbraco-cms/modal";

class MyDialog extends UmbElementMixin(LitElement) {
    // the modal handler will be injected into the element when the modal is opened.
    @property({ attribute: false })
    modalContext?: UmbModalHandler<MyModalData, MyModalResult>;

    private _handleCancel() {
        this.modalContext?.close();
    }

    private _handleSubmit() {
        this.modalContext.updateValue({ myReturnData: "hello world" });
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
