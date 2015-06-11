#Documents

The `Document` object represents a page, as it is stored in the database. All calls to the document api, goes directly to the database. It is therefore **not** recommend to be used a query API, as there are faster alternatives which interacts directly with the in-memory content instead.

All documents are versioned, so on each indiviual change, a new version is stored. Past versions can only be retrieved from the `Document` api, not from the cache. 

 * **Namespace:** `umbraco.cms.businesslogic.web` 
 * **assembly:** `cms.dll`
 

All samples in this document will require references to the following dlls:

* cms.dll
* businesslogic.dll

All samples in this document will require the following usings:
	
	using umbraco.cms.businesslogic.web;
	using umbraco.BusinessLogic;

##Constructor
The Document constructor is used to retrieve a Document object with a given Id or Guid, there are optional parameters, which allows one to control setup and version.

For all constructors, a null is returned if a document is not found with the given id, guid or version.

###Get Document by Id
Retrieves the latest version of a `Document` by its id, which is a Database identity `int`.  
**Notice:** it is recommend to avoid the use of hardcoded Id's in your code, as these will change between environments.

	Document d = new Document(1234); 

###Get Document by Guid
Retrieves the latest version of a `Document` by its guid, which is set on creation 

	Document d = new Document(guid); 

if noSetup is set to true, only the Id, property is set on the returned `Document` object, all other properties will not be loaded.
	
		Document d = new Document(guid, true); 
	 
###Get Document by version
All documents in Umbraco is versioned. So everytime a document is changed, a new version is stored seperately. All versions get a unique Id assigned. The document returned will reflect the state of the document data in that specific version.

	
		Document d = new Document(1234 versionGuid);

##Creating a Document and setting properties
To create and store a `Document` you need a `DocumentType`, calling `MakeNew()` the document is instantly persisted and property values can be set. A property expects a object so any value can be set, however, ensure the datatype associated with the property can handle the valuetype.
	
	DocumentType dt = DocumentType.GetByAlias("Textpage");
	User u = new User(0);
	int parentId = 1234;
	
	Document d = Document.MakeNew("name of document", dt, u, parentId); 
	//set a string
	d.getProperty("bodyText").Value = "Hello";
	//set a date
	d.getProperty("date").Value = DateTime.Now;
	//set a HttpPostedFile 
	d.getProperty("upload").Value = Request.Files[0];
	
	//save the document to the database
	d.Save();
	
	//publish the document
	d.Publish(user);
	
	//Inform the cache it should update
	umbraco.library.UpdateDocumentCache(d.Id);
	
##[Document methods and properties](document.md) 
The `Document` class itself has a big collection of methods and properties, please see the separate [Document](document.md) page for this.


##Static methods
###.CountSubs(1233, false);
Counts the number as a `int` of children below a given document, optional parameter to only return number of published children.

	int result = Document.CountSubs(1233, false);

###.DeleteFromType(type);
Deletes all documents with a given document type

	var dt = DocumentType.GetByAlias("newsArticle");
	Document.DeleteFromType(dt);

###.GetChildrenBySearch(1223, "wat");
Returns children as a `List<Document>` under a given document and filtered by a search string. **notice** this only performs a simple sql `LIKE` against document names and is not recommended as a website search. 

	var list = Document.GetChildrenBySearch(1223, "wat"); 

###.GetChildrenForTree(1233);
Returns children as a `Document[]` under a given document ID. This method is strictly used for the backoffice trees, and can be expected to change status to internal.

	var list = Document.GetChildrenForTree(1233);

###.GetContentFromVersion(new Guid());
Returns a `Content` object from a given version guid, representing the state of the document in this specific version

	Content version = Document.GetContentFromVersion(new Guid());		

###.GetDocumentsForExpiration();
Returns a `Document` array with documents which are ready to be unpublished, due to the removal date set on the document

	var list = Document.GetDocumentsForExpiration();	

###.GetDocumentsForRelease();
Returns a `Document` array with documents, which are ready to be published, due to the publish at date, set on the document.	

	var list = Document.GetDocumentsForRelease();

###.GetDocumentsOfDocumentType(1223);
Returns documents as a `IEnumerable<Document>` using the document type with a give ID. 
	
	var list = Document.GetDocumentsOfDocumentType(1223);

###.GetRootDocuments();
Returns all documents in the root of the content tree as a `Document` array

	var list = Document.GetRootDocuments();

###.Import(1234, new User(0), XmlElement);
Imports data from a `XmlElement` and stores it as a new child `Document`  under the given parent Id. Returns the new document id, as a `Int`. The data format for the xml, can be found under [Packaging](../Packaging/index.md)

	var pageId = Document.Import(1234, new User(0), XmlElement);


###.IsDocument(1234);
Returns a `bool` to indicate whether the given Id is `Document` or not.

	var isDocument = Document.IsDocument(1234);
	
###.MakeNew("name", doctype, User, -1);
Creates a new Document with a given name and a given document type. This method also requires a `User` object to define the document creator, as well as the ID of the parent node. If the document should be placed in the root of the content tree, use the parent Id -1.

	var documentType = DocumentType.GetByAlias("newsArticle");
	var owner = new User("admin");
	var document = Document.MakeNew("My article", documentType, owner , -1); 

###.RegeneratePreviews();
Regenerates the xml file required for document previews used by the runtime. 

	Document.RegeneratePreviews();

###.RemoveTemplateFromDocument(1234);
Sets the template to `NULL` on all documents with the given template Id. This method is triggered on template delete, and should therefore be considered a internal method.

	Document.RemoveTemplateFromDocument(1234); 

###.RePublishAll();
Clears the Xml representation of all documents from the cmsContentXml table and then recreates it for each individual published document in the database.

	Document.RePublishAll();        
