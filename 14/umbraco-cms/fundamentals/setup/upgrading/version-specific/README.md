---
description: >-
  This document covers specific upgrade steps if a version requires them. Most
  versions do not require specific upgrade steps. In most cases, you will be
  able to upgrade directly from your current versi
---

# Version Specific Upgrades

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

## Version Specific Upgrades

Use the information below to learn about any potential breaking changes and common pitfalls when upgrading your Umbraco CMS project.

If any specific steps are involved with upgrading to a specific version they will be listed below.

Use the [general upgrade guide](../) to complete the upgrade of your project.

### Breaking changes

<details>

<summary>Umbraco 14 </summary>

Below you can find the list of breaking changes introduced in Umbraco 14 CMS.

* [Angular removed: A new backoffice built with Web Components, Lit, and fueled by the Umbraco UI Library](https://github.com/umbraco/Umbraco.CMS.Backoffice)
* Icons in the new backoffice are based on [Lucide](https://lucide.dev/icons/).
* [Full TypeScript support for the Backoffice and all its APIs through a public npm package](https://www.myget.org/feed/umbracoprereleases/package/npm/@umbraco-cms/backoffice)
* A management API documentation in Swagger - replacement for Controllers that were not restful
* [Migration from Newtonsoft.Json to the System.Text.Json which removes Nested Content and Grid value converter and so on](https://github.com/umbraco/Umbraco-CMS/pull/15728)
* Nested Content and Grid Layout have been removed
* [Legacy media picker has been removed](https://github.com/umbraco/Umbraco-CMS/pull/15835)
* [Macros have been removed](https://github.com/umbraco/Announcements/issues/14). Use partial views and/or blocks in the RTE.
* [package-manifest is now umbraco.package.json](../../../../extending-backoffice/package-manifest.md)
* [Smidge has been removed from default installation](https://github.com/umbraco/Umbraco-CMS/pull/15788). Can be manually installed if needed.
* New login screen
* **Light, Dark or Contract Mode** option has been added in the backoffice. You can choose your preffered mode from your profile information.

**In-depth and further breaking changes for v14 can be found on the** [**CMS Github**](https://github.com/umbraco/Umbraco-CMS/pulls?q=is%3Apr+base%3Av14%2Fdev+label%3Acategory%2Fbreaking) **repository.**

</details>

<details>

<summary>Umbraco 14 Beta Versions</summary>

Below you can find the list of breaking changes introduced in Umbraco 14 Beta release versions.

**Beta 002**

* Refactor: Workspace Collection Condition (plus new Context token) by [@leekelleher](https://github.com/leekelleher) in [#1408](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1408)
* Feature/individual publication modals by [@iOvergaard](https://github.com/iOvergaard) in [#1423](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1423)
* rename selectedIds + Corrections for Lit warnings by [@nielslyngsoe](https://github.com/nielslyngsoe) in [#1439](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1439)

**In-depth previous, further and other changes for v14 beta versions can be found on the Release Notes on the** [**Umbraco.CMS.Backoffice** ](https://github.com/umbraco/Umbraco.CMS.Backoffice/releases)**repository.**

</details>
