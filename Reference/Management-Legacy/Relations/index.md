#Relations

_The `Relation` object represents a connection between 2 items stored in Umbraco, a parent and a child item. All obejcts in a relation must be stored in Umbraco, and have a reference in the UmbracoNode table, and a integer ID, it therefore not possible to build relations between a Umbraco object and a external piece of data._


 * **Namespace:** `umbraco.cms.businesslogic.relation` 
 * **assembly:** `cms.dll`
 

All samples in this document will require references to the following dlls:

* cms.dll
* businesslogic.dll

All samples in this document will require the following usings:
	
	using umbraco.cms.businesslogic.relation;
	using umbraco.BusinessLogic;

(see also: [uQuery Relation Extensions](../../Querying/uQuery/Relations.md))

##Constructor
The `Relation` constructor is used to retrive a Relation object with a given Id, a null is returned if no relation is found with the given Id. 

###Get Relation by Id
Retrieves the  `Relation` by its id, which is a Database identity `int`.  

	Relation r = new Relation(1234); 
	
##[Relation methods and properties](relation.md) 
The `Relation` class itself has a big collection of methods and properties, please see the separate [Relation](relation.md) page for this.

##[RelationType methods and properties](relationtype.md) 
The `RelationType` class itself is described in a  separate [RelationType](relationtype.md) page.

##Static methods

###.GetRelations()
Returns a `Relation[]` containing all relations for a given Node Id, as a optional parameter, you can filter by a specific `RelationType`
	
	//get relations from a node with a given ID
	var relations = Relation.GetRelations(1234);
	
	foreach (var relation in relations)
	{
	    var date = relation.CreateDate;
	    var parent = relation.Parent;
	    var child = relation.Child;
	}
	
	//get relations by a given ID and with a specific relation type
	var relType = RelationType.GetByAlias("myRelation");
	var relations = Relation.GetRelations(1234, relType);     
	
###.GetRelationsAsList()
Returns a `List<Relation>` containing all relations for a given Node Id, as a optional parameter, you can filter by a specific `RelationType`
	
	//get relations from a node with a given ID
	var relations = Relation.GetRelationsAsList(1234);
	
	foreach (var relation in relations)
	{
	    var date = relation.CreateDate;
	    var parent = relation.Parent;
	    var child = relation.Child;
	}
	
###.IsRelated
Returns a `Boolean` indicating whether 2 Ids have a relation, as a optional parameter you can filter by a specific `RelationTyoe`

	var relType = RelationType.GetByAlias("myRelation");
	bool isRelated= Relation.IsRelated(parentId, childId, reltype);

###.MakeNew()
Creates a new relation between a parent Id, and a child Id, of a given RelationType, a comment can be attached to creation. **Note** to create a new relation, you will need a RelationType, please see the  [RelationType](relationtype.md) page for this.

	var relType = RelationType.GetByAlias("myRelation");
	Relation.MakeNew(ParentId, ChildId, relType, "This is a new relation")
	
