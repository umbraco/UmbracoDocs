---
description: A guide to creating a custom tree in Umbraco
---

# Trees

{% hint style="info" %}
**New to sidebar navigation?** Read [Menus](../menu.md) and [Menu Items](../menu-item.md) first. For basic, static navigation you can use menu items alone. Trees are for **data-driven hierarchical structures** - use them when your menu needs to display dynamic content from an API.
{% endhint %}

{% hint style="warning" %}
**Trees are data providers, not UI components.** A tree on its own does nothing visible. To create a working tree in the backoffice, you need to understand three things:

1. **[Displaying Trees](#displaying-trees)** - How trees connect to menus to appear in the sidebar or elsewhere
2. **[Populating Trees](#populating-trees)** - How to populate tree with data
3. **[Tree Navigation](#tree-navigation)** - How to navigate to workspaces by clicking menu items
{% endhint %}

## Displaying Trees <a href="#displaying-trees" id="displaying-trees"></a>

Trees provide hierarchical data to **Menus**, which display the actual navigation you see in the backoffice sidebar. To display a tree, you need to connect multiple extensions:

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
    forEntityTypes: ['my-tree-root', 'my-tree-item'],
}
```

{% hint style="info" %}
Include both your root entity type and item entity type in `forEntityTypes` so the tree item renderer handles all nodes in your tree.
{% endhint %}

### Connecting to a Menu

To display your tree in a section sidebar, create a MenuItem with `kind: 'tree'`:

```typescript
{
    type: 'menuItem',
    kind: 'tree',
    alias: 'My.MenuItem.Tree',
    name: 'My Tree Menu Item',
    weight: 100,
    meta: {
        label: 'My Tree',
        icon: 'icon-folder',
        entityType: 'my-tree-root',
        menus: ['My.Menu'],
        treeAlias: 'My.Tree',
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

Trees get their data from a **Repository**. The repository implements methods to return tree items and is referenced by the tree manifest via `repositoryAlias`.

### Repository Implementation

Create a repository that extends `UmbControllerBase` and implements the tree repository interface:

```typescript
import { UmbControllerBase } from "@umbraco-cms/backoffice/class-api";
import type { UmbApi } from "@umbraco-cms/backoffice/extension-api";

export class MyTreeRepository extends UmbControllerBase implements UmbApi {
  async requestTreeRoot() {
    return {
      data: {
        unique: null,
        entityType: "my-tree-root",
        name: "My Tree",
        hasChildren: true,
        isFolder: true,
        icon: "icon-folder",
      },
    };
  }

  async requestTreeRootItems() {
    // Call your API here
    const response = await MyTreeService.getRoot();

    const items = response.items.map((item) => ({
      unique: item.id,
      entityType: "my-tree-item",
      parent: { unique: null, entityType: "my-tree-root" },
      name: item.name,
      hasChildren: item.hasChildren,
      isFolder: false,
      icon: "icon-document",
    }));

    return { data: { items, total: response.total } };
  }

  async requestTreeItemsOf(args) {
    if (args.parent.unique === null) {
      return this.requestTreeRootItems();
    }

    // Call your API for children
    const response = await MyTreeService.getChildren({
      parentId: args.parent.unique,
    });

    const items = response.items.map((item) => ({
      unique: item.id,
      entityType: "my-tree-item",
      parent: { unique: args.parent.unique, entityType: args.parent.entityType },
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

### Register the Repository

```typescript
{
    type: 'repository',
    alias: 'My.Tree.Repository',
    name: 'My Tree Repository',
    api: () => import('./my-tree.repository.js'),
}
```

For detailed implementation guidance, see:

- **[Tree Repository](./tree-repository.md)** - Full repository implementation with API examples
- **[Tree Models](./tree-models.md)** - `UmbTreeItemModel` and `UmbTreeRootModel` interfaces

---

## Tree Navigation <a href="#tree-navigation" id="tree-navigation"></a>

When users click a tree item, Umbraco navigates to a **workspace** to edit that item. The `entityType` in your tree items must match the `meta.entityType` in your workspace manifest.

See **[Tree Navigation & Workspaces](./tree-navigation.md)** for setup details and troubleshooting.

---

## Further Reading <a href="#further-reading" id="further-reading"></a>

- [Umbraco UI Examples - Trees](https://github.com/umbraco/Umbraco-CMS/tree/main/src/Umbraco.Web.UI.Client/examples/tree) - Working examples in the Umbraco repository
- [Workspaces](../workspaces/README.md) - Creating workspace extensions
