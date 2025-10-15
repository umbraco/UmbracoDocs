---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco
  Forms.
---

# Version Specific Upgrade Notes

This page covers specific upgrade documentation for when migrating to major 8 and 10 of Umbraco Forms.&#x20;

{% hint style="info" %}
If you are upgrading to a new minor or patch version, you can find information about the breaking changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

<details>

<summary>Version 10.1</summary>

**Breaking changes**

* The default theme has been updated to render captions for field types that support prevalues. If you have created any custom themes, please review the default theme and ensure you make similar changes to make use of the new feature.
* The method `PreValues` on the `FieldViewModel` type has been changed from a collection of strings to a collection of a `PrevalueViewModel` object that has a Value and Caption property.
* In order to fix an issue with display and editing of values, we've found a need to ensure the property representing the fields a record entry used in the backoffice is changed from a list of values to a structure containing the field Ids and values. Specifically, `EntrySearchResult.Fields` has changed type `IEnumerable<object?>` to `IEnumerable<EntrySearchResult.FieldData>`. The only scenarios affected by this would be anyone handling the `EntrySearchResultFetchingNotification` notification or developing custom export types.

</details>

<details>

<summary>Version 10</summary>

Version 10 of Umbraco Forms has a minimum dependency on Umbraco CMS core of `10.0.0`. It runs on .NET 6.

