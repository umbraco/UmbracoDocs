---
description: >-
  Learn how to create workspace actions that provide primary user interactions within workspace environments.
---

# Workspace Actions

Workspace Actions appear as buttons in the workspace footer, providing primary interaction points for workspace operations. They integrate directly with workspace contexts and can be extended with dropdown menu items.

## Purpose

Workspace Actions provide:
- **Primary interactions** prominently displayed in workspace footer
- **Context integration** with direct access to workspace state
- **Extensibility** through action menu items
- **Conditional availability** based on workspace state or type

## Manifest

{% code caption="manifest.ts" %}
```typescript
{
	type: 'workspaceAction',
	kind: 'default',
	name: 'Example Count Incrementor Workspace Action',
	alias: 'example.workspaceAction.incrementor',
	weight: 1000,
	api: () => import('./incrementor-workspace-action.js'),
	meta: {
		label: 'Increment',
		look: 'primary',
		color: 'danger',
	},
	conditions: [
		{
			alias: UMB_WORKSPACE_CONDITION_ALIAS,
			match: 'Umb.Workspace.Document',
		},
	],
}
```
{% endcode %}

### Key Properties
- **`weight`** - Controls action ordering (higher appears first)
- **`meta.look`** - Button style: `'primary'`, `'secondary'`, `'outline'`
- **`meta.color`** - Color theme: `'default'`, `'positive'`, `'warning'`, `'danger'`
- **`conditions`** - Determines workspace availability

## Implementation

Create a workspace action by extending `UmbWorkspaceActionBase` and implementing the `execute` method. This provides the functionality that runs when a user clicks the action button:

{% code caption="incrementor-workspace-action.ts" %}
```typescript
import { EXAMPLE_COUNTER_CONTEXT } from './counter-workspace-context.js';
import { UmbWorkspaceActionBase, type UmbWorkspaceAction } from '@umbraco-cms/backoffice/workspace';

export class ExampleIncrementorWorkspaceAction extends UmbWorkspaceActionBase implements UmbWorkspaceAction {
	override async execute() {
		const context = await this.getContext(EXAMPLE_COUNTER_CONTEXT);
		if (!context) {
			throw new Error('Could not get the counter context');
		}
		context.increment();
	}
}

export const api = ExampleIncrementorWorkspaceAction;
```
{% endcode %}

## Workspace Integration

### Context Access
Actions automatically have access to their workspace's contexts:

```typescript
// Context is scoped to the current workspace
const context = await this.getContext(MY_WORKSPACE_CONTEXT);
```

### Execution Lifecycle
- Actions execute when clicked
- Can be async for complex operations
- Have access to workspace state during execution
- Can modify workspace contexts

### Conditional Execution
Check workspace state before performing actions:

```typescript
override async execute() {
	const entityContext = await this.getContext(ENTITY_CONTEXT);
	
	if (!entityContext.canPerformAction()) {
		return; // Silently skip if not available
	}
	
	await entityContext.performAction();
}
```

## Action Menu Integration

Actions can be extended with dropdown menu items using `forWorkspaceActions`:

{% code caption="action-with-menu.ts" %}
```typescript
// Primary Action
{
	type: 'workspaceAction',
	alias: 'example.action.save',
	api: () => import('./save-action.js'),
	meta: { label: 'Save' },
}

// Menu Item Extension  
{
	type: 'workspaceActionMenuItem',
	alias: 'example.menuItem.saveAndClose',
	api: () => import('./save-close-action.js'),
	forWorkspaceActions: 'example.action.save', // Extends the save action
	meta: { label: 'Save and Close' },
}
```
{% endcode %}

## Action Events

Workspace actions dispatch a generic `action-executed` event when they complete:

```typescript
// Event is automatically dispatched by the action UI element
export class UmbActionExecutedEvent extends Event {
	constructor() {
		super('action-executed', { bubbles: true, composed: true, cancelable: false });
	}
}
```

### Event Characteristics
- **Generic signal** - No action-specific data included
- **Always dispatched** - Fires on both success and failure
- **DOM bubbling** - Event bubbles up through the workspace
- **No payload** - Contains no information about the action or results

### Listening for Action Events
Components can listen for action completion:

```typescript
// In a workspace component
this.addEventListener('action-executed', (event) => {
	// Action completed (success or failure)
	// Refresh UI, close modals, etc.
});
```

### When to Use Events
- **UI cleanup** - Close dropdowns, modals after action execution
- **General refresh** - Update displays when any action completes
- **State synchronization** - Trigger broad UI updates

{% hint style="info" %}
For action-specific communication, use workspace contexts rather than events. Events provide only generic completion signals.
{% endhint %}

## Common Patterns

### Entity Operations
```typescript
export class SaveAction extends UmbWorkspaceActionBase {
	override async execute() {
		const workspace = await this.getContext(DOCUMENT_WORKSPACE_CONTEXT);
		await workspace.save();
	}
}
```

### State-Dependent Actions
```typescript
export class PublishAction extends UmbWorkspaceActionBase {
	override async execute() {
		const workspace = await this.getContext(DOCUMENT_WORKSPACE_CONTEXT);
		
		if (workspace.hasValidationErrors()) {
			// Action doesn't execute if invalid
			return;
		}
		
		await workspace.saveAndPublish();
	}
}
```

### Multi-Step Operations
```typescript
export class ComplexAction extends UmbWorkspaceActionBase {
	override async execute() {
		const workspace = await this.getContext(MY_WORKSPACE_CONTEXT);
		
		workspace.setStatus('processing');
		await workspace.validate();
		await workspace.process();
		await workspace.save();
		workspace.setStatus('complete');
	}
}
```

## Best Practices

### Action Availability
Only show actions when they're meaningful:
```typescript
conditions: [
	{
		alias: UMB_WORKSPACE_CONDITION_ALIAS,
		match: 'Umb.Workspace.Document',
	},
	{
		alias: 'My.Condition.EntityState',
		match: 'draft', // Only show for draft entities
	},
],
```

### Visual Hierarchy
Use appropriate styling for action importance:
```typescript
// Primary action (most important)
meta: { look: 'primary', color: 'positive' }

// Secondary action
meta: { look: 'secondary' }

// Destructive action
meta: { look: 'primary', color: 'danger' }
```

### Context Dependencies
Always check context availability before performing operations.
