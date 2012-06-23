# uQuery

uQuery is an API giving read/write access the content, media and member data, as well as extending the relations API. uQuery originated from uComponents and was added into Umbraco from v4.8. To use uQuery declare the umbraco namespace in addition to those required for nodes, documents, media, members and relations.


`using umbraco; // uQuery`

`using umbraco.NodeFactory; // Node`

`using umbraco.cms.businesslogic.web; // Document`

`using umbraco.cms.businesslogic.media;`

`using umbraco.cms.businesslogic.member;`

`using umbraco.cms.businesslogic.relation;`











----------
## Content

Querying content can be done via **Nodes** where the source data comes from the xml cache, which is fast (current published version data) or via **Documents** where the data is retrieved from the database (slower, but the data represents the latest version whether it's published or not).

uQuery has a number of static methods to get collections of Nodes and Documents, as well as extension methods on the `umbraco.NodeFactory.Node` `umbraco.cms.Web.Document` objects.




### Nodes


#### Items
Methods that return either a single `Node` or `null`.

##### GetRootNode()
Returns: `Node`

Returns the top level node in the content tree, this node always has an id of -1, so this method is simply a wrapper method.

`Node node = uQuery.GetRootNode();`


##### GetCurrentNode()
Returns: `Node` or `null`

Returns the current content node (unlike *umbraco.nodeFactory.Node.GetCurrent()* this method will also work in the back office, hence can be used by custom datatypes). There are circumstances where *GetCurrentNode()* will a return null, for example in the back office on a content item that has never been published (since it's not in the xml cache).

`Node node = uQuery.GetCurrentNode();`

##### GetNode(string or int)
Returns: `Node` or `null`

For a given id (supplied as an int or a string), returns the associated Node obj or a null if it not found. This method supresses any exceptions thown by Umbraco when trying to create an invalid Node, if this occurs, then a null is returned.

`Node node = uQuery.GetNode(123);`

`Node node = uQuery.GetNode("123");`


##### GetNodeByUrl(string)
Returns: `Node` or `null`

Returns a node for the supplied Url, if a match can't be found a null is returned,

`Node node = uQuery.GetNodeByUrl("/home.aspx")`



#### Collections
Methods that return a collection of Node objects

##### GetNodesByCsv(string) 
Returns: `IEnumerable<Node>` 

Get node collection from a CSV string of node Ids.

`IEnumerable<Node> nodes = uQuery.GetNodesByCsv("1002, 1003, 1004");`


##### GetNodesByXPath(string)
Returns: `IEnumerable<Node>` 

Gets a collection of nodes from an XPath expression by querying the in memory xml cache.

The tokens `$currentPage`, `$ancestorOrSelf` and `$parentPage` can be used within the string expression, for example `$ancestorOrSelf` would be replaced with `/descendant::*[@id='x']` where x is the id of the current node or the nearest published parent.

On first use the XPath expression is compiled and cached.

`IEnumerable<Node> nodes = uQuery.GetNodesByXPath("\\*[@isDoc]");`


##### GetNodesByName(string)
Returns: `IEnumerable<Node>` 

This is a wrapper method to an XPath expression, and gets a collection of nodes where their names match.

`IEnumerable<Node> nodes = uQuery.GetNodesByName("Page A");`

##### GetNodesByType(string or int)
Returns: `IEnumerable<Node>`

Gets a collection of nodes from a supplied DocumentType Alias (the string parameter) or from the DocumentType Id (the int parameter). Internally this search is done via an XPath expression (as with all XPath queries via uQuery, these are also compiled and cached).

`IEnumerable<Node> nodes = uQuery.GetNodesByType("page");`

`IEnumerable<Node> nodes = uQuery.GetNodesByType(1000);`


##### GetNodesByXml(string)
Returns: `IEnumerable<Node>`

uQuery is aware of the xml fragments saved by several datatypes (*Multi-Node TreePicker*, *XPath CheckBoxTree* and the *uComponents: CheckBoxTree*)

`IEnumerable<Node> nodes = uQuery.GetNodesByXml("<MultiNodePicker> <nodeId>1001</nodeId> <nodeId>1002</nodeId> </MultiNodePicker>");`

This method can be useful in conjuction with the uQuery *.GetProperty<T>(string)* extension method:

`IEnumerable<Node> nodes = uQuery.GetNodesByXml(node.GetProperty<string>("mntpAlias"));`


##### Traversing
These methods are useful in conjunction with LINQ, allowing tree traversal with custom filtering.

###### GetAncestorNodes()
Returns: `IEnumerable<Node>`

Gets a collection of nodes from the current parent to the root.


###### GetAncestorOrSelfNodes()
Returns: `IEnumerable<Node>`

Gets a collection of nodes from the current to the root. This can be useful for breadcrumbs, for example:

`IEnumerable<Node> breadcrumbNodes = uQuery.GetCurrentNode().GetAncestorOrSelfNodes().Where(x => x.GetProperty<bool>("showInBreadcrumbs")).Reverse();`

###### GetDescendantNodes(optional Func&lt;Document, bool&gt;)
Returns: `IEnumerable<Node>`

Gets a collection of nodes from under the current in a depth first order.

`IEnumerable nodes = uQuery.GetRootNode().GetDescendantNodes();`

If a function is provided, then it's evalutated on each node before adding it to the result collection - if this function returns a false, then any further descendant nodes of the one being checked are not processed. 
For example this could be useful in getting a collection of nodes, but as soon as one is found marked as 'hidden', none of it's descendants are then evaluated. Supplying a function can make a search more efficient.

`IEnumerable nodes = uQuery.GetRootNode().GetDescendantNodes(x => !GetProperty<bool>("hidden"));`


###### GetDescendantOrSelfNodes()
Returns: `IEnumerable<Node>`

Gets a collection of nodes starting with the current, and then all it's descendant nodes.

###### GetSiblingNodes()
Returns: `IEnumerable<Node>`

###### GetPreceedingSiblingNodes()
Returns: `IEnumerable<Node>`

###### GetFollowingSiblingNodes()
Returns: `IEnumerable<Node>`

###### GetChildNodes()
Returns: `IEnumerable<Node>`


##### Properties

##### HasProperty(string)
Returns: `bool`

Checks to see if the node has a property with the supplied alias. This is a wrapper method handling a null check on *Node.GetProperty(string)*.

`if(uQuery.GetCurrentNode().HasProperty("title")) { ... }`

##### GetProperty&lt;T&gt;(string)
Returns: `bool` `int` `float` `decimal` `string` `DateTime` `XmlDocument`


##### SetProperty(string, object)
Returns: `Node`

This is a wrapper method for the Document SetProperty extension method.

















### Documents
#### Items
##### GetCurrentDocument()
Returns `Document` or `null`

Gets the current document (like *uQuery.GetCurrentNode()* this method will also work in the back office).

`Document document = uQuery.GetCurrentDocument()`

##### GetDocument(string or int)
Returns: `Document` or `null`

For a given id (supplied as an int or a string), returns the associated Document obj or a null if not found.

`Document document = uQuery.GetDocument(123);`

`Document document = uQuery.GetDocument("123");`








#### Collections
##### GetDocumentsByCsv(string)
Returns: `IEnumerable<Document>` 

Get document collection from a CSV string of node Ids


##### GetDocumentsByXml(string)
Returns: `IEnumerable<Document>`


##### Traversing
###### GetAncestorDocuments()
Returns: `IEnumerable<Document>`

###### GetAncestorOrSelfDocuments()
Returns: `IEnumerable<Document>`

###### GetDescendantDocuments(optional Func&lt;Document, bool&gt;)
Returns: `IEnumerable<Document>`

###### GetDescendantOrSelfDocuments()
Returns: `IEnumerable<Document>`

###### GetSiblingDocuments()
Returns: `IEnumerable<Document>`

###### GetPreceedingSiblingDocuments()
Returns: `IEnumerable<Document>`

###### GetFollowingSiblingDocuments()
Returns: `IEnumerable<Document>`

###### GetChildDocuments(optional Func&lt;Document, bool&gt;)
Returns: `IEnumerable<Document>`






#### Properties
##### HasProperty(string) TODO !
##### GetProperty&lt;T&gt;(string)
Returns: `bool` `int` `float` `decimal` `string` `DateTime` `XmlDocument` `...`






##### SetProperty(string, object)
Returns: `Document`


When a property is set, it's also saved
































----------
## Media
Querying media intro

### Items
#### GetMedia(string or int)
Returns: `Media` or `null`

### Collections
#### GetMediaByXPath(string)
Returns: `IEnumerable<Media>`

(uses GetPublishedXml)

#### GetMediaByCsv(string)
Returns: `IEnumerable<Media>`

#### GetMediaByXml(string)
Returns: `IEnumerable<Media>`

Currently works with XML saved by Multi-Node Tree Picker (use GetNodesByXml for Content nodes) 

#### GetMediaByName(string)
Returns: `IEnumerable<Media>`

#### GetMediaByType(string)
Returns: `IEnumerable<Media>`

#### Traversing

##### GetAncestorMedia()
Returns: `IEnumerable<Media>`

##### GetAncestorOfSelfMedia()
Returns: `IEnumerable<Media>`

##### GetDescendantMedia()
Returns: `IEnumerable<Media>`

##### GetDescendantOrSelfMedia()
Returns: `IEnumerable<Media>`

##### GetSiblingMedia()
Returns: `IEnumerable<Media>`

##### GetPrecedingSiblingMedia()*
Returns: `IEnumerable<Media>`

##### GetFollowingSiblingMedia()*
Returns: `IEnumerable<Media>`

##### GetChildMedia()
Returns: `IEnumerable<Media>`

### Properties
#### HasProperty(string)
Returns: `bool`

#### GetProperty<T>(string)
Returns: `bool` `int` `float` `decimal` `string` `DateTime` `XmlDocument`

#### SetProperty(string, object)
Returns: `Media`















----------
## Members

Querying members into

### Items
### GetMember(string or int)
Returns: `Member` or `null`

### Collections
#### GetMembersByXPath(string)
Returns: `IEnumerable<Member>`

(uses GetPublishedXml)

#### GetMembersByCsv(string)
Returns: `IEnumerable<Member>`

#### GetMembersByXml(string)
Returns: `IEnumerable<Member>`

#### GetMembersByType(string)
Returns: `IEnumerable<Member>`

#### GetMembersByGroup(string)*
Returns: `IEnumerable<Member>`

### Properties
#### HasProperty(string)
Returns: `bool`

#### GetProperty&lt;T&gt;(string)
Returns: `bool` `int` `float` `decimal` `string` `DateTime` `XmlDocument`

#### SetProperty(string, object)
Returns: `Member`

----------
## Relations
Releation methods intro

### Methods

#### CreateRelation(int, int)
Returns: `void`

validates ids against the objectypes defined on the RelationType

#### HasRelations(int)
Returns: `bool`

#### IsRelated(int, int)
Returns: `bool`

#### GetRelation(int, int)
Returns: `Relation`

#### GetRelations(int)
Returns: `Relation[]`

#### DeleteRelation(int, int)
Returns: `void`

#### ClearRelations(int)
Returns: `void`

