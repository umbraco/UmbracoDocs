---
description: "Represents a Relation between two items."
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

Constructor for creating a new Relation object. The necessary parameters are the Id of the parent item as an `int`, the Id of the child as an `int` and the relationType as `IRelationType`.

### new Relation(int parentId, int childId, Guid parentObjectType, Guid childObjectType, IRelationType relationType)

A second constructor exists but it should not be used because it is used to reconstruct a relation from the data source.

## Properties

### .ChildId

Gets or sets the Child Id of the Relation (Destination)

```csharp
// Given a `IRelationService` object get Relation by its Id and return ChildId
var relation = relationService.GetById(1234);
return relation.ChildId;
```

### .Comment

Gets or sets a comment for the Relation

```csharp
// Given a `IRelationService` object get Relation by its Id and return Comment
var relation = relationService.GetById(1234);
return relation.Comment;
```

### .ParentId

Gets or sets the Parent Id of the Relation (Source)

```csharp
// Given a `IRelationService` object get Relation by its Id and return ParentId
var relation = relationService.GetById(1234);
return relation.ParentId;
```

### .RelationType

Gets or sets the RelationType for the Relation

```csharp
// Given a `IRelationService` object get Relation by its Id and return RelationType
var relation = relationService.GetById(1234);
return relation.RelationType;
```

### .RelationTypeId

Gets the Id of the RelationType that this Relation is based on.

```csharp
// Given a `IRelationService` object get Relation by its Id and return RelationTypeId
var relation = relationService.GetById(1234);
return relation.RelationTypeId;
```
