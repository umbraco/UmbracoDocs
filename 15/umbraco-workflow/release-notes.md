---
description: Get an overview of the changes and fixes in each version of Umbraco Workflow.
---

# Release notes

In this section, we have summarized the changes to Umbraco Workflow that were released in each version. Each version is presented with a link to the [Workflow issue tracker](https://github.com/umbraco/Umbraco.Workflow.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
Check the [Version Specific Upgrade Notes](upgrading/version-specific.md) article for breaking changes when upgrading to a new major version.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Workflow 15 including all changes for this version.

### [15.1.5](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.1.5) (June 11 2025)
* Fixes pagination offset in editor dashboards [#105](https://github.com/umbrco/Umbraco.Workflow.Issues/issues/105)

### [15.1.4](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.1.4) (May 29 2025)
* Improves task summary display in notification emails [#94](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/94)
* Fixes error when attempting to open the workflow detail dialog from the editor dashboard
* Improves variant handling when creating workflow processes in code
* Aligns date handling with CMS

### 15.1.3 (May 2 2025)
* Fixes display of new-node workflow configuration, and improves workflow scaffolding for new documents.

### 15.1.2 (April 2 2025)
* Improves culture variant handling in Advanced Search
* Ensure case-insensitive culture comparison when fetching tasks

### 15.1.1 (March 20 2025)
* Fixes an intermittent issue where fetching approval groups in a mapper resulted in a scoping error

### [15.1.0](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.1.0) (March 7 2025 )
* Dependency update for Umbraco.Licenses (making this release a minor)
* Fixes pagination in assigned-to task table [#96](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/91)
* Fixes off-by-one bug when calculating approval thresholds with implicit approval [#97](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/97)
* Allow searching for empty fields in advanced search. For example, search for all Product documents with no SKU

### 15.0.4 (March 3, 2025)
* Fixes an issue where Workflow's content lock was always applied on documents where Workflow was not configured.
* Fixes a related issue where the content lock was never applied on invariant documents with no Workflow configuration.

### 15.0.3 (February 14, 2025)
* Fixes SQLite migration bug where async methods were causing a race condition.

### [15.0.2](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.0.2) (January 16 2025 )
* Fixes workflow task summary generation in email body [#91](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/91)
* Fixes localization in email body
* Updates Umbraco.Licenses dependency
* Refactors migration plan naming to align with the broader DXP product suite.

### 15.0.1 (December 16th 2024)
* Fixes column type mismatch in migration
* Correctly implements delay time in History Cleanup hosted service

### 15.0.0 (November 14th, 2024)
* Compatibility with Umbraco 15
* Replaces entity action wrappers with `umbExtensionRegistry.appendCondition()`
* Adds abstraction over `UmbContentWorkspaceContext.readOnlyState` to consistently implement readonly document workspaces.
* Fixes invariant culture handling when unlocking a scheduled document.

### 15.0.0-rc3 (November 8th, 2024)
* Compatibility with Umbraco 15-rc3

### 15.0.0-rc2 (October 23rd, 2024)
* Compatibility with Umbraco 15-rc2

### 15.0.0-rc1 (October 9th, 2024)
* Compatibility with Umbraco 15-rc1

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-workflow/release-notes.md)
