# Card Collection View

When you want to display entities as cards within a collection, use the Card Collection View Kind. This will render a card-style grid layout. Each card renders a default layout with the entity's name and icon. You can further customize the card layout by registering a custom card collection item when needed.

The default Collection Item Model used in a Card Collection View is based on the following interface:

```typescript
export interface UmbCollectionItemModel {
  unique: string;
  entityType: string;
  name?: string;
  icon?: string;
}
```

Register the Card Collection View in the extension registry with the kind set to "card":

### Manifest
{% code title="umbraco-package.json" %}
```json
{
  "type": "collectionView",
  "kind": "card",
  "alias": "My.CollectionView.Card",
  "name": "My Card Collection View",
  "conditions": [
    {
      "alias": "Umb.Condition.CollectionAlias",
      "match": "My.Collection" // Type of entity to display in this collection view
    }
  ]
}
```
{% endcode %}

## Custom Card Collection Item

If you want to customize how each item is rendered, you can create and register a custom Card Collection Item.

### Manifest
{% code title="umbraco-package.json" %}
```json
{
  "type": "entityCollectionItemCard",
  "alias": "My.EntityCollectionItemCard.EntityType",
  "name": "My Entity Type Collection Item Card",
  "element": "/App_Plugins/my-collection/card/my-entity-type-collection-item-card.element.js",
  "forEntityTypes": ["my-entity-type"]
}
```
{% endcode %}

### Implementation

Implement your custom Card Collection Item as a Lit element that extends `UmbLitElement`. This defines how an individual card is rendered in the collection.

Get more information about Card elements and base element starting points at the [UI Library documentation](https://uui.umbraco.com/?path=/docs/uui-card--docs)

```typescript
export interface MyCollectionItemModel extends UmbCollectionItemModel {
  // Add custom properties here
}
```

{% code title="my-entity-type-collection-item-card.element.ts" %}
```typescript
import type { MyCollectionItemModel } from './types.ts';
import type { UmbEntityCollectionItemElement } from '@umbraco-cms/backoffice/collection'
import { UmbDeselectedEvent, UmbSelectedEvent } from '@umbraco-cms/backoffice/event';
import { customElement, html, property } from '@umbraco-cms/backoffice/external/lit';
import { UmbLitElement } from '@umbraco-cms/backoffice/lit-element';

@customElement('my-entity-type-collection-item-card')
export class MyEntityTypeCollectionItemCardElement extends UmbLitElement implements UmbEntityCollectionItemElement {
	@property({ type: Object })
	item?: MyCollectionItemModel;

	@property({ type: Boolean })
	selectable = false;

	@property({ type: Boolean })
	selected = false;

	@property({ type: Boolean })
	selectOnly = false;

	@property({ type: Boolean })
	disabled = false;

	@property({ type: String })
	href?: string;

	#onSelected(event: CustomEvent) {
		if (!this.item) return;
		event.stopPropagation();
		this.dispatchEvent(new UmbSelectedEvent(this.item.unique));
	}

	#onDeselected(event: CustomEvent) {
		if (!this.item) return;
		event.stopPropagation();
		this.dispatchEvent(new UmbDeselectedEvent(this.item.unique));
	}

	override render() {
		if (!this.item) return nothing;

		return html`<div>My Custom Card for ${this.item.entityType}:${this.item.unique}</div>`;
	}
}

declare global {
	interface HTMLElementTagNameMap {
		'my-entity-type-collection-item-card': MyEntityTypeCollectionItemCardElement;
	}
}
```
{% endcode %}
