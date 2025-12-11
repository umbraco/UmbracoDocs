---
description: Get an overview of the changes and fixes in each version of Umbraco Workflow.
---

# Release notes

In this section, we have summarized the changes to Umbraco Workflow that were released in each version. Each version is presented with a link to the [Workflow issue tracker](https://github.com/umbraco/Umbraco.Workflow.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the details.

If there are any breaking changes or other issues to be aware of when upgrading, they are also noted here.

{% hint style="info" %}
Check the [Version Specific Upgrade Notes](upgrading/version-specific.md) article for breaking changes when upgrading to a new major version.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Workflow 17, including all changes for this version.

### [17.0.1](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.0.1) (Decemer 11, 2025)
* Fixes a bug where removing document approval steps did not persist the changes [#122](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/122)
* Fixes a bug where the request-approval action was not displaying for new documents, where the new-document approval workflow had been configured [#121](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/121)
* Fixes a bug where adding an approval group would result in an error due a failing key-to-id map [#120](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/120)
* Fixes a bug where deleting content or document types did not complete correctly due to a missing scope [#119](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/119)

### [17.0.0-rc](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.0.0-rc) (November 7, 2025)

* Compatibility with Umbraco 17-rc.
* Introduces granular permissions model.
* Updates all persistence operations to use scoped transactions.
* Moves Workflow settings from `/workflow` to `/settings`. This change allows users to access  `/workflow` without exposing low-level settings.
* Updates all DateTimes to UTC, in line with changes made in the CMS.

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-workflow/release-notes.md)
