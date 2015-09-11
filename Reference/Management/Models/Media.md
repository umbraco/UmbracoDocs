#Media

**Applies to Umbraco 6.x and newer**

The `Media` class represents a single item in the media tree, its values are fetched directly from the database, not from the cache. **Notice** the Media class should strictly be used for simple CRUD operations, not complex queries, as it is not flexible nor fast enough for this.

 * **Namespace:** `Umbraco.Core.Models` 
 * **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following usings:
	
	using Umbraco.Core.Models;
	using Umbraco.Core.Services;

##Constructors

### new Media(string name, IMedia parent, IMediaType mediaType)
Constructor for creating a new Media object where the necessary parameters are the name of the Media, the parent of the Media as an `IMedia` object and the MediaType as an `IMediaType` object for the Media being created.

### new Media(string name, IMedia parent, IMediaType mediaType, PropertyCollection properties)
Constructor for creating a new Media object where the necessary parameters are the name of the Media, the parent of the Media as an `IMedia` object, the MediaType as an `IMediaType` object and a `PropertyCollection` for the Media being created.

### new Media(string name, int parentId, IMediaType mediaType)
Constructor for creating a new Media object where the necessary parameters are the name of the Media, the id of the parent as `int` and the MediaType as an `IMediaType` object for the Media being created.

### new Media(string name, int parentId, IMediaType mediaType, PropertyCollection properties)
Constructor for creating a new Media object where the necessary parameters are the name of the Media, the id of the parent as `int`, the MediaType as an `IMediaType` object and a `PropertyCollection` for the Media being created.

##Properties

###.CreateDate
Gets or Sets a `DateTime` object, indicating then the given Media was created.

	//Given a `MediaService` object get Media by its Id and return CreateDate
	var media = mediaService.GetById(1234);
	return media.CreateDate;

###.CreatorId
Gets or Sets the Id of the `User` who created the Media.

	//Given a `MediaService` object get Media by its Id and return the Id of the Creator
	var media = mediaService.GetById(1234);
	return media.CreatorId;

###.ContentType
Returns a `MediaType` object representing the ContentType used by the given `Media`.

	//Given a `MediaService` object get Media by its Id and return MediaType
	var media = mediaService.GetById(1234);
	return media.ContentType;

###.ContentTypeId
Returns the id as an `int` of the `MediaType` object representing the ContentType used by the given `Media`.

	//Given a `MediaService` object get Media by its Id and return the Id of the MediaType
	var media = mediaService.GetById(1234);
	return media.ContentTypeId;

###.Id
Returns the unique `Media` Id as a `Int`, this ID is based on a Database identity field, and is therefore not safe to reference in code which are moved between different instances, use Key instead. 

###.Key
Returns the `Guid` assigned to the Media during creation. This value is unique, and should never change, even if the Media is moved between instances. 

	//Given a `MediaService` object get Media by its Id and return the Key
	var media = mediaService.GetById(1234);
	return media.Key;

###.Level
Gets or Sets the given `Media` level in the site hirachy as an `Int`. Media placed at the root of the tree, will return 1, Media just underneath will return 2, and so on.

	//Given a `MediaService` object get Media by its Id and return the Level
	var media = mediaService.GetById(1234);
	return media.Level;

###.Name
Gets or Sets the name of the Media as a `String`.

	//Given a `MediaService` object get Media by its Id and return its Name
	var v = mediaService.GetById(1234);
	return media.Name;

###.ParentId
Gets or Sets the parent `Media` Id as an `Int`.

	//Given a `MediaService` object get Media by its Id and return the Id of the Parent Media
	var media = mediaService.GetById(1234);
	return media.ParentId;

###.Path
Gets or Sets the path of the Media as a `String`. This string contains a comma seperated list of the anscestors Ids including the current medias own id at the end of the string.

	//Given a `MediaService` object get Media by its Id and return the Path
	var media = mediaService.GetById(1234);
	return media.Path;

###.Properties
Gets or Sets the `PropertyCollection` object, which is a collection of `Property` objects. Each property corresponds to a `PropertyType`, which is defined on the `MediaType`.

	//Given a `MediaService` object get Media by its Id and loop through all Properties
	var media = mediaService.GetById(1234);
	foreach(var property in media.Properties){
        string alias = property.Alias;
        object value = property.Value;
        Guid version = property.Version;
    } 

###.PropertyGroups
Returns a list of `PropertyGroup` objects as defined on the `MediaType` that the Media is based on. A PropertyGroup corresponds to a Tab in the backoffice.

	//Given a `MediaService` object get Media by its Id and loop through all PropertyGroups
	var media = mediaService.GetById(1234);
	foreach(var propertyGroup in media.PropertyGroups){
        string name = propertyGroup.Name;
        int? parentId = propertyGroup.ParentId;
        int sortOrder = propertyGroup.SortOrder;
        PropertyTypeCollection propertyTypes = propertyGroup.PropertyTypes; //PropertyTypes within this group
    } 

