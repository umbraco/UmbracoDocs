---
description: >-
  Learn how to build a custom Entity Framework Core repository for a collection
  in Umbraco UI Builder by inheriting from EFCoreRepository.
---

# Custom EF Core Repositories

A custom Entity Framework Core (EF Core) repository gives you full control over how a collection reads and writes its data. Inherit from `EFCoreRepository<TEntity, TId>` to get a `DbContext` and a `DbSet<TEntity>` for your queries.

The base class handles scoping, rollback, change tracking, filter rewriting, and readable errors for you. Your code only implements the data access.

## Creating the Repository

`EFCoreRepository<TEntity, TId>` lives in the `Umbraco.UIBuilder.Core.Persistence` namespace. Pass the `RepositoryContext` to the base constructor.

Implement these abstract methods:

* `GetIdImplAsync`
* `GetImplAsync`
* `SaveImplAsync`
* `DeleteImplAsync`
* `GetAllImplAsync`
* `GetPagedImplAsync`
* `GetCountImplAsync`
* `GetRelationsByParentIdImplAsync`
* `SaveRelationImplAsync`

You can also override these optional methods:

* `InsertImplAsync` and `UpdateImplAsync`. Both call `SaveImplAsync` by default.
* `DeleteRelationImplAsync`. Override it when the collection's related collections need to remove relations.

The following repository stores products and their categories. The repository uses the `Product` model from the [Entity Framework Core](efcore-repositories.md) article, and these two models:

{% code title="Category.cs" %}
```csharp
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MyProject.Models;

[Table("Categories")]
public class Category
{
    [Key]
    public int Id { get; set; }

    public string Name { get; set; } = string.Empty;
}

[Table("ProductCategories")]
public class ProductCategory
{
    public int ProductId { get; set; }

    public int CategoryId { get; set; }
}
```
{% endcode %}

`ProductCategory` is the junction type of the products' related categories. The related collection adds it to the EF Core model, with `ProductId` and `CategoryId` as its key. For more information, see the [Related Collections](../collections/related-collections.md) article.

<details>

<summary>ProductRepository.cs</summary>

