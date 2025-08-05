---
description: A guide to creating a custom tree in Umbraco
---

# Trees

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

The tree is a hierarchical structure of nodes and is registered in the Backoffice extension registry. A tree can be rendered anywhere in the Backoffice with the help of the `<umb-tree />` element.

{% hint style="info" %}
If you are looking for information on how to register a tree as a menu in a section, please refer to the [Section Sidebar](./sections/section-sidebar.md) article.
{% endhint %}

## Creating trees <a href="#creating-trees" id="creating-trees"></a>

To Create a Tree in a section of the Umbraco backoffice, you need to take multiple steps:

### Registering a tree <a href="#registering-a-tree" id="registering-a-tree"></a>

The backoffice comes with two different tree item kinds out of the box: entity and fileSystem.

Tree Manifest:

```json
{
    "type": "tree",
    "alias": "My.Tree.Alias",
    "name": "My Tree",
    "meta": {
        "repositoryAlias": "My.Repository.Alias"
    }
},
{
    "type": "treeItem",
    "kind": "entity",
    "alias": "My.TreeItem.Alias",
    "name": "My Tree Item",
    "conditions": {
        "entityType": "my-entity-type",
    },
}
```

### Rendering a tree <a href="#rendering-a-tree" id="rendering-a-tree"></a>

To render a tree in the Backoffice, you can use the `<umb-tree>` element. You need to provide the alias of the tree you want to render. The alias is the same as the one you registered in the manifest.

```typescript
<umb-tree alias="My.Tree.Alias"></umb-tree>
```

### Render a Custom Tree Item <a href="#render-a-custom-tree-item" id="render-a-custom-tree-item"></a>

The `<umb-tree />` element will render the tree items based on the registered tree item alias. If you want to render a custom tree item, you need to register a tree item manifest. This manifest can then show a custom element for the tree item.

#### **The Tree Item Manifest**

```json
{
    "type": "treeItem",
    "alias": "Umb.TreeItem.Alias",
    "name": "My Tree Item",
    "element": "./my-tree-item.element.js",
    "conditions": {
        "entityType": "my-entity-type",
    },
};
```

#### The Tree Item Element <a href="#the-tree-item-element" id="the-tree-item-element"></a>

To create a custom tree item, you need to create a custom element. This element can choose to use the `<umb-tree-item-base>` element underneath. However, it can also be used as a standalone element if you prefer to implement the tree item logic yourself.

In this example, we will create a custom tree item that uses the `<umb-tree-item-base>` element. This base element provides the necessary context and functionality for the tree item.

```typescript
import { css, html, nothing } from 'lit';
import { customElement, property } from 'lit/decorators.js';
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api';
import { UmbMyTreeItemContext, MyTreeItemDataModel } from './my-tree-item.context';

@customElement('my-tree-item')
export class MyTreeItemElement extends UmbElementMixin(LitElement) {
 private _item?: MyTreeItemDataModel;
 @property({ type: Object, attribute: false })
 public get item() {
  return this._item;
 }
 public set item(value: MyTreeItemDataModel | undefined) {
  this._item = value;
  this.#context.setTreeItem(value);
 }

 // Register the context for the tree item
 #context = new UmbMyTreeItemContext(this);

 render() {
  if (!this.item) return nothing;
  return html` <umb-tree-item-base> Some custom markup </umb-tree-item-base>`;
 }
}

export default MyTreeItemElement;
```

#### The Tree Item Context <a href="#the-tree-item-context" id="the-tree-item-context"></a>

The tree item context is a class that provides the necessary functionality for the tree item. It is used to manage the state of the tree item, such as loading children, selecting, and deselecting the item.

You can create a custom tree item context by implementing the `UmbTreeItemContext<T>` interface.

```typescript
// TODO: auto-generate this from the interface
export interface UmbTreeItemContext<T> {
 host: UmbControllerHostElement;
 unique?: string;
 type?: string;

 treeItem: Observable<T | undefined>;
 hasChildren: Observable<boolean>;
 isLoading: Observable<boolean>;
 isSelectable: Observable<boolean>;
 isSelected: Observable<boolean>;
 isActive: Observable<boolean>;
 hasActions: Observable<boolean>;
 path: Observable<string>;

 setTreeItem(treeItem: T | undefined): void;

 requestChildren(): Promise<{
  data: PagedResponse<T> | undefined;
  error: ProblemDetails | undefined;
  asObservable?: () => Observable<T[]>;
 }>;
 toggleContextMenu(): void;
 select(): void;
 deselect(): void;
 constructPath(pathname: string, entityType: string, unique: string): string;
}
```

#### Extending the Tree Item Context base <a href="#extending-the-tree-item-context-base" id="extending-the-tree-item-context-base"></a>

The easiest way to create a custom tree item context is to extend the `UmbTreeItemContextBase<T>` class. This class provides a lot of the functionality you need out of the box, such as loading children, selecting, and deselecting the item.

We provide a base class for the tree item context. This class provides some default implementations for the context. You can extend this class to overwrite any of the default implementations.

```typescript
export class UmbMyTreeItemContext extends UmbTreeItemContextBase<MyTreeItemDataModel> {
 constructor(host: UmbControllerHostElement) {
  super(host, (x: MyTreeItemDataModel) => x.unique);
 }

 // overwrite any methods or properties here if needed
}
```
