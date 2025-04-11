---
description: Configuring virtual sub trees in Umbraco UI Builder.
---

# Virtual SubTrees

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

Virtual subtrees inject an Umbraco UI Builder tree structure into another Umbraco tree at a specified location, acting as child nodes of the injection point. They extend built-in or third-party package trees with additional features. For example a "loyalty points" program for an e-commerce site can inject related database tables into a Commerce store tree, making management more intuitive.

![Virtual sub tree injected into a Commerce store tree](../images/virtual-sub-tree.png)

## Defining Virtual SubTrees

Use the `AddVirtualSubTree` methods of a [WithTreeConfigBuilder](../areas/trees.md#extending-an-existing-tree) instance to define a virtual subtree.

### Using the `AddVirtualSubTree()` Method

Adds a virtual subtree to the current tree with visibility controlled by the specified expression.

#### Method Syntax

```csharp
AddVirtualSubTree(string sectionAlias, string treeAlias, Lambda visibilityExpression, Lambda virtualSubTreeConfig = null) : VirtualSubTreeConfigBuilder
```

#### Example

````csharp
withTreeConfig.AddVirtualSubTree(ctx => ctx.Source.Id == 1056, contextAppConfig => {
    ...
});
````

### Using the `AddVirtualSubTreeBefore()` Method

Adds a virtual subtree to the current tree **before** the tree node matches the match expression, with its visibility controlled by the specified expression.

#### Method Syntax

```csharp
AddVirtualSubTreeBefore(string sectionAlias, string treeAlias, Lambda visibilityExpression, Lambda matchExpression, Lambda virtualSubTreeConfig = null) : VirtualSubTreeConfigBuilder
```

#### Example

````csharp
withTreeConfig.AddVirtualSubTreeBefore(ctx => ctx.Source.Id == 1056, treeNode => treeNode.Name == "Settings", contextAppConfig => {
    ...
});
````

### Using the `AddVirtualSubTreeAfter()` Method

Adds a virtual subtree to the current tree **after** the tree node matches the match expression, with its visibility controlled by the specified expression.

#### Method Syntax

```csharp
AddVirtualSubTreeAfter(string sectionAlias, string treeAlias, Lambda visibilityExpression, Lambda matchExpression, Lambda virtualSubTreeConfig = null) : VirtualSubTreeConfigBuilder
```

#### Example

````csharp
withTreeConfig.AddVirtualSubTreeAfter(ctx => ctx.Source.Id == 1056, treeNode => treeNode.Name == "Settings", contextAppConfig => {
    ...
});
````

## Control the Virtual SubTrees Inject Location

Control the injection location by passing a visibility expression to the `AddVirtualSubTree` methods on the root `UIBuilderConfigBuilder` instance. Without a visibility expression, the subtree appears under every node in the target tree. This expression can be used to identify the exact location where the tree should go.

The visibility expression receives a `VirtualSubTreeFilterContext` argument with relevant contextual information. The information includes the current node being rendered, alongside a list of the current user's user groups for permission-based visibility control. It also includes access to an `IServiceProvider` for dependency resolution.

````csharp
public class VirtualSubTreeFilterContext
{
    public NodeContext Source { get; }
    public IEnumerable<IReadOnlyUserGroup> UserGroups { get; }
    public IServiceProvider ServiceProvider { get; }
}

public class NodeContext
{
    public string Id { get; }
    public string TreeAlias { get; }
    public string SectionAlias { get; }
    public FormCollection QueryString { get; }
}
````

### Example: Filter Injection by Document Type

````csharp
withTreeConfig.AddVirtualSubTree(ctx =>
    {
        using var umbracoContextRef = ctx.ServiceProvider.GetRequiredService<IUmbracoContextFactory>().EnsureUmbracoContext();

        if (!int.TryParse(ctx.Source.Id, out int id))
            return false;

        return (umbracoContextRef.UmbracoContext.Content.GetById(id)?.ContentType.Alias ?? "") == "textPage";
    },
    virtualNodeConfig => virtualNodeConfig
        ...
);
````

## Control the Position of the injected Virtual SubTrees

The position of a virtual subtree within the child nodes of the injection node is controlled by using one of the  `AddVirtualSubTreeBefore` or `AddVirtualSubTreeAfter` methods. These methods need to be on the root level `UIBuilderConfigBuilder` instance. The match expression identifies the node for insertion. This expression passes a single `TreeNode` argument to determine the position. It also requires a `boolean` return value to indicate the relevant location has been found.

````csharp
public class TreeNode
{
    public object Id { get; }
    public object ParentId { get; }
    public string Alias { get; }
    public string Name { get; }
    public string NodeType { get; }
    public string Path { get; }
    public string RoutePath { get; }
    public IDictionary<string, object> AdditionalData { get; }
    ...
}
````

Below you can find an example of positioning a subtree after a node with the alias "settings":

````csharp
treeNode => treeNode.alias == "settings"
````

## Configuring a Virtual SubTree

Virtual subtrees use the `Tree` config builder API including support for folders and collections. There is an exception when adding collections to a subtree where you will have an additional foreign key expression parameter to define. The foreign key expression links the entities of the collection to the parent node of the subtree. For more information, see the [Trees](../areas/trees.md) article.

## Inject Virtual Subtrees into Third-Party Trees

Out of the box, Umbraco UI Builder supports injecting subtrees into the core content, media, members, and member group trees. It also includes third-party support for [Umbraco Commerce](../../umbraco-commerce/README.md) settings and commerce trees. To inject into additional trees, implement an `ITreeHelper` to extract necessary data. The tree helper consists of a tree alias for which the tree helper is. It includes methods to correctly identify the full parent path, a unique ID for a given node ID, and to resolve the actual entity ID. The entity ID should be used for the foreign key collection values.

````csharp
public interface ITreeHelper
{
    string TreeAlias { get; }
    string GetUniqueId(string nodeId, FormCollection queryString);
    object GetEntityId(string uniqueId);
    string GetPath(string uniqueId);
}
````

Once you have defined a tree helper, register the DI container in your startup class.

````csharp
builder.Services.AddSingleton<ITreeHelper, MyCustomTreeHelper>();
````

Once registered, any virtual subtree assigned to the helper’s tree alias will use it to locate required data.
