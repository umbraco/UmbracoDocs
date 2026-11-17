---
description: >-
  Add your own insight box or tab to the profile of a visitor in Umbraco
  Engage.
---

# Profile Insights and Tabs

The profile of a visitor shows what Umbraco Engage knows about that visitor. You can add your own content to a profile in three ways:

- A box on the **Insights** tab
- A tab of your own
- Content on the **External data** tab, as described in the [External Profile Data](external-profile-data.md) article

All three are registered in an `umbraco-package.json` file. See the [Extending the Backoffice](../extending-the-backoffice/README.md) article for an introduction.

## Add a box to the Insights tab

The **Insights** tab shows a set of boxes, such as **Goals** and **Campaigns**. Use the `engageProfileInsight` extension type to add a box.

1. Add the extension to your `umbraco-package.json` file:

```json
{
  "name": "My Profile Extensions",
  "extensions": [
    {
      "type": "engageProfileInsight",
      "alias": "My.ProfileInsight.Loyalty",
      "name": "My Loyalty Profile Insight",
      "weight": 100,
      "js": "/App_Plugins/MyProfileExtensions/loyalty-insight.js",
      "meta": {
        "label": "Loyalty"
      }
    }
  ]
}
```

2. Add a `loyalty-insight.js` file with the web component:

```javascript
import { html } from "@umbraco-cms/backoffice/external/lit";
import { UmbLitElement } from "@umbraco-cms/backoffice/lit-element";
import { UMB_ENTITY_WORKSPACE_CONTEXT } from "@umbraco-cms/backoffice/workspace";

export class MyLoyaltyInsightElement extends UmbLitElement {
    static properties = {
        _profileId: { state: true },
    };

    constructor() {
        super();

        this.consumeContext(UMB_ENTITY_WORKSPACE_CONTEXT, (context) => {
            this.observe(context?.unique, (unique) => {
                this._profileId = unique;
            });
        });
    }

    render() {
        return html`<p>Current profile id: ${this._profileId}</p>`;
    }
}

export { MyLoyaltyInsightElement as element };

customElements.define("my-loyalty-insight", MyLoyaltyInsightElement);
```

The web component reads the ID of the profile from the workspace context. Use the ID to load your own data for the visitor.

The `weight` of the extension sets the order of the boxes. The built-in boxes have a weight of 100.

### Meta properties

| Property | Description |
| --- | --- |
| `label` | The headline of the box. |
| `sidebar` | Set to `true` to place the box in the left column. |
| `wide` | Set to `true` to let the box span both columns on the right. |
| `noPadding` | Set to `true` to remove the padding inside the box. |

## Add a tab to the profile

Use the `workspaceView` extension type with the `engageProfileDetailWorkspaceView` kind to add a tab to the profile.

1. Add the extension to your `umbraco-package.json` file:

```json
{
  "type": "workspaceView",
  "kind": "engageProfileDetailWorkspaceView",
  "alias": "My.ProfileView.Loyalty",
  "name": "My Loyalty Profile View",
  "js": "/App_Plugins/MyProfileExtensions/loyalty-tab.js",
  "weight": 5,
  "meta": {
    "label": "Loyalty",
    "pathname": "loyalty",
    "icon": "icon-wand"
  }
}
```

2. Add a `loyalty-tab.js` file with the web component:

```javascript
import { html } from "@umbraco-cms/backoffice/external/lit";
import { UmbLitElement } from "@umbraco-cms/backoffice/lit-element";

export default class MyLoyaltyTabElement extends UmbLitElement {
    render() {
        return html`<p>Loyalty details for this visitor.</p>`;
    }
}

customElements.define("my-loyalty-tab", MyLoyaltyTabElement);
```

The kind limits the tab to the profile workspace. You do not need to add a workspace condition.
