---
versionFrom: 7.0.0
versionTo: 9.0.0
---

# Services Reference

_The services layer of the Umbraco API is used to interact with persisted data, all services can be accessed via the ServiceContext._

{% hint style="info" %}
Since the release of Umbraco 10, we will no longer be updating the articles in this section.

You can find up-to-date code references for all Models in our [API Documentation](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Core.Services.html).
{% endhint %}

The intended audience for these reference pages are .NET developers. It is assumed the reader already has knowledge of the basics of Umbraco and knows .NET & C#.

## [AuditService](auditservice.md)

A service for handling audit.

## [ConsentService](consentservice.md)

A service for handling lawful data processing requirements.

## [ContentService](contentservice/)

Service for doing CRUD type operations, as well as publishing for `Content` objects.

## [ContentTypeService](contenttypeservice/)

Service for doing CRUD type operations against `ContentType` and `MediaType` objects.

## [DataTypeService](datatypeservice.md)

Service for doing CRUD type operations for `DataTypeDefinition` and `DataType` objects.

## [DomainService](domainservice.md)

Service for doing CRUD type operations for domains.

## [EntityService](entityservice.md)

Service for doing CRUD type operations for entities.

## [ExternalLoginService](externalloginservice.md)

Service used to store the external login info.

## [FileService](fileservice.md)

Service for doing CRUD type operations for `Script`, `Stylesheet` and `Template` objects.

## [LocalizationService](localizationservice/)

Service for doing CRUD type operations for `Dictionary` and `Language` objects.

## [MacroService](macroservice.md)

Defines the MacroService, which is a way to access operations involving `IMacro`.

## [MediaService](mediaservice.md)

Service for doing CRUD type operations for `Media` objects.

## [MemberService](memberservice.md)

Service for doing CRUD type operations for `Member` objects.

## [MemberTypeService](membertypeservice.md)

Service for doing CRUD type operations for `MemberType` objects.

## [MemberGroupService](membergroupservice.md)

Service for doing CRUD type operations for `MemberGroup` objects / Member Roles.

## [NotificationService](notificationservice.md)

The NotificationServices is used to perform operations related to backoffice notifications.

## [PackagingService](packagingservice.md)

The PackagingService provides import/export functionality for the Core models of the API.

## [PublicAccessService](publicaccessservice.md)

Service to handle public access.

## [RedirectUrlService](redirecturlservice.md)

The RedirectUrlService is used for CRUD operations related to Redirects.

## [RelationService](relationservice.md)

Service for doing CRUD type operations for `Relation` and `RelationType` objects.

## [ServerRegistrationService](serverregistrationservice.md)

The ServerRegistrationService manages server registrations in the database.

## [TagService](tagservice.md)

Tag service to query for tags in the tags db table.

## [TextService](textservice.md)

The TextService is the entry point to localize any key in the text storage source for a given culture.

## [UserService](userservice/)

Service for managing users, user groups and permissions.
