---
versionFrom: 8.0.0
---

# ServerRegistrationService

The ServerRegistrationService manages server registrations in the database.

[Browse the API documentation for IServerRegistrationService interface](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Services.IServerRegistrationService.html).

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

If you wish to use the server registration service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the server registration service through a local `Services` property:

```csharp
IServerRegistrationService serverRegistrationService = Services.ServerRegistrationService;
```

### Dependency Injection

In other cases, you may be able to use Dependency Injection. For instance if you have registered your own class in Umbraco's dependency injection, you can specify the `IServerRegistrationService` interface in your constructor:

```csharp
public class MyClass
{

    private IServerRegistrationService _serverRegistrationService;

	public MyClass(IServerRegistrationService serverRegistrationService)
	{
		_serverRegistrationService = serverRegistrationService;
	}

}
```

### Static accessor

If neither a `Services` property or Dependency Injection is available, you can also reference the static `Current` class directly:

```csharp
IServerRegistrationService serverRegistrationService = Umbraco.Core.Composing.Current.Services.ServerRegistrationService;
```
