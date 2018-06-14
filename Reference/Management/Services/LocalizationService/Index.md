# LocalizationService

**Applies to Umbraco 6.x and newer**

The LocalizationService acts as a "gateway" to Umbraco data for operations which are related to Dictionary items and Languages.

[Browse the API documentation for LocalizationService](https://our.umbraco.org/apidocs/csharp/api/Umbraco.Core.Services.LocalizationService.html).

 * **Namespace:** `Umbraco.Core.Services` 
 * **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following usings:
	
	using Umbraco.Core;
	using Umbraco.Core.Models;
	using Umbraco.Core.Services;

**Please note that this page will be updated with samples and additional information about the methods listed below**

## Getting the service
The LocalizationService is available through the `ApplicationContext`, but the if you are using a `SurfaceController` or the `UmbracoUserControl` then the LocalizationService is available through a local `Services` property.

	Services.LocalizationService

Getting the service through the `ApplicationContext`:

	ApplicationContext.Current.Services.LocalizationService
