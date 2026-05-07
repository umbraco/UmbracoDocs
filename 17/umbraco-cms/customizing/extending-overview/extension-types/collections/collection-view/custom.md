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

Implement your Collection View as a Lit element that extends `UmbCollectionViewElementBase`. The base class provides the collection items via `_items`, handles selection state, and exposes helper methods such as `_selectItem`, `_deselectItem`, and `_isSelectableItem`. Override `render()` to define how the collection is displayed.

{% code title="my-collection-view.ts" %}
```typescript
import { customElement, html, nothing } from '@umbraco-cms/backoffice/external/lit';
import { UmbCollectionViewElementBase } from '@umbraco-cms/backoffice/collection';
import type { UmbCollectionItemModel } from '@umbraco-cms/backoffice/collection';

@customElement('my-collection-view')
export class MyCollectionViewElement extends UmbCollectionViewElementBase {

    override render() {
        if (this._loading) return nothing;
        return html`
            <ul>
                ${this._items.map((item) => this.#renderItem(item))}
            </ul>
        `;
    }

    #renderItem(item: UmbCollectionItemModel) {
        const href = item.unique ? this._itemHrefs.get(item.unique) : undefined;
        const selectable = this._isSelectableItem(item);
        const selected = this._isSelectedItem(item.unique);

        return html`
            <li>
                ${selectable
                    ? html`<input
                            type="checkbox"
                            .checked=${selected}
                            @change=${() => selected
                                ? this._deselectItem(item.unique)
                                : this._selectItem(item.unique)}/>`
                    : nothing}
                ${href && !this._selectOnly
                    ? html`<a href=${href}>${item.name}</a>`
                    : html`<span>${item.name}</span>`}
                <umb-entity-actions-bundle></umb-entity-actions-bundle>
            </li>
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
