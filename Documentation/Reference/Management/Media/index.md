#Medias

The `Media` object represents a item in the media tree, as it is stored in the database. All calls to the media api, goes directly to the database. It is therefore **not** recommend to be used a query API, as there are faster alternatives which interacts directly with the in-memory content instead.

 * **Namespace:** `umbraco.cms.businesslogic.media` 
 * **assembly:** `cms.dll`


All samples in this document will require references to the following dlls:

* cms.dll
* businesslogic.dll

All samples in this document will require the following usings:
    
    using umbraco.cms.businesslogic.media;
    using umbraco.BusinessLogic;

##Constructor
The Media constructor is used to retrive a Media object with a given Id or Guid, there are optional parameters, which allows one to control setup and version.

For all constructors, a null is returned if a Media is not found with the given id, guid or version.

###Get Media by Id
Retrieves the latest version of a `Media` by its id, which is a Database identity `int`.  
**Notice:** it is recommend to avoid the use of hardcoded Id's in your code, as these will change between environments.

    Media d = new Media(1234); 

###Get Media by Guid
Retrieves the latest version of a `Media` by its guid, which is set on creation 

    Media d = new Media(guid); 

if noSetup is set to true, only the Id, property is set on the returned `Media` object, all other properties will not be loaded.
    
        Media d = new Media(guid, true); 

##Creating a Media item and setting properties
To create and store a `Media` you need a `MediaType`, calling `MakeNew()` the media is instantly persisted and property values can be set. A property expects a object so any value can be set, however, ensure the datatype associated with the property can handle the valuetype.
	
	MediaType dt =MediaType.GetByAlias("Textpage");
	User u = new User(0);
	int parentId = 1234;
	
	Media d = Media.MakeNew("name of media", dt, u, parentId); 
	//set a string
	d.getProperty("bodyText").Value = "Hello");
	//set a date
	d.getProperty("date").Value = DateTime.Now;
	//set a HttpPostedFile 
	d.getProperty("umbracoFile").Value = Request.Files[0];
	
	//persist changes to the database
	d.Save();
	

##[Media methods and properties](media.md) 
The `Media` class itself has a big collection of methods and properties, please see the separate [Media](media.md) page for this.


##Static methods
###.CountSubs(1233, false);
Counts the number as a `int` of children below a given Media, optional parameter to only return number of published children.

    int result = Media.CountSubs(1233, false);

###.DeleteFromType(type);
Deletes all Medias with a given Media type

    var dt = MediaType.GetByAlias("newsArticle");
    Media.DeleteFromType(dt);

###.GetChildrenForTree(1233);
Returns children as a `Media[]` under a given media ID. This method is strictly used for the backoffice trees, and can be expected to change status to internal.

    var list = Media.GetChildrenForTree(1233);

###.GetMediaOfMediaType(1223);
Returns media items as a `IEnumerable<Media>` using the media type with a give ID. 
    
    var list = Media.GetMediasOfMediaType(1223);

###.GetRootMedia();
Returns all Medias in the root of the tree as a `Media` array

    var list = Media.GetRootMedia();

    
###.MakeNew("name", mediatype, User, -1);
Creates a new Media with a given name and a given media type. This method also requires a `User` object to define the media creator, as well as the ID of the parent node. If the media should be placed in the root of the content tree, use the parent Id -1.

    var mediaType = MediaType.GetByAlias("newsArticle");
    var owner = new User("admin");
    var Media = Media.MakeNew("My article", MediaType, owner , -1); 

###.RegeneratePreviews();
Regenerates the xml file required for Media previews used by the runtime. 

    Media.RegeneratePreviews();
