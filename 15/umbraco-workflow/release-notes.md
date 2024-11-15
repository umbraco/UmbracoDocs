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

You can find the release notes for versions out of support in the [Legacy documentation on Github](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-workflow/release-notes.md)
