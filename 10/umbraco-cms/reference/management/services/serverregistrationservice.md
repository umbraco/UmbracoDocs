# ServerRegistrationService

The ServerRegistrationService manages server registrations in the database.

[Browse the API documentation for IServerRegistrationService interface](https://apidocs.umbraco.com/v11/csharp/api/Umbraco.Cms.Core.Services.IServerRegistrationService.html).

* **Namespace:** `Umbraco.Cms.Core.Services`
* **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

The Umbraco.Core.dll allows you to reference the Constants classes used in the below examples.

All samples in this document will require the following using statements:

```csharp
using Umbraco.Cms.Core.Services;
```

For Razor views:

```csharp
@using Umbraco.Cms.Core.Services
```

## Getting the service

### Dependency Injection

If you wish to use the server registration service in a class, you need to specify the IServerRegistrationService interface in your constructor:

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

In Razor views, you can access the server registration service through the @inject directive:

```csharp
@inject IServerRegistrationService ServerRegistrationService
```
