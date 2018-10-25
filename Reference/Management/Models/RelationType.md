# RelationType

**Applies to Umbraco 6.x and newer**

Represents a relation type between two object types of either media or content.

 * **Namespace:** `Umbraco.Core.Models` 
 * **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statement:
	
	using Umbraco.Core.Models;

## Constructors

### new RelationType(Guid childObjectType, Guid parentObjectType, string alias)
Constructor for creating a new RelationType object where the necessary parameters are the id of the child object type, parent object type the relation type will be for, and the string alias of the relation type.

### new RelationType(Guid childObjectType, Guid parentObjectType, string alias, string name)
Constructor for creating a new RelationType object where the necessary parameters are the id of the child object type, parent object type the relation type will be for, and the string alias and name of the relation type.

## Properties

### .Name
Gets or sets the Name of the RelationType as a `String`.

	// Given a `RelationService` object get RelationType by its Id and return Name
	var relationType = relationService.GetRelationTypeById(1234);
	return relationType.Name;

### .Alias
Gets or sets the Alias of the RelationType as `String`.

	// Given a `RelationService` object get RelationType by its Id and return Alias
	var relationType = relationService.GetRelationTypeById(1234);
	return relationType.Alias;
    
### .IsBidirectional
Gets or sets a `boolean` indicating whether the RelationType is Bidirectional (true) or Parent to Child (false)

	// Given a `RelationService` object get RelationType by its Id and return IsBidirectional
	var relationType = relationService.GetRelationTypeById(1234);
	return relationType.IsBidirectional;
    
 ### .ParentObjectType
  Gets or sets the Parents object type id as `Guid`
  
	// Given a `RelationService` object get RelationType by its Id and return IsBidirectional
	var relationType = relationService.GetRelationTypeById(1234);
	return relationType.ParentObjectType;
    
 ### .ChildObjectType
  Gets or sets the Childs object type id as `Guid`
  
	// Given a `RelationService` object get RelationType by its Id and return IsBidirectional
	var relationType = relationService.GetRelationTypeById(1234);
	return relationType.ChildObjectType;