{% code title="ProductRepository.cs" lineNumbers="true" %}
```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using MyProject.Models;
using Umbraco.Cms.Core.Models;
using Umbraco.UIBuilder;
using Umbraco.UIBuilder.Core.Persistence;
using Umbraco.UIBuilder.Persistence;

namespace MyProject.Repositories;

public class ProductRepository : EFCoreRepository<Product, int>
{
    public ProductRepository(RepositoryContext context)
        : base(context)
    {
    }

    protected override Task<int> GetIdImplAsync(Product entity, CancellationToken cancellationToken = default)
        => Task.FromResult(entity.Id);

    protected override async Task<Product> GetImplAsync(int id, CancellationToken cancellationToken = default)
        => await DbSet.AsNoTracking().FirstAsync(x => x.Id == id, cancellationToken);

    protected override async Task<Product> SaveImplAsync(Product entity, CancellationToken cancellationToken = default)
    {
        // Entities you read are detached afterwards, so attach them again to save them
        if (entity.Id == 0)
        {
            DbSet.Add(entity);
        }
        else
        {
            DbSet.Update(entity);
        }

        // Save your own changes: anything left pending is dropped
        await DbContext.SaveChangesAsync(cancellationToken);
        return entity;
    }

    protected override async Task DeleteImplAsync(int id, CancellationToken cancellationToken = default)
        => await DbSet.Where(x => x.Id == id).ExecuteDeleteAsync(cancellationToken);

    protected override async Task<IEnumerable<Product>> GetAllImplAsync(Expression<Func<Product, bool>>? whereClause = null, Expression<Func<Product, object>>? orderBy = null, SortDirection orderByDirection = SortDirection.Ascending, CancellationToken cancellationToken = default)
        => await Query(whereClause, orderBy, orderByDirection).ToListAsync(cancellationToken);

    protected override async Task<PagedModel<Product>> GetPagedImplAsync(int pageNumber, int pageSize, Expression<Func<Product, bool>>? whereClause = null, Expression<Func<Product, object>>? orderBy = null, SortDirection orderByDirection = SortDirection.Ascending, CancellationToken cancellationToken = default)
    {
        var query = Query(whereClause, orderBy, orderByDirection);

        return new PagedModel<Product>
        {
            Items = await query.Skip((pageNumber - 1) * pageSize).Take(pageSize).ToListAsync(cancellationToken),
            Total = await query.LongCountAsync(cancellationToken),
        };
    }

    protected override Task<long> GetCountImplAsync(Expression<Func<Product, bool>>? whereClause, CancellationToken cancellationToken = default)
        => Query(whereClause, null, SortDirection.Ascending).LongCountAsync(cancellationToken);

    protected override async Task<IEnumerable<TJunctionEntity>> GetRelationsByParentIdImplAsync<TJunctionEntity>(int parentId, string relationAlias, CancellationToken cancellationToken = default)
    {
        var links = await DbContext.Set<ProductCategory>()
            .AsNoTracking()
            .Where(x => x.ProductId == parentId)
            .ToListAsync(cancellationToken);

        return links.Cast<TJunctionEntity>();
    }

    protected override async Task<TJunctionEntity> SaveRelationImplAsync<TJunctionEntity>(TJunctionEntity entity, CancellationToken cancellationToken = default)
    {
        if (entity is ProductCategory link
            && !await DbContext.Set<ProductCategory>().AnyAsync(x => x.ProductId == link.ProductId && x.CategoryId == link.CategoryId, cancellationToken))
        {
            DbContext.Add(link);
            await DbContext.SaveChangesAsync(cancellationToken);
        }

        return entity;
    }

    protected override async Task DeleteRelationImplAsync<TJunctionEntity>(TJunctionEntity entity, string relationAlias, CancellationToken cancellationToken = default)
    {
        if (entity is ProductCategory link)
        {
            await DbContext.Set<ProductCategory>()
                .Where(x => x.ProductId == link.ProductId && x.CategoryId == link.CategoryId)
                .ExecuteDeleteAsync(cancellationToken);
        }
    }

    // Applies the where clause and ordering UI Builder passes in. Both are already rewritten for EF Core.
    private IQueryable<Product> Query(Expression<Func<Product, bool>>? whereClause, Expression<Func<Product, object>>? orderBy, SortDirection direction)
    {
        var query = DbSet.AsNoTracking();
        if (whereClause is not null)
        {
            query = query.Where(whereClause);
        }

        if (orderBy is null)
        {
            return query.OrderByDescending(x => x.Id);
        }

        return direction == SortDirection.Ascending
            ? query.OrderBy(orderBy)
            : query.OrderByDescending(orderBy);
    }
}
```
{% endcode %}

</details>

Assign the repository to a collection with the `SetRepositoryType()` method, and add the related categories:

```csharp
collectionConfig
    .SetRepositoryType<ProductRepository>()
    .AddRelatedCollection<Product, Category, ProductCategory>(x => x.Id, "Category", "Categories", relationConfig => relationConfig
        .SetAlias("productCategories")
        .SetJunction<ProductCategory>(x => x.ProductId, y => y.CategoryId));
```

{% hint style="info" %}

Custom repositories set through `SetRepositoryType()` are used whatever the value of the `UseEFCore` setting. The setting only controls the default repository.

{% endhint %}

## What the Base Class Does for You

The public operations of `EFCoreRepository<TEntity, TId>` are sealed. These include `GetAsync`, `SaveAsync`, `InsertAsync`, `UpdateAsync`, `DeleteAsync`, `GetAllAsync`, `GetPagedAsync`, `GetCountAsync`, `GetRelationsByParentIdAsync`, `SaveRelationAsync`, and `DeleteRelationAsync`. `PerformSaveAsync` and `PerformRelationSaveAsync` are sealed too.

Each sealed operation opens the scope, applies the rollback rules, and raises the notifications. Put your logic in the `*ImplAsync` methods or in notification handlers.

### Scoping and Rollback

Every operation runs in a scope for the collection's database:

