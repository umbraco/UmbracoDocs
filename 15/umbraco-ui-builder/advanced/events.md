---
description: Configuring event handlers in Umbraco UI Builder.
---

# Events

Umbraco UI Builder triggers different notification events during operation, allowing customization of default behavior.

## Registering Event Handlers

Umbraco UI Builder follows the [Umbraco Notification mechanism](../../umbraco-cms/fundamentals/code/subscribing-to-notifications.md) for event registration.

Define a notification event handler for the target event:

```csharp
public class MyEntitySavingEventHandler :  INotificationHandler<EntitySavingNotification> {

    public void Handle(EntitySavingNotification notification)
    {
        // Handle the event here
    }

}
```

Register the event handler in `Program.cs`:

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .AddNotificationHandler<EntitySavingNotification, MyEntitySavingEventHandler>()
    .Build();
```

## Repository Events

### Using the `EntitySavingNotification()`

Triggers when `Save` is called before persisting the entity. The notification contains an `Entity` property with `Before` and `After` values, providing access to the previous and updated entities. Modify the `After` entity to persist changes. If the `Cancel` property of the notification is set to `true` then the save operation will be canceled and no changes will be saved.

#### Example

```csharp
public class MyEntitySavingEventHandler :  INotificationHandler<EntitySavingNotification> {

    public void Handle(EntitySavingNotification notification)
    {
        var person = notification.Entity.After as Person;
        if (person != null){
            ...
        }
    }

}
```

### Using the `EntitySavedNotification()`

Triggers when the repository `Save` method is called and after the entity has been persisted. The notification contains an `Entity` property with `Before` and `After` inner properties. These properties provide access to a copy of the previously persisted entity (or null if a new entity) and the updated entity that´s saved.

#### Example

```csharp
public class MyEntitySavedEventHandler :  INotificationHandler<EntitySavedNotification> {

    public void Handle(EntitySavedNotification notification)
    {
        var person = notification.Entity.After as Person;
        if (person != null){
            ...
        }
    }

}
```

### Using the `EntityDeletingNotification()`

Triggers when the repository `Delete` method is called and **before** the entity is deleted. The notification contains an `Entity` property providing access to a copy of the entity about to be deleted. If the `Cancel` property of notification is set to `true` then the delete operation will be cancelled and entity won't be deleted.

#### Example

```csharp
public class MyEntityDeletingEventHandler :  INotificationHandler<EntityDeletingNotification> {

    public void Handle(EntityDeletingNotification notification)
    {
        var person = notification.Entity.After as Person;
        if (person != null){
            ...
        }
    }

}
```

### Using the `EntityDeletedNotification()`

Triggers when the repository `Delete` method is called and **after** the entity has been deleted. The notification contains an `Entity` property providing access to a copy of the entity that´s deleted.

#### Example

```csharp
public class MyEntityDeletedEventHandler :  INotificationHandler<EntityDeletedNotification> {

    public void Handle(EntityDeletedNotification notification)
    {
        var person = notification.Entity.After as Person;
        if (person != null){
            ...
        }
    }

}
```

### Using the `SqlQueryBuildingNotification()`

Triggers when the repository is **preparing** a SQL query. The notification contains the collection alias + type, the NPoco `Sql<ISqlContext>` object, and the where clause/order by clauses. These will be used to generate the SQL query.

#### Example

```csharp
public class MySqlQueryBuildingEventHandler :  INotificationHandler<SqlQueryBuildingNotification> {

    public void Handle(SqlQueryBuildingNotification notification)
    {
        notification.Sql = notification.Sql.Append("WHERE MyId = @0", 1);
    }

}
```

### Using the `SqlQueryBuiltNotification()`

Triggers when the repository has **repaired** a SQL query. The notification contains the collection alias + type, the NPoco `Sql<ISqlContext>` object and the where clause/order by clauses that was used to generate the SQL query.

#### Example

```csharp
public class MySqlQueryBuiltEventHandler :  INotificationHandler<SqlQueryBuiltNotification> {

    public void Handle(SqlQueryBuiltNotification notification)
    {
        notification.Sql = notification.Sql.Append("WHERE MyId = @0", 1);
    }

}
```

## Repository Events Validation

From version `15.1.0`, complex server-side validation can be added to a collection using the `CancelOperation` method of the notification.

### Example

```csharp
public class MyEntitySavingEventHandler :  INotificationHandler<EntitySavingNotification> {

    public void Handle(EntitySavingNotification notification)
    {
        var person = notification.Entity.After as Person;
        if (person != null && person.Age < 18) {
            notification.CancelOperation(new EventMessage("ValidationError", "Custom validation error message raised from the notification handler"));
        }
    }

}
```
