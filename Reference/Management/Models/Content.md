#Content

**Applies to Umbraco 6.x and newer**

The `Content` class represents a single item in the content tree, its values are fetched directly from the database, not from the cache. **Notice** the Content class should strictly be used for simple CRUD operations, not complex queries, as it is not flexible nor fast enough for this.

All content is versioned, so on each indiviual change, a new version is stored. Past versions can only be retrieved from the `Content` api, not from the cache. 

 * **Namespace:** `Umbraco.Core.Models` 
 * **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following usings:
	
	using Umbraco.Core.Models;
	using Umbraco.Core.Services;

##Constructors

### new Content(string name, IContent parent, IContentType contentType)
Constructor for creating a new Content object where the necessary parameters are the name of the Content, the parent of the Content as an `IContent` object and the ContentType as an `IContentType` object for the Content being created.

### new Content(string name, IContent parent, IContentType contentType, PropertyCollection properties)
Constructor for creating a new Content object where the necessary parameters are the name of the Content, the parent of the Content as an `IContent` object, the ContentType as an `IContentType` object and a `PropertyCollection` for the Content being created.

### new Content(string name, int parentId, IContentType contentType)
Constructor for creating a new Content object where the necessary parameters are the name of the Content, the id of the parent as `int` and the ContentType as an `IContentType` object for the Content being created.

### new Content(string name, int parentId, IContentType contentType, PropertyCollection properties)
Constructor for creating a new Content object where the necessary parameters are the name of the Content, the id of the parent as `int`, the ContentType as an `IContentType` object and a `PropertyCollection` for the Content being created.

##Properties

###.CreateDate
Gets or Sets a `DateTime` object, indicating then the given Content was created.

	//Given a `ContentService` object get Content by its Id and return CreateDate
	var content = contentService.GetById(1234);
	return content.CreateDate;

###.CreatorId
Gets or Sets the Id of the `User` who created the Content.

	//Given a `ContentService` object get Content by its Id and return the Id of the Creator
	var content = contentService.GetById(1234);
	return content.CreatorId;

###.ContentType
Returns a `ContentType` object representing the DocumentType used by the given `Content`.

	//Given a `ContentService` object get Content by its Id and return ContentType
	var content = contentService.GetById(1234);
	return content.ContentType;

###.ContentTypeId
Returns the id as an `int` of the `ContentType` object representing the DocumentType used by the given `Content`.

	//Given a `ContentService` object get Content by its Id and return the Id of the ContentType
	var content = contentService.GetById(1234);
	return content.ContentTypeId;

###.ExpireDate
If set, returns the `DateTime` the Content is meant to be unpublished and become unavailable on the website.

	//Given a `ContentService` object get Content by its Id and set the expire date to 5 days from now
	var content = contentService.GetById(1234);
	content.ExpireDate = DateTime.Now.AddDays(5);

###.Id
Returns the unique `Content` Id as a `Int`, this ID is based on a Database identity field, and is therefore not safe to reference in code which are moved between different instances, use Key instead. 

###.Key
Returns the `Guid` assigned to the Content during creation. This value is unique, and should never change, even if the content is moved between instances. 

	//Given a `ContentService` object get Content by its Id and return the Key
	var content = contentService.GetById(1234);
	return content.Key;

###.Language
Gets or Sets the Language of the Content as a `string`. **Please note** that this property is introduced in v.6.0.0, but won't be fully utilized until multi-lingual support is added in a later version.

###.Level
Gets or Sets the given `Content` level in the site hirachy as an `Int`. Content placed at the root of the site, will return 1, content just underneath will return 2, and so on.

	//Given a `ContentService` object get Content by its Id and return the Level
	var content = contentService.GetById(1234);
	return content.Level;

###.Name
Gets or Sets the name of the content as a `String`.

	//Given a `ContentService` object get Content by its Id and return its Name
	var content = contentService.GetById(1234);
	return content.Name;

