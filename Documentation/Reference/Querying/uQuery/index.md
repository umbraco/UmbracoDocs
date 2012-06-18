# uQuery

uQuery is an API giving read and write access the content, media and member data, as well as extending the relations API. uQuery originated from uComponents and was added into Umbraco from v4.8, and can be accessed by referencing the umbraco namespace:

`using umbraco;`

## Content

Querying content can be done via 'Nodes' where the source data comes from the Xml cache (the current published version), or via 'Documents' where the data is retrieved from the database (which is slower, but the data represents the latest version whether it's published or not).

uQuery has a number of static methods to get collections of Nodes and Documents, as well as extension methods on the umbraco.NodeFactory.Node / umbraco.cms.Web.Document objects.

----

### Items

#### GetRootNode
Returns the top level node in the content tree, this node always has an id of -1, so this method is simply a wrapper method.
eg.

`Node node = uQuery.GetRootNode();`

#### GetCurrentNode
Returns the current content node (unlike Node.GetCurrent() this method will also work in the back office, hence can be used by custom datatypes). There are circumstances where GetCurrentNode() will a return null, for example in the back office on a content item that has never been published (hence it's not in the xml cache).

eg.

`Node node = uQuery.GetCurrentNode();`

#### GetCurrentDocument
Returns the current Document - this will also work in the back office and should always return a Document object.

eg.

`Document document = uQuery.GetCurrentDocument();`


#### GetNode
For a given id, returns a Node obj or a null if not found. There are two overloaded methods: GetNode(int) and GetNode(string).

eg.

`Node node = uQuery.GetNode(123);`

or

`Node node = uQuery.GetNode("123");`


#### GetDocument

For a given id, returns a Document obj or a null if not found. There are two overloaded methods: GetDocument(int) and GetDocument(string).

eg.

`Document document = uQuery.GetDocument(123);`

or

`Document document = uQuery.GetDocument("123");`

----

### Collections

#### GetNodesByCsv
#### GetDocumentsByCsv
#### GetNodesByXml
#### GetDocumentsByXml
#### GetNodesByXPath
#### GetNodesByName
#### GetNodesByType
#### GetNodeByUrl

----

### Traversing

#### GetAncestorNodes
#### GetAncestorDocuments
#### GetAncestorOrSelfNodes
#### GetAncestorOrSelfDocuments
#### GetPreceedingSiblingNodes
#### GetPreceedingSiblingDocuments
#### GetFollowingSiblingNodes
#### GetFollowingSiblingDocuments
#### GetSiblingNodes
#### GetSiblingDocuments
#### GetDescendantNodes
#### GetDescendantDocuments
#### GetDescendantOrSelfNodes
#### GetDescendantOrSelfDocuments
#### GetChildNodes
#### GetChildDocuments

----

### Properties
#### HasProperty
#### GetProperty
#### SetProperty

----

## Media ##
Querying media intro

----

### Items
#### GetMedia

----

### Collections
#### GetMediaByXPath
#### GetMediaByCsv
#### GetMediaByXml
#### GetMediaByName
#### GetMediaByType

----

### Traversing
#### GetAncestorMedia
#### GetAncestorOfSelfMedia
#### GetPrecedingSiblingMedia*
#### GetFollowingSiblingMedia*
#### GetSiblingMedia
#### GetDescendantMedia
#### GetDescendantOrSelfMedia
#### GetChildMedia

----

### Properties
#### HasProperty
#### GetProperty
#### SetProperty

----

## Members ##

Querying members into

----

### Items
#### GetMember

----

### Collections
#### GetMembersByXPath
#### GetMembersByCsv
#### GetMembersByXml
#### GetMembersByType
#### GetMembersByGroup

----

### Properties
#### HasProperty
#### GetProperty
#### SetProperty

----

## Relations ##
Releation methods intro

----

### Methods

#### HasRelations
#### IsRelated
#### GetRelation
#### GetRelations
#### DeleteRelation
#### ClearRelations