---
description: How tree items navigate to workspaces when clicked in Umbraco
---

# Trees & Workspaces

Trees and workspaces are tightly coupled. When users click a Tree Item, Umbraco navigates to a workspace to edit that item. This connection is established through the `entityType`, a string identifier that links Tree Items to their corresponding Workspace.

## How Tree Items Connect to Workspaces

When you click a Tree Item:

1. Umbraco reads the `entityType` from the Tree Item data.
2. It navigates to the edit Workspace URL, passing the items `unique` identifier.

## Workspace Kind: Routable vs Default

To support different routes for new vs existing items, your workspace must be routable to have different routes for each case. Use `kind: 'routable'` and set up matching routes in your Workspace API:

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
    api: () => import('./my-custom-item-workspace.api.js'),
    meta: {
        entityType: 'my-custom-item',  // Must match tree item entityType
    },
}
```

## Common Issues

{% hint style="warning" %}
**Endless loading when clicking Tree Items?** This usually means:

- No workspace is registered for that `entityType`.
- The `entityType` in your tree data doesn't match the workspace's `meta.entityType`.
- 
{% endhint %}

## Related

- [Trees](./README.md) - Main tree extension documentation.
- [Workspaces](../workspace/README.md) - Creating workspace extensions.