* A collection on the Umbraco database joins the ambient Umbraco scope. Your writes commit and roll back with that scope. A collection can opt out with `DisableUmbracoScopeSharing()`.
* A collection with its own connection string gets its own context and transaction.
* A write that throws, or whose result reports an exception, is rolled back. Inside an ambient Umbraco scope, the failed write also stops that scope from committing.
* A read never rolls back a scope.
* `EntitySavedNotification` and `EntityDeletedNotification` are published before the commit. A handler that throws rolls the write back.

### Canceled Saves and Deletes

A save or delete that a notification handler cancels is not a failure. The operation completes its scope, so the surrounding transaction is not rolled back. Anything the handler wrote before it canceled the operation is kept.

To roll back everything, throw an exception from the handler instead of canceling. The operation then fails, and the writes in its scope roll back. Inside an ambient Umbraco scope, that scope also stops committing.

### Nested Operations

Operations nested inside another operation share its context. Nested operations include operations from a notification handler, or your repository calling itself. A failed nested write stops the outer operation from committing.

{% hint style="warning" %}

Do not run operations on the same database in parallel inside one operation, for example with `Task.WhenAll`. Nested operations share one context.

{% endhint %}

### The DbContext

The `DbContext` and `DbSet` properties are only available while an operation runs. Use them in your `*ImplAsync` methods, or in code those methods call. Outside an operation, both throw an `InvalidOperationException`.

* `DbContext` never returns the context of another database.
* Do not keep the context, dispose it, or begin your own transaction on it.

### Change Tracking

Umbraco UI Builder encrypts and decrypts entities in place around your `*ImplAsync` methods. After each call, it stops tracking the following:

* Everything the call started tracking.
* The entity passed to the call.
* The entities the call returned, as a single entity, a list, or a page.

Entities that other code was tracking on the shared context are left alone.

Follow these rules in your `*ImplAsync` methods:

* Call `SaveChangesAsync` yourself. A change left pending is dropped.
* Read with `AsNoTracking`. An entity you read is not tracked afterwards.
* Use `Update` or `Attach` to save an entity you read earlier.
* Never call `ChangeTracker.Clear()`. Other code may have entities tracked on the same context.

A `GetPagedImplAsync` result with a `null` value for `Items` becomes an empty list.

### Filters and Ordering

The where clause and order-by passed to `GetAllImplAsync`, `GetPagedImplAsync`, and `GetCountImplAsync` are ready to use:

* They already include the collection's filter and the soft-delete clause.
* Umbraco's query helpers, such as `InvariantContains` and `SqlIn`, are rewritten so that EF Core can translate them.
* Calls to `string.Equals`, `Contains`, `StartsWith`, and `EndsWith` on a column are rewritten to be case-insensitive, as on the NPoco repository. The `==` operator is not rewritten.

Apply them as lambdas in `Where`, `OrderBy`, and `OrderByDescending`. They can contain provider-specific calls, such as `EF.Functions.Like`. Do not compile them or run them in memory.

Queries you build yourself are not rewritten. Helpers you add to an `IQueryable` are not rewritten either.

### Errors

* An exception from your implementation becomes a failed `OperationResult`. The exception is not thrown to the caller.
* When EF Core cannot translate a query, the error names the collection and, where it can, the method that EF Core cannot translate. The error leaves out the query values.

## Deleting Relations

Override `DeleteRelationImplAsync` to support removing relations from a related collection. The method runs in the repository's write scope.

```csharp
protected override Task DeleteRelationImplAsync<TJunctionEntity>(TJunctionEntity entity, string relationAlias, CancellationToken cancellationToken = default)
```

Without an override, deleting a relation returns a failed `OperationResult` that contains a `NotSupportedException`. The failure is checked before a scope opens, so it does not stop an ambient Umbraco scope from committing. When the backoffice saves an entity and a relation fails, the editor sees the failure.

## The Obsolete Constructor

The `EFCoreRepository(RepositoryContext context, UIBuilderDbContext dbContext)` constructor is obsolete and is scheduled for removal in Umbraco UI Builder 21.

A repository built with the obsolete constructor behaves differently:

* Its `DbContext` is not part of the ambient Umbraco scope.
* The collection's connection string is ignored.
* The repository disposes the `UIBuilderDbContext` when the repository is disposed.

Use the constructor that takes only the `RepositoryContext`.
