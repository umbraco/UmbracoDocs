---
description: Get an overview of the changes and fixes in each version of Umbraco Engage.
---

# Release Notes

This section summarizes the changes and fixes introduced in each version of Umbraco Engage. Each release includes a link to the [Engage issue tracker](https://github.com/umbraco/Umbraco.Engage.Issues/), where you can find a list of resolved issues. Individual issues are also linked for more details.

If there are any breaking changes or other issues to be aware of when upgrading, they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, check the breaking changes in the [Version Specific Upgrade Notes](upgrading/version-specific-upgrade-notes.md) article.
{% endhint %}

## Release History

Below are the release notes for Umbraco Engage 16, detailing all changes in this version.

#### [16.1.2](https://www.nuget.org/packages/Umbraco.Engage/16.1.2) (January 8th 2026)

* Resolved an issue where the YouTube IFrame Player was being overridden when already initialized on the page. The analytics script now reuses an existing YT Player instance instead of creating a new one, preventing conflicts with sites that have their own YouTube player initialization.
* Resolved Swagger schema generation issues when used in combination with the Umbraco.DeliveryApiExtensions addon.
* Resolved cookie retention when using the headless `/trackpageview/server` endpoint ([Issue #42](https://github.com/umbraco/Umbraco.Engage.Issues/issues/42)).

#### [Engage Forms 16.2.0](https://www.nuget.org/packages/Umbraco.Engage.Forms/16.2.0) (January 8th 2026)

* Resolved Form Submission Goal Type migration when migrating from version 13.x.

#### [16.1.1](https://www.nuget.org/packages/Umbraco.Engage/16.1.1) (December 16th 2025)

* Implements additional validation checks before assigning the visitor cookie, improving cookie handling reliability across various request scenarios.
* Resolved an issue where headless API responses returned absolute URLs instead of relative paths for URL paths.
* Resolved various bugs regarding A/B Test UI, including the editing and previewing of segments.
* Resolved multiple issues with reporting tabs, including segment personalization, goal performance, and segment potential displays.
* Resolved heatmap display issues by ensuring the default culture is used for invariant documents, with minor style improvements.
* Resolved `ProducesResponseType` attributes using the incorrect `StatusCodeResult` type.

#### [16.1.0](https://www.nuget.org/packages/Umbraco.Engage/16.1.0) (November 7th 2025)

* Bumped the minimal CMS requirement to Umbraco version 16.2.0 due to compatibility changes.
* Resolved **Split URL tests** and **Single Page tests** not configuring properly.
* Resolved Analytics 'New and returning visitors' issues showing inaccurate statistics.
* Redesigned the **Personalization scoring overview** interface and improved CSV export.
* Improved bot detection by updating `DeviceDectector.NET` to version 6.4.7.
* Resolved various other bugs, issues, and UI tweaks for improved stability and user experience.

#### [16.0.1](https://www.nuget.org/packages/Umbraco.Engage/16.0.1) (October 3rd 2025)

* Resolved 404 errors occurring after creating new segments.
* Added multiple UI/UX improvements.
* Resolved other smaller miscellaneous bugs and issues.

#### [16.0.0](https://www.nuget.org/packages/Umbraco.Engage/16.0.0) (September 24th 2025)

The major release of Engage V16 is finally here. With all of its features enabled, including support for the Umbraco Forms & Commerce addons. This release introduces additional UI/UX improvements and bug fixes compared to the previous release candidate.

#### [16.0.0-rc2](https://www.nuget.org/packages/Umbraco.Engage/16.0.0-rc2) (August 26th 2025)

This release candidate continues the developments introduced in release candidate #1 and adds back the missing Personalization, A/B Testing, and Reporting features. It also includes various refinements and performance improvements for a smoother overall experience in preparation for the full release.

#### [16.0.0-rc1](https://www.nuget.org/packages/Umbraco.Engage/16.0.0-rc1) (July 29nd 2025)

This Analytics-only version has been fully rebuilt to run on the new Web Component-based Umbraco backoffice. With all dependencies upgraded to the latest versions, this upgrade has led to a more future-proof product than ever before. The Personalization, A/B Testing, and Reporting features are not yet available in this initial release candidate but will follow after a bit more polishing.

To find out more about the specific upgrade notes and breaking changes, visit the [version-specific-upgrade-notes.md](upgrading/version-specific-upgrade-notes.md "mention") article.
