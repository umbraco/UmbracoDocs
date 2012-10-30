# Nodes


## Items
Methods that return either a single `Node` or `null`.

### GetRootNode()
Returns: `Node`

Returns the top level node in the content tree, this node always has an id of -1, so this method is simply a wrapper method.

	Node node = uQuery.GetRootNode();


### GetCurrentNode()
Returns: `Node` or `null`

Returns the current content node (unlike *umbraco.nodeFactory.Node.GetCurrent()* this method will also work in the back office, hence can be used by custom datatypes). There are circumstances where *GetCurrentNode()* will a return null, for example in the back office on a content item that has never been published (since it's not in the xml cache).

	Node node = uQuery.GetCurrentNode();

### GetNode(string or int)
Returns: `Node` or `null`

For a given id (supplied as an int or a string), returns the associated Node obj or a null if it not found. This method supresses any exceptions thown by Umbraco when trying to create an invalid Node, if this occurs, then a null is returned.

	Node node = uQuery.GetNode(123);

	Node node = uQuery.GetNode("123");`


### GetNodeByUrl(string)
Returns: `Node` or `null`

Returns a node for the supplied Url, if a match can't be found a null is returned,

	Node node = uQuery.GetNodeByUrl("/home.aspx");


## Collections
Methods that return a collection of Node objects

### GetNodesByCsv(string) 
Returns: `IEnumerable<Node>` 

Get node collection from a CSV string of node Ids.

	IEnumerable<Node> nodes = uQuery.GetNodesByCsv("1002, 1003, 1004");


### GetNodesByXPath(string)
Returns: `IEnumerable<Node>` 

Gets a collection of nodes from an XPath expression by querying the in memory xml cache.

The tokens `$currentPage`, `$ancestorOrSelf` and `$parentPage` can be used within the string expression, for example `$ancestorOrSelf` would be replaced with `/descendant::*[@id='x']` where x is the id of the current node or the nearest published parent.

On first use the XPath expression is compiled and cached.

	IEnumerable<Node> nodes = uQuery.GetNodesByXPath("//*[@isDoc]");


### GetNodesByName(string)
Returns: `IEnumerable<Node>` 

This is a wrapper method to an XPath expression, and gets a collection of nodes where their names match.

	IEnumerable<Node> nodes = uQuery.GetNodesByName("Page A");

### GetNodesByType(string or int)
Returns: `IEnumerable<Node>`

Gets a collection of nodes from a supplied DocumentType Alias (the string parameter) or from the DocumentType Id (the int parameter). Internally this search is done via an XPath expression (as with all XPath queries via uQuery, these are also compiled and cached).

	IEnumerable<Node> nodes = uQuery.GetNodesByType("page");

	IEnumerable<Node> nodes = uQuery.GetNodesByType(1000);


### GetNodesByXml(string)
Returns: `IEnumerable<Node>`

uQuery is aware of the xml fragments saved by several datatypes (*Multi-Node TreePicker*, *XPath CheckBoxTree* and the *uComponents: CheckBoxTree*)

	IEnumerable<Node> nodes = uQuery.GetNodesByXml(@"
											<MultiNodePicker>
												<nodeId>1001</nodeId>
												<nodeId>1002</nodeId>
											</MultiNodePicker>");

This method can be useful in conjuction with the uQuery *.GetProperty<T>(string)* extension method:

	IEnumerable<Node> nodes = uQuery.GetNodesByXml(node.GetProperty<string>("mntpAlias"));


### Traversing
These methods are useful in conjunction with LINQ, allowing tree traversal with custom filtering.

#### GetAncestorNodes()
Returns: `IEnumerable<Node>`

Gets a collection of nodes from the current parent to the root. This can be useful to find the first parent of a particular doctype, for example:
	
	Node homeNode = uQuery.GetCurrentNode()
							.GetAncestorNodes()
							.Where(x => x.NodeTypeAlias == "home")
							.FirstOrDefault();

#### GetAncestorOrSelfNodes()
Returns: `IEnumerable<Node>`

Gets a collection of nodes from the current to the root. This can be useful for breadcrumbs, for example:

	IEnumerable<Node> breadcrumbNodes = uQuery.GetCurrentNode()
												.GetAncestorOrSelfNodes()
												.Where(x => x.GetProperty<bool>("showInBreadcrumbs"))
												.Reverse();

#### GetDescendantNodes(optional Func&lt;Document, bool&gt;)
Returns: `IEnumerable<Node>`

Gets a collection of nodes from under the current in a depth first order.

	IEnumerable<Node> nodes = uQuery.GetRootNode()
									.GetDescendantNodes();

If a function is provided, then it's evalutated on each node before adding it to the result collection - if this function returns a false, then any further descendant nodes of the one being checked are not processed. 
For example this could be useful in getting a collection of nodes, but as soon as one is found marked as 'hidden', none of it's descendants are then evaluated. Supplying a function can make a search more efficient.

	IEnumerable<Node> nodes = uQuery.GetRootNode()
									.GetDescendantNodes(x => !GetProperty<bool>("hidden"));


#### GetDescendantOrSelfNodes()
Returns: `IEnumerable<Node>`

Gets a collection of nodes starting with the current, and then all it's descendant nodes.

	IEnumerable<Node> nodes = uQuery.GetRootNode().GetDescendantOrSelfNodes();



#### GetSiblingNodes()
Returns: `IEnumerable<Node>`

	IEnumerable<Node> nodes = uQuery.GetCurrentNode().GetSiblingNodes();

#### GetPreceedingSiblingNodes()
Returns: `IEnumerable<Node>`

This can be useful when rendering out navigation

	IEnumerable<Node> nodes = uQuery.GetCurrentNode().GetPreedingSiblingNodes();


#### GetFollowingSiblingNodes()
Returns: `IEnumerable<Node>`

This can be useful when rendering out navigation

	IEnumerable<Node> nodes = uQuery.GetCurrentNode().GetFolloringSiblingNodes();

#### GetChildNodes()
Returns: `IEnumerable<Node>`

	IEdnumerable<Node> nodes = uQuery.GetCurrentNode().GetChildNodes();

## Properties

### HasProperty(string)
Returns: `bool`

Checks to see if the node has a property with the supplied alias. This is a wrapper method handling a null check on *Node.GetProperty(string)*.

	if(uQuery.GetCurrentNode().HasProperty("title")) { ... }

### GetProperty&lt;T&gt;(string)
Returns: `<T>`

This generic method handles the null checks when getting a node property by alias, and then converts the stored property value into the return type `<T>` requested. It also takes into account bool values as stored as strings "0" and "1", and can also construct an XmlDocument from a string fragment. Here are some examples:

	Node currentNode = uQuery.GetCurrentNode();

	string heading = currentNode.GetProperty<string>("heading");
	bool showInNavigation = currentNode.GetProperty<bool>("showInNavigation");
	int itemsPerPage = currentNode.GetProperty<int>("itemsPerPage");
	DateTime bookingDate = currentNode.GetProperty<DateTime>("bookingDate").Date();
	XmlDocument xmlDocument = currentNode.GetProperty<XmlDocument>("imageCropper");


### GetImageCropperUrl(string, string)
Returns: `string`

This helper method will parse the xml fragment stored by the the Image Cropper datatype and return the url for the specified crop alias, or an empty string if no url could be found.

	string cropUrl = uQuery.GetCurrentNode().GetImageCropperUrl("propertyAlias", "cropAlias");



### SetProperty(string, object)
Returns: `Node`

This is a wrapper method for the Document SetProperty extension method, so gets the Document instance of the current Node, and calls SetProperty on that.


### Level()
Returns: `int`

This method returns the level (depth in the content tree) of the node.

	int level = uQuery.GetCurrentNode().Level();


### ToXml()
Returns `XmlNode`

This method gets the Umrbaco xml fragment of the node.

	XmlNode xmlNode = uQuery.GetCurrentNode().ToXml();

