# LocalizationService

**Applies to Umbraco 6.x and newer**

The LocalizationService acts as a "gateway" to Umbraco data for operations which are related to Dictionary items and Languages.

[Browse the API documentation for LocalizationService](https://our.umbraco.com/apidocs/csharp/api/Umbraco.Core.Services.LocalizationService.html).

 * **Namespace:** `Umbraco.Core.Services` 
 * **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statements:
	
	using Umbraco.Core;
	using Umbraco.Core.Models;
	using Umbraco.Core.Services;

## Getting the service

If you wish to use use the localization service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the localization service through a local `Services` property:

	ILocalizationService localizationService = Services.LocalizationService;
	
In Razor views, you can access the localization service through the `ApplicationContext` property:

    ILocalizationService localizationService = ApplicationContext.Services.LocalizationService;

If neither a `Services` property or a `ApplicationContext` property is available, you can also reference the `ApplicationContext` class directly and using the static `Current` property:

	ApplicationContext.Current.Services.LocalizationService

## Samples

* [**Retrieving languages**](Retrieving-languages.md)<br />See examples on how to retrieve languages via the localization service - either individually or as a collection.
