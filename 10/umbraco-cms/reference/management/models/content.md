---
description: "The Content class represents a single item in the content tree, its values are fetched directly from the database, not from the cache."
---

# Content

The `Content` class represents a single item in the content tree, its values are fetched directly from the database, not from the cache. **Notice** the Content class should strictly be used for CRUD operations, not complex queries, as it is not flexible nor fast enough for this.

All content is versioned, so on each individual change, a new version is stored. Past versions can only be retrieved from the `Content` api, not from the cache.

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

### new Content(string name, IContent parent, IContentType contentType, string culture = null)

Constructor for creating a new Content object where the necessary parameters are the name of the Content, the parent of the Content as an `IContent` object and the ContentType as an `IContentType` object for the Content being created. In addition, there is an optional parameter for the culture.

### new Content(string name, IContent parent, IContentType contentType, int userId, string culture = null)

Constructor for creating a new Content object where the necessary parameters are the name of the Content, the parent of the Content as an `IContent` object, the ContentType as an `IContentType` object for the Content being created and the id of the user as a `int`. In addition, there is an optional parameter for the culture.

### new Content(string name, IContent parent, IContentType contentType, PropertyCollection properties, string culture = null)

Constructor for creating a new Content object where the necessary parameters are the name of the Content, the parent of the Content as an `IContent` object, the ContentType as an `IContentType` object and a `PropertyCollection` for the Content being created. In addition, there is an optional parameter for the culture.

### new Content(string name, int parentId, IContentType contentType, string culture = null)

Constructor for creating a new Content object where the necessary parameters are the name of the Content, the id of the parent as `int` and the ContentType as an `IContentType` object for the Content being created. In addition, there is an optional parameter for the culture.

### new Content(string name, int parentId, IContentType contentType, int userId, string culture = null)

Constructor for creating a new Content object where the necessary parameters are the name of the Content, the parent id of the Content as an `int` object, the ContentType as an `IContentType` object for the Content being created and the id of the user as a `int`. In addition, there is an optional parameter for the culture.

### new Content(string name, int parentId, IContentType contentType, PropertyCollection properties, string culture = null)

Constructor for creating a new Content object where the necessary parameters are the name of the Content, the id of the parent as `int`, the ContentType as an `IContentType` object and a `PropertyCollection` for the Content being created.In addition, there is an optional parameter for the culture.

## Properties

### .CreateDate

Gets or Sets a `DateTime` object, indicating then the given Content was created.

```csharp
// Given a `ContentService` object get Content by its Id and return CreateDate
var content = contentService.GetById(1234);
return content.CreateDate;
```

### .CreatorId

Gets or Sets the Id of the `User` who created the Content.

```csharp
// Given a `ContentService` object get Content by its Id and return the Id of the Creator
var content = contentService.GetById(1234);
return content.CreatorId;
```

### .ContentType

Returns a `ISimpleContentType` object representing the DocumentType used by the given `Content`.

```csharp
// Given a `ContentService` object get Content by its Id and return ContentType
var content = contentService.GetById(1234);
return content.ContentType;
```

### .ContentTypeId

Returns the id as an `int` of the `ContentType` object representing the DocumentType used by the given `Content`.

```csharp
// Given a `ContentService` object get Content by its Id and return the Id of the ContentType
var content = contentService.GetById(1234);
return content.ContentTypeId;
```

### .Id

Returns the unique `Content` Id as a `Int`, this ID is based on a Database identity field, and is therefore not safe to reference in code which are moved between different instances, use Key instead.

### .Key

Returns the `Guid` assigned to the Content during creation. This value is unique, and should never change, even if the content is moved between instances.

```csharp
// Given a `ContentService` object get Content by its Id and return the Key
var content = contentService.GetById(1234);
return content.Key;
```

### .PublishedCultures

Gets Languages of the Content as a `IEnumerable<string>`.

### .Level

Gets or Sets the given `Content` level in the site hierarchy as an `Int`. Content placed at the root of the site, will return 1, content right underneath will return 2, and so on.

```csharp
// Given a `ContentService` object get Content by its Id and return the Level
var content = contentService.GetById(1234);
return content.Level;
```

### .Name

Gets or Sets the name of the content as a `String`.

```csharp
// Given a `ContentService` object get Content by its Id and return its Name
var content = contentService.GetById(1234);
return content.Name;
```

### .ParentId

Gets or Sets the parent `Content` Id as an `Int`.

```csharp
// Given a `ContentService` object get Content by its Id and return the Id of the Parent Content
var content = contentService.GetById(1234);
return content.ParentId;
```

### .Path

Gets or Sets the path of the content as a `String`. This string contains a comma separated list of the ancestor Ids including the current contents own id at the end of the string.

```csharp
// Given a `ContentService` object get Content by its Id and return the Path
var content = contentService.GetById(1234);
return content.Path;
```

### .Properties

Gets or Sets the `IPropertyCollection` object, which is a collection of `IProperty` objects. Each property corresponds to a `PropertyType`, which is defined on the `ContentType`.

