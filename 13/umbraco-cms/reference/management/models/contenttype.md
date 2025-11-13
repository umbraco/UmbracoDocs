---
description: "A ContentType corresponds to the Document Type found in the backoffice."
---

# ContentType

A ContentType corresponds to the Document Type found in the backoffice. The ContentType is a model / data definition for your content nodes. Every content node on an Umbraco web site always maps to a backing Document Type.

A Document Type is composed by Properties, which are grouped by Tabs (or PropertyGroups in the API). It can also inherit properties and tabs from other Document Types.

It is possible to link one or more Templates to a Document Type. This determines how your model/data is rendered to the user.

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

### ContentType(IShortStringHelper shortStringHelper, IContentType parent, string alias)

Constructor for creating a new `ContentType` object. The necessary parameters are a short string helper `IShortStringHelper`, the parent `ContentType` as an `IContentType` and the alias of the new `ContentType` as `string`.

### new ContentType(IShortStringHelper shortStringHelper, int parentId)

Constructor for creating a new `ContentType` object where the necessary parameters are a short string helper `IShortStringHelper` and the Id of the parent `ContentType` as an `Int`.

## Properties

### .Alias

Gets or Sets the Alias as a `String` of the ContentType.

```csharp
// Given a `ContentTypeService` object get ContentType by its Id and return Alias
var contentType = contentTypeService.Get(1234);
return contentType.Alias;
```

### .AllowedAsRoot

Gets or Sets a `Bool` indicating whether this ContentType is allowed at the root. If one or more ContentTypes are set to 'AllowedAsRoot' only they are shown in the create dialog at the root level in the backoffice.

```csharp
// Given a `ContentTypeService` object get ContentType by its Id and return AllowedAsRoot
var contentType = contentTypeService.Get(1234);
return contentType.AllowedAsRoot;
```

### .AllowedContentTypes

Gets or Sets an `Enumerable` list of `ContentTypeSort` objects of the ContentTypes allowed under the current ContentType.

The `ContentTypeSort` is an object with a lazy Id, int SortOrder and string Alias used to sort the MediaTypes within the list of AllowedContentTypes.

```csharp
// Given a `ContentTypeService` object get ContentType by its Id and return AllowedContentTypes
var contentType = contentTypeService.Get(1234);
return contentType.AllowedContentTypes;
```

### .AllowedTemplates

Gets or Sets an `Enumerable` list of `ITemplates` which are allowed for the current ContentType.

```csharp
// Given a `ContentTypeService` object get ContentType by its Id and return AllowedTemplates
var contentType = contentTypeService.Get(1234);
return contentType.AllowedTemplates;
```

### .ContentTypeComposition

Gets a list of `ContentTypes` as `IContentTypeComposition` objects that make up a composition of PropertyGroups and PropertyTypes for the current ContentType.

The ContentTypeComposition provides a mixin-type functionality in that you can compose a ContentType of one or more other ContentTypes in a complex structure. But be aware that the backoffice does not fully support these complex structures yet.

```csharp
// Given a `ContentTypeService` object get ContentType by its Id and return ContentTypeComposition
var contentType = contentTypeService.Get(1234);
return contentType.ContentTypeComposition;
```

### .CompositionPropertyGroups

Gets a list of all 'PropertyGroup` objects from the composition including PropertyGroups from the current ContentType.

```csharp
// Given a `ContentTypeService` object get ContentType by its Id and return CompositionPropertyGroups
var contentType = contentTypeService.Get(1234);
return contentType.CompositionPropertyGroups;
```

### .CompositionPropertyTypes

Gets a list of all `PropertyType` objects from the composition including PropertyTypes from the current ContentType.

```csharp
// Given a `ContentTypeService` object get ContentType by its Id and return CompositionPropertyTypes
var contentType = contentTypeService.Get(1234);
return contentType.CompositionPropertyTypes;
```

### .CreateDate

Gets or Sets a `DateTime` object, indicating then the given ContentType was created.

```csharp
// Given a `ContentTypeService` object get ContentType by its Id and return CreateDate
var contentType = contentTypeService.Get(1234);
return contentType.CreateDate;
```

### .CreatorId

Gets or Sets the Id of the `User` who created the ContentType.

```csharp
// Given a `ContentTypeService` object get ContentType by its Id and return the Id of the Creator
var contentType = contentTypeService.Get(1234);
return contentType.CreatorId;
```

### .Description

Gets or Sets the Description as a `String` for the ContentType.

```csharp
// Given a `ContentTypeService` object get ContentType by its Id and return the Description
var contentType = contentTypeService.Get(1234);
return contentType.Description;
```

### .DefaultTemplate

Gets the default Template set as an `ITemplate` object for this ContentType.

```csharp
// Given a `ContentTypeService` object get ContentType by its Id and return the DefaultTemplate
var contentType = contentTypeService.Get(1234);
return contentType.DefaultTemplate;
```

### .Icon

Gets or Sets the Icon as a `String` for the ContentType.

```csharp
// Given a `ContentTypeService` object get ContentType by its Id and return the Icon
var contentType = contentTypeService.Get(1234);
return contentType.Icon;
```

### .Id

Gets the unique `ContentType` Id as an `Int`. The ID, derived from a database identity field, isn't safe for code references as they are moved across instances. Therefore it's recommended to use `Key` instead.

### .Key

Gets the `Guid` assigned to the ContentType during creation. This value is unique, and should never change, even if the content is moved between instances.

```csharp
// Given a `ContentTypeService` object get ContentType by its Id and return the Key
var contentType = contentTypeService.Get(1234);
return contentType.Key;
```

### .Level