###.ParentId
Gets or Sets the parent `Content` Id as an `Int`.

	//Given a `ContentService` object get Content by its Id and return the Id of the Parent Content
	var content = contentService.GetById(1234);
	return content.ParentId;

###.Path
Gets or Sets the path of the content as a `String`. This string contains a comma seperated list of the anscestors Ids including the current contents own id at the end of the string.

	//Given a `ContentService` object get Content by its Id and return the Path
	var content = contentService.GetById(1234);
	return content.Path;

###.Properties
Gets or Sets the `PropertyCollection` object, which is a collection of `Property` objects. Each property corresponds to a `PropertyType`, which is defined on the `ContentType`.

	//Given a `ContentService` object get Content by its Id and loop through all Properties
	var content = contentService.GetById(1234);
	foreach(var property in content.Properties){
        string alias = property.Alias;
        object value = property.Value;
        Guid version = property.Version;
    } 

###.PropertyGroups
Returns a list of `PropertyGroup` objects as defined on the `ContentType` that the Content is based on. A PropertyGroup corresponds to a Tab in the backoffice.

	//Given a `ContentService` object get Content by its Id and loop through all PropertyGroups
	var content = contentService.GetById(1234);
	foreach(var propertyGroup in content.PropertyGroups){
        string name = propertyGroup.Name;
        int? parentId = propertyGroup.ParentId;
        int sortOrder = propertyGroup.SortOrder;
        PropertyTypeCollection propertyTypes = propertyGroup.PropertyTypes; //PropertyTypes within this group
    } 

###.PropertyTypes
Returns a list of `PropertyType` objects as defined on the `ContentType` that the Content is based on. A `PropertyType` is what defines a `Property`. The PropertyTypes witin this list is the sum of those within all PropertyGroups as well as those not within a group.

	//Given a `ContentService` object get Content by its Id and loop through all PropertyTypes
	var content = contentService.GetById(1234);
	foreach(var propertyType in content.PropertyTypes){
        string alias = propertyType.Alias;
		string name = propertyType.Name;
		string description = propertyType.Description;
		int dataTypeDefinitionId = propertyType.DataTypeDefinitionId;
		Guid dataTypeId = propertyType.DataTypeId;
		bool mandatory = propertyType.Mandatory;
		string helpText = propertyType.HelpText;
		int sortOrder = propertyType.SortOrder;
    } 

###.Published
Returns a `Bool` indicating whether the given `Content` is published and available on the website or not. **Notice:** the published flag does not check the current in-memory cache, so this flag is not a guarantee that the Content is/is not available in the cache and the frontend of the website.

	//Given a `ContentService` object get Content by its Id and return Published
	var content = contentService.GetById(1234);
	return content.Published;

###.ReleaseDate
If set, returns `DateTime` indicating when the `Content` should be published and made available on the website and cache.

	//Given a `ContentService` object get Content by its Id and set the release date to 4 days from now
	var content = contentService.GetById(1234);
	content.ReleaseDate = DateTime.Now.AddDays(4);

###.SortOrder
Returns the given `Content` index, compared to sibling content.

	//Given a `ContentService` object get Content by its Id and return its SortOrder
	var content = contentService.GetById(1234);
	return content.SortOrder;

###.Status
Returns a `ContentStatus` enum with the status of the Content being either Unpublished, Published, Expired, Trashed or Awaiting Release.

	//Given a `ContentService` object get Content by its Id and return its Status
	var content = contentService.GetById(1234);
	return content.Status;

###.Template
Gets or Sets the `ITemplate` object, which is the template explicitly set on the Content or the default template as defined on the `ContentType`.

	//Given a `ContentService` object get Content by its Id and return its Template
	var content = contentService.GetById(1234);
	return content.Template;

###.Trashed
Returns a `Bool` indicating whether the given `Content` is currently in the recycle bin.

	//Given a `ContentService` object get Content by its Id and return Trashed
	var content = contentService.GetById(1234);
	return content.Trashed;

