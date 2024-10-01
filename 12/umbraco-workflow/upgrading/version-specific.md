# Version Specific Upgrade Notes

This page covers specific upgrade documentation for specific versions.

{% hint style="info" %}
If you are upgrading to a new minor or patch version, you can find information about the breaking changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

<details>

<summary>Version 12</summary>

Version 12 of Umbraco Workflow has a minimum dependency on Umbraco CMS core of `12.0.0`. It runs on .NET 7.

**Breaking changes**

Version 12 contains a number of breaking changes. Presentation changes are not typically considered breaking - for reference the full details are listed below.

**Presentation**

* Replaces promises with async/await in AngularJS components.
* Adds `StateFactoryBase` type.
* Removes `getAllTasksForGroupForRange` from `WorkflowResource` - use `getAllTasksForGroup` instead, with query params.
* Removes `safeVariant` from `WorkflowResource` - logic is moved to `generateQuery`.
* Removes `saveDocTypeConfig` from `WorkflowResource` - config is saved when saving settings.
* Removes `getNewNodeConfig` from `WorkflowResource` - config is returned when getting settings.
* Removes `getPathAndType` from `WorkflowResource` - function is moved to `OfflineController`.
* Renames `getSettingsForDisplay` to `getSettings` on `SettingsResource`.

**Code**

* Removes `IWorkflowVersion` interface.
* Removes `SettingsTreeController`.
* Removes `SaveContentTypeConfig` from `ConfigController`.
* Removes `GetNewNodeConfig` from `ConfigController`.
* Removes `ICaseInsensitiveSettingsDictionaryValueAccessor`.
* Removes `EmailTemplatePath` from `WorkflowSettings` as value can not be modified.
* Removes `FakeController` from `EmailTemplateRenderer`.
* Removes `ProcessApproval(this WorkflowTaskPoco taskInstance, WorkflowAction action, int? userId, string comment, string? assignTo = null)` from `TaskInstanceExtensions`, use the implementation accepting an ActionWorkflowRequest and WorkflowInstancePoco instead.
* Removes `ActionedByAdmin(WorkflowTaskPoco taskInstance, int? userId)` from `TaskInstanceExtensions`, use the implementation accepting a WorkflowTaskPoco, ActionWorkflowRequest and WorkflowInstancePoco instead.
* Removes `Cancel(this WorkflowTaskPoco taskInstance, int? userId, string reason, DateTime? completedDate)` from `TaskInstanceExtensions`, use the implementation accepting an ActionWorkflowRequest and WorkflowInstancePoco instead.
* Removes parameterless constructor from `PackageVersionModel`, use the constructor accepting the `version` parameter instead.
* Removes `IsNightly` from `PackageVersionModel`.
* Removes `CssStatus` from `WorkflowInstanceViewModel`, status should be derived from `Status` or `StatusName`.
* Removes `CssStatus` from `WorkflowTaskSlim`, status should be derived from `Status` or `StatusName`.
* Removes `ApprovalGroupId`, `Path`, `ContentTypeId`, `CreatedDateTime`, `RequestedById`, `ActionedByUser` from `WorkflowTaskViewModel`.
* Removes `GetChartData` from `IContentReviewService`, use `IChartsService` instead. 
* Removes `GetFullyQualifiedContentEditorUrl(int? id, string baseUrl)` from `ISettingsService`, use the implementation accepting an optional `Referrer` parameter instead.
* Removes `Generate(IDictionary<string, object> dictionary, IDictionary<string, object>? additionalData = null)` from `ServerVariablesSendingExecutor`, use the async implementation instead.
* Moves `GetPathAndType` from `ConfigController` to `OfflineApprovalController`.
* `OfflineApprovalController` constructor requires an additional parameter - `IConfigService`.
</details>
