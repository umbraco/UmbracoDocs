---
description: Configuring event handlers in Umbraco UI Builder.
---

# Events

Umbraco UI Builder triggers different notification events during operation, allowing customization of default behavior.

## Registering Event Handlers

Umbraco UI Builder follows the [Umbraco Notification mechanism](https://docs.umbraco.com/umbraco-cms/develop-with-umbraco/application-code/backend-and-custom-logic/subscribing-to-notifications) for event registration.

Define a notification event handler for the target event:

{% code title="ProductSavingHandler.cs" %}
```csharp
using MyProject.Models;
using Umbraco.Cms.Core.Events;
using Umbraco.UIBuilder.Events;

namespace MyProject.Handlers;

public class ProductSavingHandler : INotificationHandler<EntitySavingNotification>
{
    public void Handle(EntitySavingNotification notification)
    {
        if (notification.Entity.After is Product product)
        {
            product.Name = product.Name.Trim();
        }
    }
}
```
{% endcode %}

Register the event handler in `Program.cs`:

{% code title="Program.cs" %}
```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .AddNotificationHandler<EntitySavingNotification, ProductSavingHandler>()
    .Build();
```
{% endcode %}

## Repository Events

The entity notifications are in the `Umbraco.UIBuilder.Events` namespace. They are published by both the Entity Framework Core (EF Core) repository and the NPoco repository.

### Using the `EntitySavingNotification()`

Triggers when an entity is saved through `SaveAsync`, `InsertAsync`, or `UpdateAsync`, before the entity is persisted. The notification contains an `Entity` property with `Before` and `After` values, providing access to the previous and updated entities. Modify the `After` entity to persist changes. If the `Cancel` property of the notification is set to `true`, the save operation is canceled and no changes are saved.

A canceled save is not a failure. The surrounding transaction is not rolled back, and anything the handler wrote before it canceled the save is kept. On the EF Core repository, throw an exception instead of canceling. The save then fails, and the handler's writes in the same scope roll back with it.

#### Example

```csharp
public class ProductSavingHandler : INotificationHandler<EntitySavingNotification>
{
    public void Handle(EntitySavingNotification notification)
    {
        if (notification.Entity.After is Product product)
        {
            product.Name = product.Name.Trim();
        }
    }
}
```

### Using the `EntitySavedNotification()`

Triggers when an entity is saved through `SaveAsync`, `InsertAsync`, or `UpdateAsync`, after the entity has been persisted. The notification contains an `Entity` property with `Before` and `After` inner properties. These properties provide access to a copy of the previously persisted entity (or null if a new entity) and the updated entity that is saved.

On the EF Core repository, the notification is published before the transaction commits. A handler that throws rolls the save back.

#### Example

```csharp
public class ProductSavedHandler : INotificationHandler<EntitySavedNotification>
{
    private readonly ILogger<ProductSavedHandler> _logger;

    public ProductSavedHandler(ILogger<ProductSavedHandler> logger) => _logger = logger;

    public void Handle(EntitySavedNotification notification)
    {
        if (notification.Entity.After is Product product)
        {
            _logger.LogInformation("Product {ProductId} saved", product.Id);
        }
    }
}
```

### Using the `EntityDeletingNotification()`

Triggers when `DeleteAsync` is called, **before** the entity is deleted. The notification contains an `Entity` property providing access to a copy of the entity about to be deleted. If the `Cancel` property of the notification is set to `true`, the delete operation is canceled and the entity is not deleted.

#### Example

```csharp
public class ProductDeletingHandler : INotificationHandler<EntityDeletingNotification>
{
    public void Handle(EntityDeletingNotification notification)
    {
        if (notification.Entity is Product { Price: > 0 })
        {
            notification.CancelOperation(new EventMessage("Delete blocked", "Set the price to 0 before you delete a product."));
        }
    }
}
```

### Using the `EntityDeletedNotification()`

Triggers when `DeleteAsync` is called, **after** the entity has been deleted. The notification contains an `Entity` property providing access to a copy of the entity that is deleted.

On the EF Core repository, the notification is published before the transaction commits. A handler that throws rolls the delete back.

#### Example

```csharp
public class ProductDeletedHandler : INotificationHandler<EntityDeletedNotification>
{
    private readonly ILogger<ProductDeletedHandler> _logger;

    public ProductDeletedHandler(ILogger<ProductDeletedHandler> logger) => _logger = logger;

    public void Handle(EntityDeletedNotification notification)
    {
        if (notification.Entity is Product product)
        {
            _logger.LogInformation("Product {ProductId} deleted", product.Id);
        }
    }
}
```

## NPoco Query Events

{% hint style="warning" %}

`SqlQueryBuildingNotification` and `SqlQueryBuiltNotification` are only published by the NPoco repository. From Umbraco UI Builder 19, the default repository uses EF Core, so handlers for these notifications do not run unless `UseEFCore` is `false`. The NPoco repository and these notifications are scheduled for removal in Umbraco UI Builder 20.

Move your handlers to `EFCoreQueryBuildingNotification` and `EFCoreQueryBuiltNotification`. For more information, see the [EF Core Events](efcore-events.md) article.

{% endhint %}

### Using the `SqlQueryBuildingNotification()`

Triggers when the NPoco repository is **preparing** a SQL query. The notification's `Args` property contains the collection alias and entity type, and the NPoco `Sql<ISqlContext>` object. `Args` also contains the where clause and order by clauses used to generate the SQL query.

#### Example

```csharp
public class ProductQueryBuildingHandler : INotificationHandler<SqlQueryBuildingNotification>
{
    public void Handle(SqlQueryBuildingNotification notification)
    {
        if (notification.Args.CollectionAlias != "products")
        {
            return;
        }

        // Only list products that cost something
        notification.Args.Sql.Where("Price > @0", 0);
    }
}
```

### Using the `SqlQueryBuiltNotification()`

Triggers when the NPoco repository has **built** a SQL query. The notification's `Args` property contains the collection alias and entity type, and the NPoco `Sql<ISqlContext>` object. `Args` also contains the where clause and order by clauses used to generate the SQL query.

#### Example

```csharp
public class ProductSqlQueryBuiltHandler : INotificationHandler<SqlQueryBuiltNotification>
{
    private readonly ILogger<ProductSqlQueryBuiltHandler> _logger;

    public ProductSqlQueryBuiltHandler(ILogger<ProductSqlQueryBuiltHandler> logger) => _logger = logger;

    public void Handle(SqlQueryBuiltNotification notification)
        => _logger.LogDebug("SQL built for {Collection}: {Sql}", notification.Args.CollectionAlias, notification.Args.Sql.SQL);
}
```

## Repository Events Validation

Complex server-side validation can be added to a collection using the `CancelOperation` method of the notification.

### Example

```csharp
public class ProductValidationHandler : INotificationHandler<EntitySavingNotification>
{
    public void Handle(EntitySavingNotification notification)
    {
        if (notification.Entity.After is Product { Price: < 0 })
        {
            notification.CancelOperation(new EventMessage("Validation error", "The price cannot be negative."));
        }
    }
}
```
