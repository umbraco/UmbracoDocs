---
meta.Title: "Breaking changes going from Umbraco 10 to 11"
meta.Description: "In this article we list the breaking changes between Umbraco 10 and 11"
---

# Breaking changes

Most breaking changes are introduced due to **updated dependencies**. The breaking changes in .NET 7 and ASP.NET Core 7 are documented by [Microsoft](https://learn.microsoft.com/en-us/dotnet/core/compatibility/7.0).

Besides the documented changes, we have also seen a few method signatures that are changed to support Nullable-Reference-Types.

If you are using **TinyMCE** plugins or custom TinyMCE configuration you need to migrate to the latest version. Learn more about this in the [Rich Text Editor documentation](../../../backoffice/property-editors/built-in-umbraco-property-editors/rich-text-editor).

The breaking changes in TinyMCE are also documented in the official migration guides for [version 4 to 5](https://www.tiny.cloud/docs/migration-from-4x/) and from [version 5 to 6](https://www.tiny.cloud/docs/tinymce/6/migration-from-5x/).

The breaking changes in Umbraco 11 are mainly the removal of classes, methods, and so on, marked as obsolete in Umbraco 9.

A few methods and classes have also been moved and changed namespace. Decoupled dependencies are documented on the [Umbraco Announcements repository](https://github.com/umbraco/Announcements/issues/5).

The full list of API-breaking changes can be found below:

- [Obsolete code removed](#obsolete-code-removed)
- [Code moved to new assemblies and namespaces](#code-moved-to-new-assemblies-and-namespaces)
- [New interface methods](#new-interface-methods)
- [No-Operation methods removed](#no-operation-methods-removed)
- [Classes that do not inherit from base type anymore](#classes-that-does-not-inherit-from-base-type-anymore)
- [Changes due to models made immutable](#changes-due-to-models-made-immutable)

## Obsolete code removed

The following have been removed after having been obsoleted since Umbraco 9.

### Umbraco.Extensions

```csharp
Umbraco.Extensions.ServiceCollectionExtensions.AddUnique<TImplementing>(Microsoft.Extensions.DependencyInjection.IServiceCollection)

Umbraco.Extensions.EnumExtensions.HasFlagAll<T>(T, T)

Umbraco.Extensions.FriendlyImageCropperTemplateExtensions.GetLocalCropUrl(Umbraco.Cms.Core.Models.MediaWithCrops, string, string?)
```

### Umbraco.Cms.Core

```csharp
Umbraco.Cms.Core.Constants.Conventions.Member.IsApproved
Umbraco.Cms.Core.Constants.Conventions.Member.IsApprovedLabel
Umbraco.Cms.Core.Constants.Conventions.Member.IsLockedOut
Umbraco.Cms.Core.Constants.Conventions.Member.IsLockedOutLabel
Umbraco.Cms.Core.Constants.Conventions.Member.LastLoginDate
Umbraco.Cms.Core.Constants.Conventions.Member.LastLoginDateLabel
Umbraco.Cms.Core.Constants.Conventions.Member.LastPasswordChangeDate
Umbraco.Cms.Core.Constants.Conventions.Member.LastPasswordChangeDateLabel
Umbraco.Cms.Core.Constants.Conventions.Member.LastLockoutDate
Umbraco.Cms.Core.Constants.Conventions.Member.LastLockoutDateLabel
Umbraco.Cms.Core.Constants.Conventions.Member.FailedPasswordAttempts
Umbraco.Cms.Core.Constants.Conventions.Member.FailedPasswordAttemptsLabel

Umbraco.Cms.Core.WebAssets.IRuntimeMinifier.Reset()

Umbraco.Cms.Core.Services.IExternalLoginService

Umbraco.Cms.Core.Services.ExternalLoginService.ExternalLoginService(
    Umbraco.Cms.Core.Scoping.ICoreScopeProvider,
    Microsoft.Extensions.Logging.ILoggerFactory,
    Umbraco.Cms.Core.Events.IEventMessagesFactory,
    Umbraco.Cms.Core.Persistence.Repositories.IExternalLoginRepository)

Umbraco.Cms.Core.Services.ExternalLoginService.GetExternalLogins(int)

Umbraco.Cms.Core.Services.ExternalLoginService.GetExternalLoginTokens(int)

Umbraco.Cms.Core.Services.ExternalLoginService.Save(int,
    System.Collections.Generic.IEnumerable<Umbraco.Cms.Core.Security.IExternalLogin>)

Umbraco.Cms.Core.Services.ExternalLoginService.Save(int,
    System.Collections.Generic.IEnumerable<Umbraco.Cms.Core.Security.IExternalLoginToken>)

Umbraco.Cms.Core.Services.ExternalLoginService.DeleteUserLogins(int)

Umbraco.Cms.Core.Services.IMacroWithAliasService

Umbraco.Cms.Core.Services.ITwoFactorLoginService2

Umbraco.Cms.Core.Services.LocalizedTextService.LocalizedTextService(
    System.Collections.Generic.IDictionary<System.Globalization.CultureInfo, System.Collections.Generic.IDictionary<string, System.Collections.Generic.IDictionary<string, string>>>,
    Microsoft.Extensions.Logging.ILogger<Umbraco.Cms.Core.Services.LocalizedTextService>)

Umbraco.Cms.Core.Services.ServiceContext.ServiceContext(
    System.Lazy<Umbraco.Cms.Core.Services.IPublicAccessService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IDomainService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IAuditService>?,
    System.Lazy<Umbraco.Cms.Core.Services.ILocalizedTextService>?,
    System.Lazy<Umbraco.Cms.Core.Services.ITagService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IContentService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IUserService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IMemberService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IMediaService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IContentTypeService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IMediaTypeService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IDataTypeService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IFileService>?,
    System.Lazy<Umbraco.Cms.Core.Services.ILocalizationService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IPackagingService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IServerRegistrationService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IEntityService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IRelationService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IMacroService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IMemberTypeService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IMemberGroupService>?,
    System.Lazy<Umbraco.Cms.Core.Services.INotificationService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IExternalLoginService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IRedirectUrlService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IConsentService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IKeyValueService>?,
    System.Lazy<Umbraco.Cms.Core.Services.IContentTypeBaseServiceProvider>?)

Umbraco.Cms.Core.Services.ServiceContext.CreatePartial(
    Umbraco.Cms.Core.Services.IContentService?,
    Umbraco.Cms.Core.Services.IMediaService?,
    Umbraco.Cms.Core.Services.IContentTypeService?,
    Umbraco.Cms.Core.Services.IMediaTypeService?,
    Umbraco.Cms.Core.Services.IDataTypeService?,
    Umbraco.Cms.Core.Services.IFileService?,
    Umbraco.Cms.Core.Services.ILocalizationService?,
    Umbraco.Cms.Core.Services.IPackagingService?,
    Umbraco.Cms.Core.Services.IEntityService?,
    Umbraco.Cms.Core.Services.IRelationService?,
    Umbraco.Cms.Core.Services.IMemberGroupService?,
    Umbraco.Cms.Core.Services.IMemberTypeService?,
    Umbraco.Cms.Core.Services.IMemberService?,
    Umbraco.Cms.Core.Services.IUserService?,
    Umbraco.Cms.Core.Services.ITagService?,
    Umbraco.Cms.Core.Services.INotificationService?,
    Umbraco.Cms.Core.Services.ILocalizedTextService?,
    Umbraco.Cms.Core.Services.IAuditService?,
    Umbraco.Cms.Core.Services.IDomainService?,
    Umbraco.Cms.Core.Services.IMacroService?,
    Umbraco.Cms.Core.Services.IPublicAccessService?,
    Umbraco.Cms.Core.Services.IExternalLoginService?,
    Umbraco.Cms.Core.Services.IServerRegistrationService?,
    Umbraco.Cms.Core.Services.IRedirectUrlService?,
    Umbraco.Cms.Core.Services.IConsentService?,
    Umbraco.Cms.Core.Services.IKeyValueService?,
    Umbraco.Cms.Core.Services.IContentTypeBaseServiceProvider?)

Umbraco.Cms.Core.Services.TwoFactorLoginService.TwoFactorLoginService(
    Umbraco.Cms.Core.Persistence.Repositories.ITwoFactorLoginRepository,
    Umbraco.Cms.Core.Scoping.ICoreScopeProvider,
    System.Collections.Generic.IEnumerable<Umbraco.Cms.Core.Security.ITwoFactorProvider>,
    Microsoft.Extensions.Options.IOptions<Microsoft.AspNetCore.Identity.IdentityOptions>,
    Microsoft.Extensions.Options.IOptions<Umbraco.Cms.Core.Security.BackOfficeIdentityOptions>)

Umbraco.Cms.Core.Routing.DefaultUrlProvider.DefaultUrlProvider(
    Microsoft.Extensions.Options.IOptionsMonitor<Umbraco.Cms.Core.Configuration.Models.RequestHandlerSettings>,
    Microsoft.Extensions.Logging.ILogger<Umbraco.Cms.Core.Routing.DefaultUrlProvider>,
    Umbraco.Cms.Core.Routing.ISiteDomainMapper,
    Umbraco.Cms.Core.Web.IUmbracoContextAccessor,
    Umbraco.Cms.Core.Routing.UriUtility)

Umbraco.Cms.Core.Persistence.Repositories.IExternalLoginRepository

Umbraco.Cms.Core.Persistence.Repositories.IMacroWithAliasRepository

Umbraco.Cms.Core.Persistence.Repositories.IMemberRepository.SetLastLogin(string, System.DateTime)

Umbraco.Cms.Core.Notifications.UmbracoApplicationComponentsInstallingNotification

Umbraco.Cms.Core.Notifications.UmbracoApplicationMainDomAcquiredNotification


Umbraco.Cms.Core.Notifications.UmbracoApplicationStartingNotification.UmbracoApplicationStartingNotification(Umbraco.Cms.Core.RuntimeLevel)

Umbraco.Cms.Core.Notifications.UmbracoApplicationStoppingNotification.UmbracoApplicationStoppingNotification()

Umbraco.Cms.Core.Models.IContentTypeWithHistoryCleanup

Umbraco.Cms.Core.Models.Language.Language(Umbraco.Cms.Core.Configuration.Models.GlobalSettings, string)

Umbraco.Cms.Core.Models.RelationType.RelationType(string, string, bool, System.Nullable<System.Guid>, System.Nullable<System.Guid>)

Umbraco.Cms.Core.Models.PublishedContent.PublishedContentType.PublishedContentType(int, string,
    Umbraco.Cms.Core.Models.PublishedContent.PublishedItemType,
    System.Collections.Generic.IEnumerable<string>,
    System.Collections.Generic.IEnumerable<Umbraco.Cms.Core.Models.PublishedContent.PublishedPropertyType>,
    Umbraco.Cms.Core.Models.ContentVariation,
    bool)

Umbraco.Cms.Core.Models.PublishedContent.PublishedContentType.PublishedContentType(int, string,
    Umbraco.Cms.Core.Models.PublishedContent.PublishedItemType, System.Collections.Generic.IEnumerable<string>,
    System.Func<Umbraco.Cms.Core.Models.PublishedContent.IPublishedContentType,
    System.Collections.Generic.IEnumerable<Umbraco.Cms.Core.Models.PublishedContent.IPublishedPropertyType>>,
    Umbraco.Cms.Core.Models.ContentVariation,
    bool)

Umbraco.Cms.Core.Models.Mapping.ContentTypeMapDefinition.ContentTypeMapDefinition(
    Umbraco.Cms.Core.Models.Mapping.CommonMapper,
    Umbraco.Cms.Core.PropertyEditors.PropertyEditorCollection,
    Umbraco.Cms.Core.Services.IDataTypeService,
    Umbraco.Cms.Core.Services.IFileService,
    Umbraco.Cms.Core.Services.IContentTypeService,
    Umbraco.Cms.Core.Services.IMediaTypeService,
    Umbraco.Cms.Core.Services.IMemberTypeService,
    Microsoft.Extensions.Logging.ILoggerFactory,
    Umbraco.Cms.Core.Strings.IShortStringHelper,
    Microsoft.Extensions.Options.IOptions<Umbraco.Cms.Core.Configuration.Models.GlobalSettings>,
    Umbraco.Cms.Core.Hosting.IHostingEnvironment)

Umbraco.Cms.Core.Models.ContentEditing.UserGroupPermissionsSave.Validate(System.ComponentModel.DataAnnotations.ValidationContext)

Umbraco.Cms.Core.Install.InstallSteps.TelemetryIdentifierStep.TelemetryIdentifierStep(
    Microsoft.Extensions.Logging.ILogger<Umbraco.Cms.Core.Install.InstallSteps.TelemetryIdentifierStep>,
    Microsoft.Extensions.Options.IOptions<Umbraco.Cms.Core.Configuration.Models.GlobalSettings>,
    Umbraco.Cms.Core.Configuration.IConfigManipulator)

Umbraco.Cms.Core.IO.ViewHelper.ViewHelper(Umbraco.Cms.Core.IO.IFileSystem)

Umbraco.Cms.Core.HealthChecks.Checks.Security.BaseHttpHeaderCheck.BaseHttpHeaderCheck(
    Umbraco.Cms.Core.Hosting.IHostingEnvironment,
    Umbraco.Cms.Core.Services.ILocalizedTextService,
    string,
    string,
    string,
    bool)

Umbraco.Cms.Core.DependencyInjection.UmbracoBuilderExtensions.AddOEmbedProvider<T>(Umbraco.Cms.Core.DependencyInjection.IUmbracoBuilder)

Umbraco.Cms.Core.DependencyInjection.UmbracoBuilderExtensions.OEmbedProviders(Umbraco.Cms.Core.DependencyInjection.IUmbracoBuilder)

Umbraco.Cms.Core.Configuration.Models.RequestHandlerSettings.CharCollection.get
Umbraco.Cms.Core.Configuration.Models.RequestHandlerSettings.CharCollection.set

Umbraco.Cms.Core.Composing.IUserComposer

Umbraco.Cms.Core.Security.BackOfficeUserStore.BackOfficeUserStore(
    Umbraco.Cms.Core.Scoping.ICoreScopeProvider,
    Umbraco.Cms.Core.Services.IUserService,
    Umbraco.Cms.Core.Services.IEntityService,
    Umbraco.Cms.Core.Services.IExternalLoginService,
    Microsoft.Extensions.Options.IOptions<Umbraco.Cms.Core.Configuration.Models.GlobalSettings>,
    Umbraco.Cms.Core.Mapping.IUmbracoMapper,
    Umbraco.Cms.Core.Security.BackOfficeErrorDescriber,
    Umbraco.Cms.Core.Cache.AppCaches)

Umbraco.Cms.Core.Security.MemberUserStore.MemberUserStore(
    Umbraco.Cms.Core.Services.IMemberService,
    Umbraco.Cms.Core.Mapping.IUmbracoMapper,
    Umbraco.Cms.Core.Scoping.ICoreScopeProvider,
    Microsoft.AspNetCore.Identity.IdentityErrorDescriber,
    Umbraco.Cms.Core.PublishedCache.IPublishedSnapshotAccessor,
    Umbraco.Cms.Core.Services.IExternalLoginService)

Umbraco.Cms.Core.Logging.Viewer.ILogViewer.GetLogLevel()

Umbraco.Cms.Core.Logging.Viewer.SerilogLogViewerSourceBase.SerilogLogViewerSourceBase(
    Umbraco.Cms.Core.Logging.Viewer.ILogViewerConfig,
    Serilog.ILogger)

Umbraco.Cms.Core.Logging.Viewer.SerilogLogViewerSourceBase.GetLogLevel()

Umbraco.Cms.Core.Configuration.JsonConfigManipulator.JsonConfigManipulator(Microsoft.Extensions.Configuration.IConfiguration)
```

### Umbraco.Cms.Infrastructure

```csharp
Umbraco.Cms.Infrastructure.Persistence.Repositories.Implement.MemberRepository.SetLastLogin(string, System.DateTime)

Umbraco.Cms.Infrastructure.Packaging.PackageMigrationBase.PackageMigrationBase(
    Umbraco.Cms.Core.Services.IPackagingService,
    Umbraco.Cms.Core.Services.IMediaService,
    Umbraco.Cms.Core.IO.MediaFileManager,
    Umbraco.Cms.Core.PropertyEditors.MediaUrlGeneratorCollection,
    Umbraco.Cms.Core.Strings.IShortStringHelper,
    Umbraco.Cms.Core.Services.IContentTypeBaseServiceProvider,
    Umbraco.Cms.Infrastructure.Migrations.IMigrationContext)

Umbraco.Cms.Infrastructure.Migrations.Install.DatabaseSchemaCreator.DatabaseSchemaCreator(
    Umbraco.Cms.Infrastructure.Persistence.IUmbracoDatabase?,
    Microsoft.Extensions.Logging.ILogger<Umbraco.Cms.Infrastructure.Migrations.Install.DatabaseSchemaCreator>,
    Microsoft.Extensions.Logging.ILoggerFactory,
    Umbraco.Cms.Core.Configuration.IUmbracoVersion,
    Umbraco.Cms.Core.Events.IEventAggregator)

Umbraco.Cms.Infrastructure.Migrations.Install.DatabaseSchemaCreatorFactory.DatabaseSchemaCreatorFactory(
    Microsoft.Extensions.Logging.ILogger<Umbraco.Cms.Infrastructure.Migrations.Install.DatabaseSchemaCreator>,
    Microsoft.Extensions.Logging.ILoggerFactory,
    Umbraco.Cms.Core.Configuration.IUmbracoVersion,
    Umbraco.Cms.Core.Events.IEventAggregator)

Umbraco.Cms.Infrastructure.HostedServices.RecurringHostedServiceBase.RecurringHostedServiceBase(
    System.TimeSpan,
    System.TimeSpan)

Umbraco.Cms.Infrastructure.HostedServices.ReportSiteTask.ReportSiteTask(
    Microsoft.Extensions.Logging.ILogger<Umbraco.Cms.Infrastructure.HostedServices.ReportSiteTask>,
    Umbraco.Cms.Core.Configuration.IUmbracoVersion,
    Microsoft.Extensions.Options.IOptions<Umbraco.Cms.Core.Configuration.Models.GlobalSettings>)
```

### Umbraco.Cms.Web

```csharp
Umbraco.Cms.Web.Common.Security.ConfigureIISServerOptions

Umbraco.Cms.Web.Common.RuntimeMinification.SmidgeRuntimeMinifier.Reset()

Umbraco.Cms.Web.Common.Middleware.UmbracoRequestMiddleware.UmbracoRequestMiddleware(
    Microsoft.Extensions.Logging.ILogger<Umbraco.Cms.Web.Common.Middleware.UmbracoRequestMiddleware>,
    Umbraco.Cms.Core.Web.IUmbracoContextFactory,
    Umbraco.Cms.Core.Cache.IRequestCache,
    Umbraco.Cms.Core.Events.IEventAggregator,
    Umbraco.Cms.Core.Logging.IProfiler,
    Umbraco.Cms.Core.Hosting.IHostingEnvironment,
    Umbraco.Cms.Core.Routing.UmbracoRequestPaths,
    Umbraco.Cms.Infrastructure.WebAssets.BackOfficeWebAssets,
    Microsoft.Extensions.Options.IOptionsMonitor<Smidge.Options.SmidgeOptions>,
    Umbraco.Cms.Core.Services.IRuntimeState,
    Umbraco.Cms.Core.Models.PublishedContent.IVariationContextAccessor,
    Umbraco.Cms.Core.PublishedCache.IDefaultCultureAccessor)

Umbraco.Cms.Web.Website.Controllers.UmbLoginController.UmbLoginController(
    Umbraco.Cms.Core.Web.IUmbracoContextAccessor,
    Umbraco.Cms.Infrastructure.Persistence.IUmbracoDatabaseFactory,
    Umbraco.Cms.Core.Services.ServiceContext,
    Umbraco.Cms.Core.Cache.AppCaches,
    Umbraco.Cms.Core.Logging.IProfilingLogger,
    Umbraco.Cms.Core.Routing.IPublishedUrlProvider,
    Umbraco.Cms.Web.Common.Security.IMemberSignInManager)

Umbraco.Cms.Web.BackOffice.Trees.MemberTypeAndGroupTreeControllerBase.MemberTypeAndGroupTreeControllerBase(
    Umbraco.Cms.Core.Services.ILocalizedTextService,
    Umbraco.Cms.Core.UmbracoApiControllerTypeCollection,
    Umbraco.Cms.Core.Trees.IMenuItemCollectionFactory,
    Umbraco.Cms.Core.Events.IEventAggregator)

Umbraco.Cms.Web.BackOffice.Controllers.CurrentUserController.CurrentUserController(
    Umbraco.Cms.Core.IO.MediaFileManager,
    Microsoft.Extensions.Options.IOptions<Umbraco.Cms.Core.Configuration.Models.ContentSettings>,
    Umbraco.Cms.Core.Hosting.IHostingEnvironment,
    Umbraco.Cms.Core.Media.IImageUrlGenerator,
    Umbraco.Cms.Core.Security.IBackOfficeSecurityAccessor,
    Umbraco.Cms.Core.Services.IUserService,
    Umbraco.Cms.Core.Mapping.IUmbracoMapper,
    Umbraco.Cms.Core.Security.IBackOfficeUserManager,
    Microsoft.Extensions.Logging.ILoggerFactory,
    Umbraco.Cms.Core.Services.ILocalizedTextService,
    Umbraco.Cms.Core.Cache.AppCaches,
    Umbraco.Cms.Core.Strings.IShortStringHelper,
    Umbraco.Cms.Web.Common.Security.IPasswordChanger<Umbraco.Cms.Core.Security.BackOfficeIdentityUser>)

Umbraco.Cms.Web.BackOffice.Controllers.EntityController.GetUrlsByUdis(Umbraco.Cms.Core.Udi[], string?)

Umbraco.Cms.Web.BackOffice.Controllers.HelpController.HelpController(Microsoft.Extensions.Logging.ILogger<Umbraco.Cms.Web.BackOffice.Controllers.HelpController>)

Umbraco.Cms.Web.BackOffice.Controllers.LanguageController.LanguageController(
    Umbraco.Cms.Core.Services.ILocalizationService,
    Umbraco.Cms.Core.Mapping.IUmbracoMapper,
    Microsoft.Extensions.Options.IOptionsSnapshot<Umbraco.Cms.Core.Configuration.Models.GlobalSettings>)

Umbraco.Cms.Web.BackOffice.Controllers.LogViewerController.LogViewerController(Umbraco.Cms.Core.Logging.Viewer.ILogViewer)
Umbraco.Cms.Web.BackOffice.Controllers.LogViewerController.GetLogLevel()

Umbraco.Cms.Web.BackOffice.Controllers.MediaController.GetPagedReferences(int, string, int, int)

Umbraco.Cms.Web.BackOffice.Controllers.MemberTypeController.GetAllTypes()

Umbraco.Cms.Web.BackOffice.Controllers.TemplateController.TemplateController(
    Umbraco.Cms.Core.Services.IFileService,
    Umbraco.Cms.Core.Mapping.IUmbracoMapper,
    Umbraco.Cms.Core.Strings.IShortStringHelper)
```

### Umbraco.Cms.Tests

```csharp
Umbraco.Cms.Tests.Common.Testing.TestOptionAttributeBase.ScanAssemblies
```

## Code moved to new assemblies and namespaces

The following have been moved to new assemblies and their namespaces have been updated accordingly.

### Umbraco.Extensions

```csharp
Umbraco.Extensions.NPocoDatabaseExtensions.ConfigureNPocoBulkExtensions()

Umbraco.Extensions.UmbracoBuilderExtensions.AddUmbracoImageSharp(Umbraco.Cms.Core.DependencyInjection.IUmbracoBuilder)
```

### Umbraco.Cms.Web

```csharp
Umbraco.Cms.Web.Common.Media.ImageSharpImageUrlGenerator

Umbraco.Cms.Web.Common.ImageProcessors.CropWebProcessor

Umbraco.Cms.Web.Common.DependencyInjection.ConfigureImageSharpMiddlewareOptions
Umbraco.Cms.Web.Common.DependencyInjection.ConfigurePhysicalFileSystemCacheOptions
```

### Umbraco.Cms.Infrastructure

```csharp
Umbraco.Cms.Infrastructure.Persistence.LocalDb
Umbraco.Cms.Infrastructure.Persistence.FaultHandling.RetryPolicyFactory
Umbraco.Cms.Infrastructure.Persistence.FaultHandling.ThrottlingMode
Umbraco.Cms.Infrastructure.Persistence.FaultHandling.ThrottlingType
Umbraco.Cms.Infrastructure.Persistence.FaultHandling.ThrottledResourceType
Umbraco.Cms.Infrastructure.Persistence.FaultHandling.ThrottlingCondition
Umbraco.Cms.Infrastructure.Persistence.FaultHandling.Strategies.NetworkConnectivityErrorDetectionStrategy
Umbraco.Cms.Infrastructure.Persistence.FaultHandling.Strategies.SqlAzureTransientErrorDetectionStrategy
```

## New interface methods

A few interfaces have been merged, adding new members to the original interfaces.

### Umbraco.Cms.Core

```csharp
Umbraco.Cms.Core.Services.IMacroService.GetAll(params string[])

Umbraco.Cms.Core.Persistence.Repositories.IMacroRepository.GetByAlias(string)
Umbraco.Cms.Core.Persistence.Repositories.IMacroRepository.GetAllByAlias(string[])

Umbraco.Cms.Core.Services.ITwoFactorLoginService.DisableWithCodeAsync(string, System.Guid, string)
Umbraco.Cms.Core.Services.ITwoFactorLoginService.ValidateAndSaveAsync(string, System.Guid, string, string)

Umbraco.Cms.Core.Models.IContentType.HistoryCleanup

Umbraco.Cms.Core.Media.IImageDimensionExtractor.SupportedImageFileTypes
```

## No-Operation methods removed

A method not doing anything for the last couple of major releases have been removed.

### Umbraco.Cms.Core

```csharp
Umbraco.Cms.Core.Services.IMembershipMemberService<T>.SetLastLogin(string, System.DateTime)
```

## Changes due to models made immutable

A single model have been made immutable, so the default constructor and the setters are not available anymore.

### Umbraco.Cms.Infrastructure

```csharp
Umbraco.Cms.Infrastructure.PublishedCache.DataSource.ContentData.ContentData()
Umbraco.Cms.Infrastructure.PublishedCache.DataSource.ContentData.Name.set
Umbraco.Cms.Infrastructure.PublishedCache.DataSource.ContentData.UrlSegment.set
Umbraco.Cms.Infrastructure.PublishedCache.DataSource.ContentData.VersionId.set
Umbraco.Cms.Infrastructure.PublishedCache.DataSource.ContentData.VersionDate.set
Umbraco.Cms.Infrastructure.PublishedCache.DataSource.ContentData.WriterId.set
Umbraco.Cms.Infrastructure.PublishedCache.DataSource.ContentData.TemplateId.set
Umbraco.Cms.Infrastructure.PublishedCache.DataSource.ContentData.Published.set
Umbraco.Cms.Infrastructure.PublishedCache.DataSource.ContentData.Properties.set
Umbraco.Cms.Infrastructure.PublishedCache.DataSource.ContentData.CultureInfos.set
```

## Classes that does not inherit from base type anymore

The following classes now directly inherit from OEmbedProviderBase instead of EmbedProviderBase.

### Umbraco.Cms.Core

```csharp
Umbraco.Cms.Core.Media.EmbedProviders.DailyMotion
Umbraco.Cms.Core.Media.EmbedProviders.Flickr
Umbraco.Cms.Core.Media.EmbedProviders.GettyImages
Umbraco.Cms.Core.Media.EmbedProviders.Giphy
Umbraco.Cms.Core.Media.EmbedProviders.Hulu
Umbraco.Cms.Core.Media.EmbedProviders.Issuu
Umbraco.Cms.Core.Media.EmbedProviders.Kickstarter
Umbraco.Cms.Core.Media.EmbedProviders.Slideshare
Umbraco.Cms.Core.Media.EmbedProviders.Soundcloud
Umbraco.Cms.Core.Media.EmbedProviders.Ted
Umbraco.Cms.Core.Media.EmbedProviders.Twitter
Umbraco.Cms.Core.Media.EmbedProviders.Vimeo
Umbraco.Cms.Core.Media.EmbedProviders.YouTube
```
