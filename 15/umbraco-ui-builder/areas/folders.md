---
description: Configuring folders to organise trees in Umbraco UI Builder.
---

# Folders

Folders help organize trees in Umbraco UI Builder, allowing you to structure content with nested folders and collections. A folder can exist within a tree or as a sub-folder within another folder. Folders can contain either sub-folders or [Collections](../collections/overview.md).

![Tree with Settings folder](../images/tree.png)

## Defining a Folder

To define a folder, use one of the `AddFolder` methods on a [`Tree`](trees.md) or parent `Folder` config builder instance.

### Using the `AddFolder()` Method

Adds a folder to the current tree with the specified name and a default folder icon.

#### Method Syntax

```cs
AddFolder(string name, Lambda folderConfig = null) : FolderConfigBuilder
```

#### Example

````csharp
treeConfig.AddFolder("Settings", folderConfig => {
    ...
});
````

### Using the `AddFolder()` Method with Custom Icon

Adds a folder to the current tree with a specified name and icon.

#### Method Syntax

```cs
AddFolder(string name, string icon, Lambda folderConfig = null) : FolderConfigBuilder
```

#### Example

````csharp
treeConfig.AddFolder("Settings", "icon-settings", folderConfig => {
    ...
});
````

## Changing a Folder Alias

When creating a new folder, an alias is automatically generated. However, if you need a specific alias, you can use the `SetAlias` method to override it.

### Using the `SetAlias()` Method

Sets a custom alias for a folder.

#### Method Syntax

```cs
SetAlias(string alias) : FolderConfigBuilder
```

#### Example

````csharp
folderConfig.SetAlias("settings");
````

## Changing a Folder Icon Color

### Using the `SetIconColor()` Method

Sets the folder icon color to the given color. The available colors are: `black`, `green`, `yellow`, `orange`, `blue`, or `red`.

#### Method Syntax

```cs
SetIconColor(string color) : FolderConfigBuilder
```

#### Example

````csharp
folderConfig.SetIconColor("blue");
````

## Adding a Sub-Folder To a Folder

### Using the `AddFolder()` Method for Sub-Folders

Adds a sub-folder inside the current folder with a specified name and a default folder icon.

#### Method Syntax

```cs
AddFolder (string name, Lambda folderConfig = null) : FolderConfigBuilder
```

#### Example

````csharp
folderConfig.AddFolder("Categories", subFolderConfig => {
    ...
});
````

### Using the `AddFolder()` Method for Sub-Folders with Custom Icon

Adds a sub folder to the current folder with a specified name and custom icon.

#### Method Syntax

```cs
AddFolder (string name, string icon, Lambda folderConfig = null) : FolderConfigBuilder
```

#### Example

````csharp
folderConfig.AddFolder("Categories", "icon-tags", subFolderConfig => {
    ...
});
````

## Adding a Collection to a Folder

### Using the `AddCollection<>()` Method

Adds a collection to the current folder with the given names, descriptions, and default icons. The ID property must be defined. For more details, see the [Collections](../collections/overview.md) article.

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

````csharp
folderConfig.AddCollection<Person>(
    p => p.Id, 
    "Person", 
    "People", 
    "A collection of people", 
    collectionConfig => {
        ...
    }
);
````

### Using the `AddCollection<>()` Method with Custom Icons

Adds a collection to the current folder with the given names, description and icons. The ID property must be defined. For more details, see the [Collections](../collections/overview.md) article.

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

````csharp
folderConfig.AddCollection<Person>(
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
````
