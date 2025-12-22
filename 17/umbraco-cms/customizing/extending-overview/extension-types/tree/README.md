---
description: A guide to creating a custom Tree in Umbraco
---

# Trees

{% hint style="info" %}
**New to sidebar navigation?** Read [Menus](../menu.md) and [Menu Items](../menu-item.md) first. For basic, static navigation you can use Menu Items alone. Trees are for **data-driven hierarchical structures** - use them when your Menu needs to display dynamic content from an API.
{% endhint %}

{% hint style="warning" %}
To create a working Tree in the Backoffice, you need to understand three things:

1. **[Populating Trees](#populating-trees)** - How to populate a Tree with data.
2. **[Displaying Trees](#displaying-trees)** - How to display Trees and connect them to Menus to appear in the Section Sidebar or elsewhere.
3. **[Trees and Workspaces](#trees-and-workspaces)** - How to navigate to Workspaces by clicking Menu Items.
{% endhint %}

## Populating Trees <a href="#populating-trees" id="populating-trees"></a>

Trees get their data from a **Repository**. The Repository implements methods to return Tree Items and is referenced by the Tree Manifest via `repositoryAlias`.

### Register the Repository

```typescript
{
    type: 'repository',
    alias: 'My.Tree.Repository',
    name: 'My Tree Repository',
    api: () => import('./my-tree.repository.js'),
}
```

### Repository Implementation

Create a Repository that implements the `TreeRepository` interface. The interface below is simplified for clarity and omits return types and arguments. See full interfaces in the [UI API Documentation](https://apidocs.umbraco.com/v17/ui-api/interfaces/packages_core_tree.UmbTreeRepository.html)

```typescript
interface UmbTreeRepository {
    requestTreeRoot();
    requestTreeRootItems();
    requestTreeItemsOf();
    requestTreeItemAncestors();
}
```

For detailed implementation guidance, see:

- **[Tree Repository](./tree-repository.md)** - Full repository implementation with static data example.
- **[Tree Models](./tree-models.md)** - `UmbTreeItemModel` and `UmbTreeRootModel` interfaces.

---

## Displaying Trees <a href="#displaying-trees" id="displaying-trees"></a>

### Tree Manifest

Register your tree with a Manifest. The `repositoryAlias` links to how the Tree gets its data:

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

Tree-items define how individual items render. Use `kind: 'default'` for standard rendering:

```typescript
{
    type: 'treeItem',
    kind: 'default',
    alias: 'My.TreeItem',
    forEntityTypes: ['my-tree-root', 'my-tree-item'],
}
```

{% hint style="info" %}
Include both your root entity type and item entity type in `forEntityTypes` so the Tree Item renderer handles all nodes in your Tree.
{% endhint %}

### Standalone Rendering

Trees can be rendered directly in custom components using the `<umb-tree>` element:

```html
<umb-tree alias="My.Tree"></umb-tree>
```

### Connecting to a Menu

Trees can also provide hierarchical data to **Menu Items**, which display the navigation you see in the Backoffice Section Sidebar. 
To register your Tree-based Menu Item use the `kind: 'tree'` in the Menu Item Manifest. 

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
        menus: ['My.Menu'] // The Menu alias where this item should appear,
        treeAlias: 'My.Tree',
        hideTreeRoot: true,  // Optional: show items at root level
    },
}
```

Examples of built-in Menus include:

* Content - `Umb.Menu.Content`
* Media - `Umb.Menu.Media`
* Advanced Settings - `Umb.Menu.AdvancedSettings`

See [Menu Items (Tree kind)](../menu-item.md#tree) and [Section Sidebar](../sections/section-sidebar.md) for the complete setup.

---

## Trees and Workspaces <a href="#trees-and-workspaces" id="trees-and-workspaces"></a>

When users click a Tree Item, Umbraco navigates to a **Workspace** to edit that item. The `entityType` in your Tree Items must match the `meta.entityType` in your Workspace Manifest.

See **[Trees & Workspaces](./trees-and-workspaces.md)** for setup details and troubleshooting.

---

## Further Reading <a href="#further-reading" id="further-reading"></a>

- [Umbraco UI Examples - Trees](https://github.com/umbraco/Umbraco-CMS/tree/main/src/Umbraco.Web.UI.Client/examples/tree) - Working examples in the Umbraco repository.
- [Workspaces](../workspaces/README.md) - Creating Workspace extensions.
