---
description: >-
  Read the state of Umbraco Engage, such as the licensed features, from your
  own backoffice extension.
---

# Using the Engage Context

Umbraco Engage provides a context with the state of the package. Your [custom screens](custom-screens.md) and other extensions can consume the context to adapt to that state.

The context token is `ENGAGE_CONTEXT`. Import the token from `@umbraco-engage/backoffice/core`.

## Consume the context

The following web component reads the licensed features. The example is a profile tab, as described in the [Profile Insights and Tabs](../profiling/profile-insights-and-tabs.md) article.

```javascript
import { html } from "@umbraco-cms/backoffice/external/lit";
import { UmbLitElement } from "@umbraco-cms/backoffice/lit-element";
import { ENGAGE_CONTEXT } from "@umbraco-engage/backoffice/core";

export default class MyLoyaltyTabElement extends UmbLitElement {
    static properties = {
        _licensedFeatures: { state: true },
    };

    constructor() {
        super();

        this.consumeContext(ENGAGE_CONTEXT, (context) => {
            if (!context) return;

            this.observe(context.licensedFeatures, (licensedFeatures) => {
                this._licensedFeatures = licensedFeatures;
            });
        });
    }

    render() {
        if (!this._licensedFeatures?.personalization) {
            return html`<p>This tab requires the Personalization feature.</p>`;
        }

        return html`<p>Loyalty details for this visitor.</p>`;
    }
}

customElements.define("my-loyalty-tab", MyLoyaltyTabElement);
```

The example works without a build step. When you use TypeScript or a bundler, install the `@umbraco-engage/backoffice` package. See the [Extending the Backoffice](README.md) article.

## Licensed features

The `licensedFeatures` property is an observable. The value is an object with one boolean per feature:

| Property | Description |
| --- | --- |
| `analytics` | `true` when the Analytics feature is licensed. |
| `abTesting` | `true` when the A/B Testing feature is licensed. |
| `personalization` | `true` when the Personalization feature is licensed. |

All values are `false` until Umbraco Engage has loaded the license state. On a site that runs in trial mode, all three values are `true`.
