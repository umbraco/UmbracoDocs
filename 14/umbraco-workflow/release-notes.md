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

This section contains the release notes for Umbraco Workflow 13 including all changes for this version.

### [13.0.7](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.4) (May 10 2024)

* Fixes an issue where Content Review notification emails failed to send due to attempting to access UmbracoContext in a hosted service [#57](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/57)

### [13.0.6] (April 23rd 2024)

* Fixes an issue where SQL query generation exposed a potential injection vector.

### [13.0.5](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.4) (March 13th 2024)

* Make dashboard, content app, and section registration classes public [#56](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/56)
* Fixes discrepancy between a JSON property attribute value and property name in WorkflowTaskCollectionViewModel, which resulted in unexpected JSON values.

### [13.0.4]

* Incorrectly tagged and released as 13.0.5 🤦

### [13.0.3](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.3) (February 28th 2024)

* Fixes issue where invariant workflows on variant content would publish previously published, but currently unpublished, variants [#52](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/52).
* Fixes issue where split-view allowed publishing content without using Workflow [#53](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/53).

The above fixes introduce an updated UI for requesting workflow approvals. For more information, see the [Submitting Content for Approval](./getting-started/submitting-changes.md) article.

### [13.0.2](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.2) (January 17th 2024)

* Fixes bug where workflow submission was not respecting user's language access permissions
* Fixes bug where approval groups were not populated for new nodes using the new-node approval workflow [#51](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/51)

### [13.0.1](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.1) (December 20th 2023)

* Updates internal license validation to handle licenses registered with 'UmbracoWorkflow' or 'Umbraco.Workflow'

### [13.0.0](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) (December 14th 2023)

* Compatibility with Umbraco 13
  * For full details of breaking changes refer to the [Version Specific Upgrade Notes](upgrading/version-specific.md)
* **FEATURE** => Advanced Search dashboard. Refer to [Advanced Search dashboard](advanced-search/advanced-search-dashboard.md) for more details.
* Update to use package migrations to avoid startup exception when Workflow is installed as part of a new Umbraco installation [#48](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/48)
* Fixed issue with scheduled workflows on invariant content [#49](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/49)
* Introduces lazy constructor parameters to prevent database access when Workflow is installed as part of a new Umbraco install

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on Github](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-workflow/release-notes.md)
