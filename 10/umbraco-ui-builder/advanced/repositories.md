---
description: Configuring repositories in Konstrukt, the back office UI builder for Umbraco.
---

# Repositories

Repositories are used by Konstrukt to access the entity data stores. By default, collections will use a generic built in NPoco repository however you can define your own repository implementation should you wish to store your entities via an alternative strategy.

## Defining a repository

To define a repository you create a class that inherits from the base class `KonstruktRepository<TEntity, TId>` and implements all of its abstract methods.

````csharp
// Example
public class PersonRepository : KonstruktRepository<Person, int> {

    public PersonRepository(KonstruktRepositoryContext context)
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

**Note:** For all `Impl` methods there are public alternatives without the `Impl` suffix, however we have separate implementation methods in order to ensure all repositories fire the relevant Konstrukt events whether triggered via the Konstrukt UI or not.

## Changing the repository implementation of a collection

#### **SetRepositoryType&lt;TRepositoryType&gt;() : KonstruktCollectionConfigBuilder&lt;TEntityType&gt;**

Sets the repository type to the given type for the current collection.

````csharp
// Example
collectionConfig.SetRepositoryType<PersonRepositoryType>();
````

#### **SetRepositoryType(Type repositoryType) : KonstruktCollectionConfigBuilder&lt;TEntityType&gt;**

Sets the repository type to the given type for the current collection.

````csharp
// Example
collectionConfig.SetRepositoryType(typeof(PersonRepositoryType));
````

## Accessing a repository in code

To help with accessing a repository (default or custom) Konstrukt has a `IKonstruktRepositoryFactory` you can inject into your code base with a couple of factory methods to create the repository instances for you. Repositories should only be created via the repository factory as there are a number of injected depenedencies that can only be resolved by Konstrukt.

#### **IKonstruktRepositoryFactory.GetRepository&lt;TEntity, TId&gt;() : KonstruktRepository&lt;TEntity, TId&gt;**

Creates a repository for the given entity type. Konstrukt will search the configuration for the first section / collection with a configuration for the given entity type and use that as repository configuration.

````csharp
// Example
public class MyController : Controller
{
    private readonly KonstruktRepository<Person, int> _repo;

    public MyController(IKonstruktRepositoryFactory repoFactory) 
    {
        _repo = repoFactory.GetRepository<Person, int>();
    }
}
````

#### **IKonstruktRepositoryFactory.GetRepository&lt;TEntity, TId&gt;(string collectionAlias) : KonstruktRepository&lt;TEntity, TId&gt;**

Creates a repository for the given entity type from the collection with the given alias.

````csharp
// Example
public class MyController : Controller
{
    private readonly KonstruktRepository<Person, int> _repo;

    public MyController(IKonstruktRepositoryFactory repoFactory) 
    {
        _repo = repoFactory.GetRepository<Person, int>("person");
    }
}
````