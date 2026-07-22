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

### [17.2.1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.2.1) (July 21st 2026)

* Update public access role rules when a member group is renamed during a deploy.
* Map Deploy endpoints when booting during an unattended upgrade (`RuntimeLevel.Upgrading`).
* Transfer invariant properties when deploying the default culture [#249](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/249).
* Fix restore of trashed content leaving a stale recycle bin path and level [#267](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/267).
* Normalize document culture code casing on import to prevent duplicate culture variation rows [#271](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/271) [#280](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/280)
* Improve condition lifecycle management, fixing the Deploy dashboard occasionally loading blank on init and refresh [#346](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/346)

### [17.2.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.2.0) (June 25th 2026)

* All items from 17.2.0-rc1 and 17.2.0-rc2.

### [17.2.0-rc2](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.2.0-rc2) (June 19th 2026)

* Support the `Umbraco:CMS:SignalR:ClientShouldSkipNegotiation` setting introduced in Umbraco CMS 17.5. Older CMS 17 versions continue to use the negotiate round-trip as before.
* Throw a clear error when the API key or secret is not configured on the environment.

### [17.2.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.2.0-rc1) (June 4th 2026)

* Prevent `ARRAffinity` cookie loss on load-balanced targets by disabling `HttpClient` handler rotation. Long-running transfers and restores now stay routed to the same target instance.
* Add a cluster-wide Deploy worker lock to prevent concurrent deploys across load-balanced backoffice instances.
* Process Deploy disk triggers on a single load-balanced server instead of racing on every node.

### [17.1.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.1.0) (May 14th 2026)

* All items from 17.1.0-rc1 and 17.1.0-rc2.

### [17.1.0-rc2](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.1.0-rc2) (May 11th 2026)

* Refresh entity signs after a transfer completes and the queue is cleared.
* Update the `@umbraco-deploy/backoffice` NPM package: prefix non-generated exported types with `Deploy`, add missing types, and fix `UmbExtensionConditionConfigMap` augmentations.

### [17.1.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.1.0-rc1) (May 6th 2026)

* Add `@umbraco-deploy/backoffice` NPM package (see below for details).
* Add entity signs for queued entities.
* Add environment name header app, showing the current environment with its icon and a badge with the number of items in the transfer queue.
* Add support for user group descriptions (introduced in Umbraco CMS 17.2).
* Allow exporting all supported entity tree roots, including a fix for members. You can now transfer/restore/export all members when `AllowMembersDeploymentOperations` is not set to `None`.
* Ensure compatibility with Umbraco CMS 17.4, which makes `IHostingEnvironment.ApplicationMainUrl` nullable at runtime ([umbraco/Umbraco-CMS#22307](https://github.com/umbraco/Umbraco-CMS/pull/22307)). Deploy now falls back to the current request's origin when the application URL is not configured.

#### `@umbraco-deploy/backoffice` NPM package

The new [`@umbraco-deploy/backoffice`](https://www.npmjs.com/package/@umbraco-deploy/backoffice) NPM package publishes Deploy's TypeScript type definitions so external packages can consume Deploy's extension points. The package exports extension manifest types (such as `ManifestDeployEntityActionRegistrar` and `ManifestDeployEntityTypeMapping`), entity action base classes, context tokens, conditions, and the referenced API and entity models.

Add the package as a development dependency in your custom backoffice extension to get accurate type information when integrating with Deploy.

### [17.0.2](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.0.2) (March 5th 2026)

* Set create date on new documents/media/members [#259](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/259)
* Request children/structure reload and entity update after import or restore [#286](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/286)
* Fix `InvalidOperationException` when getting value from `JsonValue` [#324](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/324)
* Ensure all blocks are exposed during migration [#325](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/325)
* Maintain reverse UDI order when cleaning entities [#327](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/327)

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
