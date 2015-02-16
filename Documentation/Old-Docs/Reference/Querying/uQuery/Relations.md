
# Relations

	using umbraco.cms.businesslogic.relation; // RelationType and Relation

uQuery extends the Relations API, by adding the following extension methods onto  the `umbraco.cms.businesslogic.relations.RelationType` object.
## RelationType

### CreateRelation(int, int)
Returns: `void`

Before a relation is created, this method validates the UmbracoOjbectTypes of the supplied ids to ensure they match those defined on the RelationType. If there's a validation error, then the relationship isn't added.

	RelationType.GetByAlias("relateA_B").CreateRelation(1001, 1003);

### HasRelations(int)
Returns: `bool`

Checks to see if there are any other ids related to the supplied id for the current RelationType.

	if (RelationType.GetByAlias("relateA_B").HasRelations(1001)) { ... }


### IsRelated(int, int)
Returns: `bool`

Returns true if a relationship was found between the two ids for the current RelationType.

When the RelationType has it's direction configured as a parent to child, the order of the parameters is significant (first is parent, second is child).

	if (RelationType.GetByAlias("relateA_B").IsRelated(1001, 1003)) { ... }


### GetRelation(int, int)
Returns: `Relation`

	Relation relation = RelationType.GetByAlias("relateA_B").GetRelation(1001, 1003);

### GetRelations(int)
Returns: `Relation[]`


	Relation[] relations = RelationType.GetByAlias("relateA_B").GetRelations(1001);

### DeleteRelation(int, int)
Returns: `void`

	RelationType.GetByAlias("relateA_B").DeleteRelation(1001, 1003);

### DeleteRelations(int)




Returns: `void`



### GetParentUmbracoObjectType()
Returns: `uQuery.UmbracoObjectType`

Hits the database to get the parent Guid for this relation type, and returns the associated [UmbracoObjectType](../index.md#UmbracoObjectType) Enum value.

	uQuery.UmbracoObjectType umbracoObjectType = RelationType.GetByAlias("relateA_B").GetParentUmbracoObjectType();


### GetChildUmbracoObjectType()
Returns: `uQuery.UmbracoObjectType`

Hits the database to get the child Guid for this relation type, and returns the associated [UmbracoObjectType](../index.md#UmbracoObjectType) Enum value.

	uQuery.UmbracoObjectType umbracoObjectType = RelationType.GetByAlias("relateA_B").GetChildUmbracoObjectType();



