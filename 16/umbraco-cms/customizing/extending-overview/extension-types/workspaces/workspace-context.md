---
description: >-
  Learn how to create workspace contexts that provide shared state management and communication between extensions in the workspace.
---

# Workspace Context

Workspace Contexts serve as the central communication hub for workspace extensions, providing shared state management within workspace boundaries. They enable different workspace components to interact through a common data layer.

## Purpose

Workspace Contexts provide:
- **Shared state** scoped to a specific workspace instance
- **Communication layer** between extensions in the workspace
- **Entity lifecycle management** for workspace data
- **Context isolation** ensuring workspace independence

{% hint style="info" %}
Workspace Contexts are automatically scoped to their workspace - extensions in different workspaces cannot access each other's contexts.
{% endhint %}

## Manifest

{% code caption="manifest.ts" %}
```typescript
{
	type: 'workspaceContext',
	name: 'Example Counter Workspace Context',
	alias: 'example.workspaceContext.counter',
	api: () => import('./counter-workspace-context.js'),
	conditions: [
		{
			alias: UMB_WORKSPACE_CONDITION_ALIAS,
			match: 'Umb.Workspace.Document',
		},
	],
}
```
{% endcode %}

## Implementation

Create a workspace context by extending `UmbContextBase` and providing a unique context token. Add this to your project to enable shared state management between workspace extensions:

{% code caption="counter-workspace-context.ts" %}
```typescript
import { UmbContextToken } from '@umbraco-cms/backoffice/context-api';
import { UmbContextBase } from '@umbraco-cms/backoffice/class-api';
import type { UmbControllerHost } from '@umbraco-cms/backoffice/controller-api';
import { UmbNumberState } from '@umbraco-cms/backoffice/observable-api';

export class WorkspaceContextCounterElement extends UmbContextBase {
	#counter = new UmbNumberState(0);
	readonly counter = this.#counter.asObservable();

	constructor(host: UmbControllerHost) {
		super(host, EXAMPLE_COUNTER_CONTEXT);
	}

	increment() {
		this.#counter.setValue(this.#counter.value + 1);
	}

	reset() {
		this.#counter.setValue(0);
	}
}

export const api = WorkspaceContextCounterElement;

export const EXAMPLE_COUNTER_CONTEXT = new UmbContextToken<WorkspaceContextCounterElement>(
	'UmbWorkspaceContext',
	'example.workspaceContext.counter',
);
```
{% endcode %}

## Context Token Pattern

Always use `'UmbWorkspaceContext'` as the first parameter in your context token to ensure proper workspace scoping and isolation:

```typescript
export const MY_WORKSPACE_CONTEXT = new UmbContextToken<MyWorkspaceContext>(
	'UmbWorkspaceContext', // Ensures workspace scoping
	'my.extension.alias',   // Must match manifest alias
);
```

## Workspace Lifecycle

### Initialization
- Created when workspace loads
- Available to all extensions within that workspace
- Destroyed when workspace closes

### Scoping
- Context instances are isolated per workspace
- Extensions can only access contexts from their own workspace
- Context requests automatically scope to nearest workspace

### Conditions
Workspace contexts only initialize when their conditions match:

```typescript
conditions: [
	{
		alias: UMB_WORKSPACE_CONDITION_ALIAS,
		match: 'Umb.Workspace.Document', // Only available in document workspaces
	},
],
```

## Entity Data Patterns

### Draft State Management
```typescript
export class EntityWorkspaceContext extends UmbContextBase {
	#entity = new UmbObjectState<MyEntity | null>(null);
	#isDirty = new UmbBooleanState(false);

	readonly entity = this.#entity.asObservable();
	readonly isDirty = this.#isDirty.asObservable();

	updateEntity(changes: Partial<MyEntity>) {
		const current = this.#entity.getValue();
		if (current) {
			this.#entity.setValue({ ...current, ...changes });
			this.#isDirty.setValue(true);
		}
	}
}
```

### Server Integration
```typescript
export class ServerEntityContext extends UmbContextBase {
	#repository = inject(MyEntityRepository);

	async save() {
		const entity = this.#entity.getValue();
		const saved = await this.#repository.save(entity);
		this.#entity.setValue(saved);
		this.#isDirty.setValue(false);
	}
}
```

## Extension Communication

### In Workspace Actions
```typescript
export class MyWorkspaceAction extends UmbWorkspaceActionBase {
	override async execute() {
		const context = await this.getContext(MY_WORKSPACE_CONTEXT);
		context.performAction();
	}
}
```

### In Workspace Views
```typescript
export class MyWorkspaceView extends UmbElementMixin(LitElement) {
	constructor() {
		super();
		this.consumeContext(MY_WORKSPACE_CONTEXT, (context) => {
			this.observe(context.data, (data) => this.requestUpdate());
		});
	}
}
```

## Best Practices

### State Encapsulation
```typescript
// ✅ Private state with public observables
#data = new UmbObjectState(initialData);
readonly data = this.#data.asObservable();

// ❌ Direct state exposure
data = new UmbObjectState(initialData);
```

### Context Token Consistency
```typescript
// ✅ Use workspace scoping
new UmbContextToken<T>('UmbWorkspaceContext', 'my.alias');

// ❌ Generic context (not workspace-scoped)
new UmbContextToken<T>('MyContext', 'my.alias');
```

### Conditional Availability
Only provide contexts when they're meaningful for the workspace type.
