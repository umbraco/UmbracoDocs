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

Below are the release notes for Umbraco UI Builder, detailing all changes in this version.

#### [**16.1.5**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.1.5) **(January 28th 2026)**

* Replace deprecated `PagedResult` with `PagedModel` [#214](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/214).
* Fixed translation issue when using localization files.
* Fixed items pagination in Entity Picker.

#### [**16.1.4**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.1.4) **(December 18th 2025)**

* Updated the cards UI adopting a slimmer appearance [#184](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/184)
* Fixed card counter caused by a regression in `17.0.0` [#212](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/212)
* Fixed a top padding issue with child collections [#180](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/180)

#### [**16.1.3**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.1.3) **(December 12th 2025)**

* Fixed a regression impacting child collections [#213](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/213)

#### [**16.1.2**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.1.2) **(December 11th 2025)**

* Added additional localization support for editor fields labels and descriptions, collection filters, cards, data views [#208](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/208)
* Fixed entity menu actions display [#207](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/207)
* Enable columns sorting for collections list view [#205](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/205)
* Perform list view update post bulk action [#204](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/204)
* Fixed the visibility of entity actions when entity is new [#202](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/202)
* Restored container menu actions [#201](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/201)
* Fixed handling of entities with key different than `Integer` causing actions visibility issues [#196](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/196)

#### [**16.1.1**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.1.1) **(November 27th 2025)**

* Handle entity update notifications on successful operation
* Fix `UmbChangeEvent` dispatch if `workspaceContext` is not set [#209](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/209)

#### [**16.1.0**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.1.0) **(October 11th 2025)**

* Added [localization](collections/localization.md) support for collections, sections, trees, actions, context apps, and dashboards.
* Fixed context app icons [#191](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/191)

#### [**16.0.4**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.0.4) **(September 19th 2025)**

* Fixed the UI feedback on implementation of a custom repository [#198](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/198)
* Fixed an issue with container actions not triggering due to entity context missing [#192](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/192)
* Fixed an issue with `EntityMenu` actions missing [#189](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/189)

#### [**16.0.3**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.0.3) **(August 8th 2025)**

* Fixed an issue affecting custom actions used with child collections due to `Guid` identifier passed to the server [#186](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/186)
* Updated the UI and component used to display cards [#184](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/185)
* Fixed the count badge display on summary dashboard cards [#183](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/183)
* Use `ProblemDetailsBuilder` pattern to notify correctly of exceptions [#182](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/182)

#### [**16.0.2**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.0.2) **(July 10th 2025)**

* Fixed issue with inherited actions for child collections [#168](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/168)
* Updated entity actions [#158](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/158)

#### [**16.0.1**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.0.1) **(July 1st 2025)**

* Fixed an issue with icons for tree items and cards [#169](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/169)
* Use label as value for options based filters [#156](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/156#issuecomment-2963229593)

#### [**16.0.0**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.0.0) **(June 12th 2025)**

* Upgraded to run on Umbraco version 16.

## Legacy Release Notes

You can find the release notes for **Konstrukt** in the [Change log file on GitHub](changelog-archive/changelog.md).
