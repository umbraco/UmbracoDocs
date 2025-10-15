---
description: Ask the user for confirmation
---

# Confirm Dialog

This example shows how to open a confirm dialog. The `UMB_CONFIRM_MODAL` is a token that represents the confirm dialog. The `open` method takes the token and an object with the data for the confirm dialog. The `onSubmit` method returns a promise that resolves when the user confirms the dialog and rejects when the user cancels the dialog.

The confirm modal itself is built-in and does not need to be registered in the extension registry.

The modal token describes the options that you can pass to the modal. The confirm modal token has the following properties:

* `headline` - The headline of the modal.
* `content` - The content of the modal, which can be a TemplateResult or a string.
* `color` - (Optional) The color of the modal. This can be `positive` or `danger`.
* `confirmLabel` - (Optional) The label of the confirm button.

## Basic Usage

{% code title="my-element.ts" %}
```typescript
import { html, LitElement, customElement } from "@umbraco-cms/backoffice/external/lit";
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api';
import { UMB_MODAL_MANAGER_CONTEXT, UMB_CONFIRM_MODAL } from '@umbraco-cms/backoffice/modal';

@customElement('my-element')
export class MyElement extends UmbElementMixin(LitElement) {


    async #onRequestDisable() {
        const context = await this.getContext(UMB_MODAL_MANAGER_CONTEXT)

        const modal = context?.open(
            this, UMB_CONFIRM_MODAL,
            {
                data: {
                    headline: `#actions_disable`,
                    content: `#defaultdialogs_confirmdisable`,
                    color: "danger",
                    confirmLabel: "Disable",
                }
            }
        );
        
        modal?.onSubmit()
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
                            label=${this.localize.term("actions_disable")}></uui-button>`;
    }
}
```
{% endcode %}
