---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco
  Forms.
---

# Version Specific Upgrade Notes

This article provides specific upgrade documentation for migrating to Umbraco Forms version 14.

{% hint style="info" %}
If you are upgrading to a minor or patch version, you can find the details about the changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

Version 14 of Umbraco Forms has a minimum dependency on Umbraco CMS core of `14.0.0`. It runs on .NET 8.

#### **Breaking changes**

Version 14 contains a number of breaking changes, primarily due to the new backoffice introduced in Umbraco 14. The details are listed here:

#### **Behavior**

* A new management API has been introduced at `umbraco/forms/management/api`.
* The root of the existing delivery API used for headless/AJAX solutions has moved to `umbraco/forms/delivery/api`.
* The HTML helper `RenderUmbracoFormDependencies` no longer renders the promises polyfill, which is not needed in modern browsers.
* Server-side registration of content apps has been removed as this is now a client-side concern.
* Creation of custom fields, workflow, and other provider types remains primarily a server-side task. However, they no longer require the provision of AngularJS views and controllers. Instead, these reference registered client-side manifests. For more information, see the [extending Umbraco Forms](../developer/extending/) article.
* With the removal of node selection by XPath support in Umbraco 14, the "Save as Umbraco node" workflow now uses [dynamic root](https://docs.umbraco.com/umbraco-cms/fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/multinode-treepicker).

#### **Configuration**

* The setting `FieldSettings:TitleAndDescription:AllowUnsafeHtmlRendering` has a new default of `false`.
* The setting `PageOptions:TrackRenderedFormsStorageMethod` has a new default of `HttpContextItems`.

#### **Dependencies**

* Umbraco CMS dependency was updated to `14.0.0`.

#### **Code**

The following updates describe the more significant changes to the codebase and public API:

* All controllers relating to backoffice trees and editors have been removed and their functionality replaced by the management API.
* The serialization library has been changed from `Newtonsoft.Json` to `System.Text.Json`. Among other updates this involved removing the public class `FormsJsonSerializerSettings` and replacing it with `FormsJsonSerializerOptions`.
* The obsolete methods `GetFieldsNotDisplayed` and `Build` on `FormViewModel` have been removed.
* The unused `RetryWorkflow` class has been removed.

## Legacy version specific upgrade notes

You can find the version specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-forms/installation/version-specific.md).
