---
description: >-
  A modal is a popup layer that darkens the surroundings and comes with a focus
  lock. There are two types of modals: "dialog" and "sidebar".
---

# Modals

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

## **Modal Types**

The Dialog modal appears in the middle of the screen. and the Sidebar Modal slide in from the right.

## Modal Token

For type safety, we recommend that you use Modal Tokens. The Modal Token binds the Modal Type with a Modal Data Type and a Modal Result Type.

This can also come with defaults, for example, settings for the modal type and size.

This is an example of a Modal Token declaration:

```ts
import { UmbModalToken } from "@umbraco-cms/backoffice/modal";

export type OurSomethingPickerModalData = {
    // We do not have any data to parse for this example
};

export type OurSomethingPickerModalValue = {
    key: string;
};

export const MY_SOMETHING_PICKER_MODAL = new UmbModalToken<
    OurSomethingPickerModalData,
    OurSomethingPickerModalValue
>("Our.Modal.SomethingPicker", {
    modal: {
        type: "sidebar",
        size: "small",
    },
});
```

## Make a custom Modal Element

To create your own modal, read the [Implementing a Custom Modal article](custom-modals.md) before proceeding with this article.

### Basic Usage

Consume the `UMB_MODAL_MANAGER_CONTEXT` and then use the modal manager context to open a modal. This example shows how to consume the Modal Manager Context:

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

#### Open a modal

A modal can be opened in two ways. Either you register the modal with a route or at runtime open the modal. The initial option allows users to deep-link to the modal, a potential preference in certain cases; otherwise, consider the latter.

#### Directly open a Modal

In this case, we use the Modal Token from above, this takes a key as its data. And if submitted then it returns the new key.

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

[See the implementing a Confirm Dialog for a more concrete example.](confirm-dialog.md)

**Modal Route Registration**

You can register modals with a route, making it possible to link directly to that specific modal. This also means the user can navigate back and forth in the browser history. This makes it an ideal solution for modals containing an editorial experience.

For a more concrete example, check out the [Implementing a Confirm Dialog article](route-registration.md).
