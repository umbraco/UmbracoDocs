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

This section contains the release notes for Umbraco Deploy 18, including all changes for this version.

### [18.0.0-rc2](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.0.0) (June 5th 2026)

* Compatibility with Umbraco CMS 18.0.0-rc2.
* Restrict Deploy SignalR hubs to WebSockets when the `Umbraco:CMS:SignalR:ClientShouldSkipNegotiation` CMS setting is enabled.

### [18.0.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.0.0) (June 5th 2026)

* Compatibility with Umbraco CMS 18.0.0-rc1.
  * See full details of breaking changes under [Version Specific Upgrade Details](upgrades/version-specific.md).
* Add support for transferring, restoring, importing, and exporting elements (publishable, versioned content items in the new Library section).
* Migrate Nested Content (when `MaxItems = 1`) and single-block-mode Block List configurations to the new `Umbraco.SingleBlock` editor at import time.
* Major UI/UX overhaul of the Deploy experience in the backoffice. See [Backoffice UX refresh](#backoffice-ux-refresh) below for details.
* Improved support for running Deploy on load-balanced backoffice instances:
  * Prevent `ARRAffinity` cookie loss on load-balanced targets by disabling `HttpClient` handler rotation, so long-running restores stay routed to the same target instance.
  * Add a cluster-wide Deploy worker lock to prevent concurrent deploys across load-balanced backoffice instances.
  * Process Deploy disk triggers on a single load-balanced server instead of racing on every node.

#### Backoffice UX refresh

Version 18 introduces a redesigned Deploy experience in the backoffice:

* A new sidebar workspace, launched from the environment name header app, replaces the transfer queue dashboard in the Content section. The workspace provides a single overview of the transfer queue, export queue, import, and restore environment operations.
* Redesigned transfer, queue, restore, compare, and export modals with consistent styling, improved error surfacing, and a cleaner status and operation layout.
* Refreshed status, schema, and configuration views in the management dashboard.

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-deploy/release-notes.md) and [Umbraco Deploy Package page](https://our.umbraco.com/packages/developer-tools/umbraco-deploy/).
