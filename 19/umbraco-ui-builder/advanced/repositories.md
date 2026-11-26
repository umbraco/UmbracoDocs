---
description: Configure repositories in Umbraco UI Builder.
---

# Repositories

Repositories in Umbraco UI Builder manage entity data storage. By default, collections use a built-in Entity Framework Core (EF Core) repository. To use a different storage strategy, define a custom repository implementation.

For more information about the default repository, see the [Entity Framework Core](efcore-repositories.md) article.

## Defining a Repository

Create a class that inherits from `Repository<TEntity, TId>` and implements all abstract methods. The repository API is asynchronous only. Every method you implement has an `ImplAsync` suffix and accepts a `CancellationToken`.

{% hint style="info" %}

To read and write with EF Core, inherit from `EFCoreRepository<TEntity, TId>` instead. For more information, see the [Custom EF Core Repositories](custom-efcore-repositories.md) article.

{% endhint %}

The following repository shows every method to implement. Replace each body with calls to your own data store.

{% code title="CategoryRepository.cs" %}
```csharp
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading;
using System.Threading.Tasks;
using MyProject.Models;
using Umbraco.Cms.Core.Models;
using Umbraco.UIBuilder;
using Umbraco.UIBuilder.Persistence;

namespace MyProject.Repositories;

public class CategoryRepository : Repository<Category, int>
{
    public CategoryRepository(RepositoryContext context)
        : base(context)
    {
    }

    protected override Task<int> GetIdImplAsync(Category entity, CancellationToken cancellationToken = default)
        => Task.FromResult(entity.Id);

    protected override Task<Category> GetImplAsync(int id, CancellationToken cancellationToken = default)
        => throw new NotImplementedException("Read the category from your data store.");

    protected override Task<Category> SaveImplAsync(Category entity, CancellationToken cancellationToken = default)
        => throw new NotImplementedException("Insert or update the category in your data store.");

    protected override Task DeleteImplAsync(int id, CancellationToken cancellationToken = default)
        => throw new NotImplementedException("Delete the category from your data store.");

    protected override Task<IEnumerable<Category>> GetAllImplAsync(Expression<Func<Category, bool>>? whereClause = null, Expression<Func<Category, object>>? orderBy = null, SortDirection orderByDirection = SortDirection.Ascending, CancellationToken cancellationToken = default)
        => throw new NotImplementedException("Return the categories that match the where clause, in order.");

    protected override Task<PagedModel<Category>> GetPagedImplAsync(int pageNumber, int pageSize, Expression<Func<Category, bool>>? whereClause = null, Expression<Func<Category, object>>? orderBy = null, SortDirection orderByDirection = SortDirection.Ascending, CancellationToken cancellationToken = default)
        => throw new NotImplementedException("Return one page of matching categories and the total count.");

    protected override Task<long> GetCountImplAsync(Expression<Func<Category, bool>>? whereClause, CancellationToken cancellationToken = default)
        => throw new NotImplementedException("Count the categories that match the where clause.");

    protected override Task<IEnumerable<TJunctionEntity>> GetRelationsByParentIdImplAsync<TJunctionEntity>(int parentId, string relationAlias, CancellationToken cancellationToken = default)
        => throw new NotImplementedException("Return the junction rows of the relation for this parent.");

    protected override Task<TJunctionEntity> SaveRelationImplAsync<TJunctionEntity>(TJunctionEntity entity, CancellationToken cancellationToken = default)
        => throw new NotImplementedException("Save the junction row.");
}
```
{% endcode %}

`InsertImplAsync` and `UpdateImplAsync` are optional. Both call `SaveImplAsync` unless you override them.

Umbraco UI Builder reads the results of `GetAllImplAsync` and `GetPagedImplAsync` before the operation returns. An exception from your implementation, including one from a deferred query, becomes a failed `OperationResult`. A `null` value for `Items` from `GetPagedImplAsync` becomes an empty list.

