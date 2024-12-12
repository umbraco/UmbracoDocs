---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco
  Forms.
---

# Version Specific Upgrade Notes

This article provides specific upgrade documentation for migrating to Umbraco Forms version 15.

{% hint style="info" %}
If you are upgrading to a minor or patch version, you can find the details about the changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

Version 15 of Umbraco Forms has a minimum dependency on Umbraco CMS core of `15.0.0`. It runs on .NET 9.

#### **Breaking changes**

Version 15 contains a number of breaking changes. If you do run into any, they should be straightforward to adjust and recompile.

For reference, the full details are listed here:

#### **Configuration**

* The setting `FieldSettings:Recaptcha3:ShowFieldValidation` has a new default of `true`.
* The setting `Options:EnableMultiPageFormSettings` has a new default of `true`.
* The setting `FormDesign:RemoveProvidedEmailTemplate` has been removed (as adding and removing email templates can be more consistently handled using `EmailTemplateCollection` as described [here](../developer/themes.md#removing-the-default-email-template)).

#### **Asynchronous Methods**

* `IFieldPreValueSourceType.GetPrevalues` (and the abstract method of the same name in `FieldPreValueSourceType`) is now an asynchronous method. It has an `Async` suffix.
* `IExportType.ExportRecords` and `ExportToFile` are now asynchronous methods and have `Async` suffixes.

#### **Code**

* Parameters in the `FileUpload` constructor were renamed.
* Obsolete constructors in the classes `SendRazorEmail`, `EntryAcceptedDtoFactory`, `FormDtoFactory`, `RenderFormViewComponent`, `GetValuesByKeyPrevalueSourceController`, and `UmbracoFormsController` were removed.
* The obsolete overload on `FormFileExtensions.IsFileTypeAllowed` was removed.
* The purposes defined for uses of `IDataProtector` were renamed to have a common prefix.
* Unused fields `Field.Placeholder` and `FormFieldDto.Placeholder` were removed.
* Unused `ServerVariablesParsingHandler` was removed.
* Default implementations on the interfaces `IWorkflowFactory`, `IWorkflowRepository`, `IWorkflowService` were removed.
* Obsolete methods on `PlaceholderParsingService` were removed.
* Method overloads without optional parameters on `FormDtoFactory`, `EntryAcceptedDtoFactory`, `IFormRenderingService`, `IPlaceholderParsingService`, `WorkflowType`, `DictionaryExtensions` and `StringExtensions` were removed.
* Base64 encoding was removed when storing and retrieving form state.
* The obsolete overload of `FormViewModel.Build` was removed.
* The `UmbracoPreValuesReadOnly` constructor now has an additional parameter.
* Due to the introduction of asynchronous behavior to `IFieldPreValueSourceType.GetPrevalues`, `FormViewModel.Build` is now also asynchronous.
* `FormsTreeRequirement` and related classes were removed.
* `FormRenderingService` and `FormThemeResolver` was made internal.
* Default implementations on `IFormThemeResolver` were removed.

## Legacy version specific upgrade notes

You can find the version specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-forms/installation/version-specific.md).
