#ContentTypeService

**Applies to Umbraco 6.x and newer**

The ContentTypeService acts as a "gateway" to Umbraco data for operations which are related to ContentTypes and MediaTypes.

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
The ContentTypeService is available through the `ApplicationContext`, but the if you are using a `SurfaceController` or the `UmbracoUserControl` then the ContentTypeService is available through a local `Services` property.

	Services.ContentTypeService

Getting the service through the `ApplicationContext`:

	ApplicationContext.Current.Services.ContentTypeService

##Methods

###.GetContentType(int id)
Gets a `ContentType` object by its Id.

###.GetContentType(string alias)
Gets a `ContentType` object by its Alias.

###.GetAllContentTypes(params int[] ids)
Gets a list of all available `ContentType` objects.

###.GetContentTypeChildren(int id)
Gets a list of children for a `ContentType` object by the Parent Id.

###.Save(IContentType contentType, int userId = 0)
Saves a single `ContentType` object.

###.Save(IEnumerable<IContentType> contentTypes, int userId = 0)
Saves a list of `ContentType` objects.

###.Delete(IContentType contentType, int userId = 0)
Deletes a single `ContentType` object

###.Delete(IEnumerable<IContentType> contentTypes, int userId = 0)
Deletes a list of `ContentType` objects.

###.GetMediaType(int id)
Gets a `MediaType` object by its Id.

###.GetMediaType(string alias)
Gets a `MediaType` object by its Alias.

###.GetAllMediaTypes(params int[] ids)
Gets a list of all available `MediaType` objects.

###.GetMediaTypeChildren(int id);
Gets a list of children for a `MediaType` object by the Parent Id.

###.Save(IMediaType mediaType, int userId = 0)
Saves a single `MediaType` object.

###.Save(IEnumerable<IMediaType> mediaTypes, int userId = 0)
Saves a list of `MediaType` objects.

###.Delete(IMediaType mediaType, int userId = 0)
Deletes a single `MediaType` object.

###.Delete(IEnumerable<IMediaType> mediaTypes, int userId = 0)
Deletes a list of `MediaType` objects.