###.UpdateDate
Gets or Sets a `DateTime` object, indicating when the given Content was last updated.

	//Given a `ContentService` object get Content by its Id and return UpdateDate
	var content = contentService.GetById(1234);
	return content.UpdateDate;

###.Version
Returns the current Version Id as a `Guid`, 
For each change made to a content item, its values are stored under a new Version. This version is identified by a `Guid`.

	//Given a `ContentService` object get Content by its Id and return its Version
	var content = contentService.GetById(1234);
	return content.Version;

###.WriterId
Gets or Sets the Id of the `User` who made the latest edit on the Content.

	//Given a `ContentService` object get Content by its Id and return the Id of the Writer
	var content = contentService.GetById(1234);
	return content.WriterId;

##Methods

###.ChangeContentType(IContentType contentType)
Changes the `IContentType` for the current Content object and removes PropertyTypes and Properties, which are not part of the new `ContentType`. **Please use with caution** as this remove differences between the new and old ContentType.

	//Given a `ContentTypeService` object get the ContentType that we're changing to,
	//get the Content from the `ContentService` for which we want to change ContentType for,
	//and then save the Content throught the ContentService.
	var contentType = contentTypeService.GetContentType(1122);
	var content = contentService.GetById(1234);
	content.ChangeContentType(contentType);
	contentService.Save(content);

###.GetCreatorProfile()
Gets the `IProfile` object for the Creator of this Content, which contains the Id and Name of the User who created this Content item.

	//Given a `ContentService` object get Content by its Id and get the `IProfile` of the Creator
	var content = contentService.GetById(1234);
	var profile = content.GetCreatorProfile();
	var id = profile.Id;
	string name = profile.Name;

###.GetValue(string propertyTypeAlias)
Gets the value of a Property as an `Object`.

	//Given a `ContentService` object get Content by its Id and get a value by alias
	var content = contentService.GetById(1234);
	object value = content.GetValue("bodyText");
	string text = value as string;

###.GetValue< TPassType >(string propertyTypeAlias)
Gets the value of a Property as the defined type 'TPassType'.

	//Given a `ContentService` object get Content by its Id and get a value by alias while specifying the return type
	var content = contentService.GetById(1234);
	string value = content.GetValue<string>("bodyText");

###.GetWriterProfile()
Gets the `IProfile` object for the Writer of this Content, which contains the Id and Name of the User who last updated this Content item.

	//Given a `ContentService` object get Content by its Id and get the `IProfile` of the Writer
	var content = contentService.GetById(1234);
	var profile = content.GetWriterProfile();
	var id = profile.Id;
	string name = profile.Name;

###.HasProperty(string propertyTypeAlias)
Returns a `Bool` indicating whether the Content object has a property with the supplied alias.

	//Given a `ContentService` object get Content by its Id and check if certain properties exist
	var content = contentService.GetById(1234);
	bool tagsExists = content.HasProperty("myTagProperty");
	bool bodyTextExists = content.HasProperty("bodyText");

###.IsValid()
Returns a `Bool` indicating whether the content and its properties are valid. If a property is set to Mandatory and blank upon saving the Content is not considered valid. This check is used when Content is published, so it won't be possible to publish invalid Content.

	//Given a `ContentService` object get Content by its Id and check if Content is valid
	var content = contentService.GetById(1234);
	bool valid = content.IsValid();

###.SetValue(string propertyTypeAlias, object value)
Sets the value of a property by its alias.

	//Given a `ContentService` object get Content by its Id, set a few values
	//and saves the Content through the `ContentService`
	var content = contentService.GetById(1234);
	content.SetValue("bodyText", "This text will be added to by RTE field");
	content.SetValue("date", DateTime.Now);
	contentService.Save(content);

###.ToXml()
Returns an `XElement` containing the Content data, based off the latest changes. Is used when the published content is sent to the in-memory xml cache.

	//Given a `ContentService` object get Content by its Id and returns the xml
	var content = contentService.GetById(1234);
	XElement xml = content.ToXml();
	return xml;