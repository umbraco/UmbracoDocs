---
description: Changes made to the Umbraco CMS documentation.
---

# Umbraco CMS

On this page, you can find a summary of significant changes made to the Umbraco CMS Documentation.

{% hint style="danger" %}
This page does not contain information about changes made to the product.

Refer to the [Umbraco CMS Release Notes](https://our.umbraco.com/download/releases/) for changes to the product.
{% endhint %}

## November Highlights

### New

* **Published** [**documentation for version 15**](https://docs.umbraco.com/umbraco-cms)**.**
  * Added documentation about [breaking changes](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/upgrading/version-specific#umbraco-15).
  * [Creating a Custom Seed Key Provider](https://docs.umbraco.com/umbraco-cms/extending/creating-custom-seed-key-provider)
  * [Cache Settings](https://docs.umbraco.com/umbraco-cms/reference/configuration/cache-settings)
  * [Cache Seeding](https://docs.umbraco.com/umbraco-cms/reference/cache/cache-seeding)
  * [API Users](https://docs.umbraco.com/umbraco-cms/fundamentals/data/users/api-users)
  * [API Members: Server to server access](https://docs.umbraco.com/umbraco-cms/reference/content-delivery-api/protected-content-in-the-delivery-api/server-to-server-access)
  * [Tutorial: Extending the Help Menu](https://docs.umbraco.com/umbraco-cms/tutorials/extending-the-help-menu)
  * [Running Umbraco in Docker using Docker Compose](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/install/running-umbraco-on-docker-locally)
  * [External Access](https://docs.umbraco.com/umbraco-cms/reference/management-api/external-access)
  * Documented the new [Tiptap UI for the Rich Text Editor property editor](https://docs.umbraco.com/umbraco-cms/fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/rich-text-editor).
* Added a guide for [using multiple languages across APIs](https://docs.umbraco.com/umbraco-cms/tutorials/multilanguage-setup#using-multiple-languages-across-apis). ([#6360](https://github.com/umbraco/UmbracoDocs/pull/6360))
* New [Health Check: Content Security Policy (CSP)](https://docs.umbraco.com/umbraco-cms/extending/health-check/guides/contentsecuritypolicy). ([#6426](https://github.com/umbraco/UmbracoDocs/pull/6426)) <img src="../.gitbook/assets/U_heart_regular.png" alt="" data-size="line">
* Documented the ["Folder" option](https://docs.umbraco.com/umbraco-cms/fundamentals/data/defining-content/default-document-types#folder) in the Document Type creating menu.

### Updates

* Updated the section about [Custom Query Steps in the Content Picker article](https://docs.umbraco.com/umbraco-cms/fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/content-picker#adding-a-custom-query-step).
* Added the UI alias for each [Property Editor](https://docs.umbraco.com/umbraco-cms/fundamentals/backoffice/property-editors/built-in-umbraco-property-editors).
* Renamed List View to [Collection](https://docs.umbraco.com/umbraco-cms/fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/collection). ([#6571](https://github.com/umbraco/UmbracoDocs/pull/6571)) <img src="../.gitbook/assets/U_heart_regular.png" alt="" data-size="line">
* Highlighted that the [IContentPicker is not available when using the Content Delivery API](https://docs.umbraco.com/umbraco-cms/reference/routing/request-pipeline/icontentfinder).

### Structure

* Changed the default version of the CMS documentation to version 15.
* [Unpublished version 12](https://github.com/umbraco/UmbracoDocs/tree/umbraco-eol-versions) due to the version hitting End of Life (EOL).

## September Highlights

### New

* Added the check for Runtime Mode to the [Health Check article](https://docs.umbraco.com/umbraco-cms/extending/health-check) ([#6297](https://github.com/umbraco/UmbracoDocs/pull/6297)) <img src="../.gitbook/assets/U_heart_regular.png" alt="" data-size="line">&#x20;

### Updates

* Renamed existing Property Editors. ([#6317](https://github.com/umbraco/UmbracoDocs/pull/6317))
  * Multinode Treepicker -> [Content Picker](https://docs.umbraco.com/umbraco-cms/fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/content-picker)
  * Content Picker -> [Document Picker](https://docs.umbraco.com/umbraco-cms/fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/document-picker)
* [Login screen documentation](https://docs.umbraco.com/umbraco-cms/fundamentals/backoffice/login). ([#6381](https://github.com/umbraco/UmbracoDocs/pull/6381))
* Improvements made to the "[Creating a basic site from scratch](https://docs.umbraco.com/umbraco-cms/tutorials/creating-a-basic-website)" tutorial. ([#6358](https://github.com/umbraco/UmbracoDocs/pull/6358))
* Changed _prevalues_ to _options_ in multiple articles. ([#6359](https://github.com/umbraco/UmbracoDocs/pull/6359))

### Structure

* A new Customize the Backoffice section was added for articles related to extending the Umbraco Backoffice.
