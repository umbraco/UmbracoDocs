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

**Please note that this page will be updated with samples and additional information about the methods listed below**

## Getting the service
The ContentTypeService is available through the `ApplicationContext`, but the if you are using a `SurfaceController` or the `UmbracoUserControl` then the ContentTypeService is available through a local `Services` property.

	Services.ContentTypeService

Getting the service through the `ApplicationContext`:

	ApplicationContext.Current.Services.ContentTypeService
