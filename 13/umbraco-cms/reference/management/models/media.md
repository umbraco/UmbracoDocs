---
description: The Media class represents a single item in the media tree.
---

# Media

The `Media` class represents a single item in the media tree, its values are fetched directly from the database, not from the cache. **Notice** the Media class should strictly be used for CRUD operations. Media is already stored in cache, so for querying Media you'd want to use the `IUmbracoContext.IPublishedMediaCache` to get the media. Then one would use [LINQ to query and filter the collection](../../querying/ipublishedcontent/collections.md).

* **Namespace:** `Umbraco.Cms.Core.Models`
* **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statements:

```csharp
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Services;
```

## Constructors

### new Media(string name, IMedia parent, IMediaType mediaType)

Constructor for creating a new Media object where the necessary parameters are the name of the Media, the parent of the Media as an `IMedia` object and the MediaType as an `IMediaType` object for the Media being created.

### new Media(string name, IMedia parent, IMediaType mediaType, IPropertyCollection properties)

Constructor for creating a new Media object where the necessary parameters are the name of the Media, the parent of the Media as an `IMedia` object, the MediaType as an `IMediaType` object and a `IPropertyCollection` for the Media being created.

### new Media(string name, int parentId, IMediaType mediaType)

Constructor for creating a new Media object where the necessary parameters are the name of the Media, the id of the parent as `int` and the MediaType as an `IMediaType` object for the Media being created.

### new Media(string name, int parentId, IMediaType mediaType, IPropertyCollection properties)

Constructor for creating a new Media object where the necessary parameters are the name of the Media, the id of the parent as `int`, the MediaType as an `IMediaType` object and a `IPropertyCollection` for the Media being created.

## Properties

### .CreateDate

Gets or Sets a `DateTime` object, indicating then the given Media was created.

```csharp
// Given a `MediaService` object get Media by its Id and return CreateDate
var media = mediaService.GetById(1234);
return media.CreateDate;
```

### .CreatorId

Gets or Sets the Id of the `User` as an `int` who created the Media.

```csharp
// Given a `MediaService` object get Media by its Id and return the Id of the Creator
var media = mediaService.GetById(1234);
return media.CreatorId;
```

### .ContentType

Returns a `ISimpleContentType` object representing the ContentType used by the given `Media`.

```csharp
// Given a `MediaService` object get Media by its Id and return MediaType
var media = mediaService.GetById(1234);
return media.ContentType;
```

### .ContentTypeId

Returns the id as an `int` of the `MediaType` object representing the ContentType used by the given `Media`.

```csharp
// Given a `MediaService` object get Media by its Id and return the Id of the MediaType
var media = mediaService.GetById(1234);
return media.ContentTypeId;
```

### .Id

Returns the unique `Media` Id as a `Int`, this ID is based on a Database identity field, and is therefore not safe to reference in code which are moved between different instances, use Key instead.

### .Key

Returns the `Guid` assigned to the Media during creation. This value is unique, and should never change, even if the Media is moved between instances.

```csharp
// Given a `MediaService` object get Media by its Id and return the Key
var media = mediaService.GetById(1234);
return media.Key;
```

### .Level

Gets or Sets the given `Media` level in the site hierarchy as an `Int`. Media placed at the root of the tree, will return 1, Media right underneath will return 2, and so on.

```csharp
// Given a `MediaService` object get Media by its Id and return the Level
var media = mediaService.GetById(1234);
return media.Level;
```

### .Name

Gets or Sets the name of the Media as a `String`.

```csharp
// Given a `MediaService` object get Media by its Id and return its Name
var media = mediaService.GetById(1234);
return media.Name;
```

### .ParentId

Gets or Sets the parent `Media` Id as an `Int`.

```csharp
// Given a `MediaService` object get Media by its Id and return the Id of the Parent Media
var media = mediaService.GetById(1234);
return media.ParentId;
```

### .Path

Gets or Sets the path of the Media as a `String`. This string contains a comma separated list of the ancestors Ids including the current medias own id at the end of the string.

```csharp
// Given a `MediaService` object get Media by its Id and return the Path
var media = mediaService.GetById(1234);
return media.Path;
```

