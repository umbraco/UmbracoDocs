---
versionFrom: 8.0.0
---

# RedirectUrlService

The RedirectUrlService is used for CRUD operations related to Redirects.

[Browse the API documentation for IRedirectUrlService interface](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Services.IRedirectUrlService.html).

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

If you wish to use the redirect url service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the redirect url service through a local `Services` property:

```csharp
IRedirectUrlService redirectUrlService = Services.RedirectUrlService;
```

### Dependency Injection

In other cases, you may be able to use Dependency Injection. For instance if you have registered your own class in Umbraco's dependency injection, you can specify the `IRedirectUrlService` interface in your constructor:

```csharp
public class MyClass
{

    private IRedirectUrlService _redirectUrlService;

	public MyClass(IRedirectUrlService redirectUrlService)
	{
		_redirectUrlService = redirectUrlService;
	}

}
```

### Static accessor

If neither a `Services` property or Dependency Injection is available, you can also reference the static `Current` class directly:

```csharp
IRedirectUrlService redirectUrlService = Umbraco.Core.Composing.Current.Services.RedirectUrlService;
```
