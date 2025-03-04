---
description: Configuring event handlers in Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Events

Umbraco UI Builder fires a number of notification events during regular operation to allow for extending of the default behaviour.

## Registering event handlers

Umbraco UI Builder uses the same [Notification Mechanism built into Umbraco v9+](../../umbraco-cms/fundamentals/code/subscribing-to-notifications.md) and so uses the same registration process. First you will need to define a notification event handler for the event you wish to handle like below:

```csharp
public class MyEntitySavingEventHandler :  INotificationHandler<EntitySavingNotification> {

    public void Handle(EntitySavingNotification notification)
    {
        // Handle the event here
    }

}
```

Then register your event handler in the `Program.cs` file like below:

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .AddNotificationHandler<EntitySavingNotification, MyEntitySavingEventHandler>()
    .Build();
```

## Repository events

### **EntitySavingNotification**

Raised when the repository `Save` method is called and before the entity has been persisted. The notification contains an `Entity` property with `Before` and `After` inner properties. These properties provide access to a copy of the currently persisted entity (or null if a new entity) and the updated entity that´s saved.
Changes can be made to the `After` entity and they will be persisted as part of the save operation. If the `Cancel` property of the notification is set to `true` then the save operation will be canceled and no changes will be saved.

````csharp
// Example
public class MyEntitySavingEventHandler :  INotificationHandler<EntitySavingNotification> {

    public void Handle(EntitySavingNotification notification)
    {
        var person = notification.Entity.After as Person;
        if (person != null){
            ...
        }
    }

}
````

### **EntitySavedNotification**

Raised when the repository `Save` method is called and after the entity has been persisted. The notification contains an `Entity` property with `Before` and `After` inner properties. These properties provide access to a copy of the previously persisted entity (or null if a new entity) and the updated entity that´s saved.

````csharp
// Example
public class MyEntitySavedEventHandler :  INotificationHandler<EntitySavedNotification> {

    public void Handle(EntitySavedNotification notification)
    {
        var person = notification.Entity.After as Person;
        if (person != null){
            ...
        }
    }

}
````

### **EntityDeletingNotification**

Raised when the repository `Delete` method is called and **before** the entity is deleted. The notification contains an `Entity` property providing access to a copy of the entity about to be deleted. If the `Cancel` property of notification is set to `true` then the delete operation will be cancelled and entity won't be deleted.

````csharp
// Example
public class MyEntityDeletingEventHandler :  INotificationHandler<EntityDeletingNotification> {

    public void Handle(EntityDeletingNotification notification)
    {
        var person = notification.Entity.After as Person;
        if (person != null){
            ...
        }
    }

}
````

### **EntityDeletedNotification**

Raised when the repository `Delete` method is called and **after** the entity has been deleted. The notification contains an `Entity` property providing access to a copy of the entity that´s deleted.

````csharp
// Example
public class MyEntityDeletedEventHandler :  INotificationHandler<EntityDeletedNotification> {

    public void Handle(EntityDeletedNotification notification)
    {
        var person = notification.Entity.After as Person;
        if (person != null){
            ...
        }
    }

}
````

### **SqlQueryBuildingNotification**

Raised when the repository is **preparing** a SQL query. The notification contains the collection alias + type, the NPoco `Sql<ISqlContext>` object, and the where clause/order by clauses. These will be used to generate the SQL query.

````csharp
// Example
public class MySqlQueryBuildingEventHandler :  INotificationHandler<SqlQueryBuildingNotification> {

    public void Handle(SqlQueryBuildingNotification notification)
    {
        notification.Sql = notification.Sql.Append("WHERE MyId = @0", 1);
    }

}
````

### **SqlQueryBuiltNotification**

Raised when the repository has **repaired** a SQL query. The notification contains the collection alias + type, the NPoco `Sql<ISqlContext>` object and the where clause/order by clauses that was used to generate the SQL query.

````csharp
// Example
public class MySqlQueryBuiltEventHandler :  INotificationHandler<SqlQueryBuiltNotification> {

    public void Handle(SqlQueryBuiltNotification notification)
    {
        notification.Sql = notification.Sql.Append("WHERE MyId = @0", 1);
    }

}
````

## Repository events validation

Starting with version `15.1.0`, complex server-side validation can be added to a collection by calling the `CancelOperation` method of the notification.

````csharp
// Example
public class MyEntitySavingEventHandler :  INotificationHandler<EntitySavingNotification> {

    public void Handle(EntitySavingNotification notification)
    {
        var person = notification.Entity.After as Person;
        if (person != null && person.Age < 18) {
            notification.CancelOperation(new EventMessage("ValidationError", "Custom validation error message raised from the notification handler"));
        }
    }

}
