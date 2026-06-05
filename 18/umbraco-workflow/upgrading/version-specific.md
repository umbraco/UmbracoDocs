---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco
  Workflow.
---

# Version Specific Upgrade Notes

This page covers specific upgrade documentation for when migrating to Umbraco Workflow version 18.

{% hint style="info" %}
If you are upgrading to a new minor or patch version, you can find information about the breaking changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

Version 18 of Umbraco Workflow has a minimum dependency on Umbraco CMS core of `18.0.0`. It runs on .NET 10.

## Breaking changes

Version 18 contains a number of breaking changes. The details are listed here.

### Dependencies

* Umbraco CMS dependency was updated to `18.0.0`
* SwaggerGen/Swashbuckle dependency was removed in favor of the built-in `Microsoft.AspNetCore.OpenApi` package

### Database

The `WorkflowUserGroupPermissions` table has been updated: the `NodeId` and `ContentTypeId` columns are consolidated into a single `EntityId` column paired with the existing `EntityType` discriminator. 

A new `WorkflowActionConfig` table is added for storing workflow action configurations.

All legacy migrations (pre-v17) have been removed. Sites upgrading from versions earlier than v17 must first upgrade to v17 before upgrading to v18.

### Namespace reorganization

The flat `Umbraco.Workflow.Core.Models` and `Umbraco.Workflow.Core.ViewModels` namespaces have been dissolved into feature-slice namespaces. If you reference any Workflow types directly, update your `using` statements:

The feature-slice namespaces include `Actions`, `ApprovalGroups`, `ContentApprovals`, `ContentReviews`, `Settings`, `Common`, `Email`, `Document`, `Element`, `AlternateVersions`, `Charts`, `HistoryCleanup`, `ReleaseSets`, and `SignalR`.

DTOs were also renamed from `Poco` to `Dto` suffix to remove the implied coupling to NPoco.

### Code

The list below includes changes raising validation errors `CP0001`, `CP0002` and `CP0006` between versions 17.3.2 and 18.0.0-rc1.

Of note are the removal of split config models in favor of unified `ConfigUpdateRequestModel`, the consolidation of `NodeId`/`ContentTypeId` into `EntityId` on permission models, and the removal of previously obsoleted members on `IWorkflowInstanceResolver`, `IEmailTemplateLocator`, and `IPropertyValueTransformer`.

#### Removed Types

* `Umbraco.Workflow.Core.ContentApprovals.ViewModels.DocumentConfigResponseModel`
* `Umbraco.Workflow.Core.ContentApprovals.ViewModels.DocumentConfigUpdateRequestModel`
* `Umbraco.Workflow.Core.ContentApprovals.ViewModels.DocumentTypeConfigUpdateRequestModel`
* `Umbraco.Workflow.Core.ContentReviews.Models.ContentReviewsNodeQueryResponseModel`
* `Umbraco.Workflow.Core.Models.Enums.IPermissionsModel`
* `Umbraco.Workflow.Web.Api.Configuration.BackOfficeSecurityRequirementsOperationFilter`
* `Umbraco.Workflow.Web.Api.Configuration.GenerateWorkflowSchemaDocumentFilter`
* `Umbraco.Workflow.Web.Api.Configuration.SwaggerParameterAttribute`
* `Umbraco.Workflow.Web.Api.Configuration.SwaggerParameterAttributeFilter`
* `Umbraco.Workflow.Web.Api.Configuration.WorkflowOperationIdHandler`
* `Umbraco.Workflow.Web.Api.Configuration.WorkflowSchemaIdHandler`

#### Removed Members

