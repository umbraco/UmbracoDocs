---
description: Configuring event handlers for EF Core in Umbraco UI Builder.
---

# Events

Umbraco UI Builder now supports EF Core. It publishes specific notifications, allowing you to modify queries before and after they are built.

These are the EF Core equivalents of the NPoco `SqlQueryBuildingNotification` and `SqlQueryBuiltNotification`.

## Registering Event Handlers

Umbraco UI Builder follows the [Umbraco Notification mechanism](../../umbraco-cms/fundamentals/code/subscribing-to-notifications.md) for event registration.

To define a notification event handler for the target event, please check the [Registering Event Handlers](./events.md) section.

### Using the `EFCoreQueryBuildingNotification`

Triggers when the default EF Core repository is **preparing** a query. The notification provides access to the `IQueryable`, where clause, order by expression, collection alias, and entity type. You can modify these to customize the query before execution.

#### Example

```csharp
public class MyEFCoreQueryBuildingHandler : INotificationHandler<EFCoreQueryBuildingNotification>
{
    public void Handle(EFCoreQueryBuildingNotification notification)
    {
        // Access query properties
        var collectionAlias = notification.Args.CollectionAlias;
        var entityType = notification.Args.EntityType;

        // Modify the IQueryable directly
        // notification.Args.Query = ...
    }
}
```

### Using the `EFCoreQueryBuiltNotification`

Triggers when the default EF Core repository has **completed** building a query. The notification contains the final `IQueryable`, where clause, and order by expressions that were used to generate the query.

#### Example

```csharp
public class MyEFCoreQueryBuiltHandler : INotificationHandler<EFCoreQueryBuiltNotification>
{
    public void Handle(EFCoreQueryBuiltNotification notification)
    {
        // Inspect or further modify the built query
        var query = notification.Args.Query;
    }
}
```

### Registering Event Handlers

Register EF Core query event handlers the same way you would other Umbraco notifications:

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .AddNotificationHandler<EFCoreQueryBuildingNotification, MyEFCoreQueryBuildingHandler>()
    .AddNotificationHandler<EFCoreQueryBuiltNotification, MyEFCoreQueryBuiltHandler>()
    .Build();
```
