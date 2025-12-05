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

#### [17.0.1](https://www.nuget.org/packages/Umbraco.Engage/17.0.1) (November 27th 2025)

* Resolves a 500 Internal Server Error that occurred when creating or saving a new or existing A/B test.

#### [Engage Forms 17.0.0](https://www.nuget.org/packages/Umbraco.Engage.Forms) (November 27th 2025)

* Adds the ability to store a visitor's unique key instead of the numeric ID when using the **Analytics Visitor ID** Form Field.

#### [17.0.0](https://www.nuget.org/packages/Umbraco.Engage/17.0.0) (November 27th 2025)

The major release of Engage V17 is here, including support for Umbraco Forms and Commerce add-ons. This release also introduces Deploy support for Engage, making it easier to move your setup between environments. You can transfer configuration items such as segments, personas, journey steps, and goals, while analytics data remains safely in each environment.

This release includes many automatic migrations and changes to the database structure. See [version-specific-upgrade-notes.md](upgrading/version-specific-upgrade-notes.md "mention")for more information.
