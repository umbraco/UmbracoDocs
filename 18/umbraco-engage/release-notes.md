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

Below are the release notes for Umbraco Engage 18, detailing all changes in this version.

#### [18.0.0](https://www.nuget.org/packages/Umbraco.Engage/18.0.0) (June 25th 2026)

Umbraco Engage 18 adds support for Umbraco CMS 18.

* Added support for Umbraco CMS 18.
* The database schema alignment introduced in 17.2.0 is now **enforced** when upgrading. If the alignment was not completed on your installation, the upgrade to Engage 18 is blocked at startup. A clear error explains how to complete the alignment before retrying. Fresh installs are unaffected.

See [version-specific-upgrade-notes.md](upgrading/version-specific-upgrade-notes.md "mention") for breaking changes and the required upgrade steps.
