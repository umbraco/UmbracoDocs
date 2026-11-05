---
description: >-
  Configuring and customizing Trees to organize and manage the backoffice
  interface effectively.
---

# Trees

A tree is a hierarchical structure that organizes sections into sub-sections. It appears in the main side panel of the Umbraco interface. In Umbraco UI Builder, each section can only have one tree definition, but you can use folder nodes to organize the tree.

![Tree](<../.gitbook/assets/tree (1).png>)

## Configuring a Umbraco UI Builder Section Tree

The tree configuration for Umbraco UI Builder sections is part of the [`Section`](sections.md) config builder and is accessed via its `Tree` method.

### Using the `Tree()` Method

This method defines the structure and behavior of a tree within a section.

#### Method Syntax

```cs
Tree(Lambda treeConfig = null) : TreeConfigBuilder
```

#### Example

```csharp
sectionConfig.Tree(treeConfig => {
    ...
});
```

## Adding a Tree to an Existing Section

To add a tree to an existing section, use one of the `AddTree` methods from the [`WithSection`](sections.md#extending-an-existing-section) config builder.

### Using the `AddTree()` method

This method adds a tree to the current section, specifying its name and icon.

#### Method Syntax

```cs
AddTree(string name, string icon, Lambda treeConfig = null) : TreeConfigBuilder
```

#### Example

```csharp
withSectionConfig.AddTree("My Tree", "icon-folder", treeConfig => {
    ...
});
```

### Grouping Trees with `AddTree()` Method

This method adds a tree to the current section under a specified group.

#### Method Syntax

```cs
AddTree(string groupName, string name, string icon, Lambda treeConfig = null) : TreeConfigBuilder
```

#### Example

```csharp
withSectionConfig.AddTree("My Group", "My Tree", "icon-folder", treeConfig => {
    ...
});
```

### Using `AddTreeBefore()` to Position a Tree

This method adds a tree to the current section before the tree with the specified alias.

#### Method Syntax

```cs
AddTreeBefore(string treeAlias, string name, string icon, Lambda treeConfig = null) : TreeConfigBuilder
```

#### Example

```csharp
withSectionConfig.AddTreeBefore("member", "My Tree", "icon-folder", treeConfig => {
    ...
});
```

### Using `AddTreeAfter()` to Position a Tree

This method adds a tree to the current section after the tree with the specified alias.

#### Method Syntax

```cs
AddTreeAfter(string treeAlias, string name, string icon, Lambda treeConfig = null) : TreeConfigBuilder
```

#### Example

```csharp
withSectionConfig.AddTreeAfter("member", "My Tree", "icon-folder", treeConfig => {
    ...
});
```

## Changing the Tree Icon Color

### Using the `SetIconColor()` Method

This method changes the color of the tree’s icon. The available options are `black`, `green`, `yellow`, `orange`, `blue`, or `red`.

\{% hint style="warning" %\} Only trees in existing sections have an icon. Trees in Umbraco UI Builder sections display the tree contents directly. \{% endhint %\}

#### Method Syntax

```cs
SetIconColor(string color) : TreeConfigBuilder
```

#### Example

```csharp
collectionConfig.SetIconColor("blue");
```

## Adding a Group to a Tree

### Using the `AddGroup()` Method

This method adds a group to the current tree with the specified name.

\{% hint style="warning" %\} Only trees in Umbraco UI Builder sections support groups. \{% endhint %\}

#### Method Syntax

```cs
AddGroup(string name, Lambda groupConfig = null) : GroupConfigBuilder
```

#### Example

```csharp
treeConfig.AddGroup("Settings", groupConfig => {
    ...
});
```

## Adding a Folder to a Tree or Group

### Using the `AddFolder()` Method

This method adds a folder node inside a tree or group, using the default folder icon. For more details, see the [Folders](folders.md) article.

#### Method Syntax

```cs
AddFolder(string name, Lambda folderConfig = null) : FolderConfigBuilder
```

#### Example

```csharp
treeConfig.AddFolder("Settings", folderConfig => {
    ...
});
```

### Using the `AddFolder()` Method with Custom Icon

This method adds a folder with a specified icon inside a tree or group. For more details, see the [Folders](folders.md) article.

#### Method Syntax

```cs
AddFolder(string name, string icon, Lambda folderConfig = null) : FolderConfigBuilder
```

#### Example

```csharp
treeConfig.AddFolder("Settings", "icon-settings", folderConfig => {
    ...
});
```

## Adding a Collection to a Tree or Group

### Using the `AddCollection<>()` Method

This method adds a collection to the current tree or group, specifying its names, descriptions, and default icons. The ID property must be defined. For more details, see the [Collections](../collections/overview.md) article.

#### Method Syntax

```cs
AddCollection<TEntityType>(
    Lambda idFieldExpression, 
    string nameSingular, 
    string namePlural, 
    string description, 
    Lambda collectionConfig = null
) : CollectionConfigBuilder<TEntityType>

```

#### Example

```csharp
treeConfig.AddCollection<Person>(
    p => p.Id, 
    "Person", 
    "People", 
    "A collection of people", 
    collectionConfig => {
        ...
    }
);
```

#### Using the `AddCollection<>()` Method with Icons

This method adds a collection to the current tree or group, specifying its names, descriptions, and custom icons. The ID property must be defined. For more details, see the [Collections](../collections/overview.md) article.

#### Method Syntax

```cs
AddCollection<TEntityType>(
    Lambda idFieldExpression, 
    string nameSingular, 
    string namePlural, 
    string description, 
    string iconSingular, 
    string iconPlural, 
    Lambda collectionConfig = null
) : CollectionConfigBuilder<TEntityType>

```

#### Example

```csharp
treeConfig.AddCollection<Person>(
    p => p.Id, 
    "Person", 
    "People", 
    "A collection of people", 
    "icon-umb-users", 
    "icon-umb-users", 
    collectionConfig => {
        ...
    }
);
```

## Extending an Existing Tree

To extend existing trees, call the `WithTree` method on a [`WithSectionConfigBuilder`](sections.md#extending-an-existing-section) instance.

### Using the `WithTree()` Method

This method starts a sub-configuration for an existing tree with the specified alias.

#### Method Syntax

```cs
WithTree(string alias, Lambda treeConfig = null) : WithTreeConfigBuilder
```

#### Example

```csharp
sectionConfig.WithTree("content", withTreeConfig => {
    ...
});
```

## Adding a Context App to an Existing Tree

### Using the `AddContextApp()` Method

This method adds a context app with the specified name and default icon. For more details, see the [Context Apps](context-apps.md) article.

#### Method Syntax

```cs
AddContextApp(string name, Lambda contextAppConfig = null) : ContextAppConfigBuilder
```

#### Example

```csharp
withTreeConfig.AddContextApp("Comments", contextAppConfig => {
    ...
});
```

### Using the `AddContextApp()` Method with Custom Icon

This method adds a context app with the specified name and custom icon. For more details, see the [Context Apps](context-apps.md) article.

#### Method Syntax

```cs
AddContextApp(string name, string icon, Lambda contextAppConfig = null) : ContextAppConfigBuilder
```

#### Example

```csharp
withTreeConfig.AddContextApp("Comments", "icon-chat", contextAppConfig => {
    ...
});
```

## Adding a Context App Before or After Another Context App

### Using the `AddContextApp()` Method Before Another Context App

This method adds a context app with the specified name and default icon before the specified context app alias. For more information, see the [Context Apps](context-apps.md) article.

#### Method Syntax

```cs
AddContextAppBefore(string beforeAlias, string name, Lambda contextAppConfig = null) : ContextAppConfigBuilder
```

#### Example

```csharp
withTreeConfig.AddContextAppBefore("umbContent", "Comments", contextAppConfig => {
    ...
});
```

### Using the `AddContextApp()` Method with Custom Icon Before Another Context App

This method adds a context app with the specified name and custom icon before the specified context app alias. For more information, see the [Context Apps](context-apps.md) article.

#### Method Syntax

```cs
AddContextAppBefore(string beforeAlias, string name, string icon, Lambda contextAppConfig = null) : ContextAppConfigBuilder
```

#### Example

```csharp
withTreeConfig.AddContextAppBefore("umbContent", "Comments", "icon-chat", contextAppConfig => {
    ...
});
```

### Using the `AddContextApp()` Method After Another Context App

This method adds a context app with the specified name and default icon after the specified context app alias. For more information, see the [Context Apps](context-apps.md) article.

#### Method Syntax

```cs
AddContextAppAfter(string afterAlias, string name, Lambda contextAppConfig = null) : ContextAppConfigBuilder
```

#### Example

```csharp
withTreeConfig.AddContextAppAfter("umbContent", "Comments", contextAppConfig => {
    ...
});
```

### Using the `AddContextApp()` Method with Custom Icon After Another Context App

This method adds a context app with the specified name and custom icon after the specified context app alias. For more information, see the [Context Apps](context-apps.md) article.

#### Method Syntax

```cs
AddContextAppAfter(string afterAlias, string name, string icon, Lambda contextAppConfig = null) : ContextAppConfigBuilder
```

#### Example

```csharp
withTreeConfig.AddContextAppAfter("umbContent", "Comments", "icon-chat", contextAppConfig => {
    ...
});
```
