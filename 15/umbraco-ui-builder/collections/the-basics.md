---
description: An overview of the basics of configuring a collection in Umbraco UI Builder.
---

# The Basics

A collection configuration in Umbraco UI Builder defines how collections are structured and displayed in the backoffice. This guide covers the core concepts, with additional options available in other configuration sections.

## Defining a Collection

A collection is defined using the `AddCollection` method on a [`Tree`](../areas/trees.md) or parent [`Folder`](../areas/folders.md) configuration instance.

### Using the `AddCollection()` Method

Adds a collection to the given container with the specified names, description, and default icons. The ID property must be defined.

#### Method Syntax

```cs
AddCollection<TEntityType>(Lambda idFieldExpression, string nameSingular, string namePlural, string description, Lambda collectionConfig = null) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
folderConfig.AddCollection<Person>(p => p.Id, "Person", "People", "A collection of people", collectionConfig => {
    ...
});
````

### Using the `AddCollection()` Method with Icons

Adds a collection to the given container with the specified names, description, and icons. The ID property must be defined.

#### Method Syntax

```cs
AddCollection<TEntityType>(Lambda idFieldExpression, string nameSingular, string namePlural, string description, string iconSingular, string iconPlural, Lambda collectionConfig = null) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
folderConfig.AddCollection<Person>(p => p.Id, "Person", "People", "A collection of people", "icon-umb-users", "icon-umb-users", collectionConfig => {
    ...
});
````

## Changing a Collection Alias

### Using the `SetAlias()` Method

Sets the alias of the collection.

**Optional:** When creating a new collection, an alias is automatically generated from the supplied name for you. To customize the alias, the `SetAlias` method can be used.

#### Method Syntax

```cs
SetAlias(string alias) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.SetAlias("person");
````

## Changing a Collection Icon Color

### Using the `SetIconColor()` Method

Sets the collection icon color to the given color. The available options are `black`, `green`, `yellow`, `orange`, `blue`, or `red`.

#### Method Syntax

```cs
SetIconColor(string color) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.SetIconColor("blue");
````

## Defining an Entity Name

In Umbraco, every entity is expected to have a name property. To ensure the Umbraco UI Builder knows which property to use, you must specify it. 

If the entity lacks a dedicated name property, you can define how to construct a name using other properties. This is done using either the `SetNameProperty` or `SetNameFormat` methods on a `Collection` config builder instance.

### Using the `SetNameProperty()` Method

Specifies the entity property to use as the name, which must be of type `string`. This property serves as the label in trees and list views, appears in the editor interface header, and is automatically included in searchable properties. It is also used as the default sorting property.

#### Method Syntax

```cs
SetNameProperty(Lambda namePropertyExpression) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.SetNameProperty(p => p.Name);
````

### Using the `SetNameProperty()` Method with Custom Heading

Specifies which property of your entity should be used as the name property and defines a custom heading for the list view column. The property must be of type `string`.

Setting a name property ensures its value is displayed as the label for the entity in trees and list views. It will also be editable in the editor interface's header region.

Additionally, the property is automatically added to the searchable properties collection and used as the default sort property.

#### Method Syntax

```cs
SetNameProperty(Lambda namePropertyExpression, string heading) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.SetNameProperty(p => p.Name, "Person Name");
````

### Using the `SetNameFormat()` Method

Defines a format expression to dynamically generate a label for the entity in trees and list views.

This method is used when there is no single name property available on the entity. As a result, none of the default behaviors of the `SetNameProperty` method, such as automatic sorting, searching, or header editing, will apply.

#### Method Syntax

```cs
SetNameFormat(Lambda nameFormatExpression) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.SetNameFormat(p => $"{p.FirstName} {p.LastName}");
````

## Defining a Default Sort Order

### Using the `SetSortProperty()` Method

Specifies the property used to sort the collection, with the default sort direction set to ascending.

#### Method Syntax

```cs
SetSortProperty(Lambda sortPropertyExpression) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.SetSortProperty(p => p.FirstName);
````

### Using the `SetSortProperty()` Method with Sort Direction

Defines the property of the entity to sort by, based on the specified sort direction.

#### Method Syntax

```cs
SetSortProperty(Lambda sortPropertyExpression, SortDirection sortDirection) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.SetSortProperty(p => p.FirstName, SortDirection.Descending);
````

## Defining Time Stamp Properties

### Using the `SetDateCreatedProperty` Method

Defines the property of the entity to use as the date created field. The property must be of type `DateTime`. When specified, this field will be automatically populated with the current date and time when a new entity is saved via the repository.

#### Method Syntax

```cs
SetDateCreatedProperty(Lambda dateCreatedProperty) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.SetDateCreatedProperty(p => p.DateCreated);
````

