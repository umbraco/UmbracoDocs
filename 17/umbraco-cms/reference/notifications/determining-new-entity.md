---
description: Example of how to determine if an entity is new
---

# Determining if an entity is new

Many of the Umbraco services publishes a 'Saved' notification (or similar). In some cases, it is beneficial to know if this entity is a brand new entity that has been persisted in the database. This is how you can determine this.

## Checking if it's new

We know that if an entity is new and hasn't been persisted that it will not have an ID. Therefore we know if an entity has been newly persisted to the database by checking if its ID was changed before being persisted.

Here's the snippet of code that does that:

```csharp
var dirty = (IRememberBeingDirty)entity;
var isNew = dirty.WasPropertyDirty("Id");
```

To check if an entity is new in the ContentSavingNotification use the following:

```csharp
var isNew = entity.HasIdentity is false;
```

Since the IContent has not been saved yet, it's not necessary to cast it to `IRememberBeingDirty`. It won't have an identity if it's new, since it hasn't been committed yet.

## How it works

This is all possible because of the `IRememberBeingDirty` interface. Indeed the name of this interface is hilarious but it describes exactly what it does. All entities implement this interface which is really handy. It tracks not only the property data that has changed because it inherits from yet another hilarious interface called `ICanBeDirty`. It also tracks the property data that was changed before it was committed.
