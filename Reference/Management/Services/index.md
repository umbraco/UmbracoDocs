---
versionFrom: 7.0.0
---

# Services Reference

_The services layer of the Umbraco API is used to interact with persisted data, all services can be accessed via the ServiceContext_

The intended audience for these reference pages are .net developers, it is assumed the reader already has a knowledge of the basics of Umbraco and knows .net & c#.

## [AuditService](AuditService)
A service for handling audit.

## [ApplicationTreeService](TreeService)
The ApplicationTreeService is used to control/query the storage for tree registrations.

## [ConsentService](ConsentService)
A service for handling lawful data processing requirements.

## [ContentService](ContentService)
Service for doing CRUD type operations, as well as publishing for `Content` objects.

## [ContentTypeService](ContentTypeService)
Service for doing CRUD type operations against `ContentType` and `MediaType` objects.

## [DataTypeService](DataTypeService)
Service for doing CRUD type operations for `DataTypeDefinition` and `DataType` objects.

## [DomainService](DomainService)
Service for doing CRUD type operations for domains.

## [EntityService](EntityService)
Service for doing CRUD type operations for entities.

## [ExternalLoginService](ExternalLoginService)
Service used to store the external login info.

## [FileService](FileService)
Service for doing CRUD type operations for `Script`, `Stylesheet` and `Template` objects.

## [LocalizationService](LocalizationService)
Service for doing CRUD type operations for `Dictionary` and `Language` objects.

## [MacroService](MacroService)
Defines the MacroService, which is an easy access to operations involving `IMacro`.

## [MediaService](MediaService)
Service for doing CRUD type operations for `Media` objects.

## [MemberService](MemberService)
Service for doing CRUD type operations for `Member` objects.

## [MemberTypeService](MemberTypeService)
Service for doing CRUD type operations for `MemberType` objects.

## [MemberGroupService](MemberGroupService)
Service for doing CRUD type operations for `MemberGroup` objects / Member Roles.

## [NotificationService](NotificationService)
The NotificationServices is used to perform operations related to backoffice notifications.

## [PackagingService](PackagingService)
The PackagingService provides import/export functionality for the Core models of the API.

## [PublicAccessService](PublicAccessService)
Service to handle public access.

## [RedirectUrlService](RedirectUrlService)
The RedirectUrlService is used for CRUD operations related to Redirects.
## [RelationService](RelationService)
Service for doing CRUD type operations for `Relation` and `RelationType` objects.

## [SectionService](SectionService)
Service for doing CRUD type operations for `Section` objects

## [ServerRegistrationService](ServerRegistrationService)
The ServerRegistrationService manages server registrations in the database.

## [TagService](TagService)
Tag service to query for tags in the tags db table.

## [TextService](TextService)
The TextService is the entry point to localize any key in the text storage source for a given culture.

## [UserService](UserService)
Service for managing users, user groups and permissions.
