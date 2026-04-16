---
description: >-
  Learn how to create workspace views that provide tab-based content areas for organizing different aspects of entity editing.
---

# Workspace Views

{% hint style="info" %}
If you have worked with Umbraco versions prior to version 14, you likely know this feature as Content Apps. In the new Management API and Web Component-based backoffice, this concept is unified under Workspaces.

While Content Apps implied they only lived on Content nodes, Workspace Views can be attached to any entity (Media, Members, Document Types, and so on.). A Workspace is the entire editing environment, and a View is a specific tab within that environment.
{% endhint %}

Workspace Views provide tab-based content areas within workspaces, allowing you to organize different aspects of entity editing into focused interfaces. They appear as tabs alongside the default content editing interface.

## Purpose

Workspace Views provide:

- **Tab-based organization** for different editing aspects.
- **Contextual interfaces** related to the current entity.
- **Workspace integration** with access to workspace contexts.
- **Custom functionality** specific to entity types.

<figure><img src="../../../../.gitbook/assets/workspace-views.svg" alt=""><figcaption><p>Workspace Views</p></figcaption></figure>

## Manifest

{% code caption="manifest.ts" %}

```typescript
{
  type: 'workspaceView',
  name: 'Example Counter Workspace View',
  alias: 'example.workspaceView.counter',
  element: () => import('./counter-workspace-view.js'),
  weight: 900,
  meta: {
  label: 'Counter',
  pathname: 'counter',
  icon: 'icon-lab',
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

- `weight` - Tab ordering (higher weight appears first).
- `meta.label` - Text displayed on the tab.
- `meta.pathname` - URL segment for the view.
- `meta.icon` - Icon displayed on the tab.
- `conditions` - Determines workspace availability.

## Implementation

Implement your workspace view as a Lit element that extends `UmbElementMixin`. This creates a tab-based interface that users can navigate to within the workspace:

{% code caption="counter-workspace-view.ts" %}

```typescript
import { EXAMPLE_COUNTER_CONTEXT } from './counter-workspace-context.js';
import { UmbTextStyles } from '@umbraco-cms/backoffice/style';
import { css, html, customElement, state, LitElement } from '@umbraco-cms/backoffice/external/lit';
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api';

@customElement('example-counter-workspace-view')
export class ExampleCounterWorkspaceView extends UmbElementMixin(LitElement) {
  #counterContext?: typeof EXAMPLE_COUNTER_CONTEXT.TYPE;

  @state()
  private count = 0;

  constructor() {
  super();
  this.consumeContext(EXAMPLE_COUNTER_CONTEXT, (instance) => {
    this.#counterContext = instance;
    this.#observeCounter();
  });
  }

  #observeCounter(): void {
  if (!this.#counterContext) return;
  this.observe(this.#counterContext.counter, (count) => {
    this.count = count;
  });
  }

  override render() {
  return html`
    <uui-box class="uui-text">
    <h1 class="uui-h2">Counter Example</h1>
    <p class="uui-lead">Current count value: ${this.count}</p>
    <p>This workspace view consumes the Counter Context and displays the current count.</p>
    </uui-box>
  `;
  }

  static override styles = [
  UmbTextStyles,
  css`
    :host {
    display: block;
    padding: var(--uui-size-layout-1);
    }
  `,
  ];
}

export default ExampleCounterWorkspaceView;

