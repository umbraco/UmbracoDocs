---
description: >-
  Learn how to create workspace action menu items that extend workspace actions with additional functionality.
---

# Workspace Action Menu Item

Workspace Action Menu Items extend existing workspace actions by adding dropdown menu options. They provide secondary functionality that relates to the primary action without cluttering the workspace footer.

## Manifest

{% code caption="manifest.ts" %}
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
{% endcode %}

### Key Properties
- **`kind`** - Specifies which type of element should be shown (if no `element` is provided). The `default` option refers to the `<umb-workspace-action-menu-item />`, which supports a label and an href
- **`forWorkspaceActions`** - Specifies which workspace action this extends
- **`weight`** - Controls ordering within the dropdown menu
- **`meta.label`** - Text displayed in dropdown
- **`meta.icon`** - Icon displayed alongside label

## Kinds

The `kind` property determines the behavior and purpose of the workspace action menu item. Each kind provides specialized functionality for different use cases.

### default

The `default` kind provides standard menu item functionality for executing custom actions.

**Properties:**
- **`api`** - Class that extends `UmbWorkspaceActionMenuItemBase` and implements either `execute()` or `getHref()` method
- **`meta.label`** - Text displayed in the menu item
- **`meta.icon`** - Optional icon displayed alongside the label

The API class either provides a `getHref()` method or an `execute()` method. If the `getHref()` method is provided, the action will open the returned URL. Otherwise, the `execute()` method will be run when the menu item is clicked.

**Use case:** General purpose menu items that execute custom logic or navigate to a URL when clicked.

### previewOption

The `previewOption` kind creates menu items for document preview scenarios, integrating with server-side URL providers to generate preview URLs for different environments.

**Properties:**
- **`meta.label`** - Text displayed in the menu item
- **`meta.icon`** - Icon displayed alongside the label
- **`meta.urlProviderAlias`** - Alias of the server-side `IUrlProvider` that generates the preview URL

**Use case:** Custom preview options that open documents in different preview environments (staging, production, custom domains).

{% code caption="Custom Preview Option Manifest" %}
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
{% endcode %}

{% hint style="info" %}
The `previewOption` kind requires a server-side `IUrlProvider` to be registered with the matching `urlProviderAlias`. The provider generates the preview URL when the menu item is clicked.

Learn more about implementing server-side URL providers in the [Additional preview environments support](../../../../reference/content-delivery-api/additional-preview-environments-support.md) article.
{% endhint %}

## Implementation

Create a workspace action menu item by extending `UmbWorkspaceActionMenuItemBase` and implementing the `execute` method. This provides the functionality that runs when a user interacts with the menu item:

{% code caption="reset-counter-menu-item.action.ts" %}
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
{% endcode %}

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
