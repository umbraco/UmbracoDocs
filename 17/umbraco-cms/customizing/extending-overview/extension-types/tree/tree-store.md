---
description: Implementing a tree store to cache tree data in Umbraco
---

# Tree Store

A tree store caches tree items in memory, improving performance by avoiding repeated API calls for the same data. The store is used by the tree repository to manage tree item state.

{% hint style="info" %}
The store does not communicate with APIs. It only holds cached data. All API communication happens in the [Data Source](./tree-data-source.md).
{% endhint %}

## Implementing a Tree Store

Extend `UmbUniqueTreeStore` and create a context token for dependency injection:

{% code title="my-tree.store.ts" %}
```typescript
import { UmbContextToken } from "@umbraco-cms/backoffice/context-api";
import { UmbControllerHost } from "@umbraco-cms/backoffice/controller-api";
import { UmbUniqueTreeStore } from "@umbraco-cms/backoffice/tree";

export class MyTreeStore extends UmbUniqueTreeStore {
  constructor(host: UmbControllerHost) {
    super(host, MY_TREE_STORE_CONTEXT.toString());
  }
}

export { MyTreeStore as api };

export const MY_TREE_STORE_CONTEXT = new UmbContextToken<MyTreeStore>(
  "MY_TREE_STORE_CONTEXT"
);
```
{% endcode %}

## Registering the Store

Register the store in your manifest alongside your tree:

```typescript
{
  type: 'treeStore',
  alias: 'My.TreeStore',
  name: 'My Tree Store',
  api: () => import('./my-tree.store.js'),
}
```

## Using the Store

The store context is passed to the tree repository constructor:

```typescript
export class MyTreeRepository extends UmbTreeRepositoryBase<MyTreeItemModel, MyTreeRootModel> {
  constructor(host: UmbControllerHost) {
    super(host, MyTreeDataSource, MY_TREE_STORE_CONTEXT);
  }
}
```

The base repository class handles all store operations automatically:
- Caching fetched items
- Retrieving cached items before making API calls
- Updating cached items when data changes

## Related

- [Tree Repository](./tree-repository.md) - Uses the store for caching
- [Tree Data Source](./tree-data-source.md) - Fetches data that gets cached
- [Trees](./README.md) - Main tree extension documentation
