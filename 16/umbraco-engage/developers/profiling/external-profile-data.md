---
description: >-
  Umbraco Engage does not provide a built-in way to add additional data to a
  profile. You can store the data in any format and in any way outside of
  Umbraco Engage.
hidden: true
---

# External Profile Data

Your system may associate an Umbraco Engage visitor with other data coming from an external system such as a Customer Relation Management (CRM) system.

If you want to use external data in a custom segment you have to write the data access yourself in the custom segment code.

## Visualization

It is possible to visualize this external data alongside the Umbraco Engage profile in the backoffice by providing a custom Web component for this purpose.

When this component is registered a new tab will be rendered in the Profiles section when viewing profile details. This will render the custom component that was provided and get passed the Umbraco Engage visitor ID.

![External profile data tab.](../../.gitbook/assets/External-profile-data-tab-v16.png)

### Register custom components

To render this External Data Demo tab with a custom component, create your component and register it with Umbraco Engage. The following code demonstrates both steps. Add the below code in a TypeScript file:

```typescript
export class EngageProfileInsightElement extends UmbLitElement {
    #profileId = 0;

    constructor() {
        super();
        this.consumeContext(UMB_ENTITY_WORKSPACE_CONTEXT, context => {
            this.observe(context?.unique, unique => {
                this.#profileId = +unique;
            });
        });
    }
    render() {
        return html`
            <table>
                <tr>
                    <td>This is a custom profile insight element</td>
                </tr>
                <tr>
                    <td>Current profile id: ${this.#profileId}</td>
                </tr>
            </table>
        `;
    }
}
export { EngageProfileInsightElement as element }
customElements.define("profile-insight-demo", EngageProfileInsightElement);
```

Then, load your component using a `manifest.ts` file. The extension type must be `engageExternaldataComponent`.

```json
{
    "type": "engageExternalDataComponent",
    "alias": "EngageDemo.ExternalProfileData",
    "name": "External Data Demo",
    "weight": 100,
    "js": "/path/to/my-javascript.js"
}
```

This is all that is required to render your custom component.
