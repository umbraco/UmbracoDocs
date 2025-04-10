---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco UI
  Builder.
---

# Release Notes

This section summarizes the changes and fixes introduced in each version of Umbraco UI Builder. Each release includes a link to the [UI Builder issue tracker](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues), where you can find a list of resolved issues. Individual issues are also linked for more details.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, check the breaking changes in the [Version Specific Upgrade Notes](upgrading/version-specific.md) article.
{% endhint %}

## Release History

Below are the release notes for Umbraco UI Builder 15, detailing all changes in this version.

#### [**15.1.2**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.1.2) **(April 4th 2025)**

* Removed global registration of `UDI` converters [#144](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/144), [#136](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/136), and introduced new [Entity Identifier Converters](./collections/entity-identifier-converters.md).
* Fixed `Create` action button [#137](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/137).
* Added collection list view refresh feature following an entity action [#139](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/139).
* Fixed collection visibility [#134](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/134).
* Enabled rendering of sidebar properties.
* Fixed an issue that prevented the creation of multiple sections.

#### [**15.1.1**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.1.1) **(March 21st 2025)**

* Extended `UdiConverter` with options to convert to `GUID` [#108](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/108)
* Update `Save` action visibility for readonly collections [#129](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/129)
* Fixed value editor configuration object impacting the use of custom property editors for collection properties [#122](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/122)
* Enable the display of markup from custom field views [#119](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/119)
* Fixed an issue causing sort properties not being sent to repository [#118](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/118)

#### [**15.1.0**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.1.0) **(March 4th 2025)**

* Updated licensing engine.
* Fixed issue with import entity action for Umbraco Cloud websites [#92](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/92).
* Added feature to allow server-side complex validation using [repository events](advanced/events.md).
* Enable sorting a list view based on the `Name` column.
* Fixed issue with `SetHeading` collection property.
* Fixed issue with setting a list view page size programmatically using `SetPageSize`.

#### [**15.0.3**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.3) **(February 5th 2025)**

* Fixed an issue with filter input values persistence for filterable properties.
* Filterable properties UI updates

#### [**15.0.2**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.2) **(January 22nd 2025)**

* Added updates to the licensing engine.
* Fixed an error in the entity update action.

#### [**15.0.1**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.1) **(December 16th 2024)**

* Added previously validated license resolver, to validate a license if a validation process was already executed successfully in the past 7 days.
* Fixed an issue caused by `where` clauses for filter expression and deleted property.
* Allow entity properties to be searched based on pattern: `StartsWith` | `Contains` [#116](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/116).
* Switch entity create/edit header to label view for read-only collections [#111](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/111).

#### [**15.0.0**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.0) **(November 14th 2024)**

* Product migrated to support the new Web Component-based Umbraco.

You can read more about the new Backoffice in the [Umbraco CMS documentation](https://docs.umbraco.com/umbraco-cms/extending/customize-the-editing-experience).

## Legacy Release Notes

You can find the release notes for **Konstrukt** in the [Change log file on GitHub](changelog-archive/changelog.md).
