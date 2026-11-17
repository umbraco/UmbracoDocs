---
description: >-
  Add your own screen to the sidebar of the Umbraco Engage section with a menu
  item and a workspace.
---

# Custom Screens

The Engage section in the backoffice has a sidebar with three groups: **Insights**, **Optimization**, and **Configuration**. Each item in a group opens a screen.

You can add your own screens to the Engage section. A screen consists of two Umbraco CMS extensions:

- A [menu item](https://docs.umbraco.com/umbraco-cms/extend-your-project/backoffice-extensions/extending-overview/extension-types/menu-item) that adds an item to one of the sidebar groups.
- A [workspace](https://docs.umbraco.com/umbraco-cms/extend-your-project/backoffice-extensions/extending-overview/extension-types/workspaces) that renders the screen.

## Add a screen

1. Create a folder for your extension in `App_Plugins`, for example `App_Plugins/MyEngageScreens`.
2. Add an `umbraco-package.json` file with the following content:

```json
{
  "name": "My Engage Screens",
  "extensions": [
    {
      "type": "menuItem",
      "alias": "My.MenuItem.Loyalty",
      "name": "My Loyalty Menu Item",
      "weight": 10,
      "meta": {
        "label": "Loyalty",
        "icon": "icon-wand",
        "entityType": "my-loyalty",
        "menus": ["Engage.Menu.Section.Insights"]
      }
    },
    {
      "type": "workspace",
      "alias": "My.Workspace.Loyalty",
      "name": "My Loyalty Workspace",
      "js": "/App_Plugins/MyEngageScreens/loyalty-workspace.js",
      "meta": {
        "entityType": "my-loyalty"
      }
    }
  ]
}
```

The `entityType` connects the menu item to the workspace. Use the same value in both extensions.

3. Add a `loyalty-workspace.js` file with the web component:

```javascript
import { html } from "@umbraco-cms/backoffice/external/lit";
import { UmbLitElement } from "@umbraco-cms/backoffice/lit-element";

export default class MyLoyaltyWorkspaceElement extends UmbLitElement {
    render() {
        return html`
            <umb-body-layout headline="Loyalty">
                <p>Loyalty details.</p>
            </umb-body-layout>
        `;
    }
}

customElements.define("my-loyalty-workspace", MyLoyaltyWorkspaceElement);
```

4. Restart the site and open the Engage section.

The **Loyalty** item is shown in the **Insights** group. The screen is available at `/umbraco/section/engage/workspace/my-loyalty`.

## Sidebar groups

Set the `meta.menus` property of the menu item to the alias of the group:

| Group | Menu alias |
| --- | --- |
| Insights | `Engage.Menu.Section.Insights` |
| Optimization | `Engage.Menu.Section.Optimization` |
| Configuration | `Engage.Menu.Section.Configuration` |

The `weight` of the menu item sets the position in the group. A higher weight places the item higher in the group. The built-in items in the **Insights** and **Optimization** groups use weights from 1000 down to 600.

## Read the state of Umbraco Engage

To show or hide content based on the licensed features, read the license state inside the web component. See the [Using the Engage Context](engage-context.md) article.

Follow the [Naming Rules](naming-rules.md) when you choose the aliases, the entity type, and the element name.
