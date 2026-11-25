---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco
  Workflow.
---

# Version Specific Upgrade Notes

This page covers specific upgrade documentation for when migrating to Umbraco Workflow version 19.

{% hint style="info" %}
If you are upgrading to a new minor or patch version, you can find information about the breaking changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

Version 19 of Umbraco Workflow has a minimum dependency on Umbraco CMS core of `19.0.0`. It runs on .NET 11.

## Breaking changes

Version 19 contains a number of breaking changes. The details are listed here.

### Dependencies

* Umbraco CMS dependency was updated to `19.0.0`.
* The target framework was updated to .NET 11.
* CsvHelper was updated to version 34. It no longer supports `ClassMap<T>`.

### Search

Umbraco CMS 19 replaces Examine with new search abstractions. Workflow's advanced search is built on them, and Workflow no longer creates its own `WorkflowIndex`.

* Rebuild the `Umb_Content` index after the upgrade, from **Settings** > **Search**. Advanced search returns no results until the index is rebuilt.
* The **fuzzy** option no longer has an effect.
* Search results no longer have a relevance score. `Score` is always `0`, and results are ordered by name.

### Configuration

The `SettingsCustomization` configuration is replaced by typed sections. Move the customizations to the new location:

| Workflow 18                                              | Workflow 19                        |
| -------------------------------------------------------- | ---------------------------------- |
| `Umbraco:Workflow:SettingsCustomization:{Section}:{Key}` | `Umbraco:Workflow:{Section}:{Key}` |

The sections are `ContentApprovals`, `ContentReviews` and `ReleaseSets`. Each setting still has `Value`, `IsHidden` and `IsReadOnly` options. An invalid value fails when the configuration is bound at startup.

The `Umbraco:Workflow:Colors` setting and the `ColorSettings` type are removed. The status colors in workflow emails are fixed to red, orange, and green.

The `Umbraco:Workflow:DateFormats` setting and the `DateFormats` type are removed.

### Email templates

A template customized for an earlier version fails to compile if it reads a member that was removed. The members removed in Workflow 19 are:

* `CurrentTask.Type` and `task.Type`
* `Node.Url`

