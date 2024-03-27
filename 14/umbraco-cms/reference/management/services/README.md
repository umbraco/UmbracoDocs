---
description: List of service references along with instructions on how to use them, as well as some examples for better understanding.
---

# Service References

Below you can find a list of most common services:

## [AuditService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.IAuditService.html)

## [ConsentService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.IConsentService.html)

## [DataTypeService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.IDataTypeService.html)

## [DomainService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.IDomainService.html)

## [EntityService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.IEntityService.html)

## [ExternalLoginService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.ExternalLoginService.html)

## [FileService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.IFileService.html)

## [MediaService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.IMediaService.html)

## [MemberGroupService](https://apidocs.umbraco.com/v13/csharp/api/Umbraco.Cms.Core.Services.IMemberGroupService.html)

## [MemberService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.IMemberService.html)

## [MemberTypeService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.IMemberTypeService.html)

## [NotificationService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.INotificationService.html)

## [PackagingService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.IPackagingService.html)

## [PublicAccessService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.IPublicAccessService.html)

## [RedirectUrlService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.IRedirectUrlService.html)

## [RelationService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.IRelationService.html)

## [ServerRegistrationService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.IServerRegistrationService.html)

## [TagService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.ITagService.html)

## [LocalizedTextService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.LocalizedTextService.html)

## [ContentService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.IContentService.html)

## [ContentTypeService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.IContentTypeService.html)

## [LocalizationService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.ILocalizationService.html)

## [UserService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.IUserService.html)

You can find a list of all supported services in the [API Docs](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.html).

# Getting a Service

All services can be accessed with the following using statement:

```csharp
using Umbraco.Cms.Core.Services;
```

In some cases, you can use [Dependency Injection](https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection). For example, if you have registered your class in Umbraco's dependency injection, you can specify the service interface in your constructor.

For example, if you use a `NotificationService` you can use Dependency Injection via the `INotificationService` interface like this:

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

You can use the above example for other services where you can replace the interface and service name.

# Samples

* [Consent Service Example](./consentservice.md)
Example of how to work with a Consent.
* [User Service Example](./create-a-new-user.md)
Example of adding a user to a user group.
* [Content Service Example](./create-content-programmatically.md)
Example of creating content programmatically.
* [Media Service Example](./mediaservice.md)
Examples of how to create a new folder and a new media item from a stream.
* [Relation Service Example](./relationservice.md)
Example of how to automatically relate to root node.
* [Content Type Service Example](./retrieving-content-types.md)
Examples of how to retrieve content types and content type containers.
* [Localization Service Example](./retrieving-languages.md)
Example on how to retrieve languages.
