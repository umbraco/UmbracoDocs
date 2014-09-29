#RelationService

**Applies to Umbraco 6.1.1 and newer**

The RelationService acts as a "gateway" to Umbraco data for operations which are related to Relations.

 * **Namespace:** `Umbraco.Core.Services` 
 * **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following usings:
	
	using Umbraco.Core;
	using Umbraco.Core.Models;
	using Umbraco.Core.Services;

##Getting the service
The RelationService is available through the `ApplicationContext`, or if you are using a `SurfaceController` or the `UmbracoUserControl` then the RelationService is available through a local `Services` property.

	Services.RelationService

Getting the service through the `ApplicationContext`:

	ApplicationContext.Current.Services.RelationService

##Methods

###.GetById(int id)
Gets a `Relation` object by its Id

###.GetRelationTypeById(int id)
Gets a `RelationType` object by its Id

###.GetRelationTypeByAlias(string alias)
Gets a `RelationType` object by its Alias

###.GetAllRelations(params int[] ids)
Gets an enumerable list of `Relation` objects. If the optional array of integer ids is passed in then only the `Relation` objects with matching Id's will be returned. 

###.GetAllRelationsByRelationType(RelationType relationType)
Gets an enumerable list of `Relation` objects which have the specified `RelationType`.

###.GetAllRelationsByRelationType(int relationTypeId)
Gets an enumerable list of `Relation` objects which have the specified `RelationType` Id.

###.GetAllRelationTypes(params int[] ids)
Gets an enumerable list of `RelationType` objects. If the optional array of integer ids is passed in then only the `RelationType` objects with a matching Id will be returned.

###.GetByParentId(int id)
Gets an enumerable list of `Relation` objects that have the specified ParentId.

	public IENumerable<IPublishedContent> GetFavorites(int memberId)
	{
	    var rs = ApplicationContext.Current.Services.RelationService;
	    var relType = rs.GetRelationTypeByAlias("memberFavorites");
	    var favorites = new List<IPublishedContent>();
	 
	 
	    if (memberId > 0)
	    {
	        var relations = rs.GetByParentId(memberId).Where(r => r.RelationType.Alias == "memberFavorites");
	 
		foreach (var relation in relations)
		{
			favorites.Add(UmbracoContext.Current.ContentCache.GetById(relation.ChildId));
		}
	    }
	 
	    return favorites;
	}

###.GetByChildId(int id)
Gets an enumerable list of `Relation` objects that have the specified ChildId.

###.GetByParentOrChildId(int id)
Gets an enumerable list of `Relation` objects that have the specified ParentId or ChildId.

###.GetByRelationTypeName(string relationTypeName)
Gets an enumerable list of `Relation` objects that have the specified `RelationType` Name.

###.GetByRelationTypeAlias(string relationTypeAlias)
Gets an enumerable list of `Relation` objects that have the specified `RelationType` Alias.

###.GetByRelationTypeId(int relationTypeId)
Gets an enumerable list of `Relation` objects that have the specified `RelationType` Id.

###.GetChildEntityFromRelation(IRelation relation, bool loadBaseType = false)
Gets the Child object from a `Relation` passed into the method. If the `loadBaseType` parameter is true the complete object graph will be loaded.

###.GetParentEntityFromRelation(IRelation relation, bool loadBaseType = false)
Gets the Parent object from a `Relation` passed into the method. If the `loadBaseType` parameter is true the complete object graph will be loaded.

###.GetEntitiesFromRelation(IRelation relation, bool loadBaseType = false)
Gets the Parent and Child objects from a `Relation` passed into the method. If the `loadBaseType` parameter is true the complete object graph will be loaded.

###.GetChildEntitiesFromRelations(IEnumerable<IRelation> relations, bool loadBaseType = false)
Gets the Child objects from a list of Relations passed into the method. If the `loadBaseType` parameter is true the complete object graph will be loaded.

###.GetParentEntitiesFromRelations(IEnumerable<IRelation> relations,                                                                      bool loadBaseType = false)
Gets the Parent objects from a list of Relations passed into the method. If the `loadBaseType` parameter is true the complete object graph will be loaded.

###.GetEntitiesFromRelations(IEnumerable<IRelation> relations, bool loadBaseType = false)
Gets the Parent and Child objects from a list of Relations passed into the method. If the `loadBaseType` parameter is true the complete object graph will be loaded.

###.Relate(IUmbracoEntity parent, IUmbracoEntity child, IRelationType relationType)
Relates two objects that implement the `IUmbracoEntity` interface using the `RelationType` matching the specified `RelationType` and returns the resulting `Relation` object.

###.Relate(IUmbracoEntity parent, IUmbracoEntity child, string relationTypeAlias)
Relates two objects that implement the `IUmbracoEntity` interface using the `RelationType` matching the specified relationTypeAlias and returns the resulting `Relation` object.

###.HasRelations(IRelationType relationType)
Returns `true` if there are any `Relation` objects with the specified `RelationType`, otherwise returns `false`.

###.IsRelated(int id)
Returns `true` if any relations exist for the specified Id, otherwise returns `false`.

###.Save(IRelation relation)
Saves a single `Relation` object.

	public void SetFavorite(int memberId, int contentId) {
		var rs = ApplicationContext.Current.Services.RelationService;
		var areRelated = rs.AreRelated(memberId, contentId, "memberFavorites");
	 
		if (!areRelated)
		{
			//create relation
			var relType = rs.GetRelationTypeByAlias("memberFavorites");
			var r = new Relation(memberId, contentId, relType);
			rs.Save(r);
		}
	}

###.Save(IRelationType relationType)
Saves a single IRelationType object.

###.Delete(IRelation relation)
Permanently deletes a `Relation` object.

###.Delete(IRelationType relationType)
Permanently deletes a `RelationType` object.

###.DeleteRelationsOfType(IRelationType relationType)
Permanently deletes all relations that match the specified `RelationType`.