To migrate to version 10, you should first update to the latest minor release of version 9. If you are upgrading from Umbraco 8, update Forms to the latest minor version of Forms 8. Ensure you have the configuration in place for storing form definitions in the database. For more information, see the [Umbraco Forms in the Database (legacy)](https://our.umbraco.com/documentation/Add-ons/UmbracoForms/Developer/Forms-in-the-Database/) article.

Either way will ensure you have all the database schema changes in place.

**Views and client-side files**

Umbraco 10 distributes the views and client-side files as part of a Razor class library, distributed in the Umbraco.Forms.StaticAssets package. This means these assets are no longer individual files available on disk. The advantage of this approach is that that avoids changes made to them by solution developers being inadvertently lost when the project is rebuilt.

When upgrading from Forms 9, you should either first run a `dotnet clean`, or, after installing Forms 10, delete the `App_Plugins/UmbracoForms` folder. This will ensure there aren't two copies of the `package.manifest` file, which would cause issues by registering duplicate property editors.

For views you should also remove the following folders and files (again, either via a `dotnet clean` before upgrading, or manually afterward):

* `/Views/MacroPartials/InsertUmbracoFormWithTheme.cshtml`
* `/Views/MacroPartials/RenderUmbracoFormScripts.cshtml`
* `/Views/Partials/Forms/`

If you have custom themes or other changes to the files in the `Views/Partials/Forms` folder, you should ensure those files remain.

For example, with a custom email template, remove the file `Example-Template.cshtml` from the `/Views/Forms/Emails` folder but keep any custom templates.

Similarly, if you have a custom theme, remove the `default` and `bootstrap3-horizontal` folders from the `/Views/Partials/Forms/Themes/` folder but keep any custom theme folders.

**Breaking changes**

Version 10 contains a number of breaking changes. We do not expect many projects to be affected by them as they are in areas that are not typical extension points. For reference though, the full details are listed here.

**Configuration**

* Renamed the configuration option to allow editable form submissions on the front-end to `AllowEditableFormSubmissions` (fixing the typo in the previous value of `AllowEditableFormSubmissions`).

**Code**

* `DatabaseIntegrityHealthCheck` has an altered constructor taking an additional parameter.
* The `EventExtensions` class is no longer used since V9 and has been removed.
* Static events from `BaseFileStorage` removed and replaced with notifications.
* `IFormTemplateStorage` along with its implementation in `FormTemplateStorage` and base classes have been simplified, as templates are the only file based storage now in use, and there are no methods necessary for this other than reading.
* The method `GetScaffold` has been removed from `FormController`, as it's not called from the UI.
* The following classes have altered constructors taking additional parameters, with obsolete versions removed.
  * `RecordController`
  * `FormSecurityController`
  * `FormSecurityTreeController`
  * `PostToUrl`
  * `WorkflowEmailService`
* The public fields on the `Setting` class have been converted to properties.
* The methods `GetMemberCacheKey` and `GetMemberValuesCacheKey` on `CacheKeys` taking an integer parameter have been removed.
* The method `GetUserSecurity` on `IUserSecurityStorage` has been amended to take an integer parameter rather than an object.
* The method `StringExtensions.DetectIsJson` has been removed (the equivalent exists in CMS).
* Obsoleted methods in `FieldConditionEvaluation` have been removed.
* The following unused classes have been removed:
  * `FormEventArgs`
  * `FolderEventArgs`
  * `FieldPreValueSourceEventArgs`
  * `FormDataSourceEventArgs`
  * `WorkflowEventArgs`
  * `BaseStorageEventArgs` Additional methods have been added to the following interfaces:
  * `IRecordStorage`
  * `IRecordFieldValueStorage`
  * `IUserSecurityStorage`
  * `IUserFormSecurityStorage`
  * `IFormsSecurity`
* Additional properties of `SupportsMandatory` and `EditType` have been added to the `IFieldType` interface.
* The obsoleted method `RegenerateFieldSetAndFieldIds` on `Form` has been removed.
* The constructor of `FolderNotificationHandler` had an unused parameter removed.
* The obsolete and unused methods `CanCurrentUserEdit`, `CanCurrentUserAddInEditor`, `CanCurrentUserManageWorkflows`, `EnsureUserExist`s and `CanCurrentUserExport` were removed from the `IFormSecurity` interface.
* The type parameter `TEventArgs` defined on `IBaseService` (and derived interfaces) has been removed.
* Database migration classes inheriting from `FormsMigrationBase` now use the non-obsolete base constructor defined on `PackageMigrationBase`.
* The methods on `IPlaceholderParsingService` have been combined into a single one with optional parameters.
* The method `PostSave` on `FormSecurityController` has been renamed to `PostSaveForUser`.
* The backoffice model class `FormSecurity` has been renamed to `FormSecurityForUser`.
* The unused class `NonSerialiazableTypeSurrogateSelector` was removed.
* The unused method `ImportXmlNodeFromText` on `XmlHelper` was removed.
* `IFormService.FormExist` was renamed to `IFormService.FormExists`.
* `EntrySearchResultCollection.schema` was capitalized.
* Base class `ExportType` has a constructor taking `IHostEnvironment` instead of `IHostingEnvironment`.
* Typo was fixed in the class name of `TempDataDictionraryExtensions`.
* The `SetFormThemeCssFile` extension method had an unused variable removed.
* Some method signatures have had appropriate modifications for nullable reference type support.
* Removed `BaseFileStorage`, `BaseFileSystemStorage` and `FormsFileSystemForPackageData` as they are no longer needed following changes to support distribution of assets in a razor class library.

</details>

<details>

<summary>Version 8.13</summary>

See notes under 10.1.

</details>

<details>

<summary>Version 8</summary>

Version 8 of Umbraco Forms has a minimum dependency on Umbraco CMS core of `8.0.0` and runs on .NET Framework 7.2.

In order to upgrade from Umbraco Forms 7 to Umbraco Forms 8, you can use any of these options:

**Download**

In order to upgrade you will want to [download the version of Forms you wish to upgrade to](https://our.umbraco.com/projects/developer-tools/umbraco-forms/). Instead of downloading the actual package, however, you want to download the `Umbraco.Forms.Files.x.y.z.zip` file (where x.y.z) is the version.

The filename ends with `.Files.x.y.z.zip` and contains only the files that get installed when you install Umbraco Forms.

**Copy**

The easiest way to proceed is to unzip the file you downloaded and copy and overwrite (almost) everything into your website. Almost, because you might not want to overwrite `~/App_Plugins/UmbracoForms/UmbracoForms.config` because you might have updated it in the past. Make sure to compare your current version to the version in the zip file you downloaded. If there's any new configuration options in there then copy those into your website's `UmbracoForms.config` file.

</details>

## Legacy version specific upgrade notes

You can find the version specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-forms/installation/version-specific.md).&#x20;