###.PropertyTypes
Returns a list of `PropertyType` objects as defined on the `MediaType` that the Media is based on. A `PropertyType` is what defines a `Property`. The PropertyTypes witin this list is the sum of those within all PropertyGroups as well as those not within a group.

	//Given a `MediaService` object get Media by its Id and loop through all PropertyTypes
	var media = mediaService.GetById(1234);
	foreach(var propertyType in media.PropertyTypes){
        string alias = propertyType.Alias;
		string name = propertyType.Name;
		string description = propertyType.Description;
		int dataTypeDefinitionId = propertyType.DataTypeDefinitionId;
		Guid dataTypeId = propertyType.DataTypeId;
		bool mandatory = propertyType.Mandatory;
		string helpText = propertyType.HelpText;
		int sortOrder = propertyType.SortOrder;
    } 

###.SortOrder
Returns the given `Media` index, compared to sibling media.

	//Given a `MediaService` object get Media by its Id and return its SortOrder
	var media = mediaService.GetById(1234);
	return media.SortOrder;

###.Trashed
Returns a `Bool` indicating whether the given `Media` is currently in the recycle bin.

	//Given a `MediaService` object get Media by its Id and return Trashed
	var media = mediaService.GetById(1234);
	return media.Trashed;

###.UpdateDate
Gets or Sets a `DateTime` object, indicating when the given Media was last updated.

	//Given a `MediaService` object get Media by its Id and return UpdateDate
	var media = mediaService.GetById(1234);
	return media.UpdateDate;

###.Version
Returns the current Version Id as a `Guid`, 
For each change made to a Media item, its values are stored under a new Version. This version is identified by a `Guid`.

	//Given a `MediaService` object get Media by its Id and return its Version
	var media = mediaService.GetById(1234);
	return media.Version;

##Methods

###.ChangeContentType(IMediaType mediaType)
Changes the `IMediaType` for the current Media object and removes PropertyTypes and Properties, which are not part of the new `MediaType`. **Please use with caution** as this remove differences between the new and old MediaType.

	//Given a `ContentTypeService` object get the MediaType that we're changing to,
	//get the Media from the `MediaService` for which we want to change MediaType for,
	//and then save the Media throught the MediaService.
	var mediaType = contentTypeService.GetMediaType(1122);
	var media = mediaService.GetById(1234);
	media.ChangeContentType(mediaType);
	mediaService.Save(media);

###.GetCreatorProfile()
Gets the `IProfile` object for the Creator of this Media, which contains the Id and Name of the User who created this Media item.

	//Given a `MediaService` object get Media by its Id and get the `IProfile` of the Creator
	var media = mediaService.GetById(1234);
	var profile = media.GetCreatorProfile();
	var id = profile.Id;
	string name = profile.Name;

###.GetValue(string propertyTypeAlias)
Gets the value of a Property as an `Object`.

	//Given a `MediaService` object get Media by its Id and get a value by alias
	var media = mediaService.GetById(1234);
	object value = media.GetValue("height");
	int text = int.Parse(value.ToString());

###.GetValue< TPassType >(string propertyTypeAlias)
Gets the value of a Property as the defined type 'TPassType'.

	//Given a `MediaService` object get Media by its Id and get a value by alias while specifying the return type
	var media = mediaService.GetById(1234);
	int value = media.GetValue<int>("height");

###.HasProperty(string propertyTypeAlias)
Returns a `Bool` indicating whether the Media object has a property with the supplied alias.

	//Given a `MediaService` object get Media by its Id and check if certain properties exist
	var media = mediaService.GetById(1234);
	bool tagsExists = media.HasProperty("myTagProperty");
	bool textExists = media.HasProperty("altText");

###.IsValid()
Returns a `Bool` indicating whether the Media and its properties are valid. If a property is set to Mandatory and blank upon saving the Media is not considered valid.

	//Given a `MediaService` object get Media by its Id and check if Media is valid
	var media = mediaService.GetById(1234);
	bool valid = media.IsValid();

###.SetValue(string propertyTypeAlias, object value)
Sets the value of a property by its alias.

	//Given a `MediaService` object get Media by its Id, set a few values
	//and saves the Media through the `MediaService`
	var media = mediaService.GetById(1234);
	media.SetValue("altText", "Alternative text for this media item");
	media.SetValue("date", DateTime.Now);
	mediaService.Save(media);

It is worth noting that it is also possible to pass a HttpPostedFile, HttpPostedFileBase or HttpPostedFileWrapper to the SetValue method, so it can be used for uploads.

###.ToXml()
Returns an `XElement` containing the Media data, based off the latest changes. When the Media item is saved the xml is stored in the database.

	//Given a `MediaService` object get Media by its Id and returns the xml
	var media = mediaService.GetById(1234);
	XElement xml = media.ToXml();
	return xml;