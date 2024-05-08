---
description: >-
  This document covers specific upgrade steps if a version requires them. Most
  versions do not require specific upgrade steps and you will be able to upgrade
  directly from your current version.
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

<summary>Umbraco 14</summary>

Below you can find the list of breaking changes introduced in Umbraco 14 CMS.

* [Angular removed: A new backoffice built with Web Components, Lit, and fueled by the Umbraco UI Library](https://github.com/umbraco/Umbraco.CMS.Backoffice)
* Icons in the new backoffice are based on [Lucide](https://lucide.dev/icons/).
* [Full TypeScript support for the Backoffice and all its APIs through a public npm package](https://www.myget.org/feed/umbracoprereleases/package/npm/@umbraco-cms/backoffice)
* A [management API documentation](../../../../reference/management-api/) in Swagger - replacement for Controllers that were not restful
* [Migration from Newtonsoft.Json to the System.Text.Json which removes Nested Content and Grid value converter and so on](https://github.com/umbraco/Umbraco-CMS/pull/15728)
* Nested Content and Grid Layout have been removed
* [Legacy media picker has been removed](https://github.com/umbraco/Umbraco-CMS/pull/15835)
* [Macros and Partial View Macros have been removed](https://github.com/umbraco/Announcements/issues/14). Use partial views and/or blocks in the Rich Text Editor.
* XPath has been removed. An alternative is using the Dynamic Roots in the Multinode Treepicker and for ContentXPath the alternative is [IContentLastChanceFinder](../../../../tutorials/custom-error-page.md).
* [package-manifest is now umbraco.package.json](../../../../extending-backoffice/development-flow/package-manifest.md)
* [Smidge has been removed from default installation](https://github.com/umbraco/Umbraco-CMS/pull/15788) along with RuntimeMinification setting. Smidge can be manually installed if needed and you can read the [Smidge](https://github.com/Shazwazza/Smidge) documentation on how to setup a similar setting to [RuntimeMinification](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-cms/reference/configuration/runtimeminificationsettings.md).
* `UmbracoApiController` has been removed and replaced with `UmbracoManagementApiControllerBase`
* New login screen with possibility to change it and make it customizable
* **Light, Dark or Contract Mode** option has been added in the backoffice. You can choose your preffered mode from your profile information.
* [UI Library and UI API](broken-reference) external documentations.

**In-depth and further breaking changes for v14 can be found on the** [**CMS Github**](https://github.com/umbraco/Umbraco-CMS/pulls?q=is%3Apr+base%3Av14%2Fdev+label%3Acategory%2Fbreaking) **repository and on** [**Our Website**](https://our.umbraco.com/download/releases/1400)**.**

</details>

<details>

<summary>Umbraco 14 RC Versions</summary>

Below you can find the list of breaking changes introduced in Umbraco 14 RC release versions.

**RC 3**

* [Bellissima (frontend/backoffice) changes ](https://github.com/umbraco/Umbraco.CMS.Backoffice/releases/tag/v14.0.0-rc3)
* [Backend (CMS) changes](https://github.com/umbraco/Umbraco-CMS/releases/tag/release-14.0.0-rc3)

**RC 2**

* [Bellissima (frontend/backoffice) changes ](https://github.com/umbraco/Umbraco.CMS.Backoffice/releases/tag/v14.0.0-rc2)
* [Backend (CMS) changes](https://github.com/umbraco/Umbraco-CMS/releases/tag/release-14.0.0-rc2)

**RC 1**\
First RC release - 17th of April. Breaking changes since Beta 3:

* [Bellissima (frontend/backoffice) changes ](https://github.com/umbraco/Umbraco.CMS.Backoffice/releases/tag/v14.0.0-rc1)
* [Backend (CMS) changes](https://github.com/umbraco/Umbraco-CMS/releases/tag/release-14.0.0-rc1)

</details>

<details>

<summary>Umbraco 14 Beta Versions</summary>

Below you can find the list of breaking changes introduced in Umbraco 14 Beta release versions.

**Beta 3**

* [Bellissima (frontend/backoffice) changes ](https://github.com/umbraco/Umbraco.CMS.Backoffice/releases/tag/v14.0.0-beta003)
* [Backend (CMS) changes](https://github.com/umbraco/Umbraco-CMS/releases/tag/release-14.0.0-beta003)

**Beta 2**

There are a few breaking changes since **Beta 1**. Most of the changes concern property editors and getting them to work with migrations as well as new values.

* [Bellissima (frontend/backoffice) changes](https://github.com/umbraco/Umbraco.CMS.Backoffice/releases/tag/v14.0.0-beta002)&#x20;
* [Backend (CMS) changes](https://github.com/umbraco/Umbraco-CMS/releases/tag/release-14.0.0-beta002)

**Beta 1**\
Official release of Beta, 6th March 2023.

* [Bellissima (frontend/backoffice) changes ](https://github.com/umbraco/Umbraco.CMS.Backoffice/releases/tag/v14.0.0-beta001)
* [Backend (CMS) changes](https://github.com/umbraco/Umbraco-CMS/releases/tag/release-14.0.0-beta001)

</details>
