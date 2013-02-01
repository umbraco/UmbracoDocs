#MediaService

**Applies to Umbraco 6.x and newer**

The MediaService acts as a "gateway" to Umbraco data for operations which are related to Media.

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
The MediaService is available through the `ApplicationContext`, but the if you are using a `SurfaceController` or the `UmbracoUserControl` then the MediaService is available through a local `Services` property.

	Services.MediaService

Getting the service through the `ApplicationContext`:

	ApplicationContext.Current.Services.MediaService

##Methods