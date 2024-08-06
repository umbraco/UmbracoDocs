---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco Workflow.
---

# Release notes

In this section, we have summarized the changes to Umbraco Workflow released in each version. Each version is presented with a link to the [Workflow issue tracker](https://github.com/umbraco/Umbraco.Workflow.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
Check the [Version Specific Upgrade Notes](upgrading/version-specific.md) article for breaking changes when upgrading to a new major version.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Workflow 14 including all changes for this version.

### [14.0.2](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.0.2) (August 5 2024)

* Fixes an issue where available approval group names were not displayed in Document Type approval flow condition configuration [#76](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/76)
* Updates to allow editing approval group roles (content and/or Document Type) via overlay [#75](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/75)
* Fixes an issue where adding status filters did not update the filter context [#74](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/74)
* Updates workflow history table to include status column [#72](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/72)
* Updates incorrect localization in Document Type review settings overlay [#71](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/71)
* Fixes clear button functionality in filter modal [#67](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/67)
* Fixes approval group options in reject task modal [#65](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/65)
* Updates incorrect localization in workflow detail modal when state is `pending approval` [#64](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/64)
* Fixes conditional display of core workspace actions when `extend permissions` is set to true [#62](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/62)
* Updates submit-for-approval notification to remove invariant workflow indicator [#61](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/61)
* Fixes issues related to requesting approval on newly created variant content
  * [#69](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/69)
  * [#68](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/68)
  * [#66](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/66)
* UI updates in workflow detail modal

### [14.0.1](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.0.1) (July 24 2024)

* Fixes an issue where changes to approval group membership were not correctly persisted

### [14.0.0](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.0.0) (May 30 2024)

* Compatibility with Umbraco 14
  * For full details of breaking changes refer to the [Version Specific Upgrade Notes](upgrading/version-specific.md)

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on Github](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-workflow/release-notes.md)
