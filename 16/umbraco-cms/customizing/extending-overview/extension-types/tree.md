---
description: A guide to creating a custom tree in Umbraco
---

# Trees

The tree is a hierarchical structure of nodes and is registered in the Backoffice extension registry. A tree can be rendered anywhere in the Backoffice with the help of the `<umb-tree />` element.

{% hint style="info" %}
If you are looking for information on how to register a tree as a menu in a section, please refer to the [Section Sidebar](./sections/section-sidebar.md) article.
{% endhint %}

## Creating trees <a href="#creating-trees" id="creating-trees"></a>

To create a Tree in the Backoffice, you need to take multiple steps:

### Registering a tree <a href="#registering-a-tree" id="registering-a-tree"></a>

To register a tree, you need to create a manifest:

```json
{
    "type": "tree",
    "alias": "My.Tree.Alias",
    "name": "My Tree",
    "meta": {
        "repositoryAlias": "My.Repository.Alias"
    }
}
```

### Rendering a tree <a href="#rendering-a-tree" id="rendering-a-tree"></a>

To render a tree in the Backoffice, you can use the `<umb-tree>` element. You need to provide the alias of the tree you want to render. The alias is the same as the one you registered in the manifest.

```typescript
<umb-tree alias="My.Tree.Alias"></umb-tree>
```

### Render a Custom Tree Item <a href="#render-a-custom-tree-item" id="render-a-custom-tree-item"></a>

The `<umb-tree />` element will render the tree items based on the registered tree item alias. The tree will be rendered using the [<umb-default-tree-item />](https://apidocs.umbraco.com/v16/ui-api/classes/packages_core_tree.UmbDefaultTreeItemElement.html) element by default. If you want to render a custom tree item, you need to register a tree item manifest. This manifest can then show a custom element for the tree item.

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

To create a custom tree item, you need to create a custom element. This element can optionally extend the [UmbTreeItemElementBase<T>](https://apidocs.umbraco.com/v16/ui-api/classes/packages_core_tree.UmbTreeItemElementBase.html) class. However, it can also be used as a standalone element if you prefer to implement the tree item logic yourself.

In this example, we will create a custom tree item that extends the base class. The base class provides the necessary context and functionality for the tree item.

```typescript
import type { MyTreeItemDataModel } from './my-tree-item.model.js';
import { UmbTreeItemElementBase } from '@umbraco-cms/backoffice/tree';
import { html, nothing, customElement } from '@umbraco-cms/backoffice/external/lit';

@customElement('my-tree-item')
export class MyTreeItemElement extends UmbTreeItemElementBase<MyTreeItemDataModel> {
    override render() {
        if (!this.item) return nothing;
        return html`
            <div>
                <umb-icon .name=${this.item.icon}></umb-icon>
                <span>${this.item.name}</span>
            </div>
        `;
    }
}

export default MyTreeItemElement;
```

#### The Tree Item Model <a href="#extending-the-tree-item-model" id="extending-the-tree-item-model"></a>

To define the data model for your tree item, you can create a model that extends the [UmbTreeItemModel](https://apidocs.umbraco.com/v16/ui-api/interfaces/packages_core_tree.UmbTreeItemModel.html). This model will be used to provide the data for your custom tree item.

{% code title="my-tree-item.model.ts" %}
```typescript
import type { UmbTreeItemModel } from '@umbraco-cms/backoffice/tree';

export interface MyTreeItemDataModel extends UmbTreeItemModel {
    // Add any additional properties you need for your tree item
}
```
{% endcode %}


### Adding data to the tree <a href="#adding-data-to-the-tree" id="adding-data-to-the-tree"></a>

To add data to the tree, you need to create a repository that will provide the data for the tree. The repository is defined in the manifest of the tree and linked through its `repositoryAlias`.

```json
{
    "type": "repository",
    "alias": "My.Repository.Alias",
    "name": "My Repository",
    "api": "./my-repository.js"
}
```

#### Implementing the repository <a href="#implementing-the-repository" id="implementing-the-repository"></a>

The repository needs to be able to fetch data for the tree. You can implement the repository as a class that extends the [UmbTreeRepositoryBase](https://apidocs.umbraco.com/v16/ui-api/classes/packages_core_tree.UmbTreeRepositoryBase.html) class. This class provides the necessary methods to fetch data for the tree.

{% code title="my-repository.ts" %}
```typescript
import { MyTreeDataSource } from './my-tree-data-source.js';
import type { UmbControllerHost } from '@umbraco-cms/backoffice/controller-api';
import { UmbTreeRepositoryBase } from '@umbraco-cms/backoffice/tree';

export class MyRepository extends UmbTreeRepositoryBase {
    constructor(host: UmbControllerHost) {
        super(host, MyTreeDataSource);
    }
}
```
{% endcode %}

#### Implementing the data source <a href="#implementing-the-data-source" id="implementing-the-data-source"></a>

The data source is responsible for fetching the data for the tree. You can implement the data source as a class that implements the [UmbTreeDataSource](https://apidocs.umbraco.com/v16/ui-api/interfaces/packages_core_tree.UmbTreeDataSource.html) interface.

{% code title="my-tree-data-source.ts" %}
```typescript
import type { MyTreeItemModel } from './my-tree-item.model.js';
import type {
	UmbTreeAncestorsOfRequestArgs,
	UmbTreeChildrenOfRequestArgs,
	UmbTreeDataSource,
	UmbTreeRootItemsRequestArgs,
} from '@umbraco-cms/backoffice/tree';

export class MyTreeDataSource implements UmbTreeDataSource<MyTreeItemModel> {
    async getRootItems(args: UmbTreeRootItemsRequestArgs) {
        // Fetch the root items for the tree
        return [
            {
                id: 'root1',
                name: 'Root Item 1',
                icon: 'icon-folder',
            },
            {
                id: 'root2',
                name: 'Root Item 2',
                icon: 'icon-folder',
            },
        ];
    }

    async getChildrenOf(args: UmbTreeChildrenOfRequestArgs) {
        // Fetch the children of the specified item
        if (args.id === 'root1') {
            return [
                {
                    id: 'child1',
                    name: 'Child Item 1',
                    icon: 'icon-document',
                },
                {
                    id: 'child2',
                    name: 'Child Item 2',
                    icon: 'icon-document',
                },
            ];
        }
        return [];
    }

    async getAncestorsOf(args: UmbTreeAncestorsOfRequestArgs) {
        // Fetch the ancestors of the specified item
        if (args.id === 'child1') {
            return [
                {
                    id: 'root1',
                    name: 'Root Item 1',
                    icon: 'icon-folder',
                },
            ];
        }
        return [];
    }
}
```
{% endcode %}

## Further reading <a href="#further-reading" id="further-reading"></a>

For more information on trees, you can refer to the examples folder in the GitHub repository: [Umbraco UI Examples - Trees](https://github.com/umbraco/Umbraco-CMS/tree/main/src/Umbraco.Web.UI.Client/examples/tree)