* `Umbraco.Workflow.Core.ApprovalGroups.Models.ApprovalGroupPermissionsDto.get_NodeId`
* `Umbraco.Workflow.Core.ApprovalGroups.Models.ApprovalGroupPermissionsDto.get_ContentTypeId`
* `Umbraco.Workflow.Core.ContentApprovals.Models.PermissionRequestModel.get_NodeId`
* `Umbraco.Workflow.Core.ContentApprovals.Models.WorkflowSearchFilterModel.get_NodeId`
* `Umbraco.Workflow.Core.ContentApprovals.Processes.IWorkflowInstanceResolver.CompleteForScheduler`
* `Umbraco.Workflow.Core.ContentApprovals.Processes.IWorkflowInstanceResolver.CompleteNow`
* `Umbraco.Workflow.Core.ContentReviews.Models.ContentReviewsScaffoldModel.get_Culture`
* `Umbraco.Workflow.Core.ContentReviews.Models.ContentReviewConfigPoco.SplitPath`
* `Umbraco.Workflow.Core.Email.Interfaces.IEmailTemplateLocator.GetEmailTemplateInfo`
* `Umbraco.Workflow.Core.Email.Interfaces.IEmailTemplateLocator.GetEmailTemplateVirtualPath`
* `Umbraco.Workflow.Core.Email.Interfaces.IEmailTemplateLocator.InstallTemplates`
* `Umbraco.Workflow.Core.Email.Interfaces.IEmailTemplateLocator.GetViewEngineResult`
* `Umbraco.Workflow.Core.AlternateVersions.Services.IPropertyValueTransformer.ForDisplay(IEnumerable<PropertyDataDto>, Guid, Guid)`
* `Umbraco.Workflow.Core.AlternateVersions.Services.IPropertyValueTransformer.ForPersistence(IEnumerable<PropertyDataDto>, Guid, Guid)`
* `Umbraco.Workflow.Core.Settings.ViewModels.WorkflowSettingsPropertiesViewModel.GeneralSettingsViewModel.get_DocumentTypeApprovalFlows`
* `Umbraco.Workflow.Web.Api.Controllers.Email.InstallEmailTemplateController` (removed `install-sync` endpoint)
* `Umbraco.Workflow.Web.Api.Controllers.Information.GetInformationController` (removed obsolete constructor overload)

#### Added Interface Members (Breaking)

* `Umbraco.Workflow.Core.ContentApprovals.Processes.IWorkflowInstanceResolver.CompleteForSchedulerAsync` (default implementation removed, now required)
* `Umbraco.Workflow.Core.ContentApprovals.Processes.IWorkflowInstanceResolver.CompleteNowAsync` (default implementation removed, now required)
* `Umbraco.Workflow.Core.Email.Interfaces.IEmailTemplateLocator.InstallTemplatesAsync` (default implementation removed, now required)
* `Umbraco.Workflow.Core.Email.Interfaces.IEmailTemplateLocator.GetViewPath` (default implementation removed, now required)
* `Umbraco.Workflow.Core.AlternateVersions.Services.IPropertyValueTransformer.ForDisplay(AlternateVersionDto)` (default implementation removed, now required)
* `Umbraco.Workflow.Core.AlternateVersions.Services.IPropertyValueTransformer.ForPersistenceAsync` (default implementation removed, now required)

### Localization

Status localization keys in the `workflow` section have changed from integer-based to camelCase:

| Old Key | New Key |
|---|---|
| `status1` | `approved` |
| `status2` | `rejected` |
| `status3` | `pendingApproval` |
| `status4` | `notRequired` |
| `status5` | `cancelled` |
| `status6` | `errored` |
| `status7` | `resubmitted` |
| `status8` | `cancelledByThirdParty` |
| `status9` | `excluded` |
| `status10` | `awaitingResubmission` |

This applies to both the XML language files (server-side) and TypeScript language dictionaries (client-side). Custom email templates or integrations referencing the old `statusN` keys must be updated.

### OpenAPI

SwaggerGen/Swashbuckle has been replaced with `Microsoft.AspNetCore.OpenApi`. The changes in Workflow follow those introduced in the CMS.

### Frontend

* TypeScript enums have been replaced with string-union types. If you reference Workflow enums in custom extensions, update to use the string values directly.
* The `@umbraco-workflow/backoffice` NPM package has been restructured with static imports, reducing chunk count and overall bundle size. Custom extensions importing from the package should verify their import paths are still valid.

### Legacy version specific upgrade notes

You can find the version specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/tree/umbraco-eol-versions).
