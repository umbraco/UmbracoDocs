---
description: >-
  Workspace Contexts manages shared state and enables communication between extensions in a workspace.
---

# Workspace Context

Workspace Contexts serve as the central communication hub for workspace extensions, providing shared state management within the boundaries of the Workspace. They enable different Workspace components to interact through a common data layer.

## Purpose

Workspace Contexts provide:

- **Shared state** scoped to a specific workspace instance.
- **Communication layer** between extensions in the workspace.
- **Entity lifecycle management** for workspace data.
- **Context isolation** ensures workspace independence.

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

## API Implementation

Create a workspace context by extending `UmbContextBase` and providing a unique context token. Add this to your project to enable shared state management between workspace extensions:

{% code caption="counter-workspace-context.ts" %}
```typescript
import { UmbContextToken } from '@umbraco-cms/backoffice/context-api';
import { UmbContextBase } from '@umbraco-cms/backoffice/class-api';
import type { UmbControllerHost } from '@umbraco-cms/backoffice/controller-api';
import { UmbNumberState } from '@umbraco-cms/backoffice/observable-api';

export class WorkspaceContextCounter extends UmbContextBase {
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

export const api = WorkspaceContextCounter;
```
{% endcode %}

## Context Token

A Context Token is used to consume or get a Context. Read more about [Context Consumption here](../../../foundation/context-api/consume-a-context.md).

```typescript
export const EXAMPLE_COUNTER_CONTEXT = new UmbContextToken<WorkspaceContextCounter>(
	'UmbWorkspaceContext', // Ensures workspace scoping
	'example.workspaceContext.counter',   // Must match manifest alias
);
```

When declaring a Workspace Context, always use `'UmbWorkspaceContext'` as the first parameter in your Context Token to ensure proper context isolation.

## Extension Communication

### Workspace Action

The following example shows how to call the increment method from a Workspace Action API.

```typescript
export class MyIncreaseCounterWorkspaceAction extends UmbWorkspaceActionBase {
	override async execute() {
		const context = await this.getContext(EXAMPLE_COUNTER_CONTEXT);
		context.increment();
	}
}
```

### Workspace View

The following example shows how a Workspace View Element can consume a context.

```typescript
export class MyWorkspaceView extends UmbElementMixin(LitElement) {

	@state()
	_count?: number;

	constructor() {
		super();
		this.consumeContext(EXAMPLE_COUNTER_CONTEXT, (context) => {
			this.observe(context.counter, (count) => this._count = count);
		});
	}
	
	// A render using _count
}
```
