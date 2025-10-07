---
description: >-
    Create menus that appear throughout the backoffice, in sidebars, button flyouts, and more.
---

# Menus

Menu extensions contain one or more menu item extensions and can be placed throughout the backoffice - in sidebars, flyouts, and more. This article will cover how to create a menu with custom menu items.

<figure><img src="../../../.gitbook/assets/menu.png" alt="" width="250"><figcaption><p>Menu</p></figcaption></figure>

## Creating a custom menu

Menu extensions can be created using either JSON or TypeScript. Both approaches are shown below.

{% tabs %}
{% tab title="JSON" %}
{% code title="umbraco-package.json" %}
```json
{
 "type": "menu",
 "alias": "My.Menu",
 "name": "My Menu"
}
```
{% endcode %}
{% endtab %}
{% tab title="TypeScript" %}
Extension authors define the menu manifest, then register it dynamically/during runtime using a [Backoffice Entry Point](../../extending-overview/extension-types/backoffice-entry-point.md) extension.

{% code title="my-menu/manifests.ts" %}
```typescript
import type { ManifestMenu } from '@umbraco-cms/backoffice/menu';

export const menuManifest: Array<ManifestMenu> = [
    {
        type: 'menu',
        alias: 'My.Menu',
        name: 'My Menu'
    }
];
```
{% endcode %}

{% code title="entrypoints/entrypoints.ts" %}
```typescript
import type {
    UmbEntryPointOnInit,
} from "@umbraco-cms/backoffice/extension-api";
import { umbExtensionsRegistry } from "@umbraco-cms/backoffice/extension-registry";
import { menuManifest } from "./../my-menu/manifests.ts";

export const onInit: UmbEntryPointOnInit = (_host, _extensionRegistry) => {
    console.log("Hello from my extension 🎉");

    umbExtensionsRegistry.register(menuManifest);
};
```
{% endcode %}
{% endtab %}
{% endtabs %}

# Menu Items

Each menu consists of one or more menu item extensions. Extension authors can create customized menu items.

<figure><img src="../../../.gitbook/assets/menu-item.png" alt="" width="250"><figcaption><p>Menu Item</p></figcaption></figure>

## Creating menu items

Menu Item extensions can be created using either JSON or TypeScript. Both approaches are shown below.

### Manifest

To add custom menu items, you can define a single MenuItem manifest and link an element to it. In this element, you can fetch the data and render as many menu items as you want based on that data.

{% tabs %}
{% tab title="JSON" %}
{% code title="umbraco-package.json" %}
```json
{
 "type": "menuItem",
 "alias": "My.MenuItem",
 "name": "My Menu Item",
 "element": "./menu-items.ts",
 "meta": {
  "label": "My Menu Item",
  "menus": ["My.Menu"]
 }
}
```
{% hint style="info" %}
The `element` parameter is optional. Omitting it will render a menu item styled using Umbraco defaults.
{% endhint %}
{% endcode %}
{% endtab %}
{% tab title="TypeScript" %}

Extension authors define the menu manifest, then register it dynamically/during runtime using a [Backoffice Entry Point](../../extending-overview/extension-types/backoffice-entry-point.md) extension.

The `element` attribute will point toward a custom Lit component, an example of which will be in the next section of this article.

{% code title="my-menu/manifests.ts" %}
```typescript
const menuItemManifest: Array<ManifestMenuItem> = [
    {
        type: 'menuItem',
        alias: 'My.MenuItem',
        name: 'My Menu Item',
        meta: {
            label: 'My Menu Item',
            menus: ["My.Menu"]
        },
    }
];
```
{% endcode %}

{% code title="entrypoints/entrypoints.ts" %}
```typescript
import type {
    UmbEntryPointOnInit,
} from "@umbraco-cms/backoffice/extension-api";
import { umbExtensionsRegistry } from "@umbraco-cms/backoffice/extension-registry";
import { menuItemManifest } from "./../my-menu/manifests.ts";

export const onInit: UmbEntryPointOnInit = (_host, _extensionRegistry) => {
    console.log("Hello from my extension 🎉");

    umbExtensionsRegistry.register(menuItemManifest);
};
```
{% endcode %}
{% endtab %}
{% endtabs %}

### Custom menu items

{% hint style="info" %}
**Note:** Displaying menu item extensions does not require extension authors to create custom menu item subclasss. This step is optional.
{% endhint %}

