# uQuery

uQuery is an API giving read and write access the content, media and member data, as well as extending the relations built in API. uQuery originated from uComponents and was added into Umbraco from v4.8, and can be accessed by referencing the umbraco namespace:

`using umbraco;`

## Content

Querying content can be done via 'Nodes' where the source data comes from the Xml cache (the current published version), or via 'Documents' where the data is retrieved from the database (which is slower, but the data represents the latest version whether it's published or not).

uQuery has a number of static methods to get collections of Nodes and Documents, as well as extension methods on the umbraco.NodeFactory.Node / umbraco.cms.Web.Document objects.

----

### Items

#### GetRootNode
#### GetCurrentNode
#### GetCurrentDocument
#### GetNode
#### GetDocument

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