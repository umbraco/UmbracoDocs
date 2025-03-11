---
description: Configuring **one-to-many** relationships in Umbraco UI Builder.
---

# Retrieve Child Collections

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

In one-to-many relationships, a parent entity is associated with multiple entities from another collection. In Umbraco UI Builder, retrieving child collections from such relationships is supported through child repositories. This enables you to access related data effectively, helping to maintain a well-organized backoffice UI.

## Models Representation

For a one-to-many relationship, you typically have two models: one for the parent entity and one for the child entity.

```csharp
[TableName("Students")]
[PrimaryKey("Id")]
public class Student
{
    [PrimaryKeyColumn]
    public int Id { get; set; }

    public string FirstName { get; set; }

    public string LastName { get; set; }

    public string Email { get; set; }
}
```

In the above example, the `Student` model represents the parent entity. A student can have multiple associated `StudentProjects`.

```csharp
[TableName("StudentProjects")]
[PrimaryKey("Id")]
public class StudentProject
{
    [PrimaryKeyColumn]
    public int Id { get; set; }

    public string Name { get; set; }

    public int StudentId { get; set; }
}
```

The `StudentProjects` model represents the child entity. The `StudentId` is a foreign key that links each `StudentProject` to the `Student` entity, establishing the one-to-many relationship.
 
## Child Repositories

To retrieve data from child collections, you can use the `IRepositoryFactory` to create child repository instances. These repositories provide methods to fetch child entities associated with a given parent entity.

```csharp
public class StudentProjectController : Controller
{
    private readonly IRepositoryFactory _repositoryFactory;

    public StudentProjectController(IRepositoryFactory repositoryFactory)
    {
        _repositoryFactory = repositoryFactory;
    }

    public IActionResult Index(int projectId)
    {
        var childRepository = _repositoryFactory.GetChildRepository<int, StudentProject, int>(projectId);

        var list = childRepository.GetAll();

        var count = childRepository.GetCount();

        var listPaged = childRepository.GetPaged();

        return View(list);
    }
}
```

In this example:

- The `StudentProjectController` is using the `IRepositoryFactory` to create a child repository for `StudentProject`.
- The `GetAll()`method retrieves all child entities related to the given parent.
- The `GetCount()` method returns the total number of child entities associated with the parent.
- The  `GetPaged()` method allows for pagination of child entities, making it easier to manage large sets of data.

This structure allows efficient retrieval and management of child entities, providing a well-organized way to interact with related data in Umbraco's backoffice.
