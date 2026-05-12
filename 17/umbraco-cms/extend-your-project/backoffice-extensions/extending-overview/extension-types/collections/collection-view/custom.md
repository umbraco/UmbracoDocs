# Custom Collection View

When the existing Collection View kinds do not meet your requirements, you can create a custom Collection View from scratch.

A Custom Collection View renders items produced by a [Collection](../collection.md). The collection is responsible for fetching items through its [Collection Repository](../collection.md#collection-repository).

## Manifest

{% code title="umbraco-package.json" %}
```json
{
  "type": "collectionView",
  "alias": "My.CollectionView.Custom",
  "name": "My Custom Collection View",
  "element": "/App_Plugins/my-collection-view/my-collection-view.js",
  "meta": {
    "label": "My View",
    "icon": "icon-list",
    "pathName": "my-view"
  },
  "conditions": [
    {
      "alias": "Umb.Condition.CollectionAlias",
      "match": "My.Collection" // Collection alias to display this collection view for
    }
  ]
}
```
{% endcode %}

## Implementation

Implement the Collection View as a Lit element that extends `UmbCollectionViewElementBase`. The base class provides the collection items via `_items`, handles selection state, and exposes helper methods such as `_isSelectableItem` and `_isSelectedItem`. Override `render()` to define how the collection is displayed.

Split the view into two elements: a view element that handles the layout and delegates item rendering to a dedicated item element.

{% code title="my-collection-view.ts" %}
```typescript
import { customElement, html, nothing } from '@umbraco-cms/backoffice/external/lit';
import { UmbCollectionViewElementBase } from '@umbraco-cms/backoffice/collection';
import type { UmbCollectionItemModel } from '@umbraco-cms/backoffice/collection';
import './my-collection-view-item.element.js';

@customElement('my-collection-view')
export class MyCollectionViewElement extends UmbCollectionViewElementBase {

    override render() {
        if (this._loading) return nothing;
        return html`
            <div>
                ${this._items.map((item) => this.#renderItem(item))}
            </div>
        `;
    }

    #renderItem(item: UmbCollectionItemModel) {
        return html`
            <my-collection-view-item
                .item=${item}
                .href=${item.unique ? this._itemHrefs.get(item.unique) : undefined}
                ?selectable=${this._isSelectableItem(item)}
                ?selected=${this._isSelectedItem(item.unique)}
                ?selectOnly=${this._selectOnly}
                @selected=${() => this._selectItem(item.unique)}
                @deselected=${() => this._deselectItem(item.unique)}>
            </my-collection-view-item>
        `;
    }
}

export { MyCollectionViewElement as element };

declare global {
    interface HTMLElementTagNameMap {
        'my-collection-view': MyCollectionViewElement;
    }
}
```
{% endcode %}

The item element receives the item model as a property and dispatches `UmbSelectedEvent` and `UmbDeselectedEvent` when the user interacts with the selection control. The base class on the parent view handles these events automatically.

{% code title="my-collection-view-item.element.ts" %}
```typescript
import { UmbDeselectedEvent, UmbSelectedEvent } from '@umbraco-cms/backoffice/event';
import { customElement, html, nothing, property } from '@umbraco-cms/backoffice/external/lit';
import { UmbLitElement } from '@umbraco-cms/backoffice/lit-element';
import { UmbEntityContext } from '@umbraco-cms/backoffice/entity';
import type { UmbCollectionItemModel } from '@umbraco-cms/backoffice/collection';

@customElement('my-collection-view-item')
export class MyCollectionViewItemElement extends UmbLitElement {

    #item?: UmbCollectionItemModel;
    #entityContext?: UmbEntityContext;

    @property({ type: Object })
    get item(): UmbCollectionItemModel | undefined {
        return this.#item;
    }
    set item(value: UmbCollectionItemModel | undefined) {
        const oldValue = this.#item;
        this.#item = value;
        if (value) {
            this.#entityContext = new UmbEntityContext(this);
            this.#entityContext.setEntityType(value.entityType);
            this.#entityContext.setUnique(value.unique);
        } else {
            this.#entityContext?.destroy();
            this.#entityContext = undefined;
        }
        this.requestUpdate('item', oldValue);
    }

    @property({ type: Boolean })
    selectable = false;

    @property({ type: Boolean })
    selected = false;

    @property({ type: Boolean })
    selectOnly = false;

    @property({ type: String })
    href?: string;

    override render() {
        if (!this.item) return nothing;

        return html`
            <div>
                ${this.selectable
                    ? html`<input
                            type="checkbox"
                            .checked=${this.selected}
                            @change=${() => this.selected ? this.#onDeselected() : this.#onSelected()}/>`
                    : nothing}
                ${this.href && !this.selectOnly
                    ? html`<a href=${this.href}>${this.item.name}</a>`
                    : html`<span>${this.item.name}</span>`}
                <umb-entity-actions-bundle></umb-entity-actions-bundle>
            </div>
        `;
    }

    #onSelected() {
        if (!this.item) return;
        this.dispatchEvent(new UmbSelectedEvent(this.item.unique));
    }

    #onDeselected() {
        if (!this.item) return;
        this.dispatchEvent(new UmbDeselectedEvent(this.item.unique));
    }
}

declare global {
    interface HTMLElementTagNameMap {
        'my-collection-view-item': MyCollectionViewItemElement;
    }
}
```
{% endcode %}

## Common Collection Match Values

Use the `match` property in your manifest to target a specific collection type.

| **Match Value** | **Description** |
|---|---|
| `Umb.Collection.Document` | Targets the **Document** collection (content items). |
| `Umb.Collection.Media` | Targets the **Media** collection (images, videos, files). |
| `Umb.Collection.Member` | Targets the **Member** collection. |
| `Umb.Collection.MemberGroup` | Targets the **Member Group** collection. |
| `Umb.Collection.User` | Targets the **User** collection. |
| `Umb.Collection.UserGroup` | Targets the **User Group** collection. |
| `Umb.Collection.Dictionary` | Targets the **Dictionary** collection. |
