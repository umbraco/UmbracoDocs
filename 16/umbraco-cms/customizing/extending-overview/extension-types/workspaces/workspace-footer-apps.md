---
description: >-
  Learn how to create workspace footer apps that provide persistent status information and contextual data in workspace environments.
---

# Workspace Footer App

Workspace Footer Apps provide persistent status information and contextual data in the workspace footer area. They offer a non-intrusive way to display important information that remains visible while users work with workspace content.

## Purpose

Footer Apps provide:
- **Persistent status** information visible while editing
- **Contextual data** related to the current entity
- **Non-intrusive monitoring** without taking up the main workspace space
- **Real-time updates** through workspace context integration

{% hint style="info" %}
Footer apps appear at the bottom of workspaces and are ideal for displaying status indicators, counters, and contextual information.
{% endhint %}

## Manifest

{% code caption="manifest.ts" %}
```typescript
{
	type: 'workspaceFooterApp',
	alias: 'example.workspaceFooterApp.counterStatus',
	name: 'Counter Status Footer App',
	element: () => import('./counter-status-footer-app.element.js'),
	weight: 900,
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
- **`element`** - Points to the Lit element implementation
- **`weight`** - Controls positioning within footer area
- **`conditions`** - Determines workspace availability

## Implementation

Implement your workspace footer app as a Lit element that extends `UmbElementMixin`. This provides access to workspace contexts and reactive state management:

{% code caption="counter-status-footer-app.element.ts" %}
```typescript
import { customElement, html, state, LitElement } from '@umbraco-cms/backoffice/external/lit';
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api';
import { EXAMPLE_COUNTER_CONTEXT } from './counter-workspace-context.js';

@customElement('example-counter-status-footer-app')
export class ExampleCounterStatusFooterAppElement extends UmbElementMixin(LitElement) {
	@state()
	private _counter = 0;

	constructor() {
		super();
		this.#observeCounter();
	}

	async #observeCounter() {
		const context = await this.getContext(EXAMPLE_COUNTER_CONTEXT);
		if (!context) return;
		
		this.observe(context.counter, (counter: number) => {
			this._counter = counter;
		});
	}

	override render() {
		return html`<span>Counter: ${this._counter}</span>`;
	}
}

export default ExampleCounterStatusFooterAppElement;

declare global {
	interface HTMLElementTagNameMap {
		'example-counter-status-footer-app': ExampleCounterStatusFooterAppElement;
	}
}
```
{% endcode %}

## Footer App Lifecycle

### Initialization
- Footer apps initialize when the workspace loads
- Context consumption happens during construction
- Apps persist for the workspace lifetime

### Updates
- Use `observe()` for reactive updates from workspace contexts
- Apps update automatically when observed state changes
- Efficient rendering keeps footer responsive

## Common Patterns

### Status Indicators
```typescript
@customElement('entity-status-footer-app')
export class EntityStatusFooterApp extends UmbElementMixin(LitElement) {
	@state()
	private status = 'loading';

	constructor() {
		super();
		this.consumeContext(ENTITY_CONTEXT, (context) => {
			this.observe(context.status, (status) => {
				this.status = status;
			});
		});
	}

	override render() {
		return html`
			<div class="status-indicator">
				<uui-icon name="icon-${this.#getStatusIcon()}"></uui-icon>
				<span>${this.status}</span>
			</div>
		`;
	}

	#getStatusIcon() {
		switch (this.status) {
			case 'saved': return 'check';
			case 'draft': return 'edit';
			case 'error': return 'alert';
			default: return 'hourglass';
		}
	}
}
```

### Live Counters
```typescript
@customElement('word-count-footer-app')
export class WordCountFooterApp extends UmbElementMixin(LitElement) {
	@state()
	private wordCount = 0;

	constructor() {
		super();
		this.consumeContext(CONTENT_CONTEXT, (context) => {
			this.observe(context.content, (content) => {
				this.wordCount = this.#countWords(content);
			});
		});
	}

	#countWords(content: string): number {
		return content.trim().split(/\s+/).filter(word => word.length > 0).length;
	}

	override render() {
		return html`<span>${this.wordCount} words</span>`;
	}
}
```

### Validation Summary
```typescript
@customElement('validation-footer-app')
export class ValidationFooterApp extends UmbElementMixin(LitElement) {
	@state()
	private errorCount = 0;

	@state() 
	private warningCount = 0;

	constructor() {
		super();
		this.consumeContext(VALIDATION_CONTEXT, (context) => {
			this.observe(context.errors, (errors) => {
				this.errorCount = errors.filter(e => e.severity === 'error').length;
				this.warningCount = errors.filter(e => e.severity === 'warning').length;
			});
		});
	}

	override render() {
		if (this.errorCount === 0 && this.warningCount === 0) {
			return html`<span class="valid">✓ Valid</span>`;
		}

		return html`
			<div class="validation-summary">
				${this.errorCount > 0 ? html`<span class="errors">${this.errorCount} errors</span>` : ''}
				${this.warningCount > 0 ? html`<span class="warnings">${this.warningCount} warnings</span>` : ''}
			</div>
		`;
	}
}
```

## Best Practices

### Performance
Keep footer apps lightweight for responsive workspace interaction.

### Information Density
Display only essential information. Footer space is limited.

### Context Dependencies
Always check context availability before accessing properties.

### Responsive Design
Ensure footer apps work across different workspace sizes.

### Visual Consistency
Use Umbraco's design system for consistent styling.
