---
description: How Tree Items navigate to Workspaces when clicked in Umbraco
---

# Trees & Workspaces

Trees and Workspaces are tightly coupled. When users click a Tree Item, Umbraco navigates to a Workspace to edit that item. This connection is established through the `entityType`, a string identifier that links Tree Items to their corresponding Workspace.

## How Tree Items Connect to Workspaces

When you click a Tree Item:

1. Umbraco reads the `entityType` from the Tree Item data.
2. It navigates to the edit Workspace URL, passing the items `unique` identifier.

## Workspace Kind: Routable vs Default

To support different routes for new and existing items, your Workspace must be routable to have different routes for each case. Use `kind: 'routable'` and set up matching routes in your Workspace API:

```typescript
// Tree Item Manifest
{
    type: 'treeItem',
    kind: 'default',
    alias: 'My.TreeItem',
    forEntityTypes: ['my-custom-item'],
}

// Workspace Manifest - MUST be routable for Tree navigation
{
    type: 'workspace',
    kind: 'routable',
    alias: 'My.Workspace',
    name: 'My Custom Item Workspace',
    api: () => import('./my-custom-item-workspace.api.js'),
    meta: {
        entityType: 'my-custom-item',  // Must match Tree Item entityType
    },
}
```

## Common Issues

{% hint style="warning" %}
**Endless loading when clicking Tree Items?** This usually means:

- No Workspace is registered for that `entityType`.
- The `entityType` in your Tree data doesn't match the Workspace's `meta.entityType`.
- 
{% endhint %}

## Related

- [Trees](./README.md) - Main Tree extension documentation.
- [Workspaces](../workspace/README.md) - Creating Workspace extensions.
