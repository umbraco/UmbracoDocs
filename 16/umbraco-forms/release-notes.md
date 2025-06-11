---
description: Get an overview of the things changed and fixed in each version of Umbraco Forms.
---

# Release notes

In this section, we have summarized the changes to Umbraco Forms released in each version. Each version is presented with a link to the [Forms issue tracker](https://github.com/umbraco/Umbraco.Forms.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, you can find information about the breaking changes in the [Version Specific Upgrade Notes](upgrading/version-specific/) article.
{% endhint %}

## Release history

This section contains the release notes for Umbraco Forms 16 including all changes for this version.

### [16.0.0-rc3](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.0.0) (June 3rd 2025)

* Compatibility with Umbraco 16.0.0-rc4
* Fix field/workflow settings not displaying in dialogs

### [16.0.0-rc2](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.0.0) (May 26th 2025)

* Compatibility with Umbraco 16.0.0-rc3
* Remove dependency on shop.umbraco.com (no trial license generation on install or retrieval of license in backoffice)
* Replace Excel export (using outdated EPPlus dependency) with CSV export using CsvHelper
* Add 'Save and preview' feature [#655](https://github.com/umbraco/Umbraco.Forms.Issues/issues/655)

### [16.0.0-rc1](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.0.0) (May 15th 2025)

* Compatibility with Umbraco 16.0.0-rc2
  * See full details of breaking changes under the [Version-specific Upgrade Guide](upgrading/version-specific/).

## Umbraco.Forms.Deploy

This Deploy add-on adds support for transferring, restoring, exporting and importing (including migrating between major versions) of Umbraco Forms data.

### 16.0.0-rc3 (June 3rd 2025)

* Update Forms and Deploy dependencies to 16.0.0-rc3

### 16.0.0-rc2 (May 30th 2025)

* Update Forms and Deploy dependencies to 16.0.0-rc2
* Update client-side entity types to align with server-side (UDI entity types)

### 16.0.0-rc1 (May 20th 2025)

* Update Forms and Deploy dependencies to 16.0.0-rc1

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/12/umbraco-forms/release-notes.md) and [Umbraco Forms Package page](https://our.umbraco.com/packages/developer-tools/umbraco-forms/).
