---
versionFrom: 8.0.0
meta.Title: "Determining whether an entity is new in Umbraco"
meta.Description: "How to determine whether an entity is new in Umbraco"
---

# Determining if an entity is new

Many of the Umbraco services expose a 'Saved' event (or similar). In some cases it is beneficial to know if this entity is a brand new entity that has been persisted to the database. This is how you can determine this.

## Checking if it's new

We know that if an entity is new and hasn't been persisted that it will not have an ID. Therefore we know if an entity has been newly persisted to the database by checking if its ID was changed before being persisted.

Here's the snippet of code that does that:

```csharp
var dirty = (IRememberBeingDirty)entity;
var isNew = dirty.WasPropertyDirty("Id");
```

To check if an entity is new in the ContentService.Saving event, use the following:

```csharp
var isNew = dirty.HasIdentity;
```

## How it works

This is all possible because of the `IRememberBeingDirty` interface. Indeed the name of this interface is hilarious but it describes exactly what it does. All entities implement this interface which is extremely handy. It tracks not only the property data that has changed (because it inherits from yet another hilarious interface called `ICanBeDirty`) but also the property data that was changed before it was committed.
