# DomainService

The domain service acts as a "gateway" to Umbraco data for operations which are related to domains.

[Browse the API documentation for DomainService](https://our.umbraco.com/apidocs/csharp/api/Umbraco.Core.Services.DomainService.html).

 * **Namespace:** `Umbraco.Core.Services` 
 * **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statements:
	
	using Umbraco.Core;
	using Umbraco.Core.Models;
	using Umbraco.Core.Services;

## Getting the service

If you wish to use use the domain service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the domain service through a local `Services` property:

	IDomainService domainService = Services.DomainService;

In Razor views, you can access the domain service through the `ApplicationContext` property:

    IDomainService domainService = ApplicationContext.Services.DomainService;

If neither a `Services` property or a `ApplicationContext` property is available, you can also reference the `ApplicationContext` class directly and using the static `Current` property:

	IDomainService domainService = ApplicationContext.Current.Services.DomainService;
