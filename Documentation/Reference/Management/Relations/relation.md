#Relation

_The `Relation` object represents a connection between 2 items stored in Umbraco, a parent and a child item. All obejcts in a relation must be stored in Umbraco, and have a reference in the UmbracoNode table, and a integer ID, it therefore not possible to build relations between a Umbraco object and a external piece of data._

 * **Namespace:** `umbraco.cms.businesslogic.relation` 
 * **assembly:** `cms.dll`
 

All samples in this document will require references to the following dlls:

* cms.dll
* businesslogic.dll

All samples in this document will require the following usings:
	
	using umbraco.cms.businesslogic.relation;
	using umbraco.BusinessLogic;


##Properties

###.Child
Returns or sets the child of the relation as  a `CMSNode`

	var relation = Relation.GetRelations(2332).First();
	
	string name = relation.Child.Text;
	int nodeId = relation.Child.Id;
	
	relation.Child = new CmsNode(1234);

###.Comment
Returns or sets a comment attached to the Relation during creation
	
	var relation = Relation.GetRelations(2332).First();
	string comment = relation.Comment;
	
	relation.Comment = "meh";
	
###.CreateDate
Returns the date, the relation was created as a `DateTime`
	
	var relation = Relation.GetRelations(2332).First();
	var date = relation.CreateDate;
	
###.Id
Returns the unique relation Id as a `Int`

###.Parent
Returns or sets the Parent of the relation as  a `CMSNode`

	var relation = Relation.GetRelations(2232).First();

	string name = relation.Parent.Text;
	int nodeId = relation.Parent.Id;
	
	relation.Parent = new CmsNode(1234);

##Methods

###.Delete()
Deletes the `Relation`

###.Save()
This is a Stub method, and does currently not do anything