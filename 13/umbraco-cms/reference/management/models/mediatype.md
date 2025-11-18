---
description: "A MediaType is almost the same as a ContentType. I.e. a model / data definition for your media nodes."
---

# MediaType

A MediaType is almost the same as a [ContentType](contenttype.md), that is, a model / data definition for your media nodes

You can set icon, thumbnail and description. It is also possible to add groups and properties.

A Media Type differs from a Document Type in that it has no templates.

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

### new MediaType(IShortStringHelper shortStringHelper, int parentId)

Constructor for creating a new `MediaType` object where the necessary parameters are a short string helper `IShortStringHelper` and the Id of the parent `MediaType` as an `Int`.

### new MediaType(IShortStringHelper shortStringHelper,IMediaType parent)

Constructor for creating a new `MediaType` object where the necessary parameter are a short string helper `IShortStringHelper` and the parent `MediaType` as an `IMediaType` object.

### new MediaType(IShortStringHelper shortStringHelper, IMediaType parent, string alias)

This constructor creates a new `MediaType` object and requires the following parameters: a short string helper `IShortStringHelper` and the parent `MediaType` as an `IMediaType` object. Additionally, the alias of the `MediaType` should be provided as a `string`.

## Properties

### .Alias

Gets or Sets the Alias as a `String` of the MediaType.

```csharp
// Given a `MediaTypeService` object get MediaType by its Id and return Alias
var mediaType = mediaTypeService.Get(1234);
return mediaType.Alias;
```

### .AllowedContentTypes

Gets or Sets an `Enumerable` list of `ContentTypeSort` objects of the MediaTypes allowed under the current MediaType.

The `ContentTypeSort` is an object with a lazy Id, int SortOrder and string Alias used to sort the MediaTypes within the list of AllowedContentTypes.

```csharp
// Given a `MediaTypeService` object get MediaType by its Id and return AllowedContentTypes
var mediaType = mediaTypeService.Get(1234);
return mediaType.AllowedContentTypes;
```

### .ContentTypeComposition

Gets a list of `MediaTypes` as `IContentTypeComposition` objects that make up a composition of PropertyGroups and PropertyTypes for the current MediaType.

The `ContentTypeComposition` provides a mixin-type functionality in that you can compose a MediaType of one or more other MediaTypes in a complex structure. But keep in mind that the backoffice does not fully support these complex structures yet

```csharp
// Given a `MediaTypeService` object get MediaType by its Id and return ContentTypeComposition
var mediaType = mediaTypeService.Get(1234);
return mediaType.ContentTypeComposition;
```

### .CompositionPropertyGroups

Gets a list of all `PropertyGroup` objects from the composition including PropertyGroups from the current MediaType.

```csharp
// Given a `MediaTypeService` object get MediaType by its Id and return CompositionPropertyGroups
var mediaType = mediaTypeService.Get(1234);
return mediaType.CompositionPropertyGroups;
```

### .CompositionPropertyTypes

Gets a list of all `PropertyType` objects from the composition including PropertyTypes from the current MediaType.

```csharp
// Given a `MediaTypeService` object get MediaType by its Id and return CompositionPropertyTypes
var mediaType = mediaTypeService.Get(1234);
return mediaType.CompositionPropertyTypes;
```

### .CreateDate

Gets or Sets a `DateTime` object, indicating then the given MediaType was created.

```csharp
// Given a `MediaTypeService` object get MediaType by its Id and return CreateDate
var mediaType = mediaTypeService.Get(1234);
return mediaType.CreateDate;
```

### .CreatorId

Gets or Sets the Id of the `User` who created the MediaType.

```csharp
// Given a `MediaTypeService` object get MediaType by its Id and return the Id of the Creator
var mediaType = mediaTypeService.Get(1234);
return mediaType.CreatorId;
```

### .Description

Gets or Sets the Description as a `String` for the MediaType.

```csharp
// Given a `MediaTypeService` object get MediaType by its Id and return the Description
var mediaType = mediaTypeService.Get(1234);
return mediaType.Description;
```

### .Icon

Gets or Sets the Icon as a `String` for the MediaType.

```csharp
// Given a `MediaTypeService` object get MediaType by its Id and return the Icon
var mediaType = mediaTypeService.Get(1234);
return mediaType.Icon;
```

### .Id

Retrieves the unique `MediaType` ID as an `Int`. This ID is based on a Database identity field and is therefore not safe to reference in code when moved between different instances.

### .Key

Gets the `Guid` assigned to the MediaType during creation. This value is unique, and should never change, even if the content is moved between instances.

```csharp
// Given a `MediaTypeService` object get MediaType by its Id and return the Key
var mediaType = mediaTypeService.Get(1234);
return mediaType.Key;
```

### .Level

Gets or Sets the given `MediaType` level in the site hierarchy as an `Int`. MediaTypes placed at the root of the tree, will return 1, content right underneath will return 2, and so on.

