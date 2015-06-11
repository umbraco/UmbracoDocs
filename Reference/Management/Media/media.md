#Media
The `Media` class represents a single item in the media tree, its values are
fetched directly from the database, not from the cache. **Notice** the Media class should strictly be used for simple CRUD operations, not complex queries, as it is not flexible nor fast enough for this.

Media is not versioned, unlike Documents 

 * **Namespace:** `umbraco.cms.businesslogic.media` 
 * **assembly:** `cms.dll`
 

All samples in this document will require references to the following dlls:

* cms.dll
* businesslogic.dll

All samples in this document will require the following usings:
    
    using umbraco.cms.businesslogic.media;
    using umbraco.BusinessLogic;


##Properties

###.Children
Returns a `Media[]` containing all Media items just below the given `Media`

    var media = new Media(1234);
    var children = media.Children;


###.ContentType
Returns a `ContentType` object representing the MediaType used by the given `Media`

    //return the alias of the Media type used
    var media = new Media(1234);
    var mediaType = media.ContentType;
    return mediatype.Alias;


###.CreateDateTime;
Returns the `DateTime` object telling when the Media was created.

    var media = Media.MakeNew("name", doctype, user, -1);
    return media.CreateDateTime;


###.getProperties
Returns a `Property[]` containing all property data of the given `Media`, each property has a value, a alias

    var media = new Media(1223);
    foreach(var prop in media.getProperties){
        var value = (DateTime)p.Value;
        var alias = p.PropertyType.Alias;
    } 

###.HasChildren
Returns `Bool` indicating whether the given `Media` has any Medias just below it


###.Id
Returns the unique `Media` Id as a `Int`, this ID is based on a Database identity field, and is therefore not safe to reference in code which are moved between different instances, use UniqueId instead. 

###.IsTrashed
Returns a `Bool` indicating whether the given `Media` is currently in the recycle bin.

###.Level;
Returns the given `Media` level in the site hirachy as an `Int`. Medias placed at the root of the site, will return 1, Medias just underneath will return 2, and so on.

###.Parent
Returns a `CMSNode` object, representing the Parent Media, if no parent is available, an exception will be thrown. **Notice:** `CMSNode` is the object which `Media` inherits from, and does therefore not allow access to all properties.

###.ParentId
Returns the parent `Media` Id as an `Int`

###.Relations
Returns a `Relation` array with all relations relevant to the given `Media`. This both returns parent and child relations

    var media = new Media(1234);
    foreach(var rel in media.Relations){
        //returns a Relation object containing type, child, parent and ID
        var child = rel.Child;
        var type = rel.RelType.Alias;
    }
    

###.sortOrder
Returns the given `Media` index, compared to sibling Medias.

###.Text
Returns the name of the Media as a `String`

###.UniqueId
Returns the `Guid` assigned to the Media during creation. This value is unique, and should never change, even if the Media moved between instances. 

###.User
Returns the `User` who created the Media, same as `Creator`

###.UserId;
Returns the ID of the creator/user, as a `Int`

##Methods
###.Copy(1233, User, false)
Recreates the given Media as a child of the given Id, a User is based for the audit trailm and a boolean value indicates whether a relation between original and copy should be made. Method returns the copy as a `Media` 
    
    //Get the Media to copy
    var media = new Media(1234);
    //create as a child of node with Id 1234
    media.Copy(1234, new User(0), true);


###.delete(true)
Deletes the given `Media`, a `Bool` can be passed to indicate whether the Media should be deleted, or simply moved to the Recycle bin, **notice** you will need to remove the Media from the cache as well

    var media = new Media(1223);
    umbraco.library.UnpublishSingleMedia(media.id);
    media.delete(true);

###.getProperty(alias)
Returns a `Property` with the given alias. The properties contain the Media data, the property data is instantly persisted.  

    var media = new Media(1234);
    media.getProperty("bodyText").Value = "<p>hello</p>";
    media.getProperty("dateField").Value = DateTime.Now;
    media.Save();

###.Move(1234)
Moves the Media, and places it as a child under the the Media with the given ID.
    
    //get the Media
    var media = new Media(1234);
    //move it underneath the Media with Id 5555
    media.Move(5555);
    //publish the changes
    media.Publish()
    umbraco.library.UpdateMediaCache(media.Id);


###.Save()
Saves the latest changes on the Media. This triggers the Before/After save events. 
**Notice** In v4.x this method is a stub, but from v6.0 it will be required to call to persisst any changes, so it is recommend to always include .Save() in your code.

###.ToXml(xmlMedia, true)
Returns a `XmlNode` containing the Media data, based off the latest published changes. Is used when the published Media is send to the in-memory cache.

###.XmlGenerate(XmlMedia)
Generates a xml representation of the `Media` and saves it in the database.

###.XmlNodeRefresh(XmlMedia, ref XmlNode)
Refreshes the given `XmlNode` with data from the Media properties.

###.XmlPopulate(XmlMedia, ref XmlNode, true)
Populates the given `XmlNode` with data from the Media Properties. A boolean parameter can be passed to indicate whether all child Media xml should be append as well. 