### Using the `SetDateModifiedProperty` Method

Defines the property of the entity to use as the date modified field. The property must be of type `DateTime`. When specified, this field will be updated with the current date and time whenever the entity is saved via the repository.

#### Method Syntax

```cs
SetDateModifiedProperty(Lambda dateCreatedProperty) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.SetDateModifiedProperty(p => p.DateModified);
````

## Configuring Soft Deletes

By default, entities deleted via the Umbraco UI Builder repository are permanently removed from the system. The `SetDeletedProperty` method can be used to retain records in the data repository, marking them as deleted without removing them, ensuring they do not appear in the UI.

### Using the `SetDeletedProperty()` Method

Defines the property of the entity to use as the deleted flag. The property must be of type `boolean` or `int`. When set, delete actions will mark the entity as deleted by setting the flag instead of removing the entity. 

For `boolean` properties, the flag is set to `True` when deleted. For `int` properties, the flag is set to a UTC Unix timestamp representing the deletion date. Additionally, fetch actions will automatically exclude deleted entities.

#### Method Syntax

```cs
SetDeletedProperty(Lambda deletedPropertyExpression) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.SetDeletedProperty(p => p.Deleted);
````

## Disabling Create, Update, or Delete Features

### Using the `DisableCreate()` Method

Disables the option to create entities within the current collection. Entities can still be created programmatically, after which editing is allowed through the UI.

#### Method Syntax

```cs
DisableCreate() : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.DisableCreate();
````

### Using the `DisableCreate()` Method with Conditions

Disables entity creation within the current collection if the specified runtime predicate evaluates to true. Entities can still be created programmatically, after which editing is allowed in the UI.

#### Method Syntax

```cs
DisableCreate(Predicate<CollectionPermissionContext> disableExpression) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.DisableCreate(ctx => ctx.UserGroups.Any(x => x.Alias == "editor"));
````

### Using the `DisableUpdate()` Method

Disables the option to update entities within the current collection. Entities can be created, but further editing is not permitted

#### Method Syntax

```cs
DisableUpdate() : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.DisableUpdate();
````

### Using the `DisableUpdate()` Method with Conditions

Disables the option to update entities within the current collection if the specified runtime predicate evaluates to true. Entities can be created, but further editing is not permitted.

#### Method Syntax

```cs
DisableUpdate(Predicate<CollectionPermissionContext> disableExpression) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.DisableUpdate(ctx => ctx.UserGroups.Any(x => x.Alias == "editor"));
````

### Using the `DisableDelete()` Method

Disables the option to delete entities within the current collection. This is useful when data needs to be retained and visible. For more information, see the [Configuring Soft Deletes](#configuring-soft-deletes) section.

#### Method Syntax

```cs
DisableDelete() : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.DisableDelete();
````

### Using the `DisableDelete()` Method with Conditions

Disables the option to delete entities within the current collection if the specified runtime predicate evaluates to true. This is useful when data needs to be retained and visible. For more information, see the [Configuring Soft Deletes](#configuring-soft-deletes) section.

#### Method Syntax

```cs
DisableDelete(Predicate<CollectionPermissionContext> disableExpression) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.DisableDelete(ctx => ctx.UserGroups.Any(x => x.Alias == "editor"));
````

### Using the `MakeReadOnly()` Method

Marks the collection as read-only, disabling all Create, Read, Update, and Delete (CRUD) operations via the UI.

#### Method Syntax

```cs
MakeReadOnly() : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.MakeReadOnly();
````

### Using the `MakeReadOnly()` Method with Conditions

Marks the collection as read-only if the specified runtime predicate evaluates to true. This disables all Create, Read, Update, and Delete (CRUD) operations via the UI.

#### Method Syntax

```cs
MakeReadOnly(Predicate<CollectionPermissionContext> disableExpression) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.MakeReadOnly(ctx => ctx.UserGroups.Any(x => x.Alias == "editor"));
````

## Setting Collection Visibility

### Using the `SetVisibility()` Method

Sets the runtime visibility of the collection.

#### Method Syntax

```cs
SetVisibility(Predicate<CollectionVisibilityContext> visibilityExpression) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.SetVisibility(ctx => ctx.UserRoles.Any(x => x.Alias == "editor"));
````

## Changing a Collection Connection String

By default, Umbraco UI Builder uses the Umbraco connection string for its database connection. You can override this by calling the `SetConnectionString` method on a `Collection` config builder instance.

### Using the `SetConnectionString()` Method

Defines the connection string for the collection repository.

#### Method Syntax

```cs
SetConnectionString(string connectionStringName) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.SetConnectionString("myConnectionStringName");
````