To render your menu items in Umbraco, extension authors can use the [Umbraco UI Menu Item component](https://uui.umbraco.com/?path=/docs/uui-menu-item--docs). This component enables nested menu structures with a few lines of markup.

`<uui-menu-item>` nodes accept the `has-children` boolean attribute, which will display a caret icon indicating nested items. Tying this boolean attribute to a variable requires using the `?` Lit directive, which would look similar to this: `?has-children=${boolVariable}`.

**Example:**

```html
<uui-menu-item label="Menu Item 1" has-children>
    <uui-menu-item label="Nested Menu Item 1"></uui-menu-item>
    <uui-menu-item label="Nested Menu Item 2"></uui-menu-item>
</uui-menu-item>
```

### Custom menu item element example

Custom elements can fetch the data and render menu items using markup, like above. Storing the results of the fetch in a `@state()` variable will trigger a re-render of the component when the value of the variable changes.

{% code title="menu-items.ts" overflow="wrap" lineNumbers="true" %}
```typescript
import type { UmbMenuItemElement } from '@umbraco-cms/backoffice/menu';
import { UmbLitElement } from '@umbraco-cms/backoffice/lit-element';
import { html, TemplateResult, customElement, state } from '@umbraco-cms/backoffice/external/lit';
import { MyMenuItemResponseModel, MyMenuResource } from '../../../api';

const elementName = 'my-menu-item';

@customElement(elementName)
class MyMenuItems extends UmbLitElement implements UmbMenuItemElement {
    @state()
    private _items: MyMenuItemResponseModel[] = []; // Store fetched items

    @state()
    private _loading: boolean = true; // Track loading state

    @state()
    private _error: string | null = null; // Track any errors

    override firstUpdated() {
        this.fetchInitialItems(); // Start fetching on component load
    }

    // Fetch initial items
    async fetchInitialItems() {
        try {
            this._loading = true;
            this._items = ((await MyMenuResource.getMenuApiV1()).items); // Fetch root-level items
        } catch (e) {
            this._error = 'Error fetching items';
        } finally {
            this._loading = false;
        }
    }

    // Render items
    renderItems(items: MyMenuItemResponseModel[]): TemplateResult {
        return html`
            ${items.map(element => html`
                <uui-menu-item label="${element.name}" ?has-children=${element.hasChildren}>
                ${element.type === 1
                ? html`<uui-icon slot="icon" name="icon-folder"></uui-icon>`
                : html`<uui-icon slot="icon" name="icon-autofill"></uui-icon>`}
                    <!-- recursively render children -->
                    ${element.hasChildren ? this.renderItems(element.children) : ''}
                </uui-menu-item>
            `)}
        `;
    }

    // Main render function
    override render() {
        if (this._loading) {
            return html`<uui-loader></uui-loader>`;
        }

        if (this._error) {
            return html`<uui-menu-item active disabled label="Could not load form tree!">
        </uui-menu-item>`;
        }

        // Render items if loading is done and no error occurred
        return this.renderItems(this._items);
    }
}

export { MyMenuItems as element };

declare global {
    interface HTMLElementTagNameMap {
        [elementName]: MyMenuItems;
    }
}
```
{% endcode %}

## Tree Menu Item

### Manifest

```json
{
 "type": "menuItem",
 "kind": "tree",
 "alias": "My.TreeMenuItem",
 "name": "My Tree Menu Item",
 "meta": {
  "label": "My Tree Menu Item",
  "menus": ["My.Menu"]
 }
}
```

#### Default Element

The default element supports rendering a subtree of menu items.

```typescript
class UmbMenuItemTreeDefaultElement {}
```

## Adding menu items to an existing menu

Extension authors are able to add their own additional menu items to the menus that ship with Umbraco.

Some examples of these built-in menus include:

* Content - `Umb.Menu.Content`
* Media - `Umb.Menu.Media`
* Settings - `Umb.Menu.StructureSettings`
* Templating - `Umb.Menu.Templating`
* ...

Additional Umbraco menus (nine, total) can be found using the Extension Insights browser and selecting **Menu** from the dropdown.

<figure><img src="../../../.gitbook/assets/extension-types-backoffice-browser.png" alt=""><figcaption><p>Backoffice extension browser</p></figcaption></figure>

### Extending Menus

To add a menu item to an existing menu, use the `meta.menus` property.

{% code title="umbraco-package.json" %}
```json
{
    "type": "menuItem", 
    "alias": "My.MenuItem", 
    "name": "My Menu Item", 
    "meta": {
        "label": "My Menu Item", 
        "menus": ["Umb.Menu.Content"]
    },
    "element": "menu-items.js"
}
```
{% endcode %}

## See Also
* [Section Sidebar](sections/section-sidebar.md) for information on creating menus for navigation within section extensions.
