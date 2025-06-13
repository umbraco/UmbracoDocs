---
description: Get an overview of the things changed and fixed in each version of Umbraco Deploy.
---

# Release Notes

In this section we have summarised the changes to Umbraco Deploy and [Deploy Contrib](https://github.com/umbraco/Umbraco.Deploy.Contrib) released in each version. Each version is presented with a link to the [Deploy issue tracker](https://github.com/umbraco/Umbraco.Deploy.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version you can find the details about the breaking changes in the [version specific updates](upgrades/version-specific.md) article.
{% endhint %}

## Release history

This section contains the release notes for Umbraco Deploy 15 including all changes for this version.

### [16.0.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.0.0) (May 12th 2025)

* Compatibility with Umbraco 16.0.0

### [16.0.0-rc5](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.0.0) (May 10th 2025)

* Compatibility with Umbraco 16.0.0-rc6

### [16.0.0-rc4](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.0.0) (May 10th 2025)

* Compatibility with Umbraco 16.0.0-rc5
* Removed obsolete code

### [16.0.0-rc3](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.0.0) (May 3rd 2025)

* Compatibility with Umbraco 16.0.0-rc4
* Add `deployEntityTypeMapping` manifest to allow mapping client-side entity types (used in workspaces and routes) to their server-side entity types (used in UDIs, artifacts, and service connectors)
* Use default `TryParseUdiRangeFromNodeId` implementation for internally registered entity types

### [16.0.0-rc2](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.0.0) (May 30th 2025)

* Compatibility with Umbraco 16.0.0-rc3
* Rename/add `CancellationToken` parameters and add `ConfigureAwait(false)` to awaits

### [16.0.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.0.0) (May 16th 2025)

* Compatibility with Umbraco 16.0.0-rc2
  * See full details of breaking changes under the [Version-specific Upgrade Guide](upgrades/version-specific.md)

## Umbraco.Deploy.Contrib

### [16.0.0](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-16.0.0) (May 12th 2025)

* Compatibility with Umbraco 16.0.0 and Deploy 16.0.0

### [16.0.0-rc5](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-16.0.0-rc5) (May 10th 2025)

* Compatibility with Umbraco 16.0.0-rc6 and Deploy 16.0.0-rc5

### [16.0.0-rc4](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-16.0.0-rc4) (May 10th 2025)

* Compatibility with Umbraco 16.0.0-rc5 and Deploy 16.0.0-rc4

### [16.0.0-rc3](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-16.0.0-rc3) (May 3rd 2025)

* Compatibility with Umbraco 16.0.0-rc4 and Deploy 16.0.0-rc3

### [16.0.0-rc2](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-16.0.0-rc2) (May 30th 2025)

* Compatibility with Umbraco 16.0.0-rc3 and Deploy 16.0.0-rc2

### [16.0.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-16.0.0-rc1) (May 20th 2025)

* Compatibility with Umbraco 16.0.0-rc2 and Deploy 16.0.0-rc1
* Update `TinyMCEv3DataTypeArtifactMigrator` to migrate legacy (v7) Umbraco.TinyMCEv3 to Umbraco.RichText with Tiptap UI editor

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-deploy/release-notes.md) and [Umbraco Deploy Package page](https://our.umbraco.com/packages/developer-tools/umbraco-deploy/)
