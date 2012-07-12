#RelationType

_The `RelationType` describes the type of relation that can exist between 2 Umbraco objects. The type defines the Type the 2 objects can be, by referencing their Umbraco NodeObjectType Guids_

_To create a relation, you must have a RelationType, and the types of obejcts you are relating, must match the rules set on the RelationType_

 * **Namespace:** `umbraco.cms.businesslogic.relation` 
 * **assembly:** `cms.dll`
 
All samples in this document will require references to the following dlls:

* cms.dll
* businesslogic.dll

All samples in this document will require the following usings:
	
	using umbraco.cms.businesslogic.relation;
	using umbraco.BusinessLogic;

##Creating a RelationType
Unfortunately, the Umbraco 4 does not contain a .MakeNew() method for `RelationTypes`, you therefore have to manually execute a SQL script to create the type. 

	INSERT INTO [umbracoRelationType]
	           ([dual]
	           ,[parentObjectType]
	           ,[childObjectType]
	           ,[name]
	           ,[alias])
	     VALUES
	           (1
	           ,'C66BA18E-EAF3-4CFF-8A22-41B16D66A972'
	           ,'B796F64C-1F99-4FFB-B886-4BF4BC011A9C'
	           ,'My Document to Media Relation'
	           ,'doc2media');
	GO

##Available NodeObject Types
When you create a RelationType like above, you will need the correct GUIDs from Umbraco to register the type correctly, below is a reference, with the most commons ones first.

- Document: `C66BA18E-EAF3-4CFF-8A22-41B16D66A972	`
- Media: `B796F64C-1F99-4FFB-B886-4BF4BC011A9C`	
- Template: `6FBDE604-4178-42CE-A10B-8A2600A2F07D`	
- Member: `39EB0F98-B348-42A1-8662-E7EB18487560`	

And the guids, not used so often:

- ContentItemType: `7A333C54-6F43-40A4-86A2-18688DC7E532`	
- ROOT: `EA7D8624-4CFE-4578-A871-24AA946BF34D	`
- MemberType: `9B5416FB-E72F-45A9-A07B-5A9A2709CE43	`
- MemberGroup: `366E63B9-880F-4E13-A61C-98069B029728	`
- ContentItem: `10E2B09F-C28B-476D-B77A-AA686435E44A	`
- MediaType: `4EA4382B-2F5A-4C2B-9587-AE9B3CF3602E	`
- DocumentType: `A2CB7800-F571-4787-9638-BC48539A0EFB	`
- Recyclebin: `01BB7FF2-24DC-4C0C-95A2-C24EF72BBAC8	`
- Stylesheet: `9F68DA4F-A3A8-44C2-8226-DCBD125E4840`	
- DataType: `30A2A501-1978-4DDB-A57B-F7EFED43BA3C	`


##Constructors


##Static Methods
###.GetAll()
Returns all registered relation types as `IEnumerable<RelationType>`

###.GetById(int)
Returns a `RelationType` with with given Id, returns null if not found.

###.GetByAlias(string)
Returns a `RelationType` with a given alias, returns null if not found.

##Properties
###.Alias
Returns or Sets the Alias of the type

###.Dual
Return or sets a Boolean, indicating whether this type of relation goes both ways between parent and child, if false, only child relations of a parent will returned, if true, also parent relations of a child will be returned. 

###.Id
Returns the relation types unique id.

###.Name
Returns or sets the name of the relation.

##Methods

###.Save()
Not currently in use.