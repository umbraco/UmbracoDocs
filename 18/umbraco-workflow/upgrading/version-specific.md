---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco
  Workflow.
---

# Version Specific Upgrade Notes

This page covers specific upgrade documentation for when migrating to Umbraco Workflow version 17.

{% hint style="info" %}
If you are upgrading to a new minor or patch version, you can find information about the breaking changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

Version 17 of Umbraco Workflow has a minimum dependency on Umbraco CMS core of `17.0.0`. It runs on .NET 10.

This version introduces granular permissions for Workflow features:
- Active Workflows: Read
- Advanced Search: Read
- Alternate Versions: Create, Read, Update, Delete, Promote
- Approval Groups: Create, Read, Update, Delete
- Configuration: Read, Update
- Content Reviews: Read
- Document: Initiate, Unlock
- History: Read
- Release Sets: Create, Read, Update, Delete, Publish

Default permissions are set in a migration:
- Administrator group has all permissions
- Editor group has all Read permissions
- Other groups have no permissions

Workflow settings (for content approval, content reviews and release sets) are relocated to the Settings section. Combined with the above permissions, this allows broader access to the Workflow section. Permission can be read-only for the views in the Workflow section (Approval Groups, Active Workflows, Content Reviews, History).

### Legacy version specific upgrade notes

You can find the version specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/tree/umbraco-eol-versions).
