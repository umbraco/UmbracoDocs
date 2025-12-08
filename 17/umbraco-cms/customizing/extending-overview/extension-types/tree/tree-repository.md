# Tree Repository

A tree repository orchestrates tree data operations by coordinating between a **Data Source** (which fetches data from APIs) and a **Store** (which caches data in memory). The repository itself does not communicate with APIs directly.

{% hint style="info" %}
The repository delegates all API communication to the [Data Source](./tree-data-source.md). It handles caching through the [Store](./tree-store.md).
{% endhint %}

The interface below is simplified for clarity and omits return types and arguments. See full interfaces in the [UI API Documentation](https://apidocs.umbraco.com/v17/ui-api/interfaces/packages_core_tree.UmbTreeRepository.html).

```typescript
interface UmbTreeRepository {
  requestTreeRoot();
  requestTreeRootItems();
  requestTreeItemsOf();
  requestTreeItemAncestors();
}
```

## Implementing a Tree Repository

To implement a tree repository, extend the `UmbTreeRepositoryBase` class. The base class requires:

1. A **Data Source** - Fetches tree data from your API
2. A **Store Context** - Caches tree items for performance

{% code title="my-tree.repository.ts" %}
```typescript
import type { UmbControllerHost } from "@umbraco-cms/backoffice/controller-api";
import type { UmbApi } from "@umbraco-cms/backoffice/extension-api";
import { UmbTreeRepositoryBase } from "@umbraco-cms/backoffice/tree";
import { MY_TREE_STORE_CONTEXT } from "./my-tree.store.js";
import { MyTreeDataSource } from "./my-tree.data-source.js";
import {
  MY_TREE_ROOT_ENTITY_TYPE,
  type MyTreeItemModel,
  type MyTreeRootModel,
} from "./types.js";

export class MyTreeRepository
  extends UmbTreeRepositoryBase<MyTreeItemModel, MyTreeRootModel>
  implements UmbApi
{
  constructor(host: UmbControllerHost) {
    super(host, MyTreeDataSource, MY_TREE_STORE_CONTEXT);
  }

  async requestTreeRoot() {
    const data: MyTreeRootModel = {
      unique: null,
      entityType: MY_TREE_ROOT_ENTITY_TYPE,
      name: "My Tree Root",
      icon: "icon-folder",
      hasChildren: true,
      isFolder: true,
    };

    return { data };
  }
}

export { MyTreeRepository as api };
```
{% endcode %}

### Registering the Repository

Register the repository in your manifest:

```typescript
{
  type: 'repository',
  alias: 'My.Tree.Repository',
  name: 'My Tree Repository',
  api: () => import('./my-tree.repository.js'),
}
```

The repository alias is referenced by your tree manifest via `meta.repositoryAlias`.

## Related

- [Tree Data Source](./tree-data-source.md) - Implements data fetching methods
- [Tree Store](./tree-store.md) - Caches tree items
- [Trees](./README.md) - Main tree extension documentation