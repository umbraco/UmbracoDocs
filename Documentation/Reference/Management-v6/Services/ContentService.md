#ContentService

**Applies to Umbraco 6.x and newer**

The ContentService acts as a "gateway" to Umbraco data for operations which are related to Content.

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
The ContentService is available through the `ApplicationContext`, but the if you are using a `SurfaceController` or the `UmbracoUserControl` then the ContentService is available through a local `Services` property.

	Services.ContentService

Getting the service through the `ApplicationContext`:

	ApplicationContext.Current.Services.ContentService

##Methods

###.Copy(IContent content, int parentId, bool relateToOriginal, int userId = 0)
Copies an `Content` object by creating a new Content object of the same type and copies all data from the current to the new copy which is returned.

###.CreateContent(string name, int parentId, string contentTypeAlias, int userId = 0)
Creates a `Content` object using the alias of the `ContentType` that this Content is based on.

###.CreateContent(string name, IContent parentId, string contentTypeAlias, int userId = 0)
Creates a `Content` object using the alias of the `ContentType` that this Content is based on.

###.Delete(IContent content, int userId = 0)
Permanently deletes a `Content` object.

###.DeleteContentOfType(int contentTypeId, int userId = 0)
Deletes all content of specified type. All children of deleted content is moved to Recycle Bin.

###.DeleteVersions(int id, DateTime versionDate, int userId = 0)
Permanently deletes versions from an `Content` object prior to a specific date.

###.DeleteVersion(int id, Guid versionId, bool deletePriorVersions, int userId = 0)
Permanently deletes a specific version from an `Content` object.

###.EmptyRecycleBin()
Empties the Recycle Bin by deleting all `Content` that resides in the bin.

###.GetById(int id)
Gets an `Content` object by Id as `Int`.

###.GetById(Guid key)
Gets an `Content` object by Key as `Guid`. The Key corresponds to the 'UniqueId' column in the umbracoNode table in the database.

###.GetContentOfContentType(int id)
Gets an `Enumerable` list of `Content` objects by the Id of the `ContentType`.

###.GetByLevel(int level)
Gets an `Enumerable` list of `Content` objects by Level.

###.GetChildren(int id)
Gets an `Enumerable` list of child `Content` objects by their parents Id.

###.GetVersions(int id)
Gets an `Enumerable` list of an `Content` objects versions by its Id.

###.GetRootContent()
Gets an `Enumerable` list of `Content` objects, which reside at the first level / root.

###.GetContentForExpiration()
Gets an `Enumerable` list of `Content` objects, which has an expiration date greater then today.

###.GetContentForRelease()
Gets an `Enumerable` list of `Content` objects, which has a release date greater then today.

###.GetContentInRecycleBin()
Gets an `Enumerable` list of an `Content` objects, which resides in the Recycle Bin.

###.GetChildrenByName(int parentId, string name)
Gets an `Enumerable` list of `Content` objects by its name or partial name.

###.GetDescendants(int id)
Gets an `Enumerable` list of descendant `Content` objects by Parent Id.

###.GetDescendants(IContent content)
Gets an `Enumerable` list of `Content` objects by Parent Id.

###.GetByVersion(Guid versionId)
Gets a specific version of a `Content` item.

###.GetPublishedVersion(int id)
Gets the published version of a `Content` item.

###.HasChildren(int id)
Checks whether a `Content` item has any children.

###.HasPublishedVersion(int id)
Checks whether an `Content` item has any published versions.

###.IsPublishable(IContent content)
Checks if the passed in `Content` can be published based on the anscestors publish state.

###.MoveToRecycleBin(IContent content, int userId = 0)
Deletes an `Content` object by moving it to the Recycle Bin.

###.Move(IContent content, int parentId, int userId = 0)
Moves an `Content` object to a new location

###.Publish(IContent content, int userId = 0)
Publishes a single `Content` object

###.PublishWithChildren(IContent content, int userId = 0)
Publishes a `Content` object and all its children.

###.Rollback(int id, Guid versionId, int userId = 0)
Rollback an `Content` object to a previous version. This will create a new version, which is a copy of all the old data.

###.RePublishAll(int userId = 0)
Re-Publishes all Content.

###.Save(IContent content, int userId = 0, bool raiseEvents = true)
Saves a single IContent object.

###.Save(IEnumerable<IContent> contents, int userId = 0, bool raiseEvents = true)
Saves an `Enumerable` list of `Content` objects.

###.SaveAndPublish(IContent content, int userId = 0, bool raiseEvents = true)
Saves and Publishes a single `Content` object.

###.UnPublish(IContent content, int userId = 0)
UnPublishes a single `Content` object