```csharp
// Given a `MediaTypeService` object get MediaType by its Id and return the Level
var mediaType = mediaTypeService.Get(1234);
return mediaType.Level;
```

### .Name

Gets or Sets the name of the MediaType as a `String`.

```csharp
// Given a `MediaTypeService` object get MediaType by its Id and return its Name
var mediaType = mediaTypeService.Get(1234);
return mediaType.Name;
```

### .ParentId

Gets or Sets the parent `MediaType` Id as an `Int`.

```csharp
// Given a `MediaTypeService` object get MediaType by its Id and return the Id of the Parent MediaType
var mediaType = mediaTypeService.Get(1234);
return mediaType.ParentId;
```

### .Path

Gets or Sets the path of the MediaType as a `String`. This string contains a comma separated list of the ancestor Ids including the current MediaTypes own id at the end of the string.

```csharp
// Given a `MediaTypeService` object get MediaType by its Id and return the Path
var mediaType = mediaTypeService.Get(1234);
return mediaType.Path;
```

### .PropertyGroups

Gets or Sets a `PropertyGroupCollection` containing a list of PropertyGroups for the current MediaType.

```csharp
// Given a `MediaTypeService` object get MediaType by its Id and return PropertyGroups
var mediaType = mediaTypeService.Get(1234);
return mediaType.PropertyGroups;
```

### .PropertyTypes

Gets an `Enumerable` list of PropertyTypes aggregated for all groups within the current MediaType, as well as PropertyTypes not within a group.

```csharp
// Given a `MediaTypeService` object get MediaType by its Id and return PropertyTypes
var mediaType = mediaTypeService.Get(1234);
return mediaType.PropertyTypes;
```

### .SortOrder

Gets the given `MediaType` index, compared to sibling content.

```csharp
// Given a `MediaTypeService` object get MediaType by its Id and return its SortOrder
var mediaType = mediaTypeService.Get(1234);
return mediaType.SortOrder;
```

### .Thumbnail

Gets or Sets the Thumbnail as a `String` for the MediaType.

```csharp
// Given a `MediaTypeService` object get MediaType by its Id and return the Thumbnail
var mediaType = mediaTypeService.Get(1234);
return mediaType.Thumbnail;
```

## Methods

### .AddContentType(IContentTypeComposition mediaType)

Adds a new `MediaType` to the list of composite MediaTypes.

```csharp
// Given a `MediaTypeService` object get a few MediaTypes by their alias
// and add the 'Meta' and 'SEO' MediaTypes to the composition of the 'Video' MediaType.
var metaContentType = mediaTypeService.Get("meta");
var seoContentType = mediaTypeService.Get("seo");
var videoContentType = mediaTypeService.Get("video");
videoContentType.AddContentType(metaContentType);
videoContentType.AddContentType(seoContentType);
mediaTypeService.Save(videoContentType);
```

### .CompositionAliases()

Returns an `Enumerable` list of MediaType aliases as `String` from the current composition.

```csharp
// Given a `MediaTypeService` object get a MediaType by its alias and loop through CompositionAliases
var mediaType = mediaTypeService.Get("video");
var aliases = mediaType.CompositionAliases();
foreach (var alias in aliases)
{
    string a = alias;
}
```

### .CompositionIds()

Returns an `Enumerable` list of MediaType Ids as `Int` from the current composition.

```csharp
// Given a `MediaTypeService` object get a MediaType by its alias and loop through CompositionIds
var mediaType = mediaTypeService.Get("video");
var ids = mediaType.CompositionIds();
foreach (var id in ids)
{
    int i = id;
}
```

### .ContentTypeCompositionExists(string alias)

Checks if a `MediaType` with the supplied alias exists in the list of composite MediaTypes.

```csharp
// Given a `MediaTypeService` object get a MediaType by its alias
// and check if a given MediaType exists in the composition of the 'Video' MediaType.
var mediaType = mediaTypeService.Get("video");
bool result = mediaType.ContentTypeCompositionExists("meta");
```

### .RemoveContentType(string alias)

Removes a `MediaType` with the supplied alias from the list of composite MediaTypes.

```csharp
// Given a `MediaTypeService` object get a MediaType by its alias and
// remove the 'Meta' MediaType from its composition.
var mediaType = mediaTypeService.Get("video");
bool success = mediaType.RemoveContentType("meta");
if (success)
    mediaTypeService.Save(mediaType);
```

### .RemovePropertyType(string propertyTypeAlias)

Removes a `PropertyType` from the current `MediaType`.

```csharp
// Given a `MediaTypeService` object get a MediaType by its alias
// and remove a PropertyType from the list of PropertyTypes.
var mediaType = mediaTypeService.Get("video");
mediaType.RemovePropertyType("uploader");
mediaTypeService.Save(mediaType);
```
