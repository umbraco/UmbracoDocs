---
description: >-
  This document covers specific upgrade steps if a version requires them. Most
  versions do not require specific upgrade steps. In most cases, you will be
  able to upgrade directly from your current versi
---

# Version Specific Upgrades

Use the information below to learn about any potential breaking changes and common pitfalls when upgrading your Umbraco CMS project.

If any specific steps are involved with upgrading to a specific version they will be listed below.

Use the [general upgrade guide](../) to complete the upgrade of your project.

## Breaking changes

<details>

<summary>Umbraco 13</summary>

Below you can find the list of breaking changes introduced in Umbraco 13 Release Candidate. The list will be updated if more breaking changes are introduced the further we get to the final release of Umbraco 13.

* [Use ISO codes instead of language IDs for fallback languages and translations](https://github.com/umbraco/Umbraco-CMS/issues/13751)
* [Breaking changes for the Delivery API](https://github.com/umbraco/Umbraco-CMS/issues/14745)
* [V13: New login screen](https://github.com/umbraco/Umbraco-CMS/issues/14780)
* [Updated NuGet Dependencies](https://github.com/umbraco/Umbraco-CMS/issues/14795)
* [Fix \`JsonNetSerializer\` settings leaking into derived implementations](https://github.com/umbraco/Umbraco-CMS/issues/14814)
* [Add default property value converters for all value types](https://github.com/umbraco/Umbraco-CMS/issues/14869)
* [V13: Add config to limit concurrent logins](https://github.com/umbraco/Umbraco-CMS/issues/14989)
* [Updates and support for re-use of CMS logic in Deploy](https://github.com/umbraco/Umbraco-CMS/issues/14990)
* [Dont explicitly index nested property by default](https://github.com/umbraco/Umbraco-CMS/issues/15028)
* [Blocks in the Rich Text Editor](https://github.com/umbraco/Umbraco-CMS/issues/15029)
* [Fix FurthestAncestorOrSelfDynamicRootQueryStep and FurthestDescendantOrSelfDynamicRootQueryStep](https://github.com/umbraco/Umbraco-CMS/issues/15113)
* [Remove parameter value/return nullability in \`IImageSourceParser\`, \`ILocalLinkParser\` and \`IMacroParser\`](https://github.com/umbraco/Umbraco-CMS/issues/15130)
* [Update PackageMigrationsPlans collection to be Weighted and not Lazy](https://github.com/umbraco/Umbraco-CMS/issues/15138)
* &#x20;[Move IContextCache parameter to base Deploy interfaces and add checksum to artifact dependency](https://github.com/umbraco/Umbraco-CMS/issues/15144)
* [V13: Update IWebHookService to proper casing](https://github.com/umbraco/Umbraco-CMS/issues/15169)
* [V13: Implement webhook as i entity](https://github.com/umbraco/Umbraco-CMS/issues/15267)

</details>
