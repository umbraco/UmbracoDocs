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
