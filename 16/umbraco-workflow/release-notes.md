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

This section contains the release notes for Umbraco Workflow 16 including all changes for this version.

### [16.0.2](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.0.2) (July 17 2025)
* Adds French localization (hat-tip Copilot/Claude)
* Improves display of inherited approval group members
* Ensure users without Workflow section access have read-only document configuration access
* Ensures history cleanup element is only rendered when the feature is enabled
* Fixes approval threshold changes not applying to Document Type workflow configuration
* Prefer observing over getting values in property editors in settings workspace
* Additional formatting and content improvements in email task summaries [#94](https:/github.com/umbraco/Umbraco.Workflow.Issues/issues/94)
* Ensures state is recalculated after actioning a workflow task [#105](https:/github.com/umbraco/Umbraco.Workflow.Issues/issues/105)
* Ensure users without document update permission do not see request-approval action [#105](https:/github.com/umbraco/Umbraco.Workflow.Issues/issues/105)
* Fixes a bug where rejected content was not editable by the user who made the change [#105](https:/github.com/umbraco/Umbraco.Workflow.Issues/issues/105)
* Fixes setting enabled/disabled state on workflow action buttons [#107](https:/github.com/umbraco/Umbraco.Workflow.Issues/issues/107)
* Fixes previewing content changes from a pending workflow [#108](https:/github.com/umbraco/Umbraco.Workflow.Issues/issues/108)
* Fixes a bug where documents without workflow configuration did not always display default workspace actions [#109](https:/github.com/umbraco/Umbraco.Workflow.Issues/issues/109)

### 16.0.1 (June 8, 2025)
* Minor fixes on 16.0.0 release

### 16.0.0 (June 12 2025)
* Compatibility with Umbraco 16
* **FEATURE** => Alternate Versions. Refer to [Alternate Versions](alternate-versions/alternate-versions.md) for more details.
* **FEATURE** => Release Sets. Refer to [Release Sets](release-sets/release-sets.md) for more details.

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-workflow/release-notes.md)
