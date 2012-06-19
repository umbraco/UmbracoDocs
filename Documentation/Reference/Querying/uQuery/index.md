# uQuery

uQuery is an API giving read and write access the content, media and member data, as well as extending the relations API. uQuery originated from uComponents and was added into Umbraco from v4.8, and can be accessed by referencing the umbraco namespace:

`using umbraco;`

# Content

Querying content can be done via 'Nodes' where the source data comes from the Xml cache (the current published version), or via 'Documents' where the data is retrieved from the database (which is slower, but the data represents the latest version whether it's published or not).

uQuery has a number of static methods to get collections of Nodes and Documents, as well as extension methods on the umbraco.NodeFactory.Node / umbraco.cms.Web.Document objects.


## Items

### GetRootNode()
Returns: `Node`

Returns the top level node in the content tree, this node always has an id of -1, so this method is simply a wrapper method.

eg.

`Node node = uQuery.GetRootNode();`

Returns node -1

### GetCurrentNode()
Returns: `Node`

Returns the current content node (unlike Node.GetCurrent() this method will also work in the back office, hence can be used by custom datatypes). There are circumstances where GetCurrentNode() will a return null, for example in the back office on a content item that has never been published (hence it's not in the xml cache).

eg.

`Node node = uQuery.GetCurrentNode();`

### GetNode(string or int)
Returns: `Node`

For a given id, returns a Node obj or a null if not found. There are two overloaded methods: GetNode(int) and GetNode(string).

eg.

`Node node = uQuery.GetNode(123);`

or

`Node node = uQuery.GetNode("123");`


### GetNodeByUrl(string)
Returns: `Node`

Returns a node for the supplied Url


### GetCurrentDocument()
Returns `Document`

Checks to see if the current Node can be obtained via the nodeFactory, else attempts to get via a QueryString id parameter


### GetDocument(string or int)
Returns: `Document`

For a given id, returns a Document obj or a null if not found. There are two overloaded methods: GetDocument(int) and GetDocument(string).

eg.

`Document document = uQuery.GetDocument(123);`

or

`Document document = uQuery.GetDocument("123");`

## Collections

### GetNodesByCsv(string) 
Returns: `List<Node>` 

Get node collection from a CSV string of node Ids

### GetNodesByXPath(string)
Returns: `List<Node>` 

Get node collection from an XPath expression (uses Umbraco Xml) can use use $ancestorOrSelf to use the currentNode if published else it'll use the nearest published parent ($currentPage will be depreciated) - the XPath expression is compiled and cached

### GetNodesByName(string)
Returns: `List<Node>` 

Returns a collection of nodes where names match

### GetNodesByType(string or int)
Returns: `List<Node>`

Parameter: 
`string` of the docType alias or `int` of docType id

Returns a collection of nodes of docType alias or docType id

### GetNodesByXml(string)
Returns: `List<Node>`

Currently works with XML saved by Multi-Node Tree Picker (use GetMediaByXml for Media nodes)

### GetDocumentsByCsv(string)
Returns: `List<Document>` 

Get document collection from a CSV string of node Ids


### GetDocumentsByXml(string)
Returns: `List<Document>`

## Traversing
These axis type methods are useful with LINQ

### GetAncestorNodes()
Returns: `IEnumerable<Node>`

### GetAncestorOrSelfNodes()
Returns: `IEnumerable<Node>`

### GetDescendantNodes(optional Func&lt;Document, bool&gt;)
Returns: `IEnumerable<Node>`

### GetDescendantOrSelfNodes()
Returns: `IEnumerable<Node>`

### GetSiblingNodes()
Returns: `IEnumerable<Node>`

### GetPreceedingSiblingNodes()
Returns: `IEnumerable<Node>`

### GetFollowingSiblingNodes()
Returns: `IEnumerable<Node>`

### GetChildNodes()
Returns: `IEnumerable<Node>`

### GetAncestorDocuments()
Returns: `IEnumerable<Document>`

### GetAncestorOrSelfDocuments()
Returns: `IEnumerable<Document>`

### GetDescendantDocuments(optional Func&lt;Document, bool&gt;)
Returns: `IEnumerable<Document>`

### GetDescendantOrSelfDocuments()
Returns: `IEnumerable<Document>`

### GetSiblingDocuments()
Returns: `IEnumerable<Document>`

### GetPreceedingSiblingDocuments()
Returns: `IEnumerable<Document>`

### GetFollowingSiblingDocuments()
Returns: `IEnumerable<Document>`

### GetChildDocuments(optional Func&lt;Document, bool&gt;)
Returns: `IEnumerable<Document>`

## Properties

### HasProperty(string)
Returns: `bool`

### GetProperty&lt;T&gt;(string)
Returns: `T`

### SetProperty(string, object)
Returns: `Node`

chainable property setter - calls Document.SetProperty

# Media
Querying media intro

## Items
### GetMedia(string or int)
Returns: `Media`

## Collections
### GetMediaByXPath(string)
Returns: `List<Media>`

(uses GetPublishedXml)

### GetMediaByCsv(string)
Returns: `List<Media>`

### GetMediaByXml(string)
Returns: `List<Media>`

Currently works with XML saved by Multi-Node Tree Picker (use GetNodesByXml for Content nodes) 

### GetMediaByName(string)
Returns: `List<Media>`

### GetMediaByType(string)
Returns: `List<Media>`

## Traversing

### GetAncestorMedia()
Returns: `IEnumerable<Media>`

### GetAncestorOfSelfMedia()
Returns: `IEnumerable<Media>`

### GetDescendantMedia()
Returns: `IEnumerable<Media>`

### GetDescendantOrSelfMedia()
Returns: `IEnumerable<Media>`

### GetSiblingMedia()
Returns: `IEnumerable<Media>`

### GetPrecedingSiblingMedia()*
Returns: `IEnumerable<Media>`

### GetFollowingSiblingMedia()*
Returns: `IEnumerable<Media>`

### GetChildMedia()
Returns: `IEnumerable<Media>`

## Properties
### HasProperty(string)
Returns: `bool`

### GetProperty<T>(string)
Returns: `T`

### SetProperty(string, object)
Returns: `Media`

# Members

Querying members into

## Items
### GetMember(string or int)
Returns: `Member`

## Collections
### GetMembersByXPath(string)
Returns: `List<Member>`

(uses GetPublishedXml)

### GetMembersByCsv(string)
Returns: `List<Member>`

### GetMembersByXml(string)
Returns: `List<Member>`

### GetMembersByType(string)
Returns: `List<Member>`

### GetMembersByGroup(string)*
Returns: `List<Member>`

## Properties
### HasProperty(string)
Returns: `bool`

### GetProperty&lt;T&gt;(string)
Returns: `T`

### SetProperty(string, object)
Returns: `Member`

# Relations
Releation methods intro

## Methods

### CreateRelation(int, int)
Returns: `void`

validates ids against the objectypes defined on the RelationType

### HasRelations(int)
Returns: `bool`

### IsRelated(int, int)
Returns: `bool`

### GetRelation(int, int)
Returns: `Relation`

### GetRelations(int)
Returns: `Relation[]`

### DeleteRelation(int, int)
Returns: `void`

### ClearRelations(int)
Returns: `void`