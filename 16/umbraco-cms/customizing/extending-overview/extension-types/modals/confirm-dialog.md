---
description: Present a dialog to ask the user for confirmation.
---

# Confirm Dialog

Confirmation dialogs are used to ask the user for confirmation to complete some action, and are presented as a 
center-aligned modal in the backoffice.

Extension authors do not need to register the dialog in their extension's manifest, instead these dialogs are opened by 
importing and calling the `umbOpenModal` function.

Extension authors can customize the dialog with several configuration options, such as the headline, body content, 
colors, and button labels.

* `headline` - The headline of the modal.
* `content` - The content of the modal, which can be a TemplateResult or a string.
* `color` - (Optional) The color of the modal, can be `positive` or `danger`.
* `confirmLabel` - (Optional) The label of the confirmation button.
* `cancelLabel` - (Optional) The label of the cancel button.

To see all properties of the `UMB_CONFIRM_MODAL` token, see the [API reference](https://apidocs.umbraco.com/v16/ui-api/interfaces/packages_core_modal.UmbConfirmModalData.html).

The `onSubmit` method returns a promise that resolves when the user confirms the dialog, and rejects when the user 
cancels the dialog.

## Basic Usage

{% code title="my-element.ts" %}
```typescript
import {
    html,
    LitElement,
    customElement,
} from "@umbraco-cms/backoffice/external/lit";
import { UmbElementMixin } from "@umbraco-cms/backoffice/element-api";
import { umbOpenModal, UMB_CONFIRM_MODAL } from "@umbraco-cms/backoffice/modal";

@customElement("my-confirmation-modal")
export class MyConfirmationModal extends UmbElementMixin(LitElement) {
    #onRequestDisable() {
        umbOpenModal(this, UMB_CONFIRM_MODAL, {
            data: {
                headline: this.localize.term("actions_disable"),
                content: this.localize.term("defaultdialogs_confirmdisable"),
                color: "danger",
                confirmLabel: this.localize.term("actions_disable"),
            },
        })
            .then(() => {
                console.log("User has approved");
            })
            .catch(() => {
                console.log("User has rejected");
            });
    }

    render() {
        return html`<uui-button
      look="primary"
      color="danger"
      @click=${this.#onRequestDisable}
      label=${this.localize.term("actions_disable")}
    ></uui-button>`;
    }
}
```
{% endcode %}
