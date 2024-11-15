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
### 14.1.2 (November 14th 2024)
* Adds abstraction over `UmbContentWorkspaceContext.readOnlyState` to consistently implement readonly document workspaces.
* Fixes invariant culture handling when unlocking a scheduled document.

### 14.1.1 (November 7th 2024)
* Fixes a bug causing migrations from Workflow 13 to fail on SQL Server.
* Fixes the above exposed a secondary issue where the migration from integer to GUID identifiers was incomplete. This resulted in incorrect relationships between approval groups and tasks in historic Workflow data, and incorrect information displaying the backoffice. 
* Adds SQL query performance improvements.
* Adds loading indicator to Workflow tables in the backoffice.

### [14.1.0](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.0) (October 23rd 2024 )
* Adds scheduled content locking feature. Documents can be made readonly until the scheduled release date passes, to ensure approved content is not modified without workflow approval. [#84](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/84)
* Adds support for readonly mode when a document is pending workflow approval. Along with the scheduled content lock, this feature requires Umbraco 14.3.0, which is now the minumum version dependency for Umbraco Workflow v14.
* Adds support for content segments. Segment names are displayed when requesting approval and in workflow history [#60](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/60)
* Adds support for Arabic.
* Improves UI in workflow detail overlay. Reduces the number of elements and shifts appropriate data points into tag elements.
* Adds email queue for thread-safe email notifications. Emails are now processed in the hosted service, via a first-in first-out queue. This resolves a reported issue where sending large numbers of emails could result in data reader errors. [#85](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/85)

### [14.0.3](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.0.3) (October 3rd 2024)
* Ensure scheduling information is displayed in workflow history [#82](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/82)
* Fixes an issue where dates were not correctly localized for scheduled workflows [#81](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/81)
* Fixes an issue where scheduled workflows did not apply the release/expire date if the content node was already scheduled [#81](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/80)
* Ensure converting integers to strings uses the invariant culture to avoid unexpected formatting
* Fixes an issue related to sending notification emails in sites with a large number of workflow groups [#79](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/79)

### [14.0.2](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.0.2) (August 5th 2024)

* Fixes an issue where available approval group names were not displayed in Document Type approval flow condition configuration [#76](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/76)
* Updates to allow editing approval group roles (content and/or Document Type) via overlay [#75](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/75)
* Fixes an issue where adding status filters did not update the filter context [#74](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/74)
* Updates workflow history table to include status column [#72](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/72)
* Updates incorrect localization in Document Type review settings overlay [#71](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/71)
* Fixes clear button functionality in filter modal [#67](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/67)
* Fixes approval group options in reject task modal [#65](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/65)
* Updates incorrect localization in workflow detail modal when the state is `pending approval` [#64](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/64)
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
