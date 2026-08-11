---
description: Configure repositories in Umbraco UI Builder.
---

# Repositories

Repositories in Umbraco UI Builder manage entity data storage. By default, collections use a built-in NPoco repository. To use a different storage strategy, define a custom repository implementation.

## Defining a Repository

Create a class that inherits from `Repository<TEntity, TId>` and implements all abstract methods.

```csharp
// Example
public class PersonRepository : Repository<Person, int> {

    public PersonRepository(RepositoryContext context)
        : base(context)
    { }

    protected override int GetIdImpl(Person entity) {
        return entity.Id;
    }

    protected override Person GetImpl(int id) {
        ...
    }

    protected override Person SaveImpl(Person entity) {
        ...
    }

    protected override void DeleteImpl(int id) {
        ...
    }

    protected override IEnumerable<Person> GetAllImpl(Expression<Func<Person, bool>> whereClause, Expression<Func<Person, object>> orderBy, SortDirection orderByDirection) {
        ...
    }

    protected override PagedResult<Person> GetPagedImpl(int pageNumber, int pageSize, Expression<Func<Person, bool>> whereClause, Expression<Func<Person, object>> orderBy, SortDirection orderByDirection) {
        ...
    }

    protected override long GetCountImpl(Expression<Func<Person, bool>> whereClause) {
        ...
    }

    protected override IEnumerable<TJunctionEntity> GetRelationsByParentIdImpl<TJunctionEntity>(int parentId, string relationAlias)
    {
        ...
    }

    protected override TJunctionEntity SaveRelationImpl<TJunctionEntity>(TJunctionEntity entity)
    {
        ...
    }
}
```

\{% hint style="info" %\} `Impl` methods have public alternatives without the suffix. Separate implementation methods ensure repositories trigger Umbraco UI Builder events, whether actions originate from the UI or not. \{% endhint %\}

## Changing the Repository Implementation of a Collection

### Using the `SetRepositoryType()` Method

Assign a custom repository type to a collection.

#### Method Syntax

```cs
SetRepositoryType<TRepositoryType>() : CollectionConfigBuilder<TEntityType>
```

#### Example

```csharp
collectionConfig.SetRepositoryType<PersonRepositoryType>();
```

### Using the `SetRepositoryType(Type repositoryType)` Method

Sets the repository type dynamically to the given type for the current collection.

#### Method Syntax

```cs
SetRepositoryType(Type repositoryType) : CollectionConfigBuilder<TEntityType>
```

#### Example

```csharp
collectionConfig.SetRepositoryType(typeof(PersonRepositoryType));
```

## Accessing a Repository in Code

To help with accessing a repository (default or custom) Umbraco UI Builder has an `IRepositoryFactory` you can inject into your code base. This includes a couple of factory methods to create the repository instances for you. Repositories should only be created via the repository factory as there are some injected dependencies that can only be resolved by Umbraco UI Builder.

### Using the `GetRepository<TEntity, TId>()` Method

Creates a repository for the given entity type. Umbraco UI Builder will search the configuration for the first section/collection with a configuration for the given entity type. Then it will use that as a repository configuration.

#### Method Syntax

```cs
IRepositoryFactory.GetRepository<TEntity, TId>() : Repository<TEntity, TId>
```

#### Example

```csharp
public class MyController : Controller
{
    private readonly Repository<Person, int> _repo;

    public MyController(IRepositoryFactory repoFactory) 
    {
        _repo = repoFactory.GetRepository<Person, int>();
    }
}
```

### Using the `GetRepository<TEntity, TId>(string collectionAlias)` Method

Creates a repository for the given entity type from the collection with the given alias.

#### Method Syntax

```cs
IRepositoryFactory.GetRepository<TEntity, TId>(string collectionAlias) : Repository<TEntity, TId>
```

#### Example

```csharp
public class MyController : Controller
{
    private readonly Repository<Person, int> _repo;

    public MyController(IRepositoryFactory repoFactory) 
    {
        _repo = repoFactory.GetRepository<Person, int>("person");
    }
}
```