{% hint style="info" %}

`ImplAsync` methods have public alternatives without the `Impl` part, such as `GetAsync` and `SaveAsync`. Separate implementation methods ensure repositories trigger Umbraco UI Builder events, whether actions originate from the UI or not.

{% endhint %}

{% hint style="warning" %}

When running in a load-balanced or multi-node environment, a custom repository must read and write through a shared, centralized data store. Backing a repository with in-memory collections or the local file system causes data to diverge between nodes. Use the shared site database, a distributed cache, or an external service that all nodes can reach.

{% endhint %}

### Upgrading a Custom Repository From Version 18

Umbraco UI Builder 19 removes the synchronous repository API. To upgrade a custom repository that inherits from `Repository<TEntity, TId>`:

1. Delete the synchronous overrides: `GetIdImpl`, `GetImpl`, `SaveImpl`, `DeleteImpl`, `GetAllImpl`, `GetPagedImpl`, `GetCountImpl`, `GetRelationsByParentIdImpl`, `SaveRelationImpl`, `InsertImpl`, and `UpdateImpl`.
2. Implement the matching `*ImplAsync` methods.
3. Pass the `CancellationToken` on to your data store.
4. Replace calls to the synchronous repository methods, such as `Get` and `Save`, with their `*Async` versions.

For more information, see the [Async APIs](async-apis.md) article.

## Changing the Repository Implementation of a Collection

### Using the `SetRepositoryType()` Method

Assign a custom repository type to a collection.

#### Method Syntax

```cs
SetRepositoryType<TRepositoryType>() : CollectionConfigBuilder<TEntityType>
```

#### Example

```csharp
collectionConfig.SetRepositoryType<CategoryRepository>();
```

### Using the `SetRepositoryType(Type repositoryType)` Method

Sets the repository type dynamically to the given type for the current collection.

#### Method Syntax

```cs
SetRepositoryType(Type repositoryType) : CollectionConfigBuilder<TEntityType>
```

#### Example

```csharp
collectionConfig.SetRepositoryType(typeof(CategoryRepository));
```

A custom repository is used whatever the value of the `UseEFCore` setting.

## Accessing a Repository in Code

To help with accessing a repository (default or custom) Umbraco UI Builder has an `IRepositoryFactory` you can inject into your code base. This includes a couple of factory methods to create the repository instances for you. Repositories should only be created via the repository factory as there are some injected dependencies that can only be resolved by Umbraco UI Builder.

### Using the `GetRepository<TEntity, TId>()` Method

Creates a repository for the given entity type. Umbraco UI Builder uses the first collection configured for the given entity type as the repository configuration.

#### Method Syntax

```cs
IRepositoryFactory.GetRepository<TEntity, TId>() : Repository<TEntity, TId>
```

#### Example

```csharp
public class ProductLookup
{
    private readonly Repository<Product, int> _repository;

    public ProductLookup(IRepositoryFactory repositoryFactory)
        => _repository = repositoryFactory.GetRepository<Product, int>();
}
```

### Using the `GetRepository<TEntity, TId>(string collectionAlias)` Method

Creates a repository for the given entity type from the collection with the given alias.

#### Method Syntax

```cs
IRepositoryFactory.GetRepository<TEntity, TId>(string collectionAlias) : Repository<TEntity, TId>
```

#### Example

{% code title="ProductLookup.cs" %}
```csharp
using System.Threading.Tasks;
using MyProject.Models;
using Umbraco.UIBuilder.Persistence;

namespace MyProject.Services;

public class ProductLookup
{
    private readonly Repository<Product, int> _repository;

    public ProductLookup(IRepositoryFactory repositoryFactory)
        => _repository = repositoryFactory.GetRepository<Product, int>("products");

    public async Task<Product?> FindAsync(int id)
    {
        var result = await _repository.GetAsync(id);
        return result.Success ? result.Model : null;
    }
}
```
{% endcode %}