declare global {
  interface HTMLElementTagNameMap {
  'example-counter-workspace-view': ExampleCounterWorkspaceView;
  }
}
```

{% endcode %}

## Conditions

Conditions control when a Workspace View is shown. Every condition entry has an `alias` that references a built-in or custom condition, and a `match` value that the condition evaluates against.

{% hint style="info" %}
`UMB_WORKSPACE_CONDITION_ALIAS` is a typed constant for `Umb.Condition.WorkspaceAlias`. Import it from `@umbraco-cms/backoffice/workspace` to get type safety when referencing workspace aliases in your manifest.
{% endhint %}

### Built-in Workspace-relevant Conditions

The following conditions are available out-of-the box and are most relevant for Workspace Views. For the complete list of all extension conditions, see the [Extension Conditions](../condition.md) article.

| Alias | Description | Example `match` value |
|---|---|---|
| `Umb.Condition.WorkspaceEntityType` | Requires the workspace to be working on a specific entity type. | `document`, `media`, `member`, `block`, `user` |
| `Umb.Condition.WorkspaceAlias` | Restricts the view to a specific workspace. Use the `UMB_WORKSPACE_CONDITION_ALIAS` constant from `@umbraco-cms/backoffice/workspace` for type safety. | `Umb.Workspace.Document` |
| `Umb.Condition.WorkspaceContentTypeAlias` | Requires the workspace to be based on a Content Type whose alias matches the value. Use this to target a specific Document Type (for example, only show on Blog Post nodes). | `myCustomDocTypeAlias` |
| `Umb.Condition.WorkspaceContentTypeUnique` | Requires the workspace to be based on a Content Type matched by its unique key (GUID). Use this when you need to target a specific Content Type without relying on its alias. | A content type GUID |
| `Umb.Condition.SectionAlias` | Restricts the view to a specific section (sidebar area). | `Umb.Section.Content` |
| `Umb.Condition.EntityIsTrashed` | Only shows the view if the current entity is in the recycle bin. | No match needed |
| `Umb.Condition.EntityIsNotTrashed` | Only shows the view if the current entity is not in the recycle bin. | No match needed |

{% hint style="tip" %}
Explore the full list of registered conditions in the Umbraco Backoffice by navigating to **Settings** > **Extension Insights** and filtering by "Condition".
{% endhint %}

#### Targeting a specific Document Type

To show a workspace view only for a specific Document Type (for example, "Blog Post"), use `Umb.Condition.WorkspaceContentTypeAlias`:

```typescript
conditions: [
  {
  alias: UMB_WORKSPACE_CONDITION_ALIAS,
  match: 'Umb.Workspace.Document',
  },
  {
  alias: 'Umb.Condition.WorkspaceContentTypeAlias',
  match: 'blogPost', // Only show for blog posts
  },
],
```

#### Custom Conditions

If the built-in conditions don't meet your needs, you can create your own by implementing the `UmbExtensionCondition` interface. See the [Extension Conditions](../condition.md#make-your-own-conditions) documentation for a full guide.

## View Lifecycle

### Initialization

- Views initialize when their tab becomes active.
- Context consumption happens during construction.
- Views have access to workspace-scoped contexts.

### Tab Navigation

- Views are lazy-loaded when first accessed.
- Navigation updates the workspace URL with view pathname.
- Views remain in memory while the workspace is open.

### Context Integration

Views can consume multiple workspace contexts:

```typescript
constructor() {
  super();
  
  // Consume multiple contexts
  this.consumeContext(ENTITY_CONTEXT, (context) => {
  this.observe(context.entity, (entity) => this.requestUpdate());
  });
  
  this.consumeContext(VALIDATION_CONTEXT, (context) => {
  this.observe(context.errors, (errors) => this.requestUpdate());
  });
}
```

## Common Patterns

### Entity Information View

```typescript
@customElement('entity-info-view')
export class EntityInfoView extends UmbElementMixin(LitElement) {
  #entityContext?: EntityWorkspaceContext;

  constructor() {
  super();
  this.consumeContext(ENTITY_CONTEXT, (context) => {
    this.#entityContext = context;
  });
  }

  override render() {
  const entity = this.#entityContext?.getCurrentEntity();
  
  return html`
    <uui-box headline="Entity Information">
    <dl>
      <dt>Name</dt>
      <dd>${entity?.name}</dd>
      <dt>Created</dt>
      <dd>${entity?.createDate}</dd>
    </dl>
    </uui-box>
  `;
  }
}
```

### Interactive Configuration View

```typescript
@customElement('config-view')
export class ConfigView extends UmbElementMixin(LitElement) {
  #configContext?: ConfigWorkspaceContext;

  #handleConfigChange(property: string, value: any) {
  this.#configContext?.updateConfig(property, value);
  }

  override render() {
  return html`
    <uui-box headline="Configuration">
    <uui-toggle 
      .checked=${this.#configContext?.isEnabled}
      @change=${(e) => this.#handleConfigChange('enabled', e.target.checked)}>
      Enable Feature
    </uui-toggle>
    </uui-box>
  `;
  }
}
```

### Analytics Dashboard View

```typescript
@customElement('analytics-view')
export class AnalyticsView extends UmbElementMixin(LitElement) {
  @state()
  private analytics?: AnalyticsData;

  constructor() {
  super();
  this.#loadAnalytics();
  }

  async #loadAnalytics() {
  const entityContext = await this.getContext(ENTITY_CONTEXT);
  const entityId = entityContext.getEntityId();
  
  const analyticsService = await this.getContext(ANALYTICS_SERVICE);
  this.analytics = await analyticsService.getAnalytics(entityId);
  }

  override render() {
  if (!this.analytics) {
    return html`<uui-loader></uui-loader>`;
  }

  return html`
    <uui-box headline="Analytics">
    <div class="stats-grid">
      <div class="stat">
      <span class="value">${this.analytics.pageViews}</span>
      <span class="label">Page Views</span>
      </div>
    </div>
    </uui-box>
  `;
  }
}
```

## Best Practices

### View Organization

- Use descriptive tab labels that indicate the view's purpose.
- Order views by importance using the `weight` property.
- Group related functionality into a single view rather than many small tabs.

### Context Usage

- Consume contexts in the constructor for immediate availability.
- Use `observe()` for reactive updates when context state changes.
- Check context availability before accessing properties.

### Performance

- Keep views lightweight for fast tab switching.
- Load expensive data only when view becomes active.
- Use loading states for async operations.
