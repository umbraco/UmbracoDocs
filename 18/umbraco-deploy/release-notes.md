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

### [18.0.1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.0.1) (July 21st 2026)

* Update public access role rules when a member group is renamed during a deploy.
* Map Deploy endpoints when booting during an unattended upgrade (`RuntimeLevel.Upgrading`).
* Transfer invariant properties when deploying the default culture [#249](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/249).
* Fix restore of trashed content leaving a stale recycle bin path and level [#267](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/267).
* Normalize document culture code casing on import to prevent duplicate culture variation rows [#271](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/271) [#280](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/280)
* Improve condition lifecycle management, fixing the Deploy dashboard occasionally loading blank on init and refresh [#346](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/346)

### [18.0.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.0.0) (June 25th 2026)

* Compatibility with Umbraco CMS 18.0.0.
* Fix `umbracodeploy` trigger route URLs broken by the Umbraco 18 routing migration. POST endpoints under `/umbraco/umbracodeploy/...` now resolve correctly.
* Register Deploy routes and SignalR hubs during the Upgrading runtime level.
* Fix the partial restore progress display and restore the work completion view.
* Fix the partial restore modal not auto-selecting the only available restore environment.
* Disambiguate queue root items by entity type, so each tree's root can be queued independently.
* Gate the **Open Umbraco Cloud project** action to Cloud projects only, and link directly to the project URL.

### [18.0.0-rc3](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.0.0) (June 19th 2026)

* Compatibility with Umbraco CMS 18.0.0-rc3.
* Throw a clear error when the API key or secret is not configured on the environment.

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

## Umbraco.Deploy.Contrib

### [18.0.0](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-18.0.0) (June 25th 2026)

* Compatibility with Umbraco 18.0.0 and Deploy 18.0.0.

### [18.0.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-18.0.0-rc1) (June 24th 2026)

* Compatibility with Umbraco 18.0.0-rc3 and Deploy 18.0.0-rc3.

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-deploy/release-notes.md) and [Umbraco Deploy Package page](https://our.umbraco.com/packages/developer-tools/umbraco-deploy/).
