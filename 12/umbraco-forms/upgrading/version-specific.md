---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco
  Forms.
---

# Version Specific Upgrade Notes

This page covers specific upgrade documentation for when migrating to major 12 of Umbraco Forms.&#x20;

{% hint style="info" %}
If you are upgrading to a new minor or patch version, you can find information about the breaking changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

Version 12 of Umbraco Forms has a minimum dependency on Umbraco CMS core of `12.0.0`. It runs on .NET 7.

#### **Breaking changes**

Version 12 contains a number of breaking changes. If you do run into any, they should be straightforward to adjust and recompile.

For reference, the full details are listed here:

#### **Behavior**

* The default value for configuration of request IP tracking via the `EnableRecordingOfIpWithFormSubmission` setting has been changed to `true` from `false`.
* The session variable `ContourMemberKey` is no longer set.
* Exception handling in the Forms API has been aligned with the CMS Delivery API. This leads to subtle differences in the population of the `ProblemDetails` exposed.
* Use of the Forms API has to be enabled in configuration, via setting the `Umbraco:Forms:Options:EnableFormsApi` key to `true`.
* The Swagger document for the Forms API has been removed and is now combined with that for the CMS Delivery API, at `umbraco/swagger/index.html`.
* The Forms API paths have had the `/v1.0/` segment renamed to `/v1/`, to align with the CMS Delivery API.

#### **Dependencies**

* Umbraco CMS dependency was updated to `12.0.0`.
* The dependency on `Hellang.Middleware.ProblemDetails` was removed.
* The dependency on `NSwag.AspNetCore` was removed and replaced with `Swashbuckle.AspNetCore`.

#### **Code**

The following updates describe the more significant changes to the codebase and public API:

* The interfaces that previously defined entity model classes have been removed. These were `IFormEntity`, `IFolderEntity`, `IWorkflowEntity`, `IDataSourceEntity` and `IPrevalueSourceEntity`. All code now refers to the concrete classes.
* The interfaces that previously defined application model classes have been removed. These were `IFieldPreValueSource`, `IFormDataSource`, `IFormDataSourceField`, `IWorkflow`, `IRecordField` and `IRecord`.
* These changes affect service, repository and other interfaces and classes that previously used these interfaces. All methods have been updated to use the concrete classes as parameters and return values.
* The now unused class `InterfaceJsonConverter` was removed.

These updates are more minor. We don't expect many projects to be affected by them as they are in areas that are not typical extension points:

* The obsolete constant `FormsConfigPath` was removed.
* Obsolete constructor was removed on `DictionaryHelper`.
* Obsolete overloads of `StringExtensions.ParsePlaceHolders` was removed.
* Unused parameter in the constructors of `DatabaseIntegrityHealthCheck` and `MsSqlAnalyzer` were removed.
* Default interface implementations were removed from the `MessageOnSubmitIsHtml`, `DisplayDefaultFields` and `SelectedDisplayFields` properties defined on `IFormEntity`.
* The `SearchForms` method, previously defined in the implementation of `IFormService`, has been added to the interface.
* An obsolete method on `IPlaceholderParsingService` were removed.
* An obsolete method on `IWorkflowService` were removed.
* Obsolete methods on `UmbracoBuilderExtensions` were removed.
* The obsolete constructors on `BaseEmailWorkflowType`, `SendEmail`, `SendRazorEmail` and `SendXsltEmail` workflows were removed.
* The obsolete constructors on `FormsApiControllerBase`, `DefinitionsController` and `EntriesController` API controllers were removed.
* The obsolete constructors on `UmbracoFormsController` were removed.
* The obsolete constructors on `FieldController` and `RecordController` were removed.
* The obsolete overload on the `ViewHelper.RenderPartialViewToString` method was removed and the `FakeController` class used in this method was made private.
* The obsolete `Build` method overload was removed in `FormViewModel`.
* The obsolete constructor on `FormRenderingService` was removed.
* The Forms API model classes and serialization customizations were moved from `Umbraco.Forms.Web` into `Umbraco.Forms.Core`.
* The `ISupportFileUploads` interface was moved to `Umbraco.Forms.Core.Interfaces`.
* Additional parameters were added to the constructors of `FormPickerPropertyValueConverter` and `FormDtoFactory`.
* The setting properties available on all field, workflow and other provider types have been made virtual.

## Legacy version specific upgrade notes

You can find the version specific upgrade notes for versions out of support in the [Legacy documentation on Github](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-forms/installation/version-specific.md).&#x20;
