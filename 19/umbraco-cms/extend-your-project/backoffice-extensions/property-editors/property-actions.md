---
description: Guide on how to implement Property Actions for Property Editors in Umbraco
---

# Property Actions

Property Actions are a built-in feature in Umbraco that lets you add extra buttons or tools to any property editor in the backoffice. Think of them as handy shortcuts you can attach to a field without having to rewrite or mess with the field's actual code.

When you register an action to target a specific property editor type, Umbraco places a three-dot menu (...) right next to that field's name.

## Property Actions in the UI

Umbraco utilizes Property Actions out-of-the-box for complex data types like the Block List (providing default actions like "Copy", "Replace", or "Clear"). The exact same UI container can be dynamically injected next to fields like Textbox or Rich Text Editor.

![Property action in Block List](../../../.gitbook/assets/property-actions-blocklist.png)

## Registering a Property Action

{% hint style="info" %}
Before creating a Property Action, make sure you are familiar with the [Extension Registry in Umbraco](https://docs.umbraco.com/umbraco-cms/customizing/extending-overview/extension-registry/extension-registry).
{% endhint %}

Here is how you can register a new Property Action:

{% code title="index.ts" %}
```typescript
import { umbExtensionsRegistry } from '@umbraco-cms/backoffice/extension-registry';
const manifest =
  {
    type: 'propertyAction',
    kind: 'default',
    alias: 'My.propertyAction',
    name: 'My Property Action',
    forPropertyEditorUis: ["my-property-editor"], // Target specific property editor UI aliases (for example, ["Umb.PropertyEditorUi.TextBox", "Umb.PropertyEditorUi.TinyMCE"])
    api: () => import('./my-property-action.api.js'),
    weight: 10, // Order inside the group, or inside the Other group at the end of the menu
    meta: {
      icon: 'icon-add', // Icon to display in the UI
      label: 'My property action', // Label shown to editors
    }
  };

umbExtensionsRegistry.register(manifest);
```
{% endcode %}

### Creating the Property Action Class

Every Property Action needs a class that defines what happens when the action is executed. You can extend the `UmbPropertyActionBase` class for this.

{% code title="my-property-action.api.ts" %}
```typescript
import { UmbPropertyActionBase } from '@umbraco-cms/backoffice/property-action';
import { UMB_PROPERTY_CONTEXT } from '@umbraco-cms/backoffice/property';

export class MyPropertyAction extends UmbPropertyActionBase {
  // The execute method is called when the user triggers the action.
  async execute() {
    // Retrieve the property’s current state.
    const propertyContext = await this.getContext(UMB_PROPERTY_CONTEXT);

    // Here it's possible to modify the property or perform other actions.  In this case, setting a value.
    propertyContext?.setValue("Default text here");
  }
}
export { MyPropertyAction as api };
```
{% endcode %}

## Grouping Property Actions

Umbraco splits the property action menu into groups of related actions, with a separator line between the groups. A group is an extension of the type `propertyActionGroup`. A property action joins a group through its `group` property, which holds the alias of the group.

Umbraco registers the following property action groups. Import the constants from `@umbraco-cms/backoffice/property-action`.

| Constant                              | Alias                               | Weight |
| ------------------------------------- | ----------------------------------- | ------ |
| `UMB_PROPERTY_ACTION_GROUP_CLIPBOARD` | `Umb.PropertyActionGroup.Clipboard` | 1200   |
| `UMB_PROPERTY_ACTION_GROUP_EDIT`      | `Umb.PropertyActionGroup.Edit`      | 1100   |

The following action joins the Edit group. Inside a group, the `weight` of the action only orders it among the other actions in that group.

{% code title="index.ts" %}
```typescript
import { UMB_PROPERTY_ACTION_GROUP_EDIT } from '@umbraco-cms/backoffice/property-action';
import { umbExtensionsRegistry } from '@umbraco-cms/backoffice/extension-registry';

const manifest = {
  type: 'propertyAction',
  kind: 'default',
  alias: 'My.PropertyAction.Reset',
  name: 'My Reset Property Action',
  forPropertyEditorUis: ['my-property-editor'],
  group: UMB_PROPERTY_ACTION_GROUP_EDIT,
  weight: 10,
  api: () => import('./my-property-action.api.js'),
  meta: {
    icon: 'icon-refresh',
    label: 'Reset',
  },
};

umbExtensionsRegistry.register(manifest);
```
{% endcode %}

To register your own group, use a manifest with the type `propertyActionGroup`. Inside a group, an action can add an extra line above itself with `separatorBefore: true`.

For the full ordering and separator rules, and an example of a custom group, see the [Grouping Entity Actions](../extending-overview/extension-types/entity-actions.md#grouping-entity-actions) section of the Entity Actions article.
