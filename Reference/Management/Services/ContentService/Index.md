---
keywords: services content service
versionFrom: 6.0.0
---
    
# ContentService

:::note
Applies to Umbraco 6.0.0+
:::

The ContentService acts as a "gateway" to Umbraco data for operations which are related to Content.

[Browse the API documentation for ContentService](https://our.umbraco.com/apidocs/csharp/api/Umbraco.Core.Services.ContentService.html).

 * **Namespace:** `Umbraco.Core.Services` 
 * **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statements:

```csharp
using Umbraco.Core;
using Umbraco.Core.Models;
using Umbraco.Core.Services;
```

## Getting the service

If you wish to use use the content service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the content service through a local `Services` property:

```csharp
IContentService contentService = Services.ContentService;
```

In Razor views, you can access the content service through the `ApplicationContext` property:

```csharp
IContentService contentService = ApplicationContext.Services.ContentService;
```

If neither a `Services` property or a `ApplicationContext` property is available, you can also reference the `ApplicationContext` class directly and using the static `Current` property:

```csharp
IContentService contentService = ApplicationContext.Current.Services.ContentService;
```
## Methods

### .AssignContentPermission(IContent entity, char permission, IEnumerable<int> groupIds)
    
Assigns a single permission to the current content item for the specified group ids.

### .BuildXmlCache()

This builds the Xml document used for the XML cache.

### .Copy(IContent content, int parentId, bool relateToOriginal, bool recursive, int userId = 0)

Copies an `IContent` object by creating a new `Content` object of the same type and copies all data from the current to the new copy which is returned.

### .Copy(IContent content, int parentId, bool relateToOriginal, int userId = 0)

Copies an `IContent` object by creating a new `Content` object of the same type and copies all data from the current to the new copy which is returned. Recursively copies all children.

### .Count(String)

### .CountChildren(int parentId, string contentTypeAlias = null)

Returns the number of child nodes for a provided node id. Optional string parameter for specifying a content type alias to only include nodes of this type.

### .CountDescendants(int parentId, string contentTypeAlias = null)

Returns the number of descendant nodes for a provided node id. Optional string parameter for specifying a content type alias to only include nodes of this type.

### .CountPublished(string contentTypeAlias = null)

Returns number of published items. Optional string parameter for specifying content type alias to only include nodes of this type.

### .CreateContent(string name, Guid parentId, string contentTypeAlias, int userId = 0)

Creates an `IContent` object using the alias of the `IContent` that this Content should based on. Paramters are for: node name, parent guid, content type alias, user id.

### .CreateContent(string name, int parentId, string contentTypeAlias, int userId = 0)

Creates an `IContent` object using the alias of the `IContent` that this Content should based on. Paramters are for: node name, parent id, content type alias, user id.

### .CreateContent(string name, IContent parent, string contentTypeAlias, int userId = 0)

Creates an `IContent` object using the alias of the `IContent` that this Content should based on.

### .CreateContentFromBlueprint(IContent blueprint, string name, int userId = 0)

### .CreateContentWithIdentity(string name, int parentId, string contentTypeAlias, int userId = 0)

Creates and saves an `IContent` object using the alias of the `IContent` that this Content should based on.

### .CreateContentWithIdentity(string name, IContent parent, string contentTypeAlias, int userId = 0)

Creates and saves an `IContent` object using the alias of the `IContent` that this Content should based on.

### .Delete(IContent content, int userId = 0)

Permanently deletes an IContent object as well as all of its Children.

### .DeleteBlueprint(IContent content, int userId = 0)

### .DeleteBlueprintsOfType(int contentTypeId, int userId = 0)

### .DeleteBlueprintsOfTypes(IEnumerable<int> contentTypeIds, int userId = 0)
    
### .DeleteContentOfType(int contentTypeId, int userId = 0)

Deletes all content of specified type. All children of deleted content is moved to Recycle Bin.

### .DeleteContentOfTypes(IEnumerable<int> contentTypeIds, int userId = 0)
    
Deletes all content of the specified types. All Descendants of deleted content that is not of these types is moved to Recycle Bin.

### .DeleteVersion(int id, Guid versionId, bool deletePriorVersions, int userId = 0)

Permanently deletes specific version(s) from an `IContent` object. This method will never delete the latest version of a content item.

### .DeleteVersions(int id, DateTime versionDate, int userId = 0)

Permanently deletes versions from an `IContent` object prior to a specific date. This method will never delete the latest version of a content item.

### .EmptyRecycleBin()
Empties the Recycle Bin by deleting all `IContent` that resides in the bin.

### .GetAncestors(int id)
Gets a collection of `IContent` objects, which are ancestors of the current content.

### .GetAncestors(IContent content)
Gets a collection of IContent objects, which are ancestors of the current content.

### .GetBlueprintById(Guid id)

### .GetBlueprintById(int id)

### .GetBlueprintsForContentTypes(params int[] documentTypeIds)

### .GetById(Guid key)

Gets an `IContent` object by its 'UniqueId'

### .GetById(int id)

Gets an `IContent` object by Id

### .GetByIds(IEnumerable<Guid> ids)

Gets `IContent` objects by Ids.

### .GetByIds(IEnumerable<int> ids)

Gets `IContent` objects by Ids.

### .GetByLevel(int level)

Gets a collection of `IContent` objects by Level.

### .GetByVersion(Guid versionId)

Gets a specific version of an `IContent` item.

### .GetChildren(int id)

Gets a collection of `IContent` objects by Parent Id.

### .GetChildrenByName(int parentId, string name)
    
Gets a collection of `IContent` objects by its name or partial name.

### .GetContentForExpiration()

Gets a collection of `IContent` objects, which has an expiration date less than or equal to today.

### .GetContentForRelease()

Gets a collection of `IContent` objects, which has a release date less than or equal to today.

### .GetContentInRecycleBin()

Gets a collection of an `IContent` objects, which resides in the Recycle Bin.

### .GetContentOfContentType(int id)

Gets a collection of `IContent` objects by the Id of the `IContent`.

### .GetDescendants(int id)

Gets a collection of `IContent` objects by Parent Id.

### .GetDescendants(IContent content)

Gets a collection of `IContent` objects based on the provided `IContent`.


### .GetPagedChildren(int id, long pageIndex, int pageSize, out long totalChildren, string orderBy, Direction orderDirection, bool orderBySystemField, string filter)


### .GetPagedChildren(int id, long pageIndex, int pageSize, out long totalChildren, string orderBy, Direction orderDirection, string filter = "")


### .GetPagedDescendants(int id, long pageIndex, int pageSize, out long totalChildren, string orderBy, Direction orderDirection, bool orderBySystemField, string filter)


### .GetPagedDescendants(int id, long pageIndex, int pageSize, out long totalChildren, string orderBy, Direction orderDirection, bool orderBySystemField, IQuery<IContent> filter)
    
### .GetPagedDescendants(int id, long pageIndex, int pageSize, out long totalChildren, string orderBy = "path", Direction orderDirection = Direction.Ascending, string filter = "")

### .GetPagedXmlEntries(string path, long pageIndex, int pageSize, out long totalRecords)

Gets paged content descendants as XML by path.

### .GetParent(int id)

Gets the parent of the current content as an `IContent` item.

### .GetParent(IContent content)

Gets the parent of the current content as an `IContent` item.

### .GetPermissionsForEntity(IContent content)

Returns implicit/inherited permissions assigned to the content item for all user groups

### .GetPublishedVersion(int id)

Gets the published version of an `IContent` item.

### .GetPublishedVersion(IContent content)

Gets the published version of a `IContent` item.

### .GetRootContent()

Gets a collection of `IContent` objects, which reside at the first level / root.

### .GetVersionIds(int id, int maxRows)

Gets a list of all version Ids for the given content item ordered so latest is first.

### .GetVersions(int id)

Gets a collection of an `IContent` objects versions by Id.

### .HasChildren(int id)

Checks whether an `IContent` item has any children.

### .HasPublishedVersion(int id)

Checks whether an `IContent` item has any published versions.

### .IsPublishable(IContent content)

Checks if the passed in `IContent` can be published based on the anscestors publish state.

### .Move(IContent content, int parentId, int userId = 0)

Moves an `IContent` object to a new location by changing its parent id.

### .MoveToRecycleBin(IContent content, int userId = 0)

Deletes an `IContent` object by moving it to the Recycle Bin.

### .Publish(IContent content, int userId = 0)

Publishes a single `IContent` object

### .PublishWithChildrenWithStatus(IContent content, int userId = 0, bool includeUnpublished = false)

Publishes a `IContent` object and all its children.

### .PublishWithStatus(IContent content, int userId = 0)

Publishes a single `IContent` object.

### .RebuildXmlStructures(params int[] contentTypeIds)

Rebuilds all xml content in the cmsContentXml table for all documents.

### .ReplaceContentPermissions(EntityPermissionSet permissionSet)


### .RePublishAll(int userId = 0)

This will rebuild the xml structures for content in the database.

### .Rollback(int id, Guid versionId, int userId = 0)

Rollback an `IContent` object to a previous version. This will create a new version, which is a copy of all the old data.

### .Save(IEnumerable<IContent> contents, int userId = 0, bool raiseEvents = true)

Saves a collection of IContent objects.

### .Save(IContent content, int userId = 0, bool raiseEvents = true)

Saves a single `IContent` object.


### .SaveAndPublishWithStatus(IContent content, int userId = 0, bool raiseEvents = true)

Saves and Publishes a single `IContent` object.

### .SaveBlueprint(IContent content, int userId = 0)


### .SendToPublication(IContent content, int userId = 0)

Sends an `IContent` to Publication, which executes handlers and events for the 'Send to Publication' action.

### .Sort(IEnumerable<IContent> items, int userId = 0, bool raiseEvents = true)

Sorts a collection of `IContent` objects by updating the SortOrder according to the ordering of items in the passed in System.Collections.Generic.IEnumerable<T>.

### .Sort(int[] ids, int userId = 0, bool raiseEvents = true)

Sorts a collection of `IContent` objects by updating the SortOrder according to the ordering of node Ids passed in.

### .UnPublish(IContent content, int userId = 0)

UnPublishes a single `IContent` object.
