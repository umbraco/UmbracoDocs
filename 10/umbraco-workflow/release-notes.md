---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco Workflow.
---

# Release notes

In this section, we have summarized the changes to Umbraco Workflow released in each version. Each version is presented with a link to the [Workflow issue tracker](https://github.com/umbraco/Umbraco.Workflow.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are migrating from Plumber to Umbraco Workflow, see the [Migrate from Plumber to Workflow](./upgrading/migrating-workflow.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Workflow 10 including all changes for this version.

### [10.4.1](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.4.1) (October 3 2024)
* Ensure scheduling information is displayed in workflow history [#82](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/82)
* Fixes an issue where dates were not correctly localised for scheduled workflows [#81](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/81)
* Fixes an issue where scheduled workflows did not apply the release/expire date if the content node was already scheduled [#81](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/80)
* Ensure converting integers to strings uses the invariant culture to avoid unexpected formatting

### [10.4.0](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.4.0) (September 12 2024)
* Fixes an issue where an awaited call does not trigger an AngularJS digest, causing the UI to hang. [#73](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/73)
* Fixes an issue where dates were not correctly localised in the Backoffice [#77](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/77)
* Fixes an issue related to sending notification emails in sites with a large number of Workflow groups [#79](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/79)
* **BREAKING CHANGE** resolving [#77](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/77) includes removing the `DateTimeSettings` class. This class allowed setting the preferred format for dates in the Backoffice. These settings were never applied, or were ignored when localising dates. Corresponding settings in app settings should be removed.

### [10.3.10](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.3.10) (May 10 2024)

* Fixes an issue where Content Review notification emails failed to send due to attempting to access UmbracoContext in a hosted service [#57](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/57)

### [10.3.9] (April 23rd 2024)

* Fixes an issue where SQL query generation exposed a potential injection vector. This fix was also released as a patch for Plumber v2 and v10.

### [10.3.8](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.3.8) (March 13th 2024)

* Make dashboard, content app, and section registration classes public [#56](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/56)
* Fixes discrepancy between a JSON property attribute value and property name in WorkflowTaskCollectionViewModel, which resulted in unexpected JSON values.

### [10.3.7](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.3.7) (February 28th 2024)

* Fixes issue where invariant workflows on variant content would publish previously published, but currently unpublished, variants [#52](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/52)
* Fixes issue where split-view allowed publishing content without using Workflow [#53](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/53)

The above fixes introduce an updated UI for requesting workflow approvals. For more information, see the [Submitting Content for Approval](./getting-started/submitting-changes.md) article.

### [10.3.6](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.3.6) (January 17th 2024)

* Fixes bug where workflow submission was not respecting user's language access permissions
* Fixes bug where approval groups were not populated for new nodes using the new-node approval workflow [#51](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/51)

### [10.3.5](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.3.5) (December 20th 2023)

* Updates internal license validation to handle licenses registered with 'UmbracoWorkflow' or 'Umbraco.Workflow'

### [10.3.4](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.3.4) (December 14th 2023)

* Introduces lazy constructor parameters to prevent database access when Workflow is installed as part of a new Umbraco install

### [10.3.3](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.3.3) (November 28th 2023)

* Update to use package migrations to avoid startup exception when Workflow is installed as part of a new Umbraco installation [#48](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/48)
* Fixed issue with scheduled workflows on invariant content [#49](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/49)

### [10.3.2](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.3.2) (October 24th 2023)

* Adds Italian translations
* Fixes bug where chart data series were generated for 24-hour timespans rather than from the start of the day [#45](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/45)
* Fixes bug where dates in the scheduling block were not offset according to the user's timezone [#47](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/47)

### [10.3.1](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.3.1) (September 26th 2023)

* Fixes bug where inherited members were not always populated in the associated approval group [#39](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/39)
* Corrects conditions for displaying alert banner in Workflow settings to ensure licensed settings are excluded from hidden or readonly calculations
* Fixes bug where new nodes were not requiring workflow approval due to inherited permissions not being applied
* Fixes bug where 'Lock active content' and 'Allow administrator edits' settings were not correctly applied
* Removes embedded licensing, replaced with Umbraco.Licenses

### [10.3.0](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.3.0) (September 5th 2023)

* Fixes bug where setting content review period to zero didn't exclude content from review [#28](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/28)
* Improves configuration options and handling for content reviews [#31](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/31)
* Fixes bug where variant workflows were not correctly scheduled [#42](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/42)
* Fixes bug when Swedish culture broke to differing unicode symbols when representing negative numbers [#44](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/44)
* Adds external reviewer option for content reviews
* Adds ability to schedule a publish workflow for both release and expire [#43](https://github.com/umbraco/Umbraco.Workflow.Issues/discussions/43)
* UX improvements for initiating workflows
* Removes 'Applies to' option from node-level workflow configuration as it was superceded by the equivalent global setting
* Aligns embedded licensing UI with Umbraco.Licenses
* BREAKING CHANGE: `ContentReviewReminderEmailer.SendReviewReminders.reviews` parameter changes from `Dictionary<UserGroupPoco, List<ContentReviewConfigPoco>>` to `Dictionary<IWorkflowGroup, List<ContentReviewConfigPoco>>`, which in turn changes the type of the `SentEntities` property in `WorkflowContentReviewsEmailNotificationsSendingNotification` and `WorkflowContentReviewsEmailNotificationsSentNotification`. `UserGroupPoco` implements `IWorkflowGroup`, but contains properties not present on the interface. These can be accessed by casting to the implemented type.

### [10.2.3](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.2.3) (August 1st 2023)

* Adds Dutch localization [#23](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/23)
* Additional localization cleanup and improvements
* Updates migration to avoid constraint errors [#35](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/35)

### [10.2.2](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.2.2) (June 29th 2023)

* Fixes filtering workflows initiated by the current user when FlowType is Exclude [#25](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/25)
* Ensures Document Type configuration for Content Reviews displays the license overlay on non-licensed installs [#24](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/24)
* Adds configuration option to allow administrators to edit content in an active workflow, regardless of content lock settings [#18](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/18)
* Fixes possible divide-by-zero error in chart generation
* Ensure workflow activity chart only shows stats box when stats exist

### [10.2.1](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.2.1) (May 23rd 2023)

* Ensure all Document Type properties are available when configuring conditional workflow stages
* Ensure license prompt is displayed only when install is unlicensed
* Fixes bug where default approval threshold wasn't set correctly when adding new workflow stages
* Fixes bug where querying published nodes for content reviews resulted in an ambiguous column name in the generated query [#17](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/17)
* Fixes bug where users were not persisted as approval group members if they were assigned as part of group creation

### [10.2.0](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.2.0) (May 9th 2023)

* **FEATURE** => Introduces [approval thresholds](workflow-section/approval-groups.md).

### [10.1.2](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.1.2) (April 18th 2023)

* **FEATURE** => Introduces optional configuration for manadatory comments
* **FEATURE** => Modifies content lock to allow edits until first workflow action is completed
* Ensure notifications inheriting from ObjectNotification have a public Target property [#13](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/13)
* Improve UI notification when publish fails on workflow completion
* Improve logged messages when publish fails on workflow completion
* Renames `/App_Plugins/Backoffice` to `/App_Plugins/backoffice` for Linux filepath resolution [#14](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/14)
* Ensure canEdit flag is set correctly when Workflow application state changes
* Ensure cancelled workflows are never marked as actioned by admin when cancelled by the original change requestor, regardless of their admin status

### [10.1.1](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.1.1) (March 8th 2023)

* Fixes bug in workflow detail overlay [#12](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/12)

### [10.1.0](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.1.01) (March 7th 2023)

* **FEATURE** => History cleanup and retention policies
* Fixes tree collision issue when multiple trees share class names [#11](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/11)
* Ensure version number is included in package manifest
* Improve UI/UX in submit workflow component
* Ensure notification emails are sent when a task is rejected [#9](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/9)
* Remove `async void` signatures
* Extends valid local license environment names
* Ensure signalR hub is not re-initialised once running

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-workflow/release-notes.md)
