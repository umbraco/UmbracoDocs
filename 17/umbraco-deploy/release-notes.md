---
description: Get an overview of the things changed and fixed in each version of Umbraco Deploy.
---

# Release Notes

In this section, we have summarized the changes to Umbraco Deploy and [Deploy Contrib](https://github.com/umbraco/Umbraco.Deploy.Contrib) released in each version. Each version is presented with a link to the [Deploy issue tracker](https://github.com/umbraco/Umbraco.Deploy.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the details.

If there are any breaking changes or other issues to be aware of when upgrading, they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, you can find the details about the breaking changes in the [version-specific updates](upgrades/version-specific.md) article.
{% endhint %}

## Release history

This section contains the release notes for Umbraco Deploy 17, including all changes for this version.

### [17.0.1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.0.1) (January 8th 2026)

* Set environment URL when fetching remote items and close dropdown after changing environment: [#300](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/300).
* Register all supported entity types on back-end and front-end: [#273](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/273).

### [17.0.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.0.0) (November 27th 2025)

* Compatibility with Umbraco 17.0.0.
* Simplified entity type registration that relies more on client-side registrations for the backoffice UI.
* Resource-based authorization now takes permissions into account for descendant entities, ensuring you can only transfer or export items you are allowed to access.
* Add support for Single Block Data Type/editor values.
* Fix scheduled publishing dates to use UTC.

### [17.0.0-rc3](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.0.0) (November 25th 2025)

* Compatibility with Umbraco 17.0.0-rc4.

### [17.0.0-rc2](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.0.0) (November 21th 2025)

* Compatibility with Umbraco 17.0.0-rc3.

### [17.0.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.0.0) (October 30th 2025)

* Compatibility with Umbraco 17.0.0-rc1.
  * See full details of breaking changes under the [Version-specific Upgrade Guide](upgrades/version-specific.md).

## Umbraco.Deploy.Contrib

### [17.0.0](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-17.0.0) (November 27th 2025)

* Compatibility with Umbraco 17.0.0 and Deploy 17.0.0.

### [17.0.0-rc3](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-17.0.0-rc3) (November 25th 2025)

* Compatibility with Umbraco 17.0.0-rc4 and Deploy 17.0.0-rc3.

### [17.0.0-rc2](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-17.0.0-rc2) (November 21st 2025)

* Compatibility with Umbraco 17.0.0-rc3 and Deploy 17.0.0-rc2.

### [17.0.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-17.0.0-rc1) (October 30th 2025)

* Compatibility with Umbraco 17.0.0-rc1 and Deploy 17.0.0-rc1.

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-deploy/release-notes.md) and [Umbraco Deploy Package page](https://our.umbraco.com/packages/developer-tools/umbraco-deploy/).
