---
description: How tree items navigate to workspaces when clicked in Umbraco
---

# Tree Navigation & Workspaces

Trees and workspaces are tightly coupled. When users click a tree item, Umbraco navigates to a workspace to edit that item. This connection is made through the `entityType` - a string identifier that links tree items to their corresponding workspace.

## How Tree Items Connect to Workspaces

When you click a tree item:

1. Umbraco reads the `entityType` from the tree item data
2. It looks for a workspace registered with a matching `meta.entityType`
3. It navigates to that workspace, passing the item's `unique` identifier

```
Tree Item clicked (entityType: 'my-custom-item', unique: '123')
    ↓
Workspace found (meta.entityType: 'my-custom-item')
    ↓
Navigation to: /section/my-section/workspace/my-custom-item/edit/123
```

## Workspace Kind: Routable vs Default

For tree navigation to work correctly, your workspace must use `kind: 'routable'`:

```typescript
// Tree item manifest
{
    type: 'treeItem',
    kind: 'default',
    alias: 'My.TreeItem',
    forEntityTypes: ['my-custom-item'],
}

// Workspace manifest - MUST be routable for tree navigation
{
    type: 'workspace',
    kind: 'routable',
    alias: 'My.Workspace',
    name: 'My Custom Item Workspace',
    meta: {
        entityType: 'my-custom-item',  // Must match tree item entityType
    },
}
```

{% hint style="info" %}
**Why `kind: 'routable'`?** Routable workspaces generate proper URLs and handle navigation state. This allows:
- Direct linking to specific items
- Browser back/forward navigation
- Correct tree item selection highlighting when switching between items
{% endhint %}

## Common Issues

{% hint style="warning" %}
**Endless loading when clicking tree items?** This usually means:
- No workspace is registered for that `entityType`
- The `entityType` in your tree data doesn't match the workspace's `meta.entityType`
- The workspace is using `kind: 'default'` instead of `kind: 'routable'`
{% endhint %}

## Complete Example

Here's how tree items, tree item manifests, and workspaces connect:

```typescript
// 1. Your data source returns items with entityType
const mapper = (item: ApiResponse): MyTreeItemModel => ({
    unique: item.id,
    entityType: 'my-custom-item',  // This links to the workspace
    name: item.name,
    hasChildren: false,
    icon: 'icon-document',
});

// 2. Tree item manifest handles this entityType
{
    type: 'treeItem',
    kind: 'default',
    alias: 'My.TreeItem',
    forEntityTypes: ['my-custom-item'],
}

// 3. Workspace manifest receives navigation for this entityType
{
    type: 'workspace',
    kind: 'routable',
    alias: 'My.Workspace',
    name: 'My Workspace',
    meta: {
        entityType: 'my-custom-item',
    },
}
```

## Related

- [Trees](./README.md) - Main tree extension documentation
- [Workspaces](../workspace/README.md) - Creating workspace extensions
