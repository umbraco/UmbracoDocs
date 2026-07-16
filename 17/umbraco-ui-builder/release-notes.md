---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco UI
  Builder.
---

# Release Notes

This section summarizes the changes and fixes introduced in each version of Umbraco UI Builder. Each release includes a link to the [UI Builder issue tracker](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues), where you can find a list of resolved issues. Individual issues are also linked for more details.

If there are any breaking changes or other issues to be aware of when upgrading, they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, check the breaking changes in the [Version Specific Upgrade Notes](upgrading/version-specific.md) article.
{% endhint %}

## Release History

Below are the release notes for Umbraco UI Builder, detailing all changes in this version.

### [**17.2.4**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.2.4) **(July 16th 2026)**

* Fixed read-only fields displaying JSON as `[object Object]`; JSON values now render as formatted text [#222](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/222)

### [**17.2.3**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.2.3) **(July 13th 2026)**

* Fixed the editor modal not closing when the entity being edited is deleted [#228](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/228)
* Fixed the summary dashboard showing incorrect totals [#227](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/227)
* Fixed the MultipleChoice filter editor failing to render [#226](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/226)
* Fixed the Entity Picker showing nothing when `maxItems` is set to 0 [#225](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/225)
* Fixed repository save methods on new-entity insert with the NPoco backend (regression in 17.1.0) [#224](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/224)
* Fixed a 403 `insufficient_access` error on the data-type endpoint for users without Content/Media section access [#218](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/218)
* Fixed `FileActionResult` not showing an error notification when an exception occurs [#217](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/217)
* Fixed the Entity Picker missing when the foreign key is non-nullable [#187](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/187)
* Fixed the Import Action not working with a custom data type [#178](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/178)
* Fixed Block List throwing an error on save [#123](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/123)

### [**17.2.2**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.2.2) **(May 1st 2026)**

* Fixed issue with section dashboard collections [#221](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/221)
* Fixed issue when filtering collections by a property of type `DateTime` [#219](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/219)

### [**17.2.1**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.2.1) **(April 16th 2026)**

* Fixed an issue in list views when using fields that have the same name [#220](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/220)

### [**17.2.0**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.2.0) **(April 7th 2026)**

* Fixed builder for Core sections tree registration [#216](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/216)

### [**17.1.0**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.1.0) **(March 5th 2026)**

* Added support for [EF Core](./advanced/efcore-repositories.md) data access
* [Async](./advanced/async-apis.md) APIs 

### [**17.0.5**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.0.5) **(February 27th 2026)**

* Fixed bulk actions for collections [#215](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/215)

### [**17.0.4**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.0.4) **(January 28th 2026)**

* Replace deprecated `PagedResult` with `PagedModel` [#214](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/214).
* Fixed translation issue when using localization files.
* Fixed items pagination in Entity Picker.
* Removed obsolete code scheduled for removal in V17.

### [**17.0.3**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.0.3) **(December 18th 2025)**

* Updated the cards UI adopting a slimmer appearance [#184](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/184)
* Fixed card counter caused by a regression in `17.0.0` [#212](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/212)
* Fixed a top padding issue with child collections [#180](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/180)

### [**17.0.2**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.0.2) **(December 12th 2025)**

* Fixed a regression impacting child collections [#213](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/213)

### [**17.0.1**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.0.1) **(December 11th 2025)**

* Added additional localization support for editor fields labels and descriptions, collection filters, cards, data views [#208](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/208)
* Fixed entity menu actions display [#207](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/207)
* Enable columns sorting for collections list view [#205](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/205)
* Fixed the visibility of entity actions when entity is new [#202](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/202)
* Restored container menu actions [#201](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/201)
* Fixed handling of entities with key different than `Integer` causing actions visibility issues [#196](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/196)

### 17.0.0 (November 27th 2025)

* Final release to support Umbraco 17

### 17.0.0-rc2 (November 25th 2025)

* Compatibility update for Umbraco 17.0.0-rc4 and Swashbuckle 10

### 17.0.0-rc1 (November 3rd 2025)

* Compatibility update for Umbraco 17.0.0-rc1


## Legacy Release Notes

You can find the release notes for **Konstrukt** in the [Change log file on GitHub](changelog-archive/changelog.md).
