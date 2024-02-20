---
description: Configuring **one-to-many** relationships in Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Retrieve Child Collections

In a **one-to-many** relationship context, an entity from a parent collection can be associated with multiple entities from a child collection. In this context, you might need 
to retrieve the child collection entities, without fetching the details of the parent.

## Models Representation

The Poco models would look like this:

```csharp
[TableName("Person")]
[PrimaryKey("Id")]
public class Person
{
    [PrimaryKeyColumn]
    public int Id { get; set; }

    public string Name { get; set; }

    public string Email { get; set; }
}
```

```csharp
[TableName("ChildPerson")]
[PrimaryKey("Id")]
public class ChildPerson
{
    [PrimaryKeyColumn]
    public int Id { get; set; }

    public string Name { get; set; }

    public int ParentId { get; set; }
}
```

## Child Repositories

The concept of child repository will allow you to use the new methods of `IRepositoryFactory` to create child repository instances and use them as any other repository configuration.

```csharp
// Example
public class MyController : Controller
{
    private readonly IRepositoryFactory _repositoryFactory;

    public MyController(IRepositoryFactory repositoryFactory)
    {
        _repositoryFactory = repositoryFactory;
    }

    public IActionResult Index(int parentId)
    {
        var childRepository = _repositoryFactory.GetChildRepository<int, ChildPerson, int>(parentId);

        var list = childRepository.GetAll();

        var count = childRepository.GetCount();

        var listPaged = childRepository.GetPaged();

        return View(list);
    }
}
```
