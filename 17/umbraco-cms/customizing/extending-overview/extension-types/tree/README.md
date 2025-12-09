---
description: A guide to creating a custom tree in Umbraco
---

# Trees

{% hint style="info" %}
**New to sidebar navigation?** Read [Menus](../menu.md) and [Menu Items](../menu-item.md) first. For simple, static navigation you can use menu items alone. Trees are for **data-driven hierarchical structures** - use them when your menu needs to display dynamic content from an API.
{% endhint %}

{% hint style="warning" %}
**Trees are data providers, not UI components.** A tree on its own does nothing visible. To create a working tree in the backoffice, you need to understand three things:

1. **[Displaying Trees](#displaying-trees)** - How trees connect to menus to appear in the sidebar or elsewhere
2. **[Populating Trees](#populating-trees)** - How to populate tree with data
3. **[Tree Navigation](#tree-navigation)** - How to navigate to workspaces byt clicking menu items
{% endhint %}

## Displaying Trees <a href="#displaying-trees" id="displaying-trees"></a>

Trees provide hierarchical data to **Menus**, which display the actual navigation you see in the backoffice sidebar. To display a tree, you need to connect several extensions:

```
Tree (data provider)
  ↓ referenced by
MenuItem (kind: 'tree', treeAlias: 'My.Tree')
  ↓ belongs to
Menu
  ↓ displayed by
SectionSidebarApp
  ↓ appears in
Section (Content, Media, Settings, or custom)
```

### Tree Manifest

Register your tree with a manifest. The `repositoryAlias` links to how the tree gets its data:

```typescript
{
    type: 'tree',
    kind: 'default',
    alias: 'My.Tree',
    name: 'My Tree',
    meta: {
        repositoryAlias: 'My.Tree.Repository',
    },
}
```

### Tree Item Manifest

Tree items define how individual items render. Use `kind: 'default'` for standard rendering:

```typescript
{
    type: 'treeItem',
    kind: 'default',
    alias: 'My.TreeItem',
    forEntityTypes: ['my-entity-type'],
}
```

{% hint style="info" %}
The `forEntityTypes` array must match the `entityType` values returned by your data source.
{% endhint %}

### Connecting to a Menu

To display your tree in a section sidebar, create a MenuItem with `kind: 'tree'`:

```typescript
{
    type: 'menuItem',
    kind: 'tree',
    alias: 'My.MenuItem.Tree',
    meta: {
        treeAlias: 'My.Tree',
        menus: ['My.Menu'],
        hideTreeRoot: true,  // Optional: show items at root level
    },
}
```

See [Menu Items (Tree kind)](../menu-item.md#tree) and [Section Sidebar](../sections/section-sidebar.md) for the complete setup.

### Standalone Rendering

Trees can also be rendered directly in custom components using the `<umb-tree>` element:

```html
<umb-tree alias="My.Tree"></umb-tree>
```

This is less common than displaying via menus but useful for custom UIs.

---

## Populating Trees <a href="#populating-trees" id="populating-trees"></a>

Trees need data. You can populate a tree in two ways:

### Option 1: Manual Data (Simple)

For simple, static trees you can implement a basic data source that returns hardcoded or locally-computed items:

```typescript
export class MySimpleDataSource implements UmbTreeDataSource<MyTreeItemModel> {
    async getRootItems() {
        return {
            items: [
                { unique: '1', entityType: 'my-item', name: 'Item 1', hasChildren: false, icon: 'icon-document' },
                { unique: '2', entityType: 'my-item', name: 'Item 2', hasChildren: false, icon: 'icon-document' },
            ],
            total: 2,
        };
    }

    async getChildrenOf(args) {
        return { items: [], total: 0 };
    }

    async getAncestorsOf(args) {
        return [];
    }
}
```

### Option 2: Repository Pattern (Recommended for APIs)

For trees backed by server APIs, use the full repository pattern with caching:

```
Repository (coordinates data + caching)
  ↓ uses
Data Source (fetches from API)
  ↓ caches in
Store (in-memory cache)
```

Register these in your manifests:

```typescript
// Repository - referenced by tree via repositoryAlias
{
    type: 'repository',
    alias: 'My.Tree.Repository',
    name: 'My Tree Repository',
    api: () => import('./my-tree.repository.js'),
}

// Store - caches tree items
{
    type: 'treeStore',
    alias: 'My.TreeStore',
    name: 'My Tree Store',
    api: () => import('./my-tree.store.js'),
}
```

For detailed implementation guides, see:

- **[Tree Models](./tree-models.md)** - `UmbTreeItemModel` and `UmbTreeRootModel` interfaces
- **[Tree Repository](./tree-repository.md)** - Extends `UmbTreeRepositoryBase`
- **[Tree Data Source](./tree-data-source.md)** - Implements `getRootItems`, `getChildrenOf`, `getAncestorsOf`
- **[Tree Store](./tree-store.md)** - Extends `UmbUniqueTreeStore`

---

## Tree Navigation <a href="#tree-navigation" id="tree-navigation"></a>

When users click a tree item, Umbraco navigates to a **workspace** to edit that item. The `entityType` in your tree items must match the `meta.entityType` in your workspace manifest.

See **[Tree Navigation & Workspaces](./tree-navigation.md)** for setup details and troubleshooting.

---

## Further Reading <a href="#further-reading" id="further-reading"></a>

- [Umbraco UI Examples - Trees](https://github.com/umbraco/Umbraco-CMS/tree/main/src/Umbraco.Web.UI.Client/examples/tree) - Working examples in the Umbraco repository
- [Workspaces](../workspaces/README.md) - Creating workspace extensions
