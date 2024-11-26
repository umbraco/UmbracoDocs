---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco Forms.
---

# Version Specific Upgrade Notes

This page covers specific upgrade documentation for when migrating to major 13 of Umbraco Forms.&#x20;

{% hint style="info" %}
If you are upgrading to a new minor or patch version, you can find information about the breaking changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

Version 13 of Umbraco Forms has a minimum dependency on Umbraco CMS core of `13.0.0`. It runs on .NET 8.

Deploy add-on for Umbraco Forms has been renamed from `Umbraco.Deploy.Forms` to `Umbraco.Forms.Deploy`.

#### **Breaking changes**

Version 13 contains a number of breaking changes. If you do run into any, they should be straightforward to adjust and recompile.

For reference, the full details are listed here:

#### **Behavior**

* The configuration option `UseSemanticFieldsetRendering` was removed and considered as `true`. This means the improved, semantic fieldset rendering is now used in the default theme for all installations.
* The `ExecuteWorkflowAsync` configuration option was removed.

#### **Dependencies**

* Umbraco CMS dependency was updated to `13.0.0`.

#### **Code**

The following updates describe the more significant changes to the codebase and public API:

* Amended `IWorkflowExecutionService`, `IRecordService`, `IRecordSetActionType` and `IWorkflowType` methods related to workflow execution to be asynchronous. These methods now have an `Async` suffix and will return a awaitable `Task`.
* An overload for the HTML helper `RenderUmbracoFormDependencies` that internally required service location was removed. It should now be called providing the parameter for an `IUrlHelper`, with `@Html.RenderUmbracoFormDependencies(Url)`.

These updates are more minor. We don't expect many projects to be affected by them as they are in areas that are not typical extension points:

* `DataSourceCacheRefresher` was made internal.
* `HideField` was removed from `FieldType` and `IFieldType`. `RenderInputType` with a value of `RenderInputType.Hidden` can be used here instead.
* The default implementation for the `Exists` method previously added to `IBaseService` was removed.
* The obsolete overload for method `AddDataConsentField` on `FieldsetContainerExtensions` was removed.
* The method `CanUserViewEntries` was added to the `IFormsSecurity` interface.
* The static methods `TryCreateAttachment`, `TrackAttachmentFileStream` and `DisposeAttachmentFileStreams` on `BaseEmailWorkflowType` were removed (instance methods are available to use instead).
* The obsolete constructor on the `SaveAsFile` workflow type was removed.
* The obsolete overload for method `TransformXML` on `XsltHelper` was removed.
* The obsolete overloads for method `ValidateField` on `FieldType` were removed.
* The obsolete overload for method `GetFormSecurityByUserId` on `FormSecurityControllerBase` was removed.
* The `PopulatePageElements` method was added to the `IFormRenderingService` interface.
* The `Setting` class was renamed to `SettingAttribute`.
* `PreValueFileController` has a changed constructor.
* `FileUpload` has a changed constructor.
* `ExecuteWorkflowsWithResult` on `IWorkflowExecutionService` was renamed to `ExecuteWorkflows` and the void method with that name was removed.
* The string constants used to define GUIDs for each provider type were made consistently upper-case.
* `FileUpload` and `PreValueFileController` have changed constructors to add support for server-side file validation.
* HTML helpers such as `RenderFormsScripts` now return `IHtmlContent`.
* The constructor for workflow notifications was amended to add a parameter for the current `Record`.
* The `IType` interface now defines a `Created` property.

## Legacy version specific upgrade notes

You can find the version specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-forms/installation/version-specific.md).&#x20;
