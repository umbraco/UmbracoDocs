---
description: >-
  This document covers specific upgrade steps if a version requires them. Most
  versions do not require specific upgrade steps. In most cases, you will be
  able to upgrade directly from your current versi
---

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

# Version Specific Upgrades

Use the information below to learn about any potential breaking changes and common pitfalls when upgrading your Umbraco CMS project.

If any specific steps are involved with upgrading to a specific version they will be listed below.

Use the [general upgrade guide](../) to complete the upgrade of your project.

## Breaking changes

<details>

<summary>Umbraco 14</summary>

Below you can find the list of breaking changes introduced in Umbraco 14.

* [Angular removed: A new backoffice built with Web Components, Lit, and fueled by the Umbraco UI Library](https://github.com/umbraco/Umbraco.CMS.Backoffice)
* [Full TypeScript support for the Backoffice and all its APIs through a public npm package](https://www.myget.org/feed/umbracoprereleases/package/npm/@umbraco-cms/backoffice)
* A management API documentation in Swagger - replacement for Controllers that were not restful
* [Migration from Newtonsoft.Json to the System.Text.Json which removes Nested Content and Grid value converter and so on](https://github.com/umbraco/Umbraco-CMS/pull/15728)
* [Legacy media picker has been removed](https://github.com/umbraco/Umbraco-CMS/pull/15835)
* [Macros have been removed](https://github.com/umbraco/Umbraco-CMS/pull/15794)
* package-manifest is now umbraco.package.json
* New login screen

</details>
