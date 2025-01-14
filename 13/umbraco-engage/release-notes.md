---
description: Get an overview of the changes and fixes in each version of Umbraco Engage.
---

# Release Notes

In this section, you will find a summary of changes made to Umbraco Engage that were released in each version. Each version has a link to the [Engage issue tracker](https://github.com/umbraco/Umbraco.Engage.Issues/) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
When upgrading to a major version, be sure to look at the breaking changes outlined in the [Version Specific Upgrade Notes](upgrading/version-specific-upgrade-notes.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Engage 13 including all changes for this version.

#### **[13.2.0](https://www.nuget.org/packages/Umbraco.Engage/13.2.0) (January 21st 2025)**
* Added Razor Class Library support for Engage, removing physical back-office-, views and assets files from development projects.
* Resolved the issue where accessing the back-office through domains with "www." would display as invalid on the start dashboard.
* Resolved the issue where logging into Umbraco Cloud through an Identity Provider would reset the Engage analytics cookie.
* Resolved the issue that would display incorrect goal performances in A/B Tests.
* Improved error indication in case Engage fails to install.

#### **[13.1.0](https://www.nuget.org/packages/Umbraco.Engage/13.1.0) (December 9th 2024)**
* Introduced the Last Attribution Model when assigning pageviews to campaigns.
* Optimized A/B Testing Dashboard performance by making use of reporting instead of real-time data.
* Resolved the issue where Customer Journey Step Scores were incorrectly assigned.
* Added validation for triggering custom goals on supported pageviews.

#### **[13.0.0](https://www.nuget.org/packages/Umbraco.Engage/13.0.0) (November 7th 2024)**
* Rebranded uMarketingSuite to Umbraco Engage.
* Upgraded all dependencies to the latest versions.
