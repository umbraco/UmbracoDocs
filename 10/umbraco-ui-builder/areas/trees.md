---
description: Configuring trees in Konstrukt, the back office UI builder for Umbraco.
---

# Trees

A tree is a hierarchical structure that helps organise a section into logical sub-sections and is accessed in the main side panel of the Umbraco interface. In Konstrukt, a section may only have a single tree definition, however you can use folder nodes to help organise the tree structure how you need it.

![Tree](../images/tree.png)

## Configuring a Konstrukt section tree

The tree configuration for Konstrukt sections is a sub configuration of a [`Section`](sections.md) config builder instance and is accessed via it's `Tree` method.

#### **Tree(Lambda treeConfig = null) : KonstruktTreeConfigBuilder**

Accesses the tree config of the given section.

````csharp
// Example
sectionConfig.Tree(treeConfig => {
    ...
});
````

## Adding a tree to an existing section

The tree configuration for existing sections is a sub configuration of a [`WithSection`](sections.md#extending-an-existing-section) config builder instance and is accessed via one of it's `AddTree` methods.

#### **AddTree(string name, string icon, Lambda treeConfig = null) : KonstruktTreeConfigBuilder**

Adds a tree to the current section. 

````csharp
// Example
withSectionConfig.AddTree("My Tree", "icon-folder", treeConfig => {
    ...
});
````

#### **AddTree(string groupName, string name, string icon, Lambda treeConfig = null) : KonstruktTreeConfigBuilder**

Adds a tree to the current section in a group with the given name. 
````csharp
// Example
withSectionConfig.AddTree("My Group", "My Tree", "icon-folder", treeConfig => {
    ...
});
````

#### **AddTreeBefore(string treeAlias, string name, string icon, Lambda treeConfig = null) : KonstruktTreeConfigBuilder**

Adds a tree to the current section before the tree with the given alias. 

````csharp
// Example
withSectionConfig.AddTreeBefore("member", "My Tree", "icon-folder", treeConfig => {
    ...
});
````

#### **AddTreeAfter(string treeAlias, string name, string icon, Lambda treeConfig = null) : KonstruktTreeConfigBuilder**

Adds a tree to the current section after the tree with the given alias. 

````csharp
// Example
withSectionConfig.AddTreeAfter("member", "My Tree", "icon-folder", treeConfig => {
    ...
});
````

## Changing the tree icon color

#### **SetIconColor(string color) : KonstruktTreeConfigBuilder**

Sets the trees icon color to the given color.  Possible options are `black`, `green`, `yellow`, `orange`, `blue` or `red`.

{% hint style="info" %}
**NB:** Only trees added to existing sections have an icon. Trees added to Konstrukt sections don't show a tree icon instead they go straight into displaying the tree contents.
{% endhint %}

````csharp
// Example
collectionConfig.SetIconColor("blue");
````

## Adding a group to a tree

#### **AddGroup(string name, Lambda groupConfig = null) : KonstruktGroupConfigBuilder**

Adds a group to the current tree with the given name.

{% hint style="info" %}
**NB:** Only Konstrukt section trees can configure groups, where trees added to existing sections cannot.
{% endhint %}

```csharp
// Example
treeConfig.AddGroup("Settings", groupConfig => {
    ...
});
```

## Adding a folder to a tree / group

#### **AddFolder(string name, Lambda folderConfig = null) : KonstruktFolderConfigBuilder**

Adds a folder to the current tree / group with the given name and a default folder icon. See the [Folders documentation](folders.md) for more info.

```csharp
// Example
treeConfig.AddFolder("Settings", folderConfig => {
    ...
});
```

#### **AddFolder(string name, string icon, Lambda folderConfig = null) : KonstruktFolderConfigBuilder**

Adds a folder to the current tree / group with the given name + icon. See the [Folders documentation](folders.md) for more info.

```csharp
// Example
treeConfig.AddFolder("Settings", "icon-settings", folderConfig => {
    ...
});
```

## Adding a collection to a tree / group

#### **AddCollection&lt;TEntityType&gt;(Lambda idFieldExpression, string nameSingular, string namePlural, string description, Lambda collectionConfig = null) : KonstruktCollectionConfigBuilder&lt;TEntityType&gt;**

Adds a collection to the current tree / group with the given names and description and default icons. An ID property accessor expression is required so that Konstrukt knows which property is the ID property. See the [Collections documentation](../collections/overview.md) for more info.

```csharp
// Example
treeConfig.AddCollection<Person>(p => p.Id, "Person", "People", "A collection of people", collectionConfig => {
    ...
});
```

#### **AddCollection&lt;TEntityType&gt;(Lambda idFieldExpression, string nameSingular, string namePlural, string description, string iconSingular, string iconPlural, Lambda collectionConfig = null) : KonstruktCollectionConfigBuilder&lt;TEntityType&gt;**

Adds a collection to the current tree / group with the given names, description and icons. An ID property accessor expression is required so that Konstrukt knows which property is the ID property. See the [Collections documentation](../collections/overview.md) for more info.

```csharp
// Example
treeConfig.AddCollection<Person>(p => p.Id, "Person", "People", "A collection of people", "icon-umb-users", "icon-umb-users", collectionConfig => {
    ...
});
```

## Extending an existing tree

You can extend existing trees adding Konstrukt context apps and virtual sub trees by calling the `WithTree` method of a [`KonstruktWithSectionConfigBuilder`](sections.md#extending-an-existing-section) instance.

#### **WithTree(string alias, Lambda treeConfig = null) : KonstruktWithTreeConfigBuilder**

Starts a sub configuration for the existing Umbraco tree with the given alias.

```csharp
// Example
sectionConfig.WithTree("content", withTreeConfig => {
    ...
});
```

## Adding a context app to an existing tree

#### **AddContextApp(string name, Lambda contextAppConfig = null) : KonstruktContextAppConfigBuilder**

Adds a context app with the given name and default icon. See the [Context App documentation](context-apps.md) for more info.

```csharp
// Example
withTreeConfig.AddContextApp("Comments", contextAppConfig => {
    ...
});
```

#### **AddContextApp(string name, string icon, Lambda contextAppConfig = null) : KonstruktContextAppConfigBuilder**

Adds a context app to the Umbraco menu with the given name and icon. See the [Context App documentation](context-apps.md) for more info.

```csharp
// Example
withTreeConfig.AddContextApp("Comments", "icon-chat", contextAppConfig => {
    ...
});
```

#### **AddContextAppBefore(string beforeAlias, string name, Lambda contextAppConfig = null) : KonstruktContextAppConfigBuilder**

Adds a context app with the given name and default icon before the context app with the given alias. See the [Context App documentation](context-apps.md) for more info.

```csharp
// Example
withTreeConfig.AddContextAppBefore("umbContent", "Comments", contextAppConfig => {
    ...
});
```

#### **AddContextAppBefore(string beforeAlias, string name, string icon, Lambda contextAppConfig = null) : KonstruktContextAppConfigBuilder**

Adds a context app to the Umbraco menu with the given name and icon before the context app with the given alias. See the [Context App documentation](context-apps.md) for more info.

```csharp
// Example
withTreeConfig.AddContextAppBefore("umbContent", "Comments", "icon-chat", contextAppConfig => {
    ...
});
```

#### **AddContextAppAfter(string afterAlias, string name, Lambda contextAppConfig = null) : KonstruktContextAppConfigBuilder**

Adds a context app with the given name and default icon after the context app with the given alias. See the [Context App documentation](context-apps.md) for more info.

```csharp
// Example
withTreeConfig.AddContextAppAfter("umbContent", "Comments", contextAppConfig => {
    ...
});
```

#### **AddContextAppAfter(string afterAlias, string name, string icon, Lambda contextAppConfig = null) : KonstruktContextAppConfigBuilder**

Adds a context app to the Umbraco menu with the given name and icon after the context app with the given alias. See the [Context App documentation](context-apps.md) for more info.

```csharp
// Example
withTreeConfig.AddContextAppAfter("umbContent", "Comments", "icon-chat", contextAppConfig => {
    ...
});
```