### .Properties

Gets or Sets the `PropertyCollection` object, which is a collection of `Property` objects. Each property corresponds to a `PropertyType`, which is defined on the `MediaType`.

```csharp
// Given a `MediaService` object get Media by its Id and loop through all Properties
var media = mediaService.GetById(1234);
foreach(var property in media.Properties){
    string alias = property.Alias;
    object value = property.GetValue();
}
```

### .SortOrder

Returns the given `Media` index, compared to sibling media.

```csharp
// Given a `MediaService` object get Media by its Id and return its SortOrder
var media = mediaService.GetById(1234);
return media.SortOrder;
```

### .Trashed

Returns a `Bool` indicating whether the given `Media` is currently in the recycle bin.

```csharp
// Given a `MediaService` object get Media by its Id and return Trashed
var media = mediaService.GetById(1234);
return media.Trashed;
```

### .UpdateDate

Gets or Sets a `DateTime` object, indicating when the given Media was last updated.

```csharp
// Given a `MediaService` object get Media by its Id and return UpdateDate
var media = mediaService.GetById(1234);
return media.UpdateDate;
```

### .Version

Returns the current Version Id as a `Guid`,\
For each change made to a Media item, its values are stored under a new Version. This version is identified by a `Guid`.

## Methods

### .ChangeContentType(IMediaType mediaType)

Changes the `IMediaType` for the current Media object and removes PropertyTypes and Properties, which are not part of the new `MediaType`. **Please use with caution** as this remove differences between the new and old MediaType.

```csharp
// Given a `ContentTypeService` object get the MediaType that we're changing to,
// get the Media from the `MediaService` for which we want to change MediaType for,
// and then save the Media through the MediaService.
var mediaType = contentTypeService.GetMediaType(1122);
var media = mediaService.GetById(1234);
media.ChangeContentType(mediaType);
mediaService.Save(media);
```

### .GetCreatorProfile()

Gets the `IProfile` object for the Creator of this Media, which contains the Id and Name of the User who created this Media item.

```csharp
// Given a `MediaService` object get Media by its Id and get the `IProfile` of the Creator
var media = mediaService.GetById(1234);
var profile = media.GetCreatorProfile();
var id = profile.Id;
string name = profile.Name;
```

### .GetValue(string propertyTypeAlias)

Gets the value of a Property as an `Object`.

```csharp
// Given a `MediaService` object get Media by its Id and get a value by alias
var media = mediaService.GetById(1234);
object value = media.GetValue("height");
int text = int.Parse(value.ToString());
```

### .GetValue< TPassType >(string propertyTypeAlias)

Gets the value of a Property as the defined type 'TPassType'.

```csharp
// Given a `MediaService` object get Media by its Id and get a value by alias while specifying the return type
var media = mediaService.GetById(1234);
int value = media.GetValue<int>("height");
```

### .HasProperty(string propertyTypeAlias)

Returns a `Bool` indicating whether the Media object has a property with the supplied alias.

```csharp
// Given a `MediaService` object get Media by its Id and check if certain properties exist
var media = mediaService.GetById(1234);
bool tagsExists = media.HasProperty("myTagProperty");
bool textExists = media.HasProperty("altText");
```

### .SetValue(string propertyTypeAlias, object value)

Sets the value of a property by its alias.

```csharp
// Given a `MediaService` object get Media by its Id, set a few values
// and saves the Media through the `MediaService`
var media = mediaService.GetById(1234);
media.SetValue("altText", "Alternative text for this media item");
media.SetValue("date", DateTime.Now);
mediaService.Save(media);
```

It is worth noting that it is also possible to pass a HttpPostedFile, HttpPostedFileBase or HttpPostedFileWrapper to the SetValue method, so it can be used for uploads.

### .ToXml()

Returns an `XElement` containing the Media data, based off the latest changes. When the Media item is saved the xml is stored in the database.

```csharp
// Given a `MediaService` object get Media by its Id and returns the xml
var media = mediaService.GetById(1234);
XElement xml = media.ToXml(serializer);
return xml;
```
