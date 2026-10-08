---
description: Configuring child collection groups in Umbraco UI Builder.
---

# Child Collection Groups

A child collection group is a container for other child collections. Its purpose is mainly to provide a logical grouping of multiple child collections to help with organization and an improved user experience.

![Child Collection Groups](../.gitbook/assets/child_collection_groups.png)

## Defining a Child Collection Group

You can define a child collection group by calling one of the `AddChildCollectionGroup` methods on a given collection config builder instance.

### Using the `AddChildCollectionGroup()` Method

Adds a child collection group to the current collection with the specified name and default icon.

#### Method Syntax

```cs
AddChildCollectionGroup(string name, Lambda childCollectionGroupConfig = null) : ChildCollectionGroupConfigBuilder
```

#### Example

```csharp
collectionConfig.AddChildCollectionGroup("Family", childCollectionGroupConfig => {
    ...
});
```

### Using the `AddChildCollectionGroup()` Method with Custom Icon

Adds a child collection group to the current collection with the specified name and custom icon.

#### Method Syntax

```cs
AddChildCollectionGroup(string name, string icon, Lambda childCollectionGroupConfig = null) : ChildCollectionGroupConfigBuilder
```

#### Example

```csharp
collectionConfig.AddChildCollectionGroup("Family", "icon-users", childCollectionGroupConfig => {
    ...
});
```
