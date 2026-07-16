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

### [**18.0.2**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.0.2) **(July 16th 2026)**

* Fixed read-only fields displaying JSON as `[object Object]`; JSON values now render as formatted text [#222](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/222)

### [**18.0.1**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.0.1) **(July 13th 2026)**

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

### **18.0.0** **(June 23rd 2026)**

* First stable release of Umbraco UI Builder for Umbraco 18.

### 18.0.0-rc1 (June 4th 2026)

* Initial release candidate for Umbraco v18. 
