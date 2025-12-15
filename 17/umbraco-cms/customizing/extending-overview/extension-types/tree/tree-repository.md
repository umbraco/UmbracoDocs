# Tree Repository

A tree repository provides data to populate your tree. It implements methods to return the root, root items, children of items, and ancestors.

The repository is referenced by your tree manifest via `meta.repositoryAlias`.

## Interface

The `UmbTreeRepository` interface defines the methods your repository must implement:

```typescript
interface UmbTreeRepository {
  requestTreeRoot();
  requestTreeRootItems();
  requestTreeItemsOf(args);
  requestTreeItemAncestors(args);
}
```

See the full interface in the [UI API Documentation](https://apidocs.umbraco.com/v17/ui-api/interfaces/packages_core_tree.UmbTreeRepository.html).

## Implementing a Tree Repository

Extend `UmbControllerBase` and implement the `UmbTreeRepository` interface. Call your API directly within the repository methods:

{% code title="my-tree.repository.ts" %}
```typescript
import { UmbControllerBase } from "@umbraco-cms/backoffice/class-api";
import type { UmbApi } from "@umbraco-cms/backoffice/extension-api";
import type {
  UmbTreeChildrenOfRequestArgs,
  UmbTreeRepository,
  UmbTreeRootModel,
} from "@umbraco-cms/backoffice/tree";
import { MyTreeService } from "./api/index.js";
import {
  MY_TREE_ITEM_ENTITY_TYPE,
  MY_TREE_ROOT_ENTITY_TYPE,
  type MyTreeItemModel,
} from "./types.js";

export class MyTreeRepository
  extends UmbControllerBase
  implements UmbTreeRepository<MyTreeItemModel>, UmbApi
{
  async requestTreeRoot() {
    const root: UmbTreeRootModel = {
      unique: null,
      entityType: MY_TREE_ROOT_ENTITY_TYPE,
      name: "My Items",
      hasChildren: true,
      isFolder: true,
      icon: "icon-folder",
    };

    return { data: root };
  }

  async requestTreeRootItems() {
    const response = await MyTreeService.getRoot();

    const items: Array<MyTreeItemModel> = response.items.map((item) => ({
      unique: item.id,
      entityType: MY_TREE_ITEM_ENTITY_TYPE,
      parent: { unique: null, entityType: MY_TREE_ROOT_ENTITY_TYPE },
      name: item.name,
      hasChildren: item.hasChildren,
      isFolder: false,
      icon: "icon-document",
    }));

    return { data: { items, total: response.total } };
  }

  async requestTreeItemsOf(args: UmbTreeChildrenOfRequestArgs) {
    if (args.parent.unique === null) {
      return this.requestTreeRootItems();
    }

    const response = await MyTreeService.getChildren({
      parentId: args.parent.unique,
    });

    const items: Array<MyTreeItemModel> = response.items.map((item) => ({
      unique: item.id,
      entityType: MY_TREE_ITEM_ENTITY_TYPE,
      parent: {
        unique: args.parent.unique,
        entityType: args.parent.entityType,
      },
      name: item.name,
      hasChildren: item.hasChildren,
      isFolder: false,
      icon: "icon-document",
    }));

    return { data: { items, total: response.total } };
  }

  async requestTreeItemAncestors() {
    return { data: [] };
  }
}

export { MyTreeRepository as api };
```
{% endcode %}

## Registering the Repository

Register the repository in your manifest:

```typescript
{
  type: 'repository',
  alias: 'My.Tree.Repository',
  name: 'My Tree Repository',
  api: () => import('./my-tree.repository.js'),
}
```

The tree manifest references this via `repositoryAlias`:

```typescript
{
  type: 'tree',
  alias: 'My.Tree',
  name: 'My Tree',
  meta: {
    repositoryAlias: 'My.Tree.Repository',
  },
}
```

## Static Data Example

For trees with static or hardcoded data, you can return items directly without API calls:

{% code title="static-tree.repository.ts" %}
```typescript
import { UmbControllerBase } from "@umbraco-cms/backoffice/class-api";
import type { UmbApi } from "@umbraco-cms/backoffice/extension-api";
import type { UmbTreeRepository } from "@umbraco-cms/backoffice/tree";

const staticItems = [
  {
    unique: "1",
    entityType: "my-item",
    parent: { unique: null, entityType: "my-root" },
    name: "First Item",
    hasChildren: false,
    isFolder: false,
    icon: "icon-document",
  },
  {
    unique: "2",
    entityType: "my-item",
    parent: { unique: null, entityType: "my-root" },
    name: "Second Item",
    hasChildren: false,
    isFolder: false,
    icon: "icon-document",
  },
];

export class StaticTreeRepository
  extends UmbControllerBase
  implements UmbTreeRepository<typeof staticItems[0]>, UmbApi
{
  async requestTreeRoot() {
    return {
      data: {
        unique: null,
        entityType: "my-root",
        name: "My Static Tree",
        hasChildren: true,
        isFolder: true,
        icon: "icon-folder",
      },
    };
  }

  async requestTreeRootItems() {
    const items = staticItems.filter((item) => item.parent.unique === null);
    return { data: { items, total: items.length } };
  }

  async requestTreeItemsOf(args) {
    const items = staticItems.filter(
      (item) => item.parent.unique === args.parent.unique
    );
    return { data: { items, total: items.length } };
  }

  async requestTreeItemAncestors() {
    return { data: [] };
  }
}

export { StaticTreeRepository as api };
```
{% endcode %}

## Related

- [Tree Models](./tree-models.md) - `UmbTreeItemModel` and `UmbTreeRootModel` interfaces
- [Tree Navigation](./tree-navigation.md) - How tree clicks navigate to workspaces
- [Trees](./README.md) - Main tree extension documentation
