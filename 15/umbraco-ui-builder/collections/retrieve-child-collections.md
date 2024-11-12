---
description: Configuring **one-to-many** relationships in Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Retrieve Child Collections

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

Retrieving child collections in **one-to-many** relationships with UI Builder, can be achieved with the support of child repositories. One-to-many relations are where one parent entity of a collection is associated with multiple entities from another.

## Models Representation

The models would look like this:

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

## Child Repositories

You can create child repository instances via the `IRepositoryFactory` and use them to retrieve information from the child collection.

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
