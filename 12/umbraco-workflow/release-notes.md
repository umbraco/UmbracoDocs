---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco Workflow.
---

# Release notes

In this section, we have summarized the changes to Umbraco Workflow released in each version. Each version is presented with a link to the [Workflow issue tracker](https://github.com/umbraco/Umbraco.Workflow.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, you can find information about the breaking changes in the [Version Specific Upgrade Notes](./upgrading/version-specific.md) article
{% endhint %}

## Release History

This section contains the release notes for Umbraco Workflow 12 including all changes for this version.

#### [12.2.2](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.2.2) (December 20th 2023)

* Updates internal license validation to handle licenses registered with 'UmbracoWorkflow' or 'Umbraco.Workflow'

#### [12.2.1](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.2.1) (December 14 2023)

* Introduces lazy constructor parameters to prevent database access when Workflow is installed as part of a new Umbraco install

#### [12.2.0](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.2.0) (November 28th 2023)

* **FEATURE** => Advanced Search dashboard. Refer to [Advanced Search dashboard](advanced-search/advanced-search-dashboard.md) for more details.
* Update to use package migrations to avoid startup exception when Workflow is installed as part of a new Umbraco installation [#48](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/48)
* Fixed issue with scheduled workflows on invariant content [#49](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/49)

#### [12.1.2](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.1.2) (October 24th 2023)

* Adds Italian translations
* Fixes bug where chart data series were generated for 24-hour timespans rather than from the start of the day [#45](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/45)
* Fixes bug where dates in the scheduling block were not offset according to the user's timezone [#47](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/47)

#### [12.1.1](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.1.1) (September 26th 2023)

* Fixes bug where inherited members were not always populated in the associated approval group [#39](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/39)
* Corrects conditions for displaying alert banner in Workflow settings to ensure licensed settings are excluded from hidden or readonly calculations
* Fixes bug where new nodes were not requiring workflow approval due to inherited permissions not being applied
* Fixes bug where 'Lock active content' and 'Allow administrator edits' settings were not correctly applied

#### [12.1.0](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.1.0) (September 5th 2023)

* Fixes bug where setting content review period to zero didn't exclude content from review [#28](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/28)
* Improves configuration options and handling for content reviews [#31](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/31)
* Fixes bug where variant workflows were not correctly scheduled [#42](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/42)
* Fixes bug when Swedish culture broke to differing unicode symbols when representing negative numbers [#44](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/44)
* Adds external reviewer option for content reviews
* Adds ability to schedule a publish workflow for both release and expire [#43](https://github.com/umbraco/Umbraco.Workflow.Issues/discussions/43)
* UX improvements for initiating workflows
* Removes 'Applies to' option from node-level workflow configuration as it was superceded by the equivalent global setting
* BREAKING CHANGE: `ContentReviewReminderEmailer.SendReviewReminders.reviews` parameter changes from `Dictionary<UserGroupPoco, List<ContentReviewConfigPoco>>` to `Dictionary<IWorkflowGroup, List<ContentReviewConfigPoco>>`, which in turn changes the type of the `SentEntities` property in `WorkflowContentReviewsEmailNotificationsSendingNotification` and `WorkflowContentReviewsEmailNotificationsSentNotification`. `UserGroupPoco` implements `IWorkflowGroup`, but contains properties not present on the interface. These can be accessed by casting to the implemented type.

#### [12.0.1](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.1) (August 1st 2023)

* Adds Dutch localization [#23](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/23)
* Additional localization cleanup and improvements
* Fixes Swagger generation error [#29](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/29)
* Updates migration to avoid constraint errors [#35](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/35)

#### [12.0.0](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F12.0.0) (June 29th 2023)

* Fixes filtering workflows initiated by the current user when FlowType is Exclude [#25](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/25)
* Ensures Document Type configuration for Content Reviews displays the license overlay on non-licensed installs [#24](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/24)
* Adds configuration option to allow administrators to edit content in an active workflow, regardless of content lock settings [#18](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/18)
* Fixes possible divide-by-zero error in chart generation
* Ensure workflow activity chart only shows stats box when stats exist

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on Github](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-workflow/release-notes.md)
