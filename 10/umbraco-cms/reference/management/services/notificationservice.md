# NotificationService

The NotificationServices is used to perform operations related to backoffice notifications.

[Browse the API documentation for INotificationService interface](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Core.Services.INotificationService.html).

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

In Razor views, you can access the member type service through the `@inject` directive:

```csharp
@inject INotificationService NotificationService
```