When a template on disk does not compile, Workflow renders the version it ships, and the **Email Templates** health check lists the template. For more information, see the [Email Templates](../getting-started/content-approval-settings.md#email-templates) article.

The `ContentApprovalEmailModel` constructor no longer takes a `ColorSettings` parameter.

### API

* The `workflow-history-csv` endpoint is removed. Use the `workflow-export` endpoint to export the workflow history.
* Chart points are returned with an ISO date in `x` (`yyyy-MM-dd`, UTC day), instead of `MMM d, yyyy` in the server's culture. Clients that parse `x` must read the new format. The `ChartDataPoint(DateTime, int, string)` constructor formats the date in the invariant culture.
* `ChartResponseModel.CurrentUserLocale` is removed.
* The OpenAPI schema `ApprovalGroupCollectionReponseModel` is renamed `ApprovalGroupCollectionResponseModel`. Regenerate any client that uses it.

### Code

#### Removed Types

* `Umbraco.Workflow.Core.Configuration.ColorSettings`
* `Umbraco.Workflow.Core.Configuration.DateFormats`
* `Umbraco.Workflow.Core.Configuration.SettingsCustomization`
* `Umbraco.Workflow.Core.Configuration.SettingsCustomizationDetail`
* `Umbraco.Workflow.Core.Configuration.CaseInsensitiveSettingsDictionary`
* `Umbraco.Workflow.Web.Api.Controllers.Reporting.WorkflowHistoryCsvReportingController`
* `WorkflowIndex`, `ConfigureWorkflowIndexOptions`, `WorkflowIndexPopulator`, `WorkflowInstanceValueSetBuilder`, `IWorkflowIndexer`

#### Renamed Types

* `ApprovalGroupCollectionReponseModel` is renamed `ApprovalGroupCollectionResponseModel`.

#### Removed Members

* `ApprovalGroupDto.OfflineApproval`: use `ExternalApproval`.
* `NodeSlim.Url`.
* `WorkflowTaskViewModel.Type`.
* `ContentReviewsScaffoldResponseModel.ReviewPeriod`: use `Period`.
* `IInstancesRepository.GetByGuid(Guid)` and `IInstancesService.GetByGuid(Guid)`, and their implementations: use `GetByGuid(Guid, bool)`.
* Three unused methods on `IWorkflowNotificationEmailExecutor`.
* `IContentRepository.GetSourceVersion(int)`.
* `ICsvService.ExportToStream<T, TMap>`: use `ExportToStream<T>` with a type marked with `[CsvRecord]`.
* `IAdvancedSearchService.Search`: use `SearchAsync`.
* `ChartResponseModel.CurrentUserLocale`.
* The obsolete constructors of `ScaffoldService`, `WorkflowHubRoutes`, `ApproveActionController`, `ApproveOrRejectActionController`, `RejectActionController` and `UnlockNodeController`.
* `WorkflowSettings.Colors` and `WorkflowSettings.SettingsCustomization`: use the `ContentApprovals`, `ContentReviews`, and `ReleaseSets` properties.

#### Changed Members (Breaking)

* The `AdvancedSearchResponseItemModel` constructor takes an `IContent` instead of an Examine `ISearchResult`.
* `ContentReviewConfigDto` is split into a persistence data transfer object (DTO) and a `ContentReviewConfig` model. The DTO keeps only the columns of the `WorkflowContentReviewConfig` table, and `PeriodMode` and `IsOneShotDueDate` are removed from it: use `Mode`. The `ContentReviewConfig` model carries the calculated state, such as `Path`, `DueOn`, `ReviewedOn`, `Groups` and `Expired`. The following now use `ContentReviewConfig`:
  * `IContentReviewConfigRepository.GetAllConfig`, `GetNodeConfig`, `GetPublishedNodes` and `GetReviewableNodes`
  * `IContentReviewReminderEmailer.SendReviewReminders`
  * `ContentReviewsScaffoldModel`
  * `WorkflowContentReviewsEmailNotificationsSendingNotification` and `WorkflowContentReviewsEmailNotificationsSentNotification`
* `IContentDiffService.GetDiff` returns `NotFound` when the workflow has no `SourceVersion`. Workflows created since version 1.2.0 always have a source version.

#### Added Interface Members (Breaking)

The default implementation of these members was removed. Custom implementations must now implement them:

* `IGroupsRepository.UsersForUmbracoGroup`
* `IAlternateVersionsRepository.DeletePropertyDataForVersion`
* `IWorkflowActionAuthorizer.IsAdmin`
* `IContentReviewConfigRepository.GetConfigForNode`
* `IReleaseSetRepository.DeleteComponentsAsync`
* `ISettingsService.GetFullyQualifiedTaskLinkUrl`
* `IContentDeletedHandlerExecutor.CancelActiveWorkflowsByNodeId`
* `IContentDiffService.GetPropertyChanges`
* `IInstancesRepository.GetByGuid(Guid, bool)` and `IInstancesService.GetByGuid(Guid, bool)`

`IHistoryCleanupService` has a new `DeleteCleanupSettings(IEnumerable<string>)` member.

#### Behavior changes

The cleanup that runs when an approval group is deleted, which cancels its active workflows and removes its permissions, moved from `DeleteApprovalGroupController` to a handler for `WorkflowGroupDeletedNotification`. Code that relied on the controller doing this must handle the notification.

### Frontend

* The `Workflow.WorkspaceAction.Document.Submit` and `Workflow.WorkspaceAction.Element.Submit` aliases are renamed `Workflow.WorkspaceAction.Document.RequestPublish` and `Workflow.WorkspaceAction.Element.RequestPublish`. Extensions that target the old aliases with `forWorkspaceActions` must use the new ones, which are exported as `WORKFLOW_DOCUMENT_REQUEST_PUBLISH_WORKSPACE_ACTION_ALIAS` and `WORKFLOW_ELEMENT_REQUEST_PUBLISH_WORKSPACE_ACTION_ALIAS`.
* The charts are drawn with Analytics.UI. The following are removed from `@umbraco-workflow/backoffice`:
  * `WorkflowChartBaseElement`: extend `UmbLitElement` and draw with Analytics.UI, or depend on Chart.js directly.
  * `WorkflowChartHeaderCard`, `WorkflowChartHeaderCardElement` and the `<workflow-chart-header-card>` element: use `uaui-kpi-tile`.
  * `WorkflowDayRangeDropdownElement` (`<workflow-day-range>`): use `WorkflowPeriodToggleElement` (`<workflow-period-toggle>`), which offers 7, 30 and 90 days.
  * The `./external/chartjs` subpath and the `@umbraco-workflow/backoffice/external/chartjs` import-map module. An extension that imports it fails when it loads in the browser. Depend on `chart.js` directly, or import `@umbraco/analytics-ui/external/chart.js`.
* `WorkflowActivityChartElement` and `WorkflowContentReviewsChartElement` now extend `UmbLitElement`. Members inherited from the removed base element, such as `renderHeader()`, `getForRange()` and `drawChart`, no longer exist, and subclasses that override them must be updated. `WorkflowActivityChartElement.getActivity("pending")` opens **History**: pass `"PendingApproval"` to open **Active workflows**.
* The published type definitions of the chart elements import `@umbraco/analytics-ui`. A project on TypeScript 6, or with `noUncheckedSideEffectImports` enabled, that imports from `./content-approvals` or `./content-reviews` must set `skipLibCheck` or install `@umbraco/analytics-ui`. The package is available from the Umbraco nightly NPM feed.
* `WorkflowSubmitContentBaseActionArgs`, exported from `@umbraco-workflow/backoffice/content-approvals`, is removed.
* Backoffice conditions that lose their context now report as not permitted. Custom conditions in Workflow extensions should set `permitted` themselves.

### Legacy version specific upgrade notes

You can find the version specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/tree/umbraco-eol-versions).
