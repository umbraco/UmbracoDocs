#MediaService

**Applies to Umbraco 6.x and newer**

The MediaService acts as a "gateway" to Umbraco data for operations which are related to Media.

 * **Namespace:** `Umbraco.Core.Services` 
 * **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following usings:
	
	using Umbraco.Core;
	using Umbraco.Core.Models;
	using Umbraco.Core.Services;

**Please note that this page will be updated with samples and additional information about the methods listed below**

##Getting the service
The MediaService is available through the `ApplicationContext`, but the if you are using a `SurfaceController` or the `UmbracoUserControl` then the MediaService is available through a local `Services` property.

	Services.MediaService

Getting the service through the `ApplicationContext`:

	ApplicationContext.Current.Services.MediaService

##Methods

###.CreateMedia(string name, int parentId, string mediaTypeAlias, [int userId = 0])
Creates an `Media` object using the alias of the `MediaType` that this Media is based on.

Example for methods **CreateMedia** and **Save**, creating a new `Media` object (as a child of `Media` rootnode -1);
	
        if (ApplicationContext.Current != null)
        {
            var ms = ApplicationContext.Current.Services.MediaService;
            //Use the MediaService to create a new Media object (-1 is Id of root Media object, "Folder" is the MediaType)
            var mediaMap = ms.CreateMedia("Test", -1, "Folder");
            //Use the MediaService to Save the new Media object
            ms.Save(mediaMap);
        }

###.CreateMedia(string name, Umbraco.Core.Models.IMedia parent, string mediaTypeAlias, [int userId = 0])
Creates an `Media` object using the alias of the `MediaType` that this Media is based on.

###.GetById(int id)
Gets an `Media` object by Id.

###.GetById(Guid key)
Gets an `Media` object by its 'UniqueId'.

###.GetChildren(int parentId)
Gets a `Enumerable` list of `Media` objects by parent Id.

###.GetDescendants(int parentId)
Gets `Enumerable` list descendants of a `Media` object by its parent Id.

###.GetMediaOfMediaType(int id)
Gets a `Enumerable` list of `Media` objects by the Id of the `MediaType`.

###.GetRootMedia()
Gets a `Enumerable` list of `Media` objects, which reside at the first level / root.

###.GetMediaInRecycleBin()
Gets a `Enumerable` list of `Media` objects, which reside in the Recycle Bin.

###.Move(Umbraco.Core.Models.IMedia media, int parentId, int userId)
Moves an `Media` object to a new location, determined by (location of) parentId.

###.MoveToRecycleBin(Umbraco.Core.Models.IMedia media, int userId)
Deletes an `Media` object by moving it to the Recycle Bin.

###.EmptyRecycleBin()
Empties the Recycle Bin by deleting all `Media` that resides in the Recycle Bin.

###.DeleteMediaOfType(int mediaTypeId, [int userId = 0])
Deletes all media of specified type. All children of deleted media is moved to Recycle Bin.

###.Delete(Umbraco.Core.Models.IMedia media, [int userId = 0])
Permanently deletes an `Media` object.
Please note that this method will completely remove the Media from the database, but not from the file system!

###.Save(Umbraco.Core.Models.IMedia media, int userId, [bool raiseEvents = true])
Saves a single `Media` object.

###.Save(IEnumerable<Umbraco.Core.Models.IMedia> medias, int userId, [bool raiseEvents = true])
Saves a `Enumerable` list of `Media` objects.

###.GetByLevel(int level)
Gets a `Enumerable` list of <see cref="T:Umbraco.Core.Models.IMedia"/> objects by Level.

###.GetByVersion(Guid versionId)
Gets a specific version of an `Media` item.

###.GetVersions(int id)
Gets a `Enumerable` list of an `Media` objects versions by Id.

###.HasChildren(int id)
Checks whether an `Media` item has any children.

###.DeleteVersions(int id, DateTime versionDate, [int userId = 0])
Permanently deletes versions from an `Media` object prior to a specific date.

###.DeleteVersion(int id, Guid versionId, bool deletePriorVersions, [int userId = 0])
Permanently deletes specific version(s) from an `Media` object.

###.GetMediaByPath(string mediaPath)
Gets an `Media` object from the path stored in the 'umbracoFile' property.
Parameter mediaPath being for example /media/1024/koala_403x328.jpg.
