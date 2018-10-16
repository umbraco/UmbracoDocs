# ContentTypeService

**Applies to Umbraco 6.x and newer**

The ContentTypeService acts as a "gateway" to Umbraco data for operations which are related to ContentTypes and MediaTypes.

[Browse the API documentation for ContentTypeService](https://our.umbraco.com/apidocs/csharp/api/Umbraco.Core.Services.ContentTypeService.html).

 * **Namespace:** `Umbraco.Core.Services` 
 * **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statements:
	
	using Umbraco.Core;
	using Umbraco.Core.Models;
	using Umbraco.Core.Services;

## Getting the service

If you wish to use use the content type service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the content type service through a local `Services` property:

	IContentTypeService contentTypeService = Services.ContentTypeService;

In Razor views, you can access the content type service through the `ApplicationContext` property:

    IContentTypeService contentTypeService = ApplicationContext.Services.ContentTypeService;

If neither a `Services` property or a `ApplicationContext` property is available, you can also reference the `ApplicationContext` class directly and using the static `Current` property:

	IContentTypeService contentTypeService = ApplicationContext.Current.Services.ContentTypeService;
