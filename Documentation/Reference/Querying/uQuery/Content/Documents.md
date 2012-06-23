# Documents
Querying Documents is slower than querying Nodes, as the data is sourced from the database rather than the xml cache. The Document API is used when nodes are being updated, or access to unpublished data is required.

## Items
Methods that return a `Document` object or `null`

### GetCurrentDocument()
Returns `Document` or `null`

Gets the current document (like *uQuery.GetCurrentNode()* this method will also work in the back office).

	Document document = uQuery.GetCurrentDocument();

### GetDocument(string or int)
Returns: `Document` or `null`

For a given id (supplied as an int or a string), returns the associated Document obj or a null if not found. This method will supress any exceptions thrown by Umbraco if an attempt to construct a document with an invalid id is performed.

	Document document = uQuery.GetDocument(123);

	Document document = uQuery.GetDocument("123");


## Collections
### GetDocumentsByCsv(string)
Returns: `IEnumerable<Document>` 

Get document collection from a CSV string of node Ids

	IEnumerable<Document> documents = uQuery.GetDocumentsByCsv("1001, 1002, 1003");


### GetDocumentsByXml(string)
Returns: `IEnumerable<Document>`

	IEnumerabl<Document> documents = uQuery.GetNodesByXml(@"
														<MultiNodePicker>
				                                            <nodeId>1001</nodeId>
				                                            <nodeId>1002</nodeId>
				                                        </MultiNodePicker>");
					



### Traversing
These methods are useful in conjunction with LINQ, allowing tree traversal with custom filtering.

#### GetAncestorDocuments()
Returns: `IEnumerable<Document>`

	IEnumerable<Document> documents = uQuery.GetCurrentDocument()
											.GetAncestorDocuments();


#### GetAncestorOrSelfDocuments()
Returns: `IEnumerable<Document>`

	IEnumerable<Document> documents = uQuery.GetCurrentDocument()
											.GetAncestorOrSelfDocuments();


#### GetDescendantDocuments(optional Func&lt;Document, bool&gt;)
Returns: `IEnumerable<Document>`

#### GetDescendantOrSelfDocuments()
Returns: `IEnumerable<Document>`

#### GetSiblingDocuments()
Returns: `IEnumerable<Document>`

#### GetPreceedingSiblingDocuments()
Returns: `IEnumerable<Document>`

#### GetFollowingSiblingDocuments()
Returns: `IEnumerable<Document>`

#### GetChildDocuments(optional Func&lt;Document, bool&gt;)
Returns: `IEnumerable<Document>`






## Properties
### HasProperty(string)
### GetProperty&lt;T&gt;(string)
Returns: `<T>`

This generic method handles the null checks when getting a document property by alias, and then converts the stored property value into the return type `<T>` requested. It also takes into account bool values as stored as strings "0" and "1", and can also construct an XmlDocument from a string fragment. Here are some examples:

	Document currentDocument = uQuery.GetCurrentDocument();

	string heading = currentDocument.GetProperty<string>("heading");
	bool showInNavigation = currentDocument.GetProperty<bool>("showInNavigation");
	int itemsPerPage = currentDocument.GetProperty<int>("itemsPerPage");
	DateTime bookingDate = currentDocument.GetProperty<DateTime>("bookingDate").Date();
	XmlDocument xmlDocument = currentDocument.GetProperty<XmlDocument>("imageCropper");






### SetProperty(string, object)
Returns: `Document`

	Document currentDocument = uQuery.GetCurrentDocument();

	


When a property is set, it's also saved