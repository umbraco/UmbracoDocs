---
description: >-
    A modal is a popup layer that darkens the surroundings and comes with a focus lock. There
    are two types of modals: "dialog" and "sidebar".
---

# Modals

## **Modal Types**

The Dialog modal appears in the middle of the screen. and the Sidebar Modal slide in from the right.

## Modal Token

For type safety, we recommend that you use Modal Tokens. The Modal Token binds the Modal Type with a Modal Data Type and a Modal Result Type.

This can also come with defaults, for example, settings for the modal type and size.

This is an example of a Modal Token declaration:

```ts
import { ModalToken } from "@umbraco-cms/element";

export type OurSomethingPickerModalData = {
    key: string | null;
};

export type OurSomethingPickerModalResult = {
    key: string;
};

export const MY_SOMETHING_PICKER_MODAL = new UmbModalToken<
    UmbLinkPickerModalData,
    UmbLinkPickerModalResult
>("Our.Modal.SomethingPicker", {
    type: "sidebar",
    size: "small",
});
```

### Basic Usage

Consume the `UmbModalManagerContext` and then use the modal manager context to open a modal. This examples shows how to consume the Modal Manager Context:

```ts
import { LitElement } from "@umbraco-cms/backoffice/external/lit";
import { UmbElementMixin } from "@umbraco-cms/element";
import {
    UmbModalManagerContext,
    UMB_MODAL_CONTEXT_ALIAS,
} from "@umbraco-cms/modal";

class MyElement extends UmbElementMixin(LitElement) {
    #modalManagerContext?: UmbModalManagerContext;

    constructor() {
        super();
        this.consumeContext(UMB_MODAL_CONTEXT_ALIAS, (instance) => {
            this.#modalManagerContext = instance;
            // modalManagerContext is now ready to be used.
        });
    }
}
```

#### Open a modal

A modal can be opened in two ways. Either you register the modal with a route or at runtime open the modal. Notice the first one will enable users to deep-link to the modal, this might be preferable in some cases if not go for the last.

#### Directly open a Modal

In this case, we use the Modal Token from above, this takes a key as its data. And if submitted then it returns the new key.

```typescript
const modalContext = this._modalContext?.open(MY_SOMETHING_PICKER_MODAL, {
    key: this.value,
});

modalContext
    ?.onSubmit()
    .then((data) => {
        this.value = data.key;
    })
    .catch(() => undefined);
```

[See the implementing a Confirm Dialog for a more concrete example.](confirm-dialog.md)

**Modal Route Registration**

You can register modals with a route, making it possible to link directly to that specific modal. This also means the user can navigate forth and back in the browser history of their browser. Making this the ideal solution for modals containing an editorial experience.

[See the implementing a Confirm Dialog for a more concrete example.](confirm-dialog.md)
