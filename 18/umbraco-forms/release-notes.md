---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco
  Forms.
---

# Release Notes

In this section, we have summarized the changes to Umbraco Forms released in each version. Each version is presented with a link to the [Forms issue tracker](https://github.com/umbraco/Umbraco.Forms.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}

If you are upgrading to a new major version, you can find information about the breaking changes in the [Version Specific Upgrade Notes](upgrading/version-specific.md) article.

{% endhint %}

## Release history

This section contains the release notes for Umbraco Forms 18 including all changes for this version.

### [18.1.0-rc](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+label%3Arelease%2F18.1.0) (August 6th 2026)
* Records: Store the submission page as a GUID (`UmbracoPageKey`), the preferred reference over the integer `UmbracoPageId` [#1719](https://github.com/umbraco/Umbraco.Forms.Issues/discussions/1719)
* Headless: Expose additional form settings in the Delivery API definition response [#1439](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1439)
* Workflows: Add `GetConfigurationErrors()` support for workflow types [#1709](https://github.com/umbraco/Umbraco.Forms.Issues/discussions/1709)
* Workflows: Persist additional data set during workflow execution [#1603](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1603)
* Workflows: Populate the `Exception` property on `WorkflowExecutionFailedNotification` [#1700](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1700)
* Workflows: Fix the workflow type label shown for a deleted workflow [#1713](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1713)
* Workflows: Fix `IFeatureCollection has been disposed` when running workflows via `RecordService` [#1362](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1362)
* Field Types: Fix the sensitive data toggle disappearing when enabled [#1415](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1415)
* Field & Workflow Settings: Add setting value converters so property editor UIs persist values correctly [#1569](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1569)
* Email: Respect the `DefaultEmailTemplate` provided by an email template collection [#1737](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1737)
* Email: Surface the underlying error detail when a Razor email view fails to render [#1571](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1571)
* Validation: Use the configured validation message for regular expression validation [#858](https://github.com/umbraco/Umbraco.Forms.Issues/issues/858)
* Assets: Use the CMS cache buster so backoffice assets refresh after an upgrade [#1739](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1739)

### [18.0.4](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+label%3Arelease%2F18.0.4) (July 13th 2026)
* Conditions: Apply page button conditions to the visible submit button [#1705](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1705)
* Conditions: Fall back to the option value when a choice caption is empty [#1727](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1727)
* Field Types: Guard against empty prevalue captions and values [#1386](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1386)
* Field Mapping: Align fields in the field mapping property editors [#1716](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1716)
* Form Entries: Truncate long field values in the entries collection table [#1708](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1708)
* Workflows: Record a failed workflow in the audit table so it can be retried [#1372](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1372)
* Workflows: Prevent unintended auto-approval when a workflow changes a record's state [#1598](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1598)

### [18.0.3](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+label%3Arelease%2F18.0.3) (July 2nd 2026)
* Fix upgrade failure when `DisableRecordIndexing` is set to `true`

### 18.0.2 (July 1st 2026)
* Analytics: Fix intermittent startup failure caused by the historical data backfill

### [18.0.1](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+label%3Arelease%2F18.0.1) (June 30th 2026)
* Added translations
* Form Design: Fix field layout overflow in multi-column fieldsets [#1682](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1682)
* Magic Strings: Resolve to field alias when captions collide [#1735](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1735)
* Field Types: Make `text-with-field-picker` editor controls full width [#1740](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1740)
* Workflows: Persist selected order when reordering workflow stages [#1741](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1741)
* Form Entries: Fix infinite error loop on entry details after browser back [#1742](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1742)

### 18.0.0 (June 25th 2026)
* Update dependencies to 18.0.0
* All items detailed under release candidates for 18.0.0.

### 18.0.0-rc2 (June 18th 2026)

* Update dependencies to 18.0.0-rc2

### 18.0.0-rc1 (June 4th 2026)

* Update dependencies to 18.0.0-rc1

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/12/umbraco-forms/release-notes.md) and [Umbraco Forms Package page](https://our.umbraco.com/packages/developer-tools/umbraco-forms/).
