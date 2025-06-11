---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco
  Workflow.
---

# Version Specific Upgrade Notes

This page covers specific upgrade documentation for when migrating to Umbraco Workflow version 16.

{% hint style="info" %}
If you are upgrading to a new minor or patch version, you can find information about the breaking changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

Version 16 of Umbraco Workflow has a minimum dependency on Umbraco CMS core of `16.0.0`. It runs on .NET 9.

## Breaking changes

Version 16 contains a number of breaking changes. The details are listed here:

### Dependencies

* Umbraco CMS dependency was updated to `16.0.0`

### Code

The list below includes all changes raising validation errors `CP0001`, `CP0002` and `CP0006` between versions 15.1.5 and 16.0.0.

Of note are changes to API controller constructors to accept an `IWorkflowProcessFactory` argument and the removal of `IInstancesService.Create` (`IWorkflowInstanceGenerator.Create` should be used instead). Other changes are not typical extension or integration points, but are listed below for reference.

#### Removed Types
- `Umbraco.Workflow.Core.Models.GlobalUserVariablesModel`
- `Umbraco.Workflow.Core.Models.GlobalVariablesModel`
- `Umbraco.Workflow.Core.Models.OptionType`
- `Umbraco.Workflow.Core.Processes.ICompleteWorkflowInstances`
- `Umbraco.Workflow.Web.Api.Controllers.Settings.GetVersionSettingsController`

