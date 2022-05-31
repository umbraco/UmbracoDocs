---
versionFrom: 9.0.0
meta.Title: "RelationType Model"
meta.Description: "The `RelationType` class represents a relation definition between two node types (content or media)."
---
# RelationType

The `RelationType` class represents a relation definition between two node types (content or media). For example keeping track of node usage across the site, in order to avoid deleting content that is used else where. When querying a relation this is done using the parent node key unless the `RelationType` is set to bidirectional in which case you can also query using the child node key.

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

Constructor for creating a new RelationType object where the necessary parameters are the string alias and name of the relation type, a `bool` to indicate whether the relation is bidirectional, and the `Guid?` key of the child object type, parent object type the relation type will be for.

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
