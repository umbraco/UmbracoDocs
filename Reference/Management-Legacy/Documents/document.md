#Document

**Applies to Umbraco 4.x and earlier**

The `Document` class represents a single item in the content tree, its values are
fetched directly from the database, not from the cache. **Notice** the Document class should strictly be used for simple CRUD operations, not complex queries, as it is not flexible nor fast enough for this.

All documents are versioned, so on each indiviual change, a new version is stored. Past versions can only be retrieved from the `Document` api, not from the cache. 

 * **Namespace:** `umbraco.cms.businesslogic.web` 
 * **assembly:** `cms.dll`
 

All samples in this document will require references to the following dlls:

* cms.dll
* businesslogic.dll

All samples in this document will require the following usings:
	
	using umbraco.cms.businesslogic.web;
	using umbraco.BusinessLogic;


##Properties

###.Children
Returns a `Document[]` containing all documents just below the given `Document`

	var d = new Document(1234);
	var children = d.Children;


###.ContentType
Returns a `ContentType` object representing the DocumentType used by the given `Document`

	//return the alias of the document type used
	var doc = new Document(1234);
	var docType = doc.ContentType;
	return doctype.Alias;


###.CreateDateTime;
Returns the `DateTime` object telling when the document was created.

	var doc = Document.MakeNew("name", doctype, user, -1);
	return doc.CreateDateTime;


###.Creator
Returns the `User` who created the document

	var doc = new Document(1234);
	var authorName = doc.Creator.Name;


###.ExpireDate
If set, returns the `DateTime` the Document is meant to be unpublished and become unavailable on the website

###.getProperties
Returns a `Property[]` containing all property data of the given `Document`, each property has a value, a alias

	var doc = new Document(1223);
	foreach(var prop in doc.getProperties){
        var value = (DateTime)prop.Value;
        var alias = prop.PropertyType.Alias;
    } 

