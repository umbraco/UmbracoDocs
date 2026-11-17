---
description: >-
  Add your own tab or sub-tab to the Umbraco Engage section with the
  engageScreenElement extension type.
---

# Custom Screens

The Engage section in the backoffice shows a row of tabs, such as **Analytics**, **Personalization**, and **Settings**. Each tab is a screen. Most screens have a second row of sub-tabs.

You can add your own screens to the Engage section. A screen is registered with the `engageScreenElement` extension type.

{% hint style="info" %}
The Engage section uses its own tab layout. Use the `engageScreenElement` extension type to add content to the section.
{% endhint %}

## Add a top-level screen

A top-level screen adds a tab to the first row of the Engage section.

1. Create a folder for your extension in `App_Plugins`, for example `App_Plugins/MyEngageScreens`.
2. Add an `umbraco-package.json` file with the following content:

```json
{
  "name": "My Engage Screens",
  "extensions": [
    {
      "type": "engageScreenElement",
      "alias": "My.Screen.Loyalty",
      "name": "My Loyalty Screen",
      "js": "/App_Plugins/MyEngageScreens/loyalty-screen.js",
      "elementName": "my-loyalty-screen",
      "weight": 10,
      "meta": {
        "label": "Loyalty",
        "pathname": "loyalty"
      }
    }
  ]
}
```

3. Add a `loyalty-screen.js` file with the web component:

```javascript
import { html } from "@umbraco-cms/backoffice/external/lit";
import { UmbLitElement } from "@umbraco-cms/backoffice/lit-element";

export default class MyLoyaltyScreenElement extends UmbLitElement {
    render() {
        return html`<h1>Loyalty</h1>`;
    }
}

customElements.define("my-loyalty-screen", MyLoyaltyScreenElement);
```

4. Restart the site and open the Engage section.

The **Loyalty** tab is available at `/umbraco/section/engage/loyalty`.

### Manifest properties

| Property | Description |
| --- | --- |
| `type` | Must be `engageScreenElement`. |
| `alias` | A unique alias with your own prefix. See the [Naming Rules](naming-rules.md) article. |
| `js` | The path to the JavaScript file that defines the web component. |
| `elementName` | The name of the web component. |
| `for` | The element name of the parent screen. Leave out for a top-level screen. |
| `weight` | The position of the tab. A higher weight places the tab further to the left. |
| `meta.label` | The text on the tab. |
| `meta.pathname` | The URL segment of the screen. The value must be unique among the screens on the same level. |

The built-in top-level screens use weights from 100 (**Start**) down to 40 (**Settings**). The first screen in the row is the default screen of the section. A weight above 100 makes your screen the default screen.

## Add a sub-tab to an existing screen

Set the `for` property to the element name of the parent screen. The screen is then added as a sub-tab of that screen.

```json
{
  "type": "engageScreenElement",
  "alias": "My.Screen.Analytics.Loyalty",
  "name": "My Loyalty Analytics Screen",
  "js": "/App_Plugins/MyEngageScreens/loyalty-analytics-screen.js",
  "elementName": "my-loyalty-analytics-screen",
  "for": "ue-analytics-screen",
  "meta": {
    "label": "Loyalty",
    "pathname": "loyalty"
  }
}
```

The built-in sub-tabs have no weight. A custom sub-tab is placed before the built-in sub-tabs.

The built-in screens have the following element names:

| Screen | Element name |
| --- | --- |
| Analytics | `ue-analytics-screen` |
| A/B Testing | `ue-abtesting-screen` |
| Personalization | `ue-personalization-screen` |
| Profiles | `ue-profiles-screen` |
| Reporting | `ue-reporting-screen` |
| Settings | `ue-settings-screen` |

## Rules for screen elements

- The web component must extend `UmbLitElement` or another Umbraco element. A plain `HTMLElement` shows the tab without content.
- Give each screen its own JavaScript file.
- Extension conditions are not evaluated for the `engageScreenElement` extension type. Check the state inside your web component instead.

To show or hide content based on the licensed features, read the license state inside the web component. See the [Using the Engage Context](engage-context.md) article.
