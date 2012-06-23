### Documents
#### Items
##### GetCurrentDocument()
Returns `Document` or `null`

Gets the current document (like *uQuery.GetCurrentNode()* this method will also work in the back office).

	Document document = uQuery.GetCurrentDocument();

##### GetDocument(string or int)
Returns: `Document` or `null`

For a given id (supplied as an int or a string), returns the associated Document obj or a null if not found.

	Document document = uQuery.GetDocument(123);

	Document document = uQuery.GetDocument("123");








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