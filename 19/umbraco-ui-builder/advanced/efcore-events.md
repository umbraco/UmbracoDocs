---
description: >-
  Learn how to change the queries of the Entity Framework Core default
  repository in Umbraco UI Builder with query notifications.
---

# EF Core Events

The Entity Framework Core (EF Core) default repository publishes two query notifications. Use them to change a query before or after Umbraco UI Builder builds it.

These notifications replace the NPoco `SqlQueryBuildingNotification` and `SqlQueryBuiltNotification`. The NPoco notifications are only published when the site uses the NPoco repository.

Both notifications are in the `Umbraco.UIBuilder.Infrastructure.Events` namespace. Both expose an `Args` property of type `EFCoreQueryNotificationArgs` with these members:

| Member | Type | Description |
| --- | --- | --- |
| `CollectionAlias` | `string` | The alias of the collection being queried. |
| `EntityType` | `Type?` | The entity type of the collection. |
| `Query` | `IQueryable` | The query. Cast it to `IQueryable<TEntity>` to add to it. Settable. |
| `WhereClause` | `LambdaExpression?` | The where clause. Settable. |
| `OrderBy` | `LambdaExpression?` | The order-by expression. Settable. |
| `OrderByDirection` | `SortDirection` | The sort direction. Settable. |

## Registering Event Handlers

Umbraco UI Builder follows the [Umbraco Notification mechanism](https://docs.umbraco.com/umbraco-cms/develop-with-umbraco/application-code/backend-and-custom-logic/subscribing-to-notifications) for event registration.

Register the handlers in a composer:

{% code title="ProductQueryComposer.cs" %}
```csharp
using MyProject.Handlers;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.UIBuilder.Infrastructure.Events;

namespace MyProject.Composers;

public class ProductQueryComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AddNotificationHandler<EFCoreQueryBuildingNotification, ProductQueryBuildingHandler>();
        builder.AddNotificationHandler<EFCoreQueryBuiltNotification, ProductQueryBuiltHandler>();
    }
}
```
{% endcode %}

## Using the `EFCoreQueryBuildingNotification`

Triggers when the default EF Core repository is **preparing** a query for a list, a page, or a count. The repository then adds the collection filter and the ordering, and uses your changes to these members:

* `Query`
* `WhereClause`
* `OrderBy` and `OrderByDirection`. These changes apply to lists and pages only.

### Example

The following handler only lists products that have a price:

{% code title="ProductQueryBuildingHandler.cs" %}
```csharp
using System.Linq;
using MyProject.Models;
using Umbraco.Cms.Core.Events;
using Umbraco.UIBuilder.Infrastructure.Events;

namespace MyProject.Handlers;

public class ProductQueryBuildingHandler : INotificationHandler<EFCoreQueryBuildingNotification>
{
    public void Handle(EFCoreQueryBuildingNotification notification)
    {
        if (notification.Args.CollectionAlias != "products"
            || notification.Args.Query is not IQueryable<Product> products)
        {
            return;
        }

        // Only list products that cost something
        notification.Args.Query = products.Where(x => x.Price > 0);
    }
}
```
{% endcode %}

## Using the `EFCoreQueryBuiltNotification`

Triggers when the default EF Core repository has **completed** building a query. The query already includes the collection filter, the where clause, and the ordering. Changes to `Query` are used. For a page, the total count is taken from the query after your handler runs.

### Example

{% code title="ProductQueryBuiltHandler.cs" %}
```csharp
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Events;
using Umbraco.UIBuilder.Infrastructure.Events;

namespace MyProject.Handlers;

public class ProductQueryBuiltHandler : INotificationHandler<EFCoreQueryBuiltNotification>
{
    private readonly ILogger<ProductQueryBuiltHandler> _logger;

    public ProductQueryBuiltHandler(ILogger<ProductQueryBuiltHandler> logger) => _logger = logger;

    public void Handle(EFCoreQueryBuiltNotification notification)
        => _logger.LogDebug(
            "Query built for {Collection}: {Expression}",
            notification.Args.CollectionAlias,
            notification.Args.Query.Expression);
}
```
{% endcode %}

{% hint style="info" %}

Umbraco UI Builder rewrites Umbraco's query helpers, such as `InvariantContains`, in the `WhereClause` and `OrderBy` lambdas. Helpers you add to `Query` yourself are not rewritten, so use plain LINQ there.

{% endhint %}

## Moving From the NPoco Query Notifications

Handlers for `SqlQueryBuildingNotification` and `SqlQueryBuiltNotification` do not run for collections on EF Core. When the site starts, Umbraco UI Builder logs a warning that lists these handlers.

To move a handler to EF Core:

1. Change the notification type to `EFCoreQueryBuildingNotification` or `EFCoreQueryBuiltNotification`.
2. Replace the changes to the NPoco `Sql` object with changes to the `Query`, `WhereClause`, or `OrderBy` members.
3. Update the registration in your composer.

The following handler adds a condition to the NPoco SQL query. The handler only runs on the NPoco repository:

{% code title="ProductQueryBuildingHandler.cs (NPoco)" %}
```csharp
using Umbraco.Cms.Core.Events;
using Umbraco.UIBuilder.Events;

namespace MyProject.Handlers;

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
{% endcode %}

The EF Core version of the same handler is the example in the [Using the `EFCoreQueryBuildingNotification`](#using-the-efcorequerybuildingnotification) section.
