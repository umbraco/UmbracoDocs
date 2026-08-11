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

#### Member data

You can now connect form fields to member properties. A field mapped to a member property is pre-filled for the logged-in member, either as an editable field or a hidden one. Each member's form activity appears on a Forms tab in the Member editor. The analytics overview and per-form tables report the number of unique members who submitted a form.

For more information, see the [Connecting Fields to Member Data](editor/creating-a-form/connecting-fields-to-member-data.md), [Member Form Submissions](editor/member-form-submissions.md), and [Analytics](editor/analytics.md) articles.

#### Other

* Records: Store the submission page as a GUID (`UmbracoPageKey`), the preferred reference over the integer `UmbracoPageId` [#1719](https://github.com/umbraco/Umbraco.Forms.Issues/discussions/1719)
* Headless: Expose additional form settings in the Delivery API definition response [#1439](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1439)
* Record Export: Make the CSV export delimiter configurable [#1541](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1541)
* Workflows: Add `GetConfigurationErrors()` support for workflow types [#1709](https://github.com/umbraco/Umbraco.Forms.Issues/discussions/1709)
* Workflows: Populate the `Exception` property on `WorkflowExecutionFailedNotification` [#1700](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1700)
* Field & Workflow Settings: Add setting value converters so property editor UIs persist values correctly [#1569](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1569)
* Field & Workflow Settings: Support typed setting values (`int`, `decimal`, `enum`, `Guid`) [#1717](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1717)
* Email: Surface the underlying error detail when a Razor email view fails to render [#1571](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1571)
* Workflows: Persist additional data set during workflow execution [#1603](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1603)
* Workflows: Fix the workflow type label shown for a deleted workflow [#1713](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1713)
* Workflows: Fix `IFeatureCollection has been disposed` when running workflows via `RecordService` [#1362](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1362)
* Workflows: Resolve the rich text editor from the configured Data Type in the Send email (Razor) workflow [#1756](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1756)
* Email: Respect the `DefaultEmailTemplate` provided by an email template collection [#1737](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1737)
* Field Types: Fix the sensitive data toggle disappearing when enabled [#1415](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1415)
* Field & Workflow Settings: Keep the field editor open when settings validation fails
* Validation: Use the configured validation message for regular expression validation [#858](https://github.com/umbraco/Umbraco.Forms.Issues/issues/858)
* Form Design: Remove the top margin on the first form settings layout item [#1643](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1643)
* Form Permissions: Set the permissions for a new form from its creator, so copied and imported forms are set up correctly
* Delivery API: Return default field settings in the response when settings have not been edited [#1753](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1753)
* Data Sources: Fix the form wizard assigning a default prevalue source that hasn't been saved yet to foreign-key fields [#1751](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1751)
* Assets: Use the CMS cache buster so backoffice assets refresh after an upgrade [#1739](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1739)
* Upgrades: Migrate legacy XPath root node settings in prevalue sources and the Save as Umbraco node workflow to dynamic root
* Upgrades: Fix the prevalue source repair migration failing on SQL Server
* Analytics: Group charts by the viewer's local time zone instead of UTC, so they match the entries list [#1759](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1759)
* Workflows: Fix the Save as Umbraco node workflow parsing dates with the wrong culture, which could save the wrong date or fail the workflow [#1758](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1758)
* Workflows: Trim form names when parsing the `IgnoreWorkFlowsOnEdit` setting, so a comma-separated list of form names matches correctly
* Localization: Localize the delete confirmation dialog for pages, groups, fields, and workflows, and add German (de-de) [#1442](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1442)
* Backoffice Contexts: Normalize context-token alias strings to Forms + PascalCase [#1724](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1724)
* Field Types: Only lock the sensitive data toggle once its value has been saved, so it can still be turned back off before saving [#1762](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1762)

### [18.0.5](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+label%3Arelease%2F18.0.5) (July 22nd 2026)
* Enforce server-side validation of the form step to prevent bypassing page validation and CAPTCHA on submission [GHSA-fv48-47xr-hwfj](https://github.com/umbraco/Umbraco.Forms.Issues/security/advisories/GHSA-fv48-47xr-hwfj)

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

## Umbraco.Forms.Deploy

### 18.0.1 (July 24th 2026)

* Fix Umbraco Forms artifact property mappings lost on transfer/restore, including *Show summary page* and related form settings [#331](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/331)
* Fix deploy of `Form.MessageOnSubmitBlocks` and its block element type dependencies (Umbraco Forms 17.3.0 or later)

### 18.0.0 (June 25th 2026)

* Compatibility with Umbraco Forms 18 and Deploy 18

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/12/umbraco-forms/release-notes.md) and [Umbraco Forms Package page](https://our.umbraco.com/packages/developer-tools/umbraco-forms/).
