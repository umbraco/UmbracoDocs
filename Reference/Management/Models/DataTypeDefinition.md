#DataTypeDefinition

**Applies to Umbraco 6.x and newer**

A DataTypeDefinition is what you see in the backoffice in the Developer / DataTypes tree. The listed nodes are definitions of the DataTypes that are available to use on your PropertyTypes.

 * **Namespace:** `Umbraco.Core.Models` 
 * **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following usings:
	
	using Umbraco.Core.Models;

##Constructors

### new DataTypeDefinition(int parentId, Guid controlId)
Constructor for creating a new `DataTypeDefinition` object where the necessary parameters are the id of the parent as `Int` and the Id of the DataType's control as a `Guid`.

##Properties

###.ControlId
Gets the Id of the DataType as a `Guid`.

###.CreateDate
Gets or Sets a `DateTime` object, indicating then the given Content was created.

###.CreatorId
Gets or Sets the Id of the `User` who created the Content.

###.DatabaseType
Gets or Sets the DatabaseType as a `DataTypeDatabaseType` enum for which the DataType's value is saved as.

###.Id
Returns the unique `Content` Id as a `Int`, this ID is based on a Database identity field, and is therefore not safe to reference in code which are moved between different instances, use Key instead. 

###.Key
Returns the `Guid` assigned to the Content during creation. This value is unique, and should never change, even if the content is moved between instances. 

###.Level
Gets or Sets the given `Content` level in the site hirachy as an `Int`. Content placed at the root of the site, will return 1, content just underneath will return 2, and so on.

###.Name
Gets or Sets the name of the content as a `String`.

###.ParentId
Gets or Sets the parent `Content` Id as an `Int`.

###.Path
Gets or Sets the path of the content as a `String`. This string contains a comma seperated list of the anscestors Ids including the current contents own id at the end of the string.

###.SortOrder
Returns the given `Content` index, compared to sibling content.

###.Trashed
Returns a `Bool` indicating whether the given `Content` is currently in the recycle bin.
