---
description: List of service references along with instructions on how to use them, as well as some examples for better understanding.
---

# Using Umbraco services

In this article you can learn how to use and work with some of the services provided with Umbraco CMS.

You can find a list of all supported services in the [API Documentation](https://apidocs.umbraco.com/v17/csharp/api/Umbraco.Cms.Core.Services.html).

## Getting a Service

All services can be accessed with the following using statement:

```csharp
using Umbraco.Cms.Core.Services;
```

In some cases, you can use [Dependency Injection](https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection). For example, if you have registered your class in Umbraco's dependency injection, you can specify the service interface in your constructor.

To use the `NotificationService` you can use Dependency Injection via the `INotificationService` interface like this:

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

In Razor views, you can access the Notification Service through the `@inject` directive:

```csharp
@inject INotificationService NotificationService
```

Use the above example for other services by replacing the interface and the name of the service.

## Examples on using services

* [Consent Service](./consentservice.md)
* [User Service](./userservice.md)
* [Content Service](./contentservice.md)
* [Media Service](./mediaservice.md)
* [Relation Service](./relationservice.md)
* [Content Type Service](./contenttypeservice.md)
* [Localization Service](./localizationservice.md)
