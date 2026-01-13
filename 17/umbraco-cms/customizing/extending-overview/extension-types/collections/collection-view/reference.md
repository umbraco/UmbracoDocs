# Reference Collection View

When you want to display entities as a list of references within a collection, use the Reference Collection View Kind. This will render a basic list layout. Each item renders a default layout with the entity's name and icon. You can further customize the item layout by registering a custom Ref Collection Item when needed.

The default Collection Item Model used in a Reference Collection View is based on the following interface:

```typescript
export interface UmbCollectionItemModel {
  unique: string;
  entityType: string;
  name?: string;
  icon?: string;
}
```

Register the Referemce Collection View in the extension registry with the kind set to "ref":

### Manifest
{% code title="umbraco-package.json" %}
```json
{
  "type": "collectionView",
  "kind": "ref",
  "alias": "My.CollectionView.Ref",
  "name": "My Ref Collection View",
  "conditions": [
    {
      "alias": "Umb.Condition.CollectionAlias",
      "match": "My.Collection" // Collection alias to display this collection view for
    }
  ]
}
```
{% endcode %}

## Custom Reference Collection Item
If you want to customize how each item is rendered, you can create and register a custom Ref Collection Item.

### Manifest
{% code title="umbraco-package.json" %}
```json
{
  "type": "entityCollectionItemRef",
  "alias": "My.EntityCollectionItemRef.EntityType",
  "name": "My Entity Type Collection Item Ref",
  "element": "/App_Plugins/my-collection/ref/my-entity-type-collection-item-ref.element.js",
  "forEntityTypes": ["my-entity-type"]
}
```
{% endcode %}

### Implementation
Implement your custom Ref Collection Item as a Lit element that extends `UmbLitElement`. This defines how an individual item is rendered in the collection.

Get more information of Reference elements and base element starting points at the [UI Library documentation](https://uui.umbraco.com/?path=/docs/displays-references-ref--docs)

```typescript
export interface MyCollectionItemModel extends UmbCollectionItemModel {
  // Add custom properties here
}
```

{% code title="my-entity-type-collection-item-ref.element.ts" %}
```typescript
import type { MyCollectionItemModel } from './types.ts';
import type { UmbEntityCollectionItemElement } from '@umbraco-cms/backoffice/collection'
import { UmbDeselectedEvent, UmbSelectedEvent } from '@umbraco-cms/backoffice/event';
import { customElement, html, property } from '@umbraco-cms/backoffice/external/lit';
import { UmbLitElement } from '@umbraco-cms/backoffice/lit-element';

@customElement('my-entity-type-collection-item-ref')
export class MyEntityTypeCollectionItemRefElement extends UmbLitElement implements UmbEntityCollectionItemElement {
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
		return html`<div>My Custom Ref for ${this.item.entityType}:${this.item.unique}</div>`;
	}
}

declare global {
	interface HTMLElementTagNameMap {
		'my-entity-type-collection-item-ref': MyEntityTypeCollectionItemRefElement;
	}
}
```
{% endcode %}