```csharp
// Given a `ContentService` object get Content by its Id and loop through all Properties
var content = contentService.GetById(1234);
foreach (var property in content.Properties)
{
    string alias = property.Alias;
    object value = property.GetValue();

}
```

### .Published

Returns a `Bool` indicating whether the given `Content` is published and available on the website or not. **Notice:** the published flag does not check the current in-memory cache, so this flag is not a guarantee that the Content is/is not available in the cache and the frontend of the website.

```csharp
// Given a `ContentService` object get Content by its Id and return Published
var content = contentService.GetById(1234);
return content.Published;
```

### .PublishDate

If set, returns `DateTime?` indicating when the `Content` should be published and made available on the website and cache.

```csharp
// Given a `ContentService` object get Content by its Id and set the release date to 4 days from now
var content = contentService.GetById(1234);
return content.PublishDate
```

### .SortOrder

Returns the given `Content` index, compared to sibling content.

```csharp
// Given a `ContentService` object get Content by its Id and return its SortOrder
var content = contentService.GetById(1234);
return content.SortOrder;
```

### .PublishedState

Returns a `IPublishedState` enum with the status of the Content being either Unpublished, Published, Publishing, Unpublishing.

```csharp
// Given a `ContentService` object get Content by its Id and return its Status
var content = contentService.GetById(1234);
return content.PublishedState;
```

### .TemplateId

Gets or sets the template id used to render the content.

```csharp
// Given a `ContentService` object get Content by its Id and return its Template
var content = contentService.GetById(1234);
return content.TemplateId;
```

### .Trashed

Returns a `Bool` indicating whether the given `Content` is currently in the recycle bin.

```csharp
// Given a `ContentService` object get Content by its Id and return Trashed
var content = contentService.GetById(1234);
return content.Trashed;
```

### .UpdateDate

Gets or Sets a `DateTime` object, indicating when the given Content was last updated.

```csharp
// Given a `ContentService` object get Content by its Id and return UpdateDate
var content = contentService.GetById(1234);
return content.UpdateDate;
```

### .VersionId

Returns the current Version Id as a `int`, for each change made to a content item, its values are stored under a new Version. This version is identified by a `int`.

```csharp
// Given a `ContentService` object get Content by its Id and return its Version
var content = contentService.GetById(1234);
return content.VersionId;
```

### .WriterId

Gets or Sets the Id of the `User` who made the latest edit on the Content.

```csharp
// Given a `ContentService` object get Content by its Id and return the Id of the Writer
var content = contentService.GetById(1234);
return content.WriterId;
```

## Methods

### .GetCreatorProfile(IUserService userService)

Gets the `IProfile` object for the Creator of this Content, which contains the Id and Name of the User who created this Content item.

```csharp
// Given a `ContentService` object get Content by its Id and get the `IProfile` of the Creator
var content = contentService.GetById(1234);
var profile = content.GetCreatorProfile(userService);
var id = profile.Id;
string name = profile.Name;
```

### .GetValue(string propertyTypeAlias)

Gets the value of a Property as an `Object`.

```csharp
// Given a `ContentService` object get Content by its Id and get a value by alias
var content = contentService.GetById(1234);
object value = content.GetValue("bodyText");
string text = value as string;
```

### .GetValue< TPassType >(string propertyTypeAlias)

Gets the value of a Property as the defined type 'TPassType'.

```csharp
// Given a `ContentService` object get Content by its Id and get a value by alias while specifying the return type
var content = contentService.GetById(1234);
string value = content.GetValue<string>("bodyText");
```

### .GetWriterProfile(IUserService userService)

Gets the `IProfile` object for the Writer of this Content, which contains the Id and Name of the User who last updated this Content item.

```csharp
// Given a `ContentService` object get Content by its Id and get the `IProfile` of the Writer
var content = contentService.GetById(1234);
var profile = content.GetWriterProfile(userService);
var id = profile.Id;
string name = profile.Name;
```

### .HasProperty(string propertyTypeAlias)

Returns a `Bool` indicating whether the Content object has a property with the supplied alias.

```csharp
// Given a `ContentService` object get Content by its Id and check if certain properties exist
var content = contentService.GetById(1234);
bool tagsExists = content.HasProperty("myTagProperty");
bool bodyTextExists = content.HasProperty("bodyText");
```

### .SetValue(string propertyTypeAlias, object value)

Sets the value of a property by its alias.

```csharp
// Given a `ContentService` object get Content by its Id, set a few values
// and saves the Content through the `ContentService`
var content = contentService.GetById(1234);
content.SetValue("bodyText", "This text will be added to by RTE field");
content.SetValue("date", DateTime.Now);
contentService.Save(content);
```

### .ToXml(IEntityXmlSerializer serializer)

Returns an `XElement` containing the Content data, based off the latest changes. Is used when the published content is sent to the in-memory xml cache.

```csharp
// Given a `ContentService` object get Content by its Id and returns the xml
var content = contentService.GetById(1234);
XElement xml = content.ToXml(serializer);
return xml;
```
