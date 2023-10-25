---
description: Configuring repositories in Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Repositories

Repositories are used by Umbraco UI Builder to access the entity data stores. By default, collections will use a generic built-in NPoco repository. However, you can define your own repository implementation should you wish to store your entities via an alternative strategy.

## Defining a repository

To define a repository create a class that inherits from the base class `Repository<TEntity, TId>` and implements all of its abstract methods.

````csharp
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
}
````

**Note:** For all `Impl` methods there are public alternatives without the `Impl` suffix. However, there are separate implementation methods in order to ensure all repositories fire the relevant Umbraco UI Builder events. This is whether triggered via the Umbraco UI Builder's UI or not.

## Changing the repository implementation of a collection

### **SetRepositoryType&lt;TRepositoryType&gt;() : CollectionConfigBuilder&lt;TEntityType&gt;**

Sets the repository type to the given type for the current collection.

````csharp
// Example
collectionConfig.SetRepositoryType<PersonRepositoryType>();
````

### **SetRepositoryType(Type repositoryType) : CollectionConfigBuilder&lt;TEntityType&gt;**

Sets the repository type to the given type for the current collection.

````csharp
// Example
collectionConfig.SetRepositoryType(typeof(PersonRepositoryType));
````

## Accessing a repository in code

To help with accessing a repository (default or custom) Umbraco UI Builder has an `IRepositoryFactory` you can inject into your code base. This includes a couple of factory methods to create the repository instances for you.
Repositories should only be created via the repository factory as there are some injected dependencies that can only be resolved by Umbraco UI Builder.

### **IRepositoryFactory.GetRepository&lt;TEntity, TId&gt;() : Repository&lt;TEntity, TId&gt;**

Creates a repository for the given entity type. Umbraco UI Builder will search the configuration for the first section/collection with a configuration for the given entity type. Then it will use that as a repository configuration.

````csharp
// Example
public class MyController : Controller
{
    private readonly Repository<Person, int> _repo;

    public MyController(IRepositoryFactory repoFactory) 
    {
        _repo = repoFactory.GetRepository<Person, int>();
    }
}
````

### **IRepositoryFactory.GetRepository&lt;TEntity, TId&gt;(string collectionAlias) : Repository&lt;TEntity, TId&gt;**

Creates a repository for the given entity type from the collection with the given alias.

````csharp
// Example
public class MyController : Controller
{
    private readonly Repository<Person, int> _repo;

    public MyController(IRepositoryFactory repoFactory) 
    {
        _repo = repoFactory.GetRepository<Person, int>("person");
    }
}
````
