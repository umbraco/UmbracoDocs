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

## Implementation

Create a workspace action menu item by extending `UmbWorkspaceActionMenuItemBase` and implementing the `execute` method. This provides the functionality that runs when users interacts with the menu item:

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