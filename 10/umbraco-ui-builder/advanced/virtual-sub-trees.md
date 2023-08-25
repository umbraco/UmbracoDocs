---
description: Configuring virtual sub trees in Konstrukt, the backoffice UI builder for Umbraco.
---

# Virtual Sub Trees

Virtual sub trees are a powerful feature that allows you to inject a Konstrukt tree structure into an other Umbraco tree at a desired location, thus acting as child nodes to the node chosen as the injection point. With virtual sub trees it allows you to extend built in or even 3rd party package trees with additional features. An example could be developing a "loyalty point" program for your ecommerce site and injecting the related database tables into a Vendr store tree to allow management of the program in it's most logical location.

![Example virtual sub tree injected into a Vendr store tree](../images/virtual-sub-tree.png)

## Defining virtual sub trees

You define a virtual sub tree by calling one of the `AddVirtualSubTree` methods o a [`KonstruktWithTreeConfigBuilder`](../areas/trees.md#extending-an-existing-tree) instance.

#### **AddVirtualSubTree(string sectionAlias, string treeAlias, Lambda visibilityExpression, Lambda virtualSubTreeConfig = null) : KonstruktVirtualSubTreeConfigBuilder**

Adds a virtual sub tree to the current tree with it's visibility controlled via the visibility expression.

````csharp
// Example
withTreeConfig.AddVirtualSubTree(ctx => ctx.Source.Id == 1056, contextAppConfig => {
    ...
});
````

#### **AddVirtualSubTreeBefore(string sectionAlias, string treeAlias, Lambda visibilityExpression, Lambda matchExpression, Lambda virtualSubTreeConfig = null) : KonstruktVirtualSubTreeConfigBuilder**

Adds a virtual sub tree to the current tree, before the tree node matching the match expression, with it's visibility controlled via the visibility expression.

````csharp
// Example
withTreeConfig.AddVirtualSubTreeBefore(ctx => ctx.Source.Id == 1056, treeNode => treeNode.Name == "Settings", contextAppConfig => {
    ...
});
````

#### **AddVirtualSubTreeAfter(string sectionAlias, string treeAlias, Lambda visibilityExpression, Lambda matchExpression, Lambda virtualSubTreeConfig = null) : KonstruktVirtualSubTreeConfigBuilder**

Adds a virtual sub tree to the current tree, after the tree node matching the match expression, with it's visibility controlled via the visibility expression.

````csharp
// Example
withTreeConfig.AddVirtualSubTreeAfter(ctx => ctx.Source.Id == 1056, treeNode => treeNode.Name == "Settings", contextAppConfig => {
    ...
});
````

## Controlling where to inject the virtual sub tree

Controlling where a virtual sub tree is injected is done so via the visibility expression passed to one of the `AddVirtualSubTree` methods on the root level `KonstruktConfigBuilder` instance. Without a vsibility expression Konstrukt would inject the virtual sub tree under every node in the given tree and so we use this expression to indentify the exact location where our tree should go. 

To help with this the visibility expression is passed a single `KonstruktVirtualSubTreeFilterContext` argument with relevant contextual information about the current node being rendered, alongside a list of the current users user groups for permission based visibility control and access to a `IServiceProvider` in case you need to resolve a service to determine the correct node to inject below.

````csharp
public class KonstruktVirtualSubTreeFilterContext
{
    public KonstruktNodeContext Source { get; }
    public IEnumerable<IReadOnlyUserGroup> UserGroups { get; }
    public IServiceProvider ServiceProvider { get; }
}

public class KonstruktNodeContext
{
    public string Id { get; }
    public string TreeAlias { get; }
    public string SectionAlias { get; }
    public FormCollection QueryString { get; }
}
````

An example of a more complex filter expression where injection is based on the document type of a content node might look like the following:

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

## Controlling the position of the injected virtual sub tree  

The position of a virtual sub tree within the child nodes of the injection node is controlled by using one of the  `AddVirtualSubTreeBefore` or `AddVirtualSubTreeAfter` methods on the root level `KonstruktConfigBuilder` instance, along with passing a match expression which is used to identify the tree node to insert before / after. This expression is passed a single `TreeNode` argument for you to determine the position and requires a `boolean` return value to indicate the relevant location has been found.

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

An example of positioning a sub tree after a node with the alias "settings" might look like the following:

````csharp
treeNode => treeNode.alias == "settings"
````

## Configuring a virtual sub tree  

Virtual sub trees share essentially the same API as the `Tree` config builder API including support for folders and collections, except when adding collections to a sub tree you will have an additional foreign key expression parameter to define which links the collections entities to the parent node of the sub tree. Please see the [core trees documentation for more info](../areas/trees.md).

## Injecting virtual sub trees into 3rd party trees

Out of the box Konstrukt supports injecting sub trees into the core content, media, members and member groups trees along with 3rd party support for [Vendr](https://vendr.net) settings and commerce trees. In order to support additional trees to inject into you must implement an `IKonstruktTreeHelper` which is used to extract required information. The tree helper consists of a tree alias for which the tree the helper is for along with methods to correctly identify the full parent path, a unique ID for a given node ID and one to resolve the actual entity ID which should be used for collection foreign key values.

````csharp
public interface IKonstruktTreeHelper
{
    string TreeAlias { get; }
    string GetUniqueId(string nodeId, FormCollection queryString);
    object GetEntityId(string uniqueId);
    string GetPath(string uniqueId);
}
````

Once you have defined a tree helper, you can register it the DI container in your startup class.

````csharp
builder.Services.AddSingleton<IKonstruktTreeHelper, MyCustomTreeHelper>();
````

Once registered any virtual sub trees registered against the given helpers tree alias will then use your tree helper to locate the required information.