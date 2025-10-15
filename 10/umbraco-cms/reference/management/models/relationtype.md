---
description: "The `RelationType` class represents a relation definition between two node types (content or media)."
---

# RelationType

The `RelationType` class represents a relation definition between two node types (content or media). For example keeping track of node usage across the site, in order to avoid deleting content that is used else where. When querying a relation, it is typically done using the parent node key. However, if the `RelationType` is bidirectional, querying with the child node key is also possible.

* **Namespace:** `Umbraco.Cms.Core.Models`
* **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statement:

```csharp
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Services;
```

## Constructors

### new RelationType(string name, string alias, bool isBidrectional, Guid? parentObjectType, Guid? childObjectType)

Create a new RelationType object with this constructor. It requires a `string` alias, the relation type's name, and a `bool` for bidirectionality. Additionally, specify the `Guid?` keys for both child and parent object types involved in the relation.

## Properties

### .Name

Gets or sets the Name of the RelationType as a `String`.

```csharp
// Given a `RelationService` object get RelationType by its Id and return Name
var relationType = relationService.GetRelationTypeById(1234);
return relationType.Name;
```

### .Alias

Gets or sets the Alias of the RelationType as `String`.

```csharp
// Given a `RelationService` object get RelationType by its Id and return Alias
var relationType = relationService.GetRelationTypeById(1234);
return relationType.Alias;
```

### .IsBidirectional

Gets or sets a `boolean` indicating whether the RelationType is Bidirectional (true) or Parent to Child (false)

```csharp
// Given a `RelationService` object get RelationType by its Id and return IsBidirectional
var relationType = relationService.GetRelationTypeById(1234);
return relationType.IsBidirectional;
```

### .ParentObjectType

Gets or sets the Parents object type key as `Guid?`

```csharp
// Given a `RelationService` object get RelationType by its Id and return ParentObjectType
var relationType = relationService.GetRelationTypeById(1234);
return relationType.ParentObjectType;
```

### .ChildObjectType

Gets or sets the Childs object type key as `Guid?`

```csharp
// Given a `RelationService` object get RelationType by its Id and return ChildObjectType
var relationType = relationService.GetRelationTypeById(1234);
return relationType.ChildObjectType;
```
