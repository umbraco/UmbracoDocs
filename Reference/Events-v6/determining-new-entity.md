#Determining if an entity is new#

Many of the Umbraco services expose a 'Saved' event (or similar), in some cases it is beneficial to know if this entity is a brand new entity that has just been persisted to the database, this is how you can determine this.

## Checking if it's new##

We know that if an entity is new and hasn't been persisted that it will not have an ID. Therefore we know if an entity has been newly persisted to the database by checking if its ID was changed before being persisted.

Here's the snippet of code that does that:

    var dirty = (IRememberBeingDirty)entity;
    var isNew = dirty.WasPropertyDirty("Id");

To check if an entity is new in the ContentService.Saving event, use the following:

    var isNew = dirty.HasIdentity;

In v6.2+ and 7.1+ you can use the extension method on any implementation of IEntity (which is nearly all models returned by the Umbraco Services):

	var isNew = entity.IsNewEntity(); 

## How it works##

This is all possible because of the `IRememberBeingDirty` interface. Indeed the name of this interface is hilarious but it describes exactly what it does. All entities implement this interface which is extremely handy as it tracks not only the property data that has changed (because it inherits from yet another hilarious interface called `ICanBeDirty`) but also the property data that was changed before it was committed.
