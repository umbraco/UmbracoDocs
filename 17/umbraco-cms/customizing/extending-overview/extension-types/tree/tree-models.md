---
description: Understanding tree item and root models in Umbraco
---

# Tree Models

Trees use two model types to represent data: **Tree Item Model** for individual nodes and **Tree Root Model** for the root node. Your [Data Source](./tree-data-source.md) transforms API responses into these models.

## UmbTreeItemModel

The base interface for tree items. All tree items must include these properties:

```typescript
interface UmbTreeItemModel {
  unique: string;        // Identifier for selection, navigation, and API calls
  entityType: string;    // Must match workspace meta.entityType for navigation
  name: string;          // Display name shown in the tree
  hasChildren: boolean;  // Shows expand arrow when true
  isFolder: boolean;     // Visual styling hint
  icon?: string;         // Icon name (e.g., 'icon-document', 'icon-folder')
  parent?: {             // Parent reference for hierarchy and breadcrumbs
    unique: string;      // Parent's identifier
    entityType: string;  // Parent's entity type
  };
}
```

### Extending the Model

Add custom properties by extending the base interface:

```typescript
import type { UmbTreeItemModel } from '@umbraco-cms/backoffice/tree';

export interface MyTreeItemModel extends UmbTreeItemModel {
  // Add custom properties
  status: 'draft' | 'published';
  lastModified: string;
}
```

Your [Data Source mapper](./tree-data-source.md#the-mapper-function) populates these properties from your API response.

## UmbTreeRootModel

The root model represents the top-level node of your tree. It extends `UmbTreeItemModel` but typically has `unique: null`:

```typescript
interface UmbTreeRootModel extends UmbTreeItemModel {
  unique: null;  // Root has no parent, so unique is null
}
```

### Defining a Root Model

```typescript
import type { UmbTreeRootModel } from '@umbraco-cms/backoffice/tree';

export interface MyTreeRootModel extends UmbTreeRootModel {
  // Root-specific properties if needed
}

// Example root data returned by repository
const rootData: MyTreeRootModel = {
  unique: null,
  entityType: 'my-tree-root',
  name: 'My Tree',
  hasChildren: true,
  isFolder: true,
  icon: 'icon-folder',
};
```

The root model is returned by `requestTreeRoot()` in your [Tree Repository](./tree-repository.md).

## Entity Types

You typically define two entity types - one for the root and one for items:

```typescript
// types.ts
export const MY_TREE_ROOT_ENTITY_TYPE = 'my-tree-root';
export const MY_TREE_ITEM_ENTITY_TYPE = 'my-tree-item';

export interface MyTreeRootModel extends UmbTreeRootModel {
  entityType: typeof MY_TREE_ROOT_ENTITY_TYPE;
}

export interface MyTreeItemModel extends UmbTreeItemModel {
  entityType: typeof MY_TREE_ITEM_ENTITY_TYPE;
}
```

{% hint style="info" %}
The `entityType` values must match your workspace and tree item manifests. See [Tree Navigation](./tree-navigation.md) for how these connect.
{% endhint %}

## Related

- [Tree Data Source](./tree-data-source.md) - Transforms API responses into tree models
- [Tree Repository](./tree-repository.md) - Returns root model via `requestTreeRoot()`
- [Tree Navigation](./tree-navigation.md) - How `entityType` connects to workspaces