#### Removed Members
- `Umbraco.Workflow.Core.ApprovalGroups.Services.IGroupService.GetUserGroupWithUsers``1(System.Guid)`
- `Umbraco.Workflow.Core.ApprovalGroups.ViewModels.ApprovalGroupDetailPermissionConfigModel.get_ApprovalThreshold`
- `Umbraco.Workflow.Core.ApprovalGroups.ViewModels.DocumentTypePermissionConfigModel.get_ApprovalThreshold`
- `Umbraco.Workflow.Core.Email.Models.HtmlEmailModel.#ctor(Umbraco.Cms.Core.Services.ILocalizedTextService,Umbraco.Cms.Core.Services.IUserService,Umbraco.Workflow.Core.Configuration.ColorSettings)`
- `Umbraco.Workflow.Core.Models.Enums.WorkflowType.Both`
- `Umbraco.Workflow.Core.Models.GlobalWorkflowVariablesModel.get_DefaultApprovalThreshold`
- `Umbraco.Workflow.Core.Models.GlobalWorkflowVariablesModel.get_FlowType`
- `Umbraco.Workflow.Core.Models.ScaffoldRequestModel.get_ContentTypeKey`
- `Umbraco.Workflow.Core.Models.ScaffoldRequestModel.set_ContentTypeKey(System.Guid)`
- `Umbraco.Workflow.Core.Persistence.ITasksRepository.GetActiveByNodeId(System.Int32)`
- `Umbraco.Workflow.Core.Processes.IWorkflowProcessGenerator.GetProcess(Umbraco.Workflow.Core.Models.Enums.WorkflowType)`
- `Umbraco.Workflow.Core.Services.IInstancesService.Create(Umbraco.Workflow.Core.ViewModels.InitiateWorkflowRequestModel)`
- `Umbraco.Workflow.Core.Services.ITasksService.GetActiveTasksByNodeId(System.Int32,System.String)`
- `Umbraco.Workflow.Core.Services.ScaffoldService.#ctor(Umbraco.Workflow.Core.Services.ITasksService,Umbraco.Workflow.Core.Services.IConfigService,Umbraco.Workflow.Core.ContentReviews.Services.IContentReviewService,Umbraco.Workflow.Core.Persistence.IContentRepository,Umbraco.Workflow.Core.Services.ISettingsService,Umbraco.Cms.Core.Mapping.IUmbracoMapper,Umbraco.Cms.Core.Services.IIdKeyMap,Umbraco.Cms.Core.Services.IContentService)`
- `Umbraco.Workflow.Core.ViewModels.InstanceDetailViewModel.get_Status`
- `Umbraco.Workflow.Core.ViewModels.InstanceDetailViewModel.get_Type`
- `Umbraco.Workflow.Core.ViewModels.InstanceDetailViewModel.get_WorkflowStatus`
- `Umbraco.Workflow.Core.ViewModels.InstanceDetailViewModel.get_WorkflowType`
- `Umbraco.Workflow.Core.ViewModels.InstanceDetailViewModel.set_WorkflowStatus(Umbraco.Workflow.Core.Models.Enums.WorkflowStatus)`
- `Umbraco.Workflow.Core.ViewModels.InstanceDetailViewModel.set_WorkflowType(Umbraco.Workflow.Core.Models.Enums.WorkflowType)`
- `Umbraco.Workflow.Core.ViewModels.LanguageViewModel.get_IsDefault`
- `Umbraco.Workflow.Core.ViewModels.LanguageViewModel.set_IsDefault(System.Boolean)`
- `Umbraco.Workflow.Core.ViewModels.UserItemModel.set_Name(System.String)`
- `Umbraco.Workflow.Core.ViewModels.UserItemModel.set_Unique(System.Guid)`
- `Umbraco.Workflow.Core.ViewModels.WorkflowInstanceViewModel.get_StatusName`
- `Umbraco.Workflow.Core.ViewModels.WorkflowInstanceViewModel.get_TypeDescription`
- `Umbraco.Workflow.Core.ViewModels.WorkflowInstanceViewModel.set_StatusName(System.String)`
- `Umbraco.Workflow.Core.ViewModels.WorkflowInstanceViewModel.set_TypeDescription(System.String)`
- `Umbraco.Workflow.Core.ViewModels.WorkflowTaskCollectionViewModel.get_ApprovalsText`
- `Umbraco.Workflow.Core.ViewModels.WorkflowTaskCollectionViewModel.set_ApprovalsText(System.String)`
- `Umbraco.Workflow.Core.ViewModels.WorkflowTaskViewModel.get_Status`
- `Umbraco.Workflow.Core.ViewModels.WorkflowTaskViewModel.get_TypeDescription`
- `Umbraco.Workflow.Core.ViewModels.WorkflowTaskViewModel.get_TypeId`
- `Umbraco.Workflow.Core.ViewModels.WorkflowTaskViewModel.set_TypeDescription(System.String)`
- `Umbraco.Workflow.Core.ViewModels.WorkflowTaskViewModel.set_TypeId(System.Int32)`
- `Umbraco.Workflow.Web.Api.Controllers.Action.ApproveActionController.#ctor(Umbraco.Workflow.Core.Services.IInstancesService,Umbraco.Workflow.Core.Processes.IWorkflowProcessGenerator,Umbraco.Workflow.Core.Mapping.IWorkflowActionResponsePresentationMapper)`
- `Umbraco.Workflow.Web.Api.Controllers.Action.ApproveOrRejectActionController.#ctor(Umbraco.Workflow.Core.Services.IInstancesService,Umbraco.Workflow.Core.Processes.IWorkflowProcessGenerator,Umbraco.Workflow.Core.Mapping.IWorkflowActionResponsePresentationMapper)`
- `Umbraco.Workflow.Web.Api.Controllers.Action.CancelActionController.#ctor(Umbraco.Workflow.Core.Services.IInstancesService,Umbraco.Workflow.Core.Processes.IWorkflowProcessGenerator,Umbraco.Workflow.Core.Mapping.IWorkflowActionResponsePresentationMapper)`
- `Umbraco.Workflow.Web.Api.Controllers.Action.RejectActionController.#ctor(Umbraco.Workflow.Core.Services.IInstancesService,Umbraco.Workflow.Core.Processes.IWorkflowProcessGenerator,Umbraco.Workflow.Core.Mapping.IWorkflowActionResponsePresentationMapper)`
- `Umbraco.Workflow.Web.Api.Controllers.Action.RequiresInstanceActionController.#ctor(Umbraco.Workflow.Core.Services.IInstancesService,Umbraco.Workflow.Core.Processes.IWorkflowProcessGenerator,Umbraco.Workflow.Core.Mapping.IWorkflowActionResponsePresentationMapper)`
- `Umbraco.Workflow.Web.Api.Controllers.Action.ResubmitActionController.#ctor(Umbraco.Workflow.Core.Services.IInstancesService,Umbraco.Workflow.Core.Mapping.IWorkflowActionResponsePresentationMapper,Umbraco.Workflow.Core.Processes.IWorkflowProcessGenerator)`
- `Umbraco.Workflow.Web.Api.Controllers.ApprovalGroup.DeleteApprovalGroupController.#ctor(Umbraco.Workflow.Core.ApprovalGroups.Services.IGroupService,Umbraco.Cms.Core.Security.IBackOfficeSecurityAccessor,Umbraco.Workflow.Core.Services.IInstancesService,Umbraco.Workflow.Core.Processes.IWorkflowProcessGenerator,Umbraco.Workflow.Core.Services.INotificationsService,Umbraco.Workflow.Core.Services.IConfigService)`
- `Umbraco.Workflow.Web.Api.Controllers.Information.GetInformationController.#ctor(Umbraco.Cms.Core.PublishedCache.IDefaultCultureAccessor,Umbraco.Cms.Core.Security.IBackOfficeSecurityAccessor,Umbraco.Cms.Core.Services.ILanguageService,Microsoft.Extensions.Options.IOptions{Umbraco.Workflow.Core.HistoryCleanup.Configuration.HistoryCleanup},Umbraco.Workflow.Core.Services.ISettingsService,Umbraco.Workflow.Core.SignalR.WorkflowHubRoutes)`
- `Umbraco.Workflow.Web.Api.Controllers.Information.GetInformationController.WorkflowInformationResponseModel.get_GlobalVariables`
- `Umbraco.Workflow.Web.Api.Controllers.Scaffold.GetScaffoldController.Get(Umbraco.Workflow.Core.Models.ScaffoldRequestModel)`

#### Added Interface Members (Breaking)
- `Umbraco.Workflow.Core.Persistence.IDatabaseAccessor.Execute(NPoco.Sql)`
- `Umbraco.Workflow.Core.Persistence.IDatabaseAccessor.ExecuteScalar``1(NPoco.Sql)`
- `Umbraco.Workflow.Core.Persistence.ITasksRepository.GetActiveByNodeId(System.Int32,System.String)`
- `Umbraco.Workflow.Core.Persistence.IWorkflowRepository``1.GetIdForKey``1(System.Guid)`
- `Umbraco.Workflow.Core.Services.ITasksService.GetActiveTasksByNodeId(System.Int32,System.String,System.String)`

### Legacy version specific upgrade notes

You can find the version specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/tree/umbraco-eol-versions).
