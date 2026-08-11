# Tree Repository

A Tree Repository provides data to populate your Tree. It implements methods to return the root, root items, children of items, and ancestors.

The repository is referenced by your Tree Manifest via `meta.repositoryAlias`.

## Interface

The `UmbTreeRepository` interface defines the methods your repository must implement:

```typescript
interface UmbTreeRepository {
  requestTreeRoot();
  requestTreeRootItems();
  requestTreeItemsOf();
  requestTreeItemAncestors();
}
```

See the full interface in the [UI API Documentation](https://apidocs.umbraco.com/v17/ui-api/interfaces/packages_core_tree.UmbTreeRepository.html).

## Registering the Repository

Register the Repository in your Manifest:

```typescript
{
  type: 'repository',
  alias: 'My.Tree.Repository',
  name: 'My Tree Repository',
  api: () => import('./my-tree.repository.js'),
}
```

## Implementing a Tree Repository

Extend `UmbControllerBase` and implement the `UmbTreeRepository` interface.

### Static Data Example

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

export class MyStaticTreeRepository
  extends UmbControllerBase
  implements UmbTreeRepository, UmbApi
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
    // Implement as needed
    return { data: [] };
  }
}

export { MyStaticTreeRepository as api };
```
{% endcode %}

## Related

- [Tree Models](./tree-models.md) - `UmbTreeItemModel` and `UmbTreeRootModel` interfaces.
- [Trees & Workspaces](./trees-and-workspaces.md) - How Tree clicks navigate to Workspaces.
- [Trees](./README.md) - Main Tree extension documentation.