Gets or Sets the given `ContentType` level in the site hierarchy as an `Int`. ContentTypes placed at the root of the tree, will return 1, content right underneath will return 2, and so on.

```csharp
// Given a `ContentTypeService` object get ContentType by its Id and return the Level
var contentType = contentTypeService.Get(1234);
return contentType.Level;
```

### .Name

Gets or Sets the name of the ContentType as a `String`.

```csharp
// Given a `ContentTypeService` object get ContentType by its Id and return its Name
var contentType = contentTypeService.Get(1234);
return contentType.Name;
```

### .ParentId

Gets or Sets the parent `ContentType` Id as an `Int`.

```csharp
// Given a `ContentTypeService` object get ContentType by its Id and return the Id of the Parent ContentType
var contentType = contentTypeService.Get(1234);
return contentType.ParentId;
```

### .Path

Gets or Sets the path of the ContentType as a `String`. This string contains a comma separated list of the ancestors Ids including the current ContentTypes own id at the end of the string.

```csharp
// Given a `ContentTypeService` object get ContentType by its Id and return the Path
var contentType = contentTypeService.Get(1234);
return contentType.Path;
```

### .PropertyGroups

Gets or Sets a `PropertyGroupCollection` containing a list of PropertyGroups for the current ContentType.

```csharp
// Given a `ContentTypeService` object get ContentType by its Id and return PropertyGroups
var contentType = contentTypeService.Get(1234);
return contentType.PropertyGroups;
```

### .PropertyTypes

Gets an `Enumerable` list of PropertyTypes aggregated for all groups within the current ContentType, as well as PropertyTypes not within a group.

```csharp
// Given a `ContentTypeService` object get ContentType by its Id and return PropertyTypes
var contentType = contentTypeService.Get(1234);
return contentType.PropertyTypes;
```

### .SortOrder

Gets the given `ContentType` index, compared to sibling content.

```csharp
// Given a `ContentTypeService` object get ContentType by its Id and return its SortOrder
var contentType = contentTypeService.Get(1234);
return contentType.SortOrder;
```

### .Thumbnail

Gets or Sets the Thumbnail as a `String` for the ContentType.

```csharp
// Given a `ContentTypeService` object get ContentType by its Id and return the Thumbnail
var contentType = contentTypeService.Get(1234);
return contentType.Thumbnail;
```

## Methods

### .AddContentType(IContentTypeComposition contentType)

Adds a new `ContentType` to the list of composite ContentTypes.

```csharp
// Given a `ContentTypeService` object get a few ContentTypes by their alias
// and add the 'Meta' and 'SEO' ContentTypes to the composition of the 'Textpage' ContentType.
var metaContentType = contentTypeService.Get("meta");
var seoContentType = contentTypeService.Get("seo");
var textpageContentType = contentTypeService.Get("textPage");
textpageContentType.AddContentType(metaContentType);
textpageContentType.AddContentType(seoContentType);
contentTypeService.Save(textpageContentType);
```

### .CompositionAliases()

Returns an `Enumerable` list of ContentType aliases as `String` from the current composition.

```csharp
// Given a `ContentTypeService` object get a ContentType by its alias and loop through CompositionAliases
var contentType = contentTypeService.Get("textPage");
var aliases = contentType.CompositionAliases();
```

### .CompositionIds()

Returns an `Enumerable` list of ContentType Ids as `Int` from the current composition.

```csharp
// Given a `ContentTypeService` object get a ContentType by its alias and loop through CompositionIds
var contentType = contentTypeService.Get("textPage");
var ids = contentType.CompositionIds();
```

### .ContentTypeCompositionExists(string alias)

Checks if a `ContentType` with the supplied alias exists in the list of composite ContentTypes.

```csharp
// Given a `ContentTypeService` object get a ContentType by its alias
// and check if a given ContentType exists in the composition of the 'Text Page' ContentType.
var contentType = contentTypeService.Get("textPage");
bool result = contentType.ContentTypeCompositionExists("meta");
```

### .SetDefaultTemplate(ITemplate template)

Sets the default `Template` for the current ContentType.

```csharp
// Given a `ContentTypeService` object get a ContentType by its alias
// and change the default template with another one from the list of allowed templates.
var contentType = contentTypeService.Get("textPage");
ITemplate template = contentType.AllowedTemplates.First(x => x.Alias == "anotherTemplate");
contentType.SetDefaultTemplate(template);
contentTypeService.Save(contentType);
```

### .RemoveContentType(string alias)

Removes a `ContentType` with the supplied alias from the list of composite ContentTypes.

```csharp
// Given a `ContentTypeService` object get a ContentType by its alias and
// remove the 'Meta' ContentType from its composition.
var contentType = contentTypeService.Get("textPage");
bool success = contentType.RemoveContentType("meta");
if(success)
    contentTypeService.Save(contentType);
```

### .RemovePropertyType(string propertyTypeAlias)

Removes a `PropertyType` from the current `ContentType`.

```csharp
// Given a `ContentTypeService` object get a ContentType by its alias
// and remove a PropertyType from the list of PropertyTypes.
var contentType = contentTypeService.Get("textPage");
contentType.RemovePropertyType("author");
contentTypeService.Save(contentType);
```

### .RemoveTemplate(ITemplate template)

Removes a `Template` from the list of allowed templates.

```csharp
// Given a `ContentTypeService` object get a ContentType by its alias
// and remove one of the templates from the list of allowed templates.
var contentType = contentTypeService.Get("textPage");
ITemplate template = contentType.AllowedTemplates.First(x => x.Alias == "RemoveThisTemplate");
contentType.RemoveTemplate(template);
contentTypeService.Save(contentType);
```
