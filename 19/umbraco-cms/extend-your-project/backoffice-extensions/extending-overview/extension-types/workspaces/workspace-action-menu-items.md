---
description: >-
  Learn how to create workspace action menu items that extend workspace actions
  with additional functionality.
---

# Workspace Action Menu Items

Workspace Action Menu Items extend existing workspace actions by adding dropdown menu options. They provide secondary functionality that relates to the primary action without cluttering the workspace footer.

## Manifest

```typescript
{
	type: 'workspaceActionMenuItem',
	kind: 'default',
	alias: 'example.workspaceActionMenuItem.resetCounter',
	name: 'Reset Counter Menu Item',
	api: () => import('./reset-counter-menu-item.action.js'),
	forWorkspaceActions: 'example.workspaceAction.incrementor',
	weight: 100,
	meta: {
		label: 'Reset Counter',
		icon: 'icon-refresh',
	},
}
```

### Key Properties

* **`kind`** - Specifies which type of element should be shown (if no `element` is provided). The `default` option refers to the `<umb-workspace-action-menu-item />`, which supports a label and an href
* **`forWorkspaceActions`** - Specifies which workspace action this extends
* **`weight`** - Controls ordering within the dropdown menu, or within the group when `group` is set
* **`group`** - Optional alias of the group the menu item belongs to. See [Grouping Menu Items](#grouping-menu-items)
* **`separatorBefore`** - Optional. When `true`, adds an extra separator line above the menu item inside its group
* **`meta.label`** - Text displayed in dropdown
* **`meta.icon`** - Icon displayed alongside label

## Kinds

The `kind` property determines the behavior and purpose of the workspace action menu item. Each kind provides specialized functionality for different use cases.

### default

The `default` kind provides standard menu item functionality for executing custom actions.

**Properties:**

* **`api`** - Class that extends `UmbWorkspaceActionMenuItemBase` and implements either `execute()` or `getHref()` method
* **`meta.label`** - Text displayed in the menu item
* **`meta.icon`** - Optional icon displayed alongside the label

The API class provides either a `getHref()` method or an `execute()` method. If the `getHref()` method is provided, the action will open the returned URL. Otherwise, the `execute()` method will be run when the menu item is clicked.

**Use case:** General purpose menu items that execute custom logic or navigate to a URL when clicked.

### previewOption

The `previewOption` kind creates menu items for document preview scenarios, integrating with server-side URL providers to generate preview URLs for different environments.

**Properties:**

* **`meta.label`** - Text displayed in the menu item
* **`meta.icon`** - Icon displayed alongside the label
* **`meta.urlProviderAlias`** - Alias of the server-side `IUrlProvider` that generates the preview URL

**Use case:** Custom preview options that open documents in different preview environments (staging, production, or custom domains).

```typescript
{
	type: 'workspaceActionMenuItem',
	kind: 'previewOption',
	alias: 'My.Custom.PreviewOption',
	name: 'My Custom Preview Option',
	forWorkspaceActions: 'Umb.WorkspaceAction.Document.SaveAndPreview',
	weight: 101,
	meta: {
		icon: 'icon-umbraco',
		label: 'Preview on Staging',
		urlProviderAlias: 'MyStagingUrlProvider',
	},
}
```

{% hint style="info" %}
The `previewOption` kind requires a server-side `IUrlProvider` to be registered with the matching `urlProviderAlias`. The provider generates the preview URL when the menu item is clicked.

Learn more about implementing server-side URL providers in the [Additional preview environments support](../../../../../develop-with-umbraco/headless-and-apis/content-delivery-api/additional-preview-environments-support.md) article.
{% endhint %}

## Implementation

Create a workspace action menu item by extending `UmbWorkspaceActionMenuItemBase` and implementing the `execute` method. This provides the functionality that runs when a user interacts with the menu item:

```typescript
import { EXAMPLE_COUNTER_CONTEXT } from './counter-workspace-context.js';
import { UmbWorkspaceActionMenuItemBase } from '@umbraco-cms/backoffice/workspace';
import type { UmbWorkspaceActionMenuItem } from '@umbraco-cms/backoffice/workspace';

export class ExampleResetCounterMenuItemAction extends UmbWorkspaceActionMenuItemBase implements UmbWorkspaceActionMenuItem {
	override async execute() {
		const context = await this.getContext(EXAMPLE_COUNTER_CONTEXT);
		if (!context) {
			throw new Error('Could not get the counter context');
		}

		context.reset();
	}
}

export const api = ExampleResetCounterMenuItemAction;
```

## Action Relationship

Menu items display a dropdown menu for their associated actions:

### Primary Action

```typescript
// The main action that appears as a button
{
	type: 'workspaceAction',
	alias: 'example.workspaceAction.save',
	meta: { label: 'Save' },
}
```

### Menu Item Extensions

```typescript
// Multiple menu items can extend the same action
{
	type: 'workspaceActionMenuItem',
	alias: 'example.menuItem.saveAndClose',
	forWorkspaceActions: 'example.workspaceAction.save',
	meta: { label: 'Save and Close' },
}

{
	type: 'workspaceActionMenuItem',
	alias: 'example.menuItem.saveAsDraft',
	forWorkspaceActions: 'example.workspaceAction.save',
	meta: { label: 'Save as Draft' },
}
```

## Grouping Menu Items

Umbraco splits the dropdown menu of a workspace action into groups of related menu items, with a separator line between the groups. A group is an extension of the type `workspaceActionMenuItemGroup`. A menu item joins a group through its `group` property, which holds the alias of the group.

Umbraco registers one workspace action menu item group. Import the constant from `@umbraco-cms/backoffice/workspace`.

| Constant                                          | Alias                                         | Weight |
| ------------------------------------------------- | --------------------------------------------- | ------ |
| `UMB_WORKSPACE_ACTION_MENU_ITEM_GROUP_PUBLISHING` | `Umb.WorkspaceActionMenuItemGroup.Publishing` | 100    |

The **Save and publish** menu in the Document workspace uses the Publishing group for Schedule publish, Publish with descendants, and Unpublish.

The following menu item joins the same group. Inside a group, the `weight` of the menu item only orders it among the other items in that group. A weight of 5 places the item after Publish with descendants (weight 10) and before Unpublish (weight 0).

{% code title="manifest.ts" %}
```typescript
import { UMB_WORKSPACE_ACTION_MENU_ITEM_GROUP_PUBLISHING } from '@umbraco-cms/backoffice/workspace';
import { umbExtensionsRegistry } from '@umbraco-cms/backoffice/extension-registry';

const manifest = {
    type: 'workspaceActionMenuItem',
    kind: 'default',
    alias: 'My.WorkspaceActionMenuItem.PublishToStaging',
    name: 'My Publish to Staging Menu Item',
    api: () => import('./publish-to-staging-menu-item.action.js'),
    forWorkspaceActions: 'Umb.WorkspaceAction.Document.SaveAndPublish',
    group: UMB_WORKSPACE_ACTION_MENU_ITEM_GROUP_PUBLISHING,
    weight: 5,
    meta: {
        label: 'Publish to staging',
        icon: 'icon-globe',
    },
};

umbExtensionsRegistry.register(manifest);
```
{% endcode %}

To register your own group, use a manifest with the type `workspaceActionMenuItemGroup`.

Inside a group, a menu item can add an extra line above itself with `separatorBefore: true`. Unpublish sets `separatorBefore: true`, so a line separates Unpublish from the two publish actions in the Publishing group.

For the full ordering and separator rules, and an example of a custom group, see the [Grouping Entity Actions](../entity-actions.md#grouping-entity-actions) section of the Entity Actions article.
