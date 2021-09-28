---
versionFrom: 8.0.0
---

# NotificationService

The NotificationServices is used to perform operations related to backoffice notifications. 

[Browse the API documentation for INotificationService interface](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Services.INotificationService.html).

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

If you wish to use use the notification service in a class that inherits from one of the Umbraco base classes (eg. `SurfaceController`, `UmbracoApiController` or `UmbracoAuthorizedApiController`), you can access the notification service through a local `Services` property:

```csharp
INotificationService notificationService = Services.NotificationService;
```

### Dependency Injection

In other cases, you may be able to use Dependency Injection. For instance if you have registered your own class in Umbraco's dependency injection, you can specify the `INotificationService` interface in your constructor:

```csharp
public class MyClass
{

    private INotificationService _notificationService;

	public MyClass(INotificationService notificationService)
	{
		_notificationService = notificationService;
	}

}
```

### Static accessor

If neither a `Services` property or Dependency Injection is available, you can also reference the static `Current` class directly:

```csharp
INotificationService notificationService = Umbraco.Core.Composing.Current.Services.NotificationService;
```
