---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco UI
  Builder.
---

# Release Notes

In this section, we have summarized the changes to Umbraco UI Builder released in each version. Each version is presented with a link to the [UI Builder issue tracker](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, check the breaking changes in the [Version Specific Upgrade Notes](upgrading/version-specific.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco UI Builder 13 including all changes for this version.

#### [**13.2.3**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.2.3) **(April 4th 2025)**

* Removed global registration of `UDI` converters [#144](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/144) and introduced new [Entity Identifier Converters](./collections/entity-identifier-converters.md).

#### [**13.2.2**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.2.2) **(March 21st 2025)**

* Fixed an issue for bulk actions that disabled the actions row on cancel [#130](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/130)
* Extended `UdiConverter` with options to convert to `GUID` [#108](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/108)

#### [**13.2.1**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.2.1) **(March 17th 2025)**

* Added the `ActivatorUtilitiesConstructor` attribute to the `ImportActionEntity` constructor.

#### [**13.2.0**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.2.0) **(March 4th 2025)**

* Updated licensing engine.
* Fixed issue with import entity action for Umbraco Cloud websites [#92](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/92)

#### [**13.1.7**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.7) **(January 22nd 2025)**

* Added updates to the licensing engine.

#### [**13.1.6**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.6) **(December 16th 2024)**

* Added previously validated license resolver, to validate a license if a validation process was already executed successfully in the past 7 days.
* Fixed an issue caused by `where` clauses for filter expression and deleted property.
* Allow entity properties to be searched based on pattern: `StartsWith` | `Contains` [#116](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/116)
* Switch entity create/edit header to label view for read-only collections [#111](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/111)

#### [**13.1.5**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.5) **(June 17th 2024)**

* Fixed an issue that did not allow a readonly field to be added multiple times to an editor [#105](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/105)

#### [**13.1.4**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.4) **(May 13th 2024)**

* Added support for using properties of nested objects as searchable [#97](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/97#issuecomment-2074303827)

You can read more about this in the [searchable properties](searching/searchable-properties.md) article.

#### [**13.1.3**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.3) **(May 8th 2024)**

* Fixed an issue with the `UdiConverter` affecting child collections [#99](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/99)

#### [**13.1.2**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.2) **(April 23rd 2024)**

* Fixed an issue with nested objects in collection entities [#97](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/97)
* Fixed an issue with the `UdiConverter` causing website configuration binding to return incorrect values [#96](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/96)

#### [**13.1.1**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.1) **(March 18th 2024)**

* Fixed an issue where the database is getting disposed in a UIBuilder repository, causing an error when Forms tries to save the form submission after the workflow is complete [Umbraco.Forms.Issues#1179](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1179).
* Allow renaming the heading of the implicit `Name` column by calling the `SetNameProperty` method overload.

You can read more about this in [the basics](collections/the-basics.md) article.
* Use `CsvHelper` library with the built in `ExportEntityAction`.
* Update `CsvHelper` version dependency.

#### [**13.1.0**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.0) **(March 6th 2024)**

* All updates listed under 13.1.0-rc1 and 13.1.0-rc2.

#### [**13.1.0-rc2**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.0) **(February 26th 2024)**

* Upgrade from 13.0.3 to 13.1.0-rc1 breaks existing custom repository. [#91](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/91)

While working with a custom repository, the entity ID type converter defaulted to the newly registered `UdiConverter` instead of `Int32Converter`. With the current update, the required converter will be picked in a different order.

#### [**13.1.0-rc1**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.0) **(February 20th 2024)**

Umbraco UI Builder 13.1 is the first release since launch adding new features. We've focussed on improving the experience when working with related collections, addressing some additional use cases that widen the scope of the product. This includes the possibility to retrieve child collections entities or use an Umbraco entity as foreign key.

* Related Collections

This feature provides support for managing **many-to-many** relationships by configuring main, related and junction entities.

You can read more about this in the [related collections](collections/related-collections.md) article.

* Retrieve Child Collections

This feature addresses a **one-to-many** relationship context. Having a parent collection with child sub-collections, one might need to retrieve the child collections only, without fetching the details of the parent.

You can read more about this in the [retrieve child collections](collections/retrieve-child-collections.md) article.

* Implementation of a `UdiConverter`

This update addresses the configuration of collections that use as foreign key a reference to an Umbraco entity. If the FK type is `Integer`, the persisted value defaults to 0. This is because the UDI value of the entity cannot be converted from `String` to `Int`. Based on the UDI value, we are retrieving and persisting the `Id` of the Umbraco entity.

A use case can be found in the [GitHub issue #86](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/86).


#### [**13.0.3**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.3) **(February 20th 2024)**

* Dependency version update for `Umbraco.Licenses`

#### [13.0.2](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=label%3Arelease%2F13.0.2+is%3Aclosed) (January 26th 2024)

* Doesn't work after upgrading to 13.0.3 [#88](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/88)
* Dependency issue when installing UIBuilder alongside Umbraco Commerce in a v13 Umbraco website [#82](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/87)
* Dependency issue when installing UIBuilder alongside uSync in a v13 Umbraco website [#85](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/85)
* Fields in Sidebar are not included when creating item [#82](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/82)

#### [13.0.1](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=label%3Arelease%2F13.0.1+is%3Aclosed) (January 11th 2024)

* Fix built-in export/import actions errors [#84](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/84)
* Update list view `editorState` to support integration with `Contentment Data Types` [#83](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/83)

#### [13.0.0](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13+label%3Arelease%2F13.0.0) (December 13th 2023)

* Upgraded to run again Umbraco v13 and .NET 8
* Upgraded all 3rd party dependencies
* Nullable references

## Legacy release notes

You can find the release notes for **Konstrukt** in the [Change log file on GitHub](changelog-archive/changelog.md).
