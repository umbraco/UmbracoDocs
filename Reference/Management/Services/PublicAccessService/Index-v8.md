---
versionFrom: 8.0.0
---

# PublicAccessService

Service to handle public access.

[Browse the API documentation for IPublicAccessService interface](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Services.IPublicAccessService.html).

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

If you wish to use the public access service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the public access service through a local `Services` property:

```csharp
IPublicAccessService publicAccessService = Services.PublicAccessService;
```

### Dependency Injection

In other cases, you may be able to use Dependency Injection. For instance if you have registered your own class in Umbraco's dependency injection, you can specify the `IPublicAccessService` interface in your constructor:

```csharp
public class MyClass
{

    private IPublicAccessService _publicAccessService;

	public MyClass(IPublicAccessService publicAccessService)
	{
		_publicAccessService = publicAccessService;
	}

}
```

### Static accessor

If neither a `Services` property or Dependency Injection is available, you can also reference the static `Current` class directly:

```csharp
IPublicAccessService publicAccessService = Umbraco.Core.Composing.Current.Services.PublicAccessService;
```
