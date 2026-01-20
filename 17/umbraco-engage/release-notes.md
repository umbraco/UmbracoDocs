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

Below are the release notes for Umbraco Engage 17, detailing all changes in this version.

#### [17.0.3](https://www.nuget.org/packages/Umbraco.Engage/17.0.3) (December 16th 2025)

* Implements additional validation checks before assigning the visitor cookie, improving cookie handling reliability across various request scenarios.
* Resolved an issue where headless API responses returned absolute URLs instead of relative paths for URL paths.
* Resolved various bugs regarding A/B Test UI, including the editing and previewing of segments and validation around enabled segmentation on content.
* Resolved an issue where starting an A/B test did not immediately start the test due to timezone conversion problems.
* Resolved multiple issues with reporting tabs, including segment personalization, goal performance, and segment potential displays.
* Resolved heatmap display issues by ensuring the default culture is used for invariant documents, with minor style improvements.
* Resolved `ProducesResponseType` attributes using the incorrect `StatusCodeResult` type.

#### [17.0.2](https://www.nuget.org/packages/Umbraco.Engage/17.0.2) (December 1st 2025)

* Resolved a broken dependency in the Cockpit, resulting in broken charts and an unresponsive cockpit.

#### [17.0.1](https://www.nuget.org/packages/Umbraco.Engage/17.0.1) (November 27th 2025)

* Resolves a 500 Internal Server Error that occurred when creating or saving a new or existing A/B test.

#### [Engage Forms 17.0.0](https://www.nuget.org/packages/Umbraco.Engage.Forms) (November 27th 2025)

* Adds the ability to store a visitor's unique key instead of the numeric ID when using the **Analytics Visitor ID** Form Field.

#### [17.0.0](https://www.nuget.org/packages/Umbraco.Engage/17.0.0) (November 27th 2025)

The major release of Engage V17 is here, including support for Umbraco Forms and Commerce add-ons. This release also introduces Deploy support for Engage, making it easier to move your setup between environments. You can transfer configuration items such as segments, personas, journey steps, and goals, while analytics data remains safely in each environment.

This release includes many automatic migrations and changes to the database structure. See [version-specific-upgrade-notes.md](upgrading/version-specific-upgrade-notes.md "mention")for more information.
