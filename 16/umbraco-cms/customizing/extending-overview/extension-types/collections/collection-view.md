---
description: >-
  Learn how to create a Collection View that defines how data is displayed within a collection in Umbraco.
---

## Purpose
Use a collection view when you need to:
- Present data in a structured or visual way (e.g, table, cards, grid)
- Customize how entity fields are displayed

## Create a Collection View

{% hint style="info" %}
Before creating a Collection View, make sure you are familiar with the [Extension Registry in Umbraco](../../../../customizing/extending-overview/extension-registry/register-extensions.md).
{% endhint %}

### Manifest
{% code title="umbraco-package.json" %}
```json
{
  "type": "collectionView",
  "alias": "My.CollectionView.Alias",
  "name": "My Collection View",
  "element": "/App_Plugins/my-collection-view/my-collection-view.js",
  "meta": {
    "label": "Table",
    "icon": "icon-list",
    "pathName": "table"
  },
  "conditions": [
    {
      "alias": "Umb.Condition.CollectionAlias",
      "match": "Umb.Collection.Document" // Type of entity to display in this collection view
    }
  ]
}
```
{% endcode %}

### Implementation

Implement your collection view as a Lit element that extends `UmbLitElement`.
This defines how a list of entities is rendered in your collection.

{% code title="my-collection-view.ts" %}
```typescript
import { css, customElement, html, state } from '@umbraco-cms/backoffice/external/lit';
import { UmbLitElement } from '@umbraco-cms/backoffice/lit-element';
import { UMB_DOCUMENT_COLLECTION_CONTEXT } from '@umbraco-cms/backoffice/document';
import type { UmbDocumentCollectionItemModel } from '@umbraco-cms/backoffice/document';
import type { UmbCollectionColumnConfiguration } from '@umbraco-cms/backoffice/collection';

@customElement('my-document-table-collection-view')
export class MyDocumentTableCollectionViewElement extends UmbLitElement {

	@state() private _columns: Array<{ name: string; alias: string; align?: string }> = [];
	@state() private _items?: Array<UmbDocumentCollectionItemModel> = [];

	constructor() {
		super();

		this.consumeContext(UMB_DOCUMENT_COLLECTION_CONTEXT, (collectionContext) => {
			collectionContext?.setupView(this);

			this.observe(collectionContext?.userDefinedProperties, (props) => {
				this.#createColumns(props);
			});

			this.observe(collectionContext?.items, (items) => {
				this._items = items;
			});
		});
	}

	#createColumns(userProps: Array<UmbCollectionColumnConfiguration> = []) {
		const baseCols = [
			{ name: 'Name', alias: 'name' },
			{ name: 'State', alias: 'state' },
		];
		const userCols = userProps.map((p) => ({
			name: p.nameTemplate ?? p.alias,
			alias: p.alias,
		}));
		this._columns = [...baseCols, ...userCols, { name: '', alias: 'entityActions', align: 'right' }];
	}

	override render() {
        if (this._items === undefined) return html`<p>Not found...</p>`;
		return html`
			<table>
				<thead>
					<tr>
						${this._columns.map((col) => html`<th style="text-align:${col.align ?? 'left'}">${col.name}</th>`)}
					</tr>
				</thead>
				<tbody>
					${this._items.map(
			(item) => html`
							<tr>
								${this._columns.map((col) => {
				switch (col.alias) {
					case 'name':
						return html`<td><a href="#">${item.name}</a></td>`;
					case 'state':
						return html`<td>${item.state}</td>`;
					case 'sortOrder':
						return html`<td>${item.sortOrder}</td>`;
					case 'updateDate':
						return html`<td>${item.updateDate}</td>`
					case 'creator':
						return html`<td>${item.creator}</td>`;
					case 'entityActions':
						return html`<td style="text-align:right;">⋮</td>`;
					default:
						const val = item.values.find((v) => v.alias === col.alias)?.value ?? '';
						return html`<td>${val}</td>`;
				}
			})}
							</tr>
						`
		)}
				</tbody>
			</table>
		`;
	}

	static override styles = css`
		:host {
			display: block;
			width: 100%;
			overflow-x: auto;
			font-family: sans-serif;
		}
		table {
			width: 100%;
			border-collapse: collapse;
		}
		th,
		td {
			padding: 6px 10px;
			border: 1px solid #ddd;
			white-space: nowrap;
		}
		th {
			background: #f8f8f8;
			font-weight: 600;
		}
		a {
			color: var(--uui-color-interactive, #0366d6);
			text-decoration: none;
		}
		a:hover {
			text-decoration: underline;
		}
	`;
}

export default MyDocumentTableCollectionViewElement;

declare global {
	interface HTMLElementTagNameMap {
		'my-document-table-collection-view': MyDocumentTableCollectionViewElement;
	}
}
```
{% endcode %}

### Common Collection Match Values

Use the `match` property in your manifest to target a specific collection type.
| **Match Value** | **Description** |
|------------------|-----------------|
| `Umb.Collection.Document` | Targets the **Document** collection (content items). |
| `Umb.Collection.Media` | Targets the **Media** collection (images, videos, files). |
| `Umb.Collection.Member` | Targets the **Member** collection. |
| `Umb.Collection.MemberGroup` | Targets the **Member Group** collection. |
| `Umb.Collection.User` | Targets the **User** collection. |
| `Umb.Collection.UserGroup` | Targets the **User Group** collection. |
| `Umb.Collection.Dictionary` | Targets the **Dictionary** collection. |

