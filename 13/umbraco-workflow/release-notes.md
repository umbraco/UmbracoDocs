---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco Workflow.
---

# Release notes

In this section, we have summarized the changes to Umbraco Workflow released in each version. Each version is presented with a link to the [Workflow issue tracker](https://github.com/umbraco/Umbraco.Workflow.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, you can find information about the breaking changes in the [Version Specific Upgrade Notes](upgrading/version-specific.md) article
{% endhint %}

## Release History

This section contains the release notes for Umbraco Workflow 13 including all changes for this version.

#### [13.0.2](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.2) (January 17th 2024)

* Fixes bug where workflow submission was not respecting user's language access permissions
* Fixes bug where approval groups were not populated for new nodes using the new-node approval workflow [#51](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/51)

#### [13.0.1](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.1) (December 20th 2023)

* Updates internal license validation to handle licenses registered with 'UmbracoWorkflow' or 'Umbraco.Workflow'

#### [13.0.0](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) (December 14th 2023)

* Compatibility with Umbraco 13
  * For full details of breaking changes refer to the [Version Specific Upgrade Notes](upgrading/version-specific.md)
* **FEATURE** => Advanced Search dashboard. Refer to [Advanced Search dashboard](advanced-search/advanced-search-dashboard.md) for more details.
* Update to use package migrations to avoid startup exception when Workflow is installed as part of a new Umbraco installation [#48](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/48)
* Fixed issue with scheduled workflows on invariant content [#49](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/49)
* Introduces lazy constructor parameters to prevent database access when Workflow is installed as part of a new Umbraco install

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on Github](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-workflow/release-notes.md)
