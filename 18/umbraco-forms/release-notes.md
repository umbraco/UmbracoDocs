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