###.getProperty
Returns or sets  a `Property` describing the property with a given alias

	var doc = new Document(1223);
	var bodyText = doc.getProperty("bodyText);
	
	//get the bodyText value	
	var bodyTextValue = bodyText.Value
	
	//sets the bodyText value
	bodytext.Value = "<p>hello</p>";
	
	doc.Save();
	

###.HasChildren
Returns `Bool` indicating whether the given `Document` has any documents just below it


###.Id
Returns the unique `Document` Id as a `Int`, this ID is based on a Database identity field, and is therefore not safe to reference in code which are moved between different instances, use UniqueId instead. 

###.IsTrashed
Returns a `Bool` indicating whether the given `Document` is currently in the recycle bin.


###.Level;
Returns the given `Document` level in the site hirachy as an `Int`. Documents placed at the root of the site, will return 1, documents just underneath will return 2, and so on.

###.OptimizedMode
Indicates whether the Document was initialized with a single SQL query, loading all data in one go, instead of lazy-loading each individual property. 
**Notice:** this indicator does in general not do anything internally.


###.Parent
Returns a `CMSNode` object, representing the Parent document, if no parent is available, an exception will be thrown. **Notice:** `CMSNode` is the object which `Document` inherits from, and does therefore not allow access to all properties.


###.ParentId
Returns the parent `Document` Id as an `Int`

###.Published
Returns a Bool indicating whether the given `Document` is published and available on the website or not. **Notice:** the published flag does not check the current in-memory cache, so this flag is not a guarantee the Document is/is not available in the cache and the website

###.Relations
Returns a `Relation` array with all relations relevant to the given `Document`. This both returns parent and child relations

	var doc = new Documnet(1234);
	foreach(var rel in doc.Relations){
		//returns a Relation object containing type, child, parent and ID
		var child = rel.Child;
		var type = rel.RelType.Alias;
	}
	

###.ReleaseDate
If set, returns `DateTime` indicating when the `Document` should be published and made available on the website and cache.

###.sortOrder
Returns the given `Document` index, compared to sibling documents.

###.Template
Returns the ID of the currently set template as a `Int`

###.Text
Returns the name of the document as a `String`

###.UniqueId
Returns the `Guid` assigned to the Document during creation. This value is unique, and should never change, even if the document moved between instances. 


###.UpdateDate
Returns a `DateTime` object, indicating the last the given Document was updated.

###.User
Returns the `User` who created the Document, same as `Creator`

###.UserId;
Returns the ID of the creator/user, as a `Int`

###.Version;
Returns the current Version ID as a `Guid`, 
For each change made to a document, its values are stored under a new Version. This version is identified by a `Guid`

###.VersionDate
Returns the `DateTime` this specific version was created, not the Document itself.


###.Writer
Returns a `User` object, of the user who made the latest edit on the Document.


##Methods
###.Copy(1233, User, false)
Recreates the given Document as a child of the given Id, a User is based for the audit trailm and a boolean value indicates whether a relation between original and copy should be made. Method returns the copy as a `Document` 
	
	//Get the document to copy
	var doc = new Document(1234);
	//create as a child of node with Id 1234
	doc.Copy(1234, new User(0), true);


###.delete(true)
Deletes the given `Document`, a `Bool` can be passed to indicate whether the Document should be deleted, or simply moved to the Recycle bin, **notice** you will need to remove the document from the cache as well

	var doc = new Document(1223);
	umbraco.library.UnpublishSingleDocument(doc.id);
	doc.delete(true);

###.getProperty(alias)
Returns a `Property` with the given alias. The properties contain the document data, the property data is instantly persisted.  

	var doc = new Document(1234);
	doc.getProperty("bodyText").Value = "<p>hello</p>";
	doc.getProperty("dateField").Valye = DateTime.Now;


###.GetTextPath()
Returns the parent Ids as a path to the given `Document`. If a document exist underneath a Document with ID 1234, which then exist under a document with id 5555, the TextPath returned is -1,5555,1234
 
###.GetVersions()
Returns a `DocumentVersionList` containing all previous versions of the given Document. each version contains a date, the name of the Document, user, and the unque version ID.

	foreach(var version in d.GetVersions()){
 	   var date = version.Date;
	    var name = version.Text;
	    var uniqueId = version.Version
	}

###.HasPendingChanges()
Returns a `Bool` indicating whether there has been any property/data changes since the last time this Document was published. 

###.HasPublishedVersion()
Returns a `Bool` indicating whether the given Document has been published previously.

###.Move(1234)
Moves the Document, and places it as a child under the the Document with the given ID.
	
	//get the document
	var doc = new Document(1234);
	//move it underneath the document with Id 5555
	doc.Move(5555);
	//publish the changes
	doc.Publish()
	umbraco.library.UpdateDocumentCache(doc.Id);

###.Publish(user)
Creates a new Xml Representation of the current Document, and creates a new version of document, for continued editing.
**Notice:** Publishing a document, is a 2 step operation, first exposing a Xml representation of the current state of the document, and afterwards pushing this xml into the in memory xml cache. 

	//Get the document
	var doc = new Document(1234);

	//create and store a xml representation of the document
	doc.Publish(user);

	//tell the runtime to retrieve the xml from the database and store in cache
	umbraco.library.UpdateDocumentCache(doc.Id);
	

###.PublishWithChildrenWithResult(user)
Publishes the given Document using Publish(user) and then performs the same .Publish() on all children.

###.PublishWithResult(user)
Does the same thing as .Publish(user) but returns a `Bool` indicating whether the publish was successfull.

###.PublishWithSubs(user)

###.RemoveTemplate()
Sets the template ID to `Null` on the given Document

###.RollBack(VersionId, user)
Rolls the `Document` back to the version with the a given Version Id. A user must be passed for the Document audit trail. 

###.Save()
Saves the latest changes on the Document. This triggers the Before/After save events. 
**Notice** In v4.x this method is a stub, but from v6.0 it will be required to call to persisst
any changes, so it is recommend to always include .Save() in your code.

###.SendToPublication(user)
Sends the Document to publishing, which triggers notifications to the appropriate admins, subscribing to notifications. Send to publishing, is only used in case the current `User` does not have permission to publish a document.

###.ToPreviewXml(XmlDocument)
Returns a `XmlNode` containing the Document data, based off the latest changes, even unpublished changes, is only used for the internal Preview functionality

###.ToXml(xmldocument, true)
Returns a `XmlNode` containing the Document data, based off the latest published changes. Is used when the published document is send to the in-memory cache.

###.UnPublish()
Sets the Published flag to false, which means the Xml will not be included in the Xml Cache the next time it refreshes. **Notice:** to force the document out of the cache instantly, a call to library.UnpublishSingleNode()

	//get the document
	var doc = new Document(1234);
		
	//remove it from the cache
	umbraco.library.UnpublishSingleNode(doc.id);

	//mark it as unpublished
	doc.UnPublish();
	

###.XmlGenerate(XmlDocument)
Generates a xml representation of the `Document` and saves it in the database.

###.XmlNodeRefresh(XmlDocument, ref XmlNode)
Refreshes the given `XmlNode` with data from the Document properties.

###.XmlPopulate(XmlDocument, ref XmlNode, true)
Populates the given `XmlNode` with data from the Document Properties. A boolean parameter can be passed to indicate whether all child document xml should be append as well. 
