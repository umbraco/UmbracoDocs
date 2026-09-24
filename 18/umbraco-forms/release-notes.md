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

### [18.2.0-rc](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+label%3Arelease%2F18.2.0) (September 17th 2026)

#### Form versions

A version of a form is now saved every time the form is saved, including its workflows. The Rollback action on a form lists the saved versions, shows what each one contains, and rolls the form back to the one you pick. A rollback is saved as a version of its own, so it can be undone the same way.

Pin a version to keep it. Pinned versions, and the most recent version of a form, are never removed.

Removing older versions is opt-in and set up in configuration. For the settings, see the [FormVersionCleanup](developer/configuration/README.md#formversioncleanup) section of the Configuration article.

For more information, see the [Rollback to a Previous Version](editor/managing-forms/rollback-to-a-previous-version.md) article.

#### Recycle bin

Deleting a form or a folder now moves it to a recycle bin, instead of removing it straight away. Deleting a folder moves everything inside it as well.

A form in the recycle bin no longer renders on your website, and the Forms API returns a "not found" response for it. Restore the form to bring it back, along with the folder it came from.

Nothing is removed from the database until you delete it from the bin. Deleting it there removes the form with its entries, workflows, stored versions, and user permissions.

For more information, see the [Recycle Bin](editor/managing-forms/recycle-bin.md) article.

#### Form history

The **Info** tab of a form now lists each change made to the form. An entry records when the form was created, saved, moved to the recycle bin, restored, rolled back, or deleted.

For more information, see the [Form History](editor/managing-forms/form-history.md) article.

#### Other

* Records: Add create and delete endpoints to the Management API
* Field Types: Add a Decimal storage type for field values, so decimals keep their fractional part instead of being stored as whole numbers [#1515](https://github.com/umbraco/Umbraco.Forms.Issues/discussions/1515)
* Form Entries: Show a record's additional data in the entry details [#1602](https://github.com/umbraco/Umbraco.Forms.Issues/discussions/1602)
* Date Fields: Format date field values in the record's own culture in the entries grid, exports, and workflow output [#1773](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1773)
* Data Sources: Fix foreign key detection for SQL database data sources [#1768](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1768)
* Data Sources: Render the data source type settings on the initial workspace load [#1770](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1770)
* Providers: Handle unregistered provider types without failing the provider listings [#1769](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1769)
* Forms Dashboard: Fix incorrect pagination when searching forms [#1776](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1776)
* Delivery API: Resolve local links in the message shown on submit [#1227](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1227)
* Delivery API: Return rich text as JSON when `RichTextOutputAsJson` is enabled [#1779](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1779)
* File Upload: Fix the page reload when pressing Enter to add an allowed file type [#1780](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1780)
* File Upload: Fix the alignment and sizing of the allowed file type buttons [#1780](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1780)
* Field Previews: Fix the alignment of preview list items [#1635](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1635)
* Form Copy: Remap field ids in workflow conditions when copying a form [#1784](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1784)
* Permissions: Check the edit permission, not the view permission, before allowing an entry to be edited

{% hint style="warning" %}
The Post to URL, Post as XML, and Save as File workflows now send date field values in the ISO 8601 format.

For example, a date is sent as `2027-09-22T19:33:00`. These workflows previously used the format of whichever culture the server ran under. Update any integration that parses these values.

Date field values shown to people now follow the culture the entry was submitted with. The entries grid, the exports, the email and Slack workflows, and the Save as Umbraco Node workflow are affected.

For the full list of what changed and what to check, see the [Version Specific Upgrade Notes](upgrading/version-specific.md#date-formats-in-workflows-and-exports) article.
{% endhint %}

{% hint style="info" %}
Form versions are kept indefinitely. Removing old versions is opt-in, so an upgrade never removes form history on its own.

To start removing them, set `Enabled` to `true` under `Umbraco:Forms:Options:FormVersionCleanup`, and set `KeepLatestVersions`, `KeepVersionsNewerThanDays`, or both. The most recent version of a form and any pinned version are always kept.
{% endhint %}

### 18.1.3 (September 24th 2026)
* Show form names as plain text in the **Move** and **Copy workflows** dialogs, so HTML in a name can't run as script [GHSA-r7qp-475g-rwpg](https://github.com/umbraco/Umbraco.Forms.Issues/security/advisories/GHSA-r7qp-475g-rwpg)
* Upgrading: Grant the Forms **Security** permission to the **Administrators** group without rolling back the upgrade. Sites stuck in the `Upgrading` state after installing 18.1.2 complete the upgrade on the next start.

### 18.1.2 (September 17th 2026)
* Require a dedicated user group permission for the Forms Security area, so that backoffice users cannot grant themselves Forms permissions [GHSA-8jv5-237g-mfj9](https://github.com/umbraco/Umbraco.Forms.Issues/security/advisories/GHSA-8jv5-237g-mfj9)
* Umbraco Licenses dependency updated to 18.0.3

{% hint style="warning" %}
Access to the Forms Security area now depends on a new **Security** permission. You grant it on the **Permissions** tab of a user group. The upgrade grants the permission to the built-in **Administrators** group only. Any other user group that manages Forms security must be granted the permission again by an administrator.
{% endhint %}

### [18.1.1](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+label%3Arelease%2F18.1.1) (August 27th 2026)

* Upgrading: Fix a boot failure when upgrading directly from Forms 17.5.0 [#1782](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1782)

{% hint style="warning" %}
If you run Forms 17.5.0, upgrade to 18.1.1 or later. Versions 18.0.0 to 18.1.0 do not recognize the migration state that Forms 17.5.0 ends on, and the upgrade fails at boot. For details, see the [Version Specific Upgrade Notes](upgrading/version-specific.md) article.
{% endhint %}

### [18.1.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+label%3Arelease%2F18.1.0) (August 20th 2026)

The changes below are the ones made since `18.1.0-rc`. For everything else in this release, see the `18.1.0-rc` notes.

* Prevent backoffice users without access to sensitive data from reading the values and uploaded files of fields marked as sensitive [GHSA-p6vj-8vxc-mf5c](https://github.com/umbraco/Umbraco.Forms.Issues/security/advisories/GHSA-p6vj-8vxc-mf5c)
* Withhold the details of the member who submitted an entry from backoffice users without access to sensitive data [GHSA-p6vj-8vxc-mf5c](https://github.com/umbraco/Umbraco.Forms.Issues/security/advisories/GHSA-p6vj-8vxc-mf5c)
* Upgrading: Fix a boot failure when upgrading directly from Forms 13.9.9 [#1772](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1772)
* API: Return problem details from the management API, so the real error message appears in the backoffice instead of `Unknown error`
* Localization: Sync the Czech, Danish, Spanish, French, Italian, Dutch, and Polish translation files with the current English keys
* Localization: Correct the Danish translations, including the term used for prevalue captions and the email-related labels
* Records: Read record field values in batches, instead of one database query per field value
* Records: Populate the Examine records index in groups of records, instead of holding every record for a form in memory at once

{% hint style="info" %}
This release changes who can download the files uploaded to a form that collects sensitive data. For details, see the [Sensitive Data](developer/security.md#what-sensitive-means-for-file-uploads) section of the Security article.

Upgrading rebuilds the Examine records index. Values captured before the upgrade are re-indexed without the data from fields marked as sensitive. This release also reduces how long that rebuild takes, especially on installations with many form entries.
{% endhint %}

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

### 18.0.6 (August 18th 2026)
* Prevent backoffice users without access to sensitive data from reading the values and uploaded files of fields marked as sensitive [GHSA-p6vj-8vxc-mf5c](https://github.com/umbraco/Umbraco.Forms.Issues/security/advisories/GHSA-p6vj-8vxc-mf5c)
* Withhold the details of the member who submitted an entry from backoffice users without access to sensitive data [GHSA-p6vj-8vxc-mf5c](https://github.com/umbraco/Umbraco.Forms.Issues/security/advisories/GHSA-p6vj-8vxc-mf5c)

{% hint style="info" %}
This release changes who can download the files uploaded to a form that collects sensitive data. For details, see the [Sensitive Data](developer/security.md#what-sensitive-means-for-file-uploads) section of the Security article.

Upgrading rebuilds the Examine records index. Values captured before the upgrade are re-indexed without the data from fields marked as sensitive. On installations with many form entries, this rebuild can take some time to complete.
{% endhint %}

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
