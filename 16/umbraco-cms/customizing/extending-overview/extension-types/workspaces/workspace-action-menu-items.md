---
description: >-
  Learn how to create workspace action menu items that extend workspace actions with additional functionality.
---

# Workspace Action Menu Item

Workspace Action Menu Items extend existing workspace actions by adding dropdown menu options. They provide secondary functionality that relates to the primary action without cluttering the workspace footer.

## Purpose

Action Menu Items provide:
- **Secondary actions** that extend primary workspace actions
- **Grouped functionality** under a single action button
- **Progressive disclosure** for related operations
- **Context integration** with workspace state

{% hint style="info" %}
Action Menu Items are associated with specific Workspace Actions using the `forWorkspaceActions` property.
{% endhint %}

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
- **`forWorkspaceActions`** - Specifies which workspace action this extends
- **`weight`** - Controls ordering within the dropdown menu
- **`meta.label`** - Text displayed in dropdown
- **`meta.icon`** - Icon displayed alongside label

## Implementation

Create a workspace action menu item by extending `UmbWorkspaceActionMenuItemBase` and implementing the `execute` method. This provides the functionality that runs when users select the menu item:

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

Menu items create dropdown menus for their associated actions:

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

## Use Cases

### Alternative Operations
Provide different ways to perform related actions:
```typescript
// Primary: Quick save
// Menu: Save and close, Save as template, Save and publish
```

### Destructive Actions
Keep dangerous operations in dropdown menus:
```typescript
// Primary: Edit
// Menu: Delete, Archive, Reset
```

### Context-Specific Options
Add options that depend on entity state:
```typescript
override async execute() {
	const entityContext = await this.getContext(ENTITY_CONTEXT);
	
	if (entityContext.isDraft()) {
		await entityContext.saveAsDraft();
	} else {
		await entityContext.saveAndPublish();
	}
}
```

## Best Practices

### Related Functionality
Only group actions that are logically related to the primary action.

### Clear Labels
Use descriptive labels that clearly indicate the menu item's purpose.

### Appropriate Ordering
Use weight to order menu items by importance or frequency of use.

### Context Dependencies
Always check context availability before performing operations.

{% content-ref url="../../../../../examples/workspace-context-counter/" %}
[Complete Integration Example](../../../../../examples/workspace-context-counter/)
{% endcontent-ref %}