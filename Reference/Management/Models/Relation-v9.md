---
versionFrom: 9.0.0
verified-against: rc001
meta.Title: "Relation Model"
meta.Description: "Represents a Relation between two items."
---

# Relation

Represents a Relation between two items.

* **Namespace:** `Umbraco.Cms.Core.Models`
* **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statement:

```csharp
using Umbraco.Cms.Core.Models;
```

## Constructors

### new Relation(int parentId, int childId, IRelationType relationType)

Constructor for creating a new Relation object where the necessary parameters are the Id of the parent item as an `int`, the Id of the child as an `int` and the relationType as `IRelationType`.

### new Relation(int parentId, int childId, Guid parentObjectType, Guid childObjectType, IRelationType relationType)

A second constructor exists but it should not be used because it is used to reconstruct a relation from the data source.

## Properties
