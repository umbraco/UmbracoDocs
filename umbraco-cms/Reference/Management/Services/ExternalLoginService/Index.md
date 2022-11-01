---
versionFrom: 8.0.0
---

# ExternalLoginService

The ExternalLoginService is used to store the external login info and can be replaced with your own implementation.

[Browse the API documentation for IExternalLoginService interface](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Services.IExternalLoginService.html).

 * **Namespace:** `Umbraco.Core.Services` 
 * **Assembly:** `Umbraco.Core.dll`

 All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statements:

```csharp
using Umbraco.Core;
using Umbraco.Core.Models;
using Umbraco.Core.Services;
```

## Getting the service

### Services property

If you wish to use use the external login service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the external login service through a local `Services` property:

```csharp
IExternalLoginService externalLoginService = Services.ExternalLoginService;
```

### Dependency Injection

In other cases, you may be able to use Dependency Injection. For instance if you have registered your own class in Umbraco's dependency injection, you can specify the `IExternalLoginService` interface in your constructor:

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

### Static accessor

If neither a `Services` property or Dependency Injection is available, you can also reference the static `Current` class directly:

```csharp
IExternalLoginService externalLoginService = Umbraco.Core.Composing.Current.Services.ExternalLoginService;
```
