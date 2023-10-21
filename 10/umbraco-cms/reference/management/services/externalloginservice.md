# ExternalLoginService

The ExternalLoginService is used to store the external login info and can be replaced with your own implementation.

[Browse the API documentation for IEntityService interface](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Core.Services.IExternalLoginService.html).

* **Namespace:** `Umbraco.Cms.Core.Services`
* **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statements:

```csharp
using Umbraco.Cms.Core.Services;
```

## Getting the service

### Dependency Injection

If you wish to use the entity service in a class, you need to specify the `IExternalLoginService` interface in your constructor:

```csharp
public class MyClass
{
	private IExternalLoginService _externalLoginService;

	public MyClass(IExternalLoginService externalLoginService)
	{
		_externalLoginService = externalLoginService;
	}
}
```

In Razor views, you can access the entity service through the `@inject` directive:

```csharp
@inject IExternalLoginService ExternalLoginService
```