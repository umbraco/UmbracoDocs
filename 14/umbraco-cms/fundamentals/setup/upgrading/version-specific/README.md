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
* [package-manifest is now umbraco.package.json](../../../../extending-backoffice/package-manifest.md)
* [Smidge has been removed from default installation](https://github.com/umbraco/Umbraco-CMS/pull/15788) along with RuntimeMinification setting. Smidge can be manually installed if needed and you can read the [Smidge](https://github.com/Shazwazza/Smidge) documentation on how to setup a similar setting to [RuntimeMinification](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-cms/reference/configuration/runtimeminificationsettings.md).
* New login screen
* **Light, Dark or Contract Mode** option has been added in the backoffice. You can choose your preffered mode from your profile information.
* [UI Library and UI API](broken-reference) external documentations.

**In-depth and further breaking changes for v14 can be found on the** [**CMS Github**](https://github.com/umbraco/Umbraco-CMS/pulls?q=is%3Apr+base%3Av14%2Fdev+label%3Acategory%2Fbreaking) **repository.**

</details>

<details>

<summary>Umbraco 14 RC Versions</summary>

Below you can find the list of breaking changes introduced in Umbraco 14 RC release versions.

[RC 1](https://github.com/umbraco/Umbraco.CMS.Backoffice/releases/tag/v14.0.0-rc1)\
First RC release - 17th of April.

**Breaking changes from beta 3:**

* [#1411](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1411) - Bugfix: Move To Entity Action (Part 1)&#x20;
* [#1568](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1568) - Feature/Content Editor Kind + Work for validation (take 3)&#x20;
* [#1591](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1591) - Bugfix: Duplicate to Entity Action (part 1)

#### New Features:

* [#1593](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1593) - Media Entity Picker property-editor UI&#x20;
* [#1598](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1598) - Hide entity actions when Tree used inside a Modal
* [#1611](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1611) - Media Tree Item
* [#1605](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1605) - Document Type Create Actions
* [#1638](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1638) - Umbraco version number (header logo modal)

</details>

<details>

<summary>Umbraco 14 Beta Versions</summary>

Below you can find the list of breaking changes introduced in Umbraco 14 Beta release versions.

[**Beta 3**](https://github.com/umbraco/Umbraco.CMS.Backoffice/releases/tag/v14.0.0-beta003)

Management API Breaking Changes:

* [#16027](https://github.com/umbraco/Umbraco-CMS/pull/16027) - Remove manifest validators&#x20;
* [#16026](https://github.com/umbraco/Umbraco-CMS/pull/16026) - Remove remnants of the Angular implementation
* [#16024](https://github.com/umbraco/Umbraco-CMS/pull/16024) - Remove "additional data" from entities
* [#15946](https://github.com/umbraco/Umbraco-CMS/pull/15946) - Document version endpoints with async service
* [#15923](https://github.com/umbraco/Umbraco-CMS/pull/15923) - Convert Tourdata into a more generic concept

Bellissima (Client) Breaking Changes:

* &#x20;[#1455](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1455) - Workspace routable kind
* [#1475](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1475) - Feature: Entity Workspace Context Token and Interface + preparation for Validation&#x20;
* [#1488](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1488) - Rename Settings Menu
* [#1429](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1429) - Feature: Workspace breadcrumbs
* [#1474](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1474) - Bugfix: Relation types
* &#x20;[#1502](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1502) - Feature/tracked references server update&#x20;
* [#1500](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1500) - Breaking: Rename save() to submit() for workspace contexts (Validation part 2)&#x20;
* [#1521](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1521) - Breaking: rename Umbraco controller methods&#x20;
* [#1391](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1391) - Bugfix: Rename file system file
* [#1524](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1524) - Remove exports from packages/core/index.ts
* [#1565](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1565) - Feature: Replace openapi-typescript-codegen with @hey-api/openapi-ts
* [#1569](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1569) - Feature: Rename Resource class suffix to Service&#x20;
* &#x20;[#1584](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1584) - UI Library 1.8.0-rc.1

[**Beta 2**](https://github.com/umbraco/Umbraco.CMS.Backoffice/releases/tag/v14.0.0-beta002)

There are a few breaking changes since **Beta 1**. Most of the changes concern property editors and getting them to work with migrations as well as new values.

* [#1408](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1408) - Refactor: Workspace Collection Condition (plus new Context token)
* [#1423](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1423) - Feature/individual publication modals
* [#1439](https://github.com/umbraco/Umbraco.CMS.Backoffice/pull/1439) - rename selectedIds + Corrections for Lit warnings

Management API Breaking Changes

* [#15892](https://github.com/umbraco/Umbraco-CMS/pull/15892) - Revoke previous sessions when AllowConcurrentLogins is false
* [#15890](https://github.com/umbraco/Umbraco-CMS/pull/15890) - Extend IContentEntitySlim
* [#15891](https://github.com/umbraco/Umbraco-CMS/pull/15891) - Remove Keep Alive Job
* [#15887](https://github.com/umbraco/Umbraco-CMS/pull/15887) - Workaround for failing entity tree children
* [#15862](https://github.com/umbraco/Umbraco-CMS/pull/15862) - Removed “type” from tree item response models
* [#15856](https://github.com/umbraco/Umbraco-CMS/pull/15856) - Remove duplicate pagination helper

[**Beta 1**](https://github.com/umbraco/Umbraco.CMS.Backoffice/releases/tag/v14.0.0-beta001)\
Official release of Beta, 6th March 2023.

**In-depth previous, further and other changes for v14 beta versions can be found on the Release Notes on the** [**Umbraco.CMS.Backoffice**](https://github.com/umbraco/Umbraco.CMS.Backoffice/releases) **repository.**

</details>
