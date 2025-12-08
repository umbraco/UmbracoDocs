---
description: Implementing a tree data source to provide tree data in Umbraco
---

# Tree Data Source

A tree data source is responsible for fetching data for a tree. It implements methods to retrieve root items, children of a specific item, and ancestors of an item.

## Interface

The `UmbTreeDataSource` interface defines three methods:

```typescript
interface UmbTreeDataSource<TreeItemType> {
  getRootItems(args: UmbTreeRootItemsRequestArgs): Promise<UmbPagedModel<TreeItemType>>;
  getChildrenOf(args: UmbTreeChildrenOfRequestArgs): Promise<UmbPagedModel<TreeItemType>>;
  getAncestorsOf(args: UmbTreeAncestorsOfRequestArgs): Promise<Array<TreeItemType>>;
}
```

## Implementing a Data Source

For most cases, extend `UmbTreeServerDataSourceBase` which handles common tree operations and provides a mapper for transforming API responses.

{% code title="my-tree.data-source.ts" %}
```typescript
import type { UmbControllerHost } from "@umbraco-cms/backoffice/controller-api";
import type {
  UmbTreeAncestorsOfRequestArgs,
  UmbTreeChildrenOfRequestArgs,
  UmbTreeRootItemsRequestArgs,
} from "@umbraco-cms/backoffice/tree";
import { UmbTreeServerDataSourceBase } from "@umbraco-cms/backoffice/tree";
import type { MyTreeItemResponseModel } from "../api/index.js";
import { MyTreeClientService } from "../api/index.js";
import {
  MY_TREE_ITEM_ENTITY_TYPE,
  MY_TREE_ROOT_ENTITY_TYPE,
  type MyTreeItemModel,
} from "./types.js";

export class MyTreeDataSource extends UmbTreeServerDataSourceBase<
  MyTreeItemResponseModel,
  MyTreeItemModel
> {
  constructor(host: UmbControllerHost) {
    super(host, {
      getRootItems,
      getChildrenOf,
      getAncestorsOf,
      mapper,
    });
  }
}

const getRootItems = async (args: UmbTreeRootItemsRequestArgs) =>
  await MyTreeClientService.getRoot({
    query: { skip: args.skip, take: args.take },
  });

const getChildrenOf = async (args: UmbTreeChildrenOfRequestArgs) => {
  if (args.parent?.unique === null) {
    return await getRootItems(args);
  } else {
    return await MyTreeClientService.getChildren({
      query: { parent: args.parent.unique },
    });
  }
};

const getAncestorsOf = async (args: UmbTreeAncestorsOfRequestArgs) => {
  return await MyTreeClientService.getAncestors({
    query: { id: args.treeItem.unique },
  });
};

const mapper = (item: MyTreeItemResponseModel): MyTreeItemModel => {
  return {
    unique: item.id ?? "",
    parent: { unique: "", entityType: MY_TREE_ROOT_ENTITY_TYPE },
    name: item.name ?? "unknown",
    entityType: MY_TREE_ITEM_ENTITY_TYPE,
    hasChildren: item.hasChildren,
    isFolder: false,
    icon: item.icon ?? "icon-document",
  };
};
```
{% endcode %}

## Method Details

### getRootItems

Fetches the top-level items in the tree. Receives pagination arguments (`skip`, `take`).

### getChildrenOf

Fetches children of a specific parent item. The `args.parent` contains the parent's `unique` identifier and `entityType`.

{% hint style="info" %}
When `args.parent.unique` is `null`, it typically means the root level, so you may delegate to `getRootItems`.
{% endhint %}

### getAncestorsOf

Returns the ancestor path for a given item. Used for breadcrumb navigation and expanding the tree to a specific item.

## The Mapper Function

The mapper transforms your API response model into the tree item model format Umbraco expects:

```typescript
interface UmbTreeItemModel {
  unique: string;           // Unique identifier
  entityType: string;       // Must match workspace entityType for navigation
  name: string;             // Display name
  hasChildren: boolean;     // Shows expand arrow if true
  isFolder: boolean;        // Visual styling hint
  icon?: string;            // Icon to display
  parent?: {                // Parent reference
    unique: string;
    entityType: string;
  };
}
```

{% hint style="warning" %}
The `entityType` in your tree item model must match the `entityType` in your workspace manifest for tree item clicks to navigate correctly.
{% endhint %}

## Related

- [Tree Repository](./tree-repository.md) - Uses the data source
- [Tree Store](./tree-store.md) - Caches tree items
- [Trees](./README.md) - Main tree extension documentation
