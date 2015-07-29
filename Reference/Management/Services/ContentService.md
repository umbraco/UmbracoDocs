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

###.AssignContentPermission(IContent content, char permission, IEnumerable<int> userIds)
Assigns a single permission to the current `Content` object for the specified list of user IDs.

###.Copy(IContent content, int parentId, bool relateToOriginal, _[int userId = 0]_)
Copies an `Content` object by creating a new `Content` object of the same type and copies all data from the current to the new copy which is returned.

###.Count(_[string contentTypeAlias = null]_)
Count all `Content` objects with given `ContentType`.

###.CountChildren(int parentId, _[string contentTypeAlias = null]_)
Count all Children for given parent `Content` object with `ContentType`.

###.CountDescendants(int parentId, _[string contentTypeAlias = null]_)
Count all Descendants for given parent `Content` object with `ContentType`.

###.CountPublished(_[string contentTypeAlias = null]_)
Count all `Content` objects Published with `ContentType`.

###.CreateContent(string name, int parentId, string contentTypeAlias, _[int userId = 0]_)
Creates a `Content` object using the alias of the `ContentType` that this Content is based on.

###.CreateContent(string name, IContent parentId, string contentTypeAlias, _[int userId = 0]_)
Creates a `Content` object using the alias of the `ContentType` that this Content is based on.

###.CreateContentWithIdentity(string name, IContent parent, string contentTypeAlias, _[int userId = 0]_)
Creates and saves an `Content` object using the alias `ContentType` that this `Content` should be based on.

###.CreateContentWithIdentity(string name, int parentId, string contentTypeAlias, _[int userId = 0]_)
Creates and saves an `Content` object using the alias `ContentType` that this `Content` should be based on.

###.Delete(IContent content, _[int userId = 0]_)
Permanently deletes a `Content` object.

###.DeleteContentOfType(int contentTypeId, _[int userId = 0]_)
Deletes all content of specified type. All children of deleted content is moved to Recycle Bin.

###.DeleteVersion(int id, Guid versionId, bool deletePriorVersions, _[int userId = 0]_)
Permanently deletes a specific version from an `Content` object.

###.DeleteVersions(int id, DateTime versionDate, _[int userId = 0]_)
Permanently deletes versions from an `Content` object prior to a specific date.

###.EmptyRecycleBin()
Empties the Recycle Bin by deleting all `Content` that resides in the bin.

###.GetAncestors(IContent content)
Gets an `Enumerable` list of `Content` objects for given `Content` object.

###.GetAncestors(int id)
Gets an `Enumerable` list of `Content` objects for given `Content` object ID.

###.GetById(int id)
Gets an `Content` object by Id as `Int`.

###.GetById(Guid key)
Gets an `Content` object by Key as `Guid`. The Key corresponds to the 'UniqueId' column in the umbracoNode table in the database.

###.GetByIds(IEnumerable<int> ids)
Gets an `Enumerable` list of `Content` objects for given `Enumerable` list of `Content` object IDs.

###.GetContentOfContentType(int id)
Gets an `Enumerable` list of `Content` objects by the Id of the `ContentType`.

###.GetByLevel(int level)
Gets an `Enumerable` list of `Content` objects by Level.

###.GetChildren(int id)
Gets an `Enumerable` list of child `Content` objects by their parents Id.

###.GetRootContent()
Gets an `Enumerable` list of `Content` objects, which reside at the first level / root.

###.GetVersions(int id)
Gets an `Enumerable` list of an `Content` objects versions by its Id.

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

###.GetPagedChildren(int id, int pageIndex, int pageSize, out int totalChildren, string orderBy, Direction orderDirection, _[string filter = ""]_)
Gets an `Enumerable` list of `Content` child objects, paged.

###.GetPagedDescendants(int id, int pageIndex, int pageSize, out int totalChildren, _[string orderBy = "Path"]_, _[Direction orderDirection = Direction.Ascending]_, _[string filter = ""]_)
Gets an `Enumerable` list of `Content` descendant objects, paged.

###.GetParent(IContent content)
Get parent `Content` object, by `Content` object.

###.GetParent(int id)
Get parent `Content` object, by `Content` ID.

###.GetPermissionsForEntity(IContent content)
Gets a collection of `EntityPermission` permission objects for the `Content` item.

###.GetPublishedVersion(int id)
Gets the published version of a `Content` item.

###.GetRootContent()
Gets a collection of `Content` objects, which reside at the first level / root

###.HasChildren(int id)
Checks whether a `Content` item has any children. Returns a `bool`.

###.HasPublishedVersion(int id)
Checks whether an `Content` item has any published versions. Returns a `bool`.

###.IsPublishable(IContent content)
Checks if the passed in `Content` can be published based on the ancestors publish state. Returns a `bool`.

###.Move(IContent content, int parentId, _[int userId = 0]_)
Moves an `Content` object to a new location.

###.MoveToRecycleBin(IContent content, _[int userId = 0]_)
Deletes an `Content` object by moving it to the Recycle Bin.

###.Publish(IContent content, _[int userId = 0]_)
Publishes a single `Content` object

###.PublishWithChildren(IContent content, _[int userId = 0]_)
Publishes a `Content` object and all its children.

###.PublishWithChildrenWithStatus(IContent content, _[int userId = 0]_, _[bool includeUnpublished = false]_)
Publishes a `Content` object and all its children, returning a collection of `<Attempt<PublishStatus>>`.

###.PublishWithStatus(IContent content, _[int userId = 0]_)
Publishes a `Content` object, returning the result as a `Attempt<PublishStatus>`.

###.RebuildXmlStructures(params int[] contentTypeIds)
Rebuilds all xml content in the cmsContentXml table for all documents matching the IDs passed in. If none then rebuilds the structures for all content.

###.ReplaceContentPermissions(EntityPermissionSet permissionSet)
Replaces the `PermissionSet` for Content.

###.RePublishAll(_[int userId = 0]_)
Re-Publishes all Content.

###.Rollback(int id, Guid versionId, _[int userId = 0]_)
Rollback an `Content` object to a previous version. This will create a new version, which is a copy of all the old data.

###.Save(IContent content, _[int userId = 0]_, _[bool raiseEvents = true]_)
Saves a single IContent object.

###.Save(IEnumerable<IContent> contents, _[int userId = 0]_, _[bool raiseEvents = true]_)
Saves an `Enumerable` list of `Content` objects.

###.SaveAndPublish(IContent content, _[int userId = 0]_, _[bool raiseEvents = true]_)
Saves and Publishes a single `Content` object.

###.SaveAndPublishWithStatus(IContent content, _[int userId = 0]_, _[bool raiseEvents = true]_)
Saves and Publishes a single `Content` object, returning the result as a `Attempt<PublishStatus>`.

###.SendToPublication(IContent content, _[int userId = 0]_)
Sends a `Content` item to Publication, which executes handlers and events for the 'Send to Publication' action.
Returns `True` if sending publication was succesful, otherwise `False`.

###.Sort(IEnumerable<IContent> items, _[int userId = 0]_, _[bool raiseEvents = true]_)
Sorts a collection `Content` objects by updating the SortOrder according to the ordering of items in the passed in System.Collections.Generic.IEnumerable<T>. Returns `True` if sorting succeeded, otherwise `False`. Using this method will ensure that the Published-state is maintained upon sorting so the cache is updated accordingly - as needed.

###.UnPublish(IContent content, _[int userId = 0]_)
UnPublishes a single `Content` object.
