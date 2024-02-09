---
description: Ask the user for confirmation
---

# Confirm Dialog

{% hint style="warning" %}
This page is a work in progress.&#x20;
{% endhint %}

```typescript
import { html, LitElement } from "@umbraco-cms/backoffice/external/lit";
import { UmbElementMixin } from "@umbraco-cms/element";
import {
    UmbModalManagerContext,
    UMB_MODAL_MANAGER_CONTEXT,
} from "@umbraco-cms/modal";

class MyElement extends UmbElementMixin(LitElement) {
    #modalManagerContext?: UmbmodalManagerContext;
    constructor() {
        super();
        this.consumeContext(UMB_MODAL_MANAGER_CONTEXT, (instance) => {

            this.#modalManagerContext = instance;
        });
    }
    #onRequestDisable() {
        const modalContext = this.#modalManagerContext?.open(
            UMB_CONFIRM_MODAL,
            {
                headline: `${this.localize.term("actions_disable")}`,
                content: `${this.localize.term(
                    "defaultdialogs_confirmdisable"
                )}`,
                color: "danger",
                confirmLabel: "Disable",
            }
        );
        modalContext
            ?.onSubmit()
            .then(() => {
                console.log("User has approved");
            })
            .catch(() => {
                console.log("User has rejected");
            });
    }

    render() {
        return html`<uui-button @click=${
            this.#onRequestDisable
        } label=${this.localize.term("actions_disable")}></button>`;
    }
}
```
