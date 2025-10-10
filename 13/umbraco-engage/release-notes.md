---
description: Get an overview of the changes and fixes in each version of Umbraco Engage.
---

# Release Notes

In this section, you will find a summary of changes made to Umbraco Engage that were released in each version. Each version has a link to the [Engage issue tracker](https://github.com/umbraco/Umbraco.Engage.Issues/) showing a list of issues resolved in the release. We also link to the individual issues themselves from the details.

If there are any breaking changes or other issues to be aware of when upgrading, they are also noted here.

{% hint style="info" %}
When upgrading to a major version, be sure to look at the breaking changes outlined in the [Version Specific Upgrade Notes](upgrading/version-specific-upgrade-notes.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Engage 13, including all changes for this version.

[**13.6.1**](https://www.nuget.org/packages/Umbraco.Engage/13.6.0) **(October 7th 2025)**

* Added a "Scoring Overview" to the Personalization section, allowing you to export a list of all Content Nodes that have Personas and/or Customer Journey Scores configured.
* Resolved a breaking issue regarding content segments introduced in Umbraco CMS 13.11's VariationContexts.
* Resolved `UmbracoUrlAlias` and other reserved routing property aliases from breaking segmentation.&#x20;
  * A new String Array field has been added to the configuration to allow additional property aliases to be excluded from segmentation. See [configuration.md](developers/settings/configuration.md "mention") for more details.
* Resolved an issue with A/B test baseline conversion rates dropping to 0% when creating a new test, which prevented the A/B test from starting.
* Resolved an issue with the Headless **TrackPageview Server API** where URLs were incorrectly matched to the CMS hostname URL instead of the API body-provided URL.
* Resolved potential Collation Conflict errors during nightly reporting generation.

[**13.6.0**](https://www.nuget.org/packages/Umbraco.Engage/13.6.0) **(August 26th 2025)**

* Added Defer Async support to all the client-side scripts (e.g. umbracoEngage.analytics.js)
* Resolved broken asset links on case-sensitive systems caused by incorrect casing ([Issue #20](https://github.com/umbraco/Umbraco.Engage.Issues/issues/20))
* Improved statistics per domain: subdomains now respect whether `www.` is commonly used or not, and display accordingly.
* Performance improvements for processing custom goal triggers and implicit scorings.

[**13.5.3**](https://www.nuget.org/packages/Umbraco.Engage/13.5.3) **(July 23nd 2025)**

* Resolved Data Generation no longer executing after being interrupted by a restart of the application by adding a generation status healthcheck on startup.
* Resolved issue where segments could not be deleted on an installation with a separated Engage and Umbraco database.
* Resolved issue where Analytics Pageviews would show URLs with 0 pageviews and 0 sessions.
* Resolved issue where Profiles would not show Members associated with the visitor profile.

[13.5.2](https://www.nuget.org/packages/Umbraco.Engage/13.5.2) **(July 7th 2025)**

* Resolves issue where under certain edge cases, visitors without A/B Testing cookie consent were still being assigned to A/B test variants. This caused anonymous visitors to be incorrectly segmented and included in A/B test results.
  * This patch includes an automatic migration that removes any variant assignments for anonymous visitors. However, it does **not** automatically delete associated A/B test data, to avoid long processing times on large datasets.
  * After upgrading, you may optionally run the SQL query below to reset any potentially inaccurate A/B test results. Once executed, the updated data will be reflected in the backoffice within 24 hours.

```sql
DELETE pvabtv
FROM umbracoEngageAnalyticsPageviewAbTestVariant pvabtv
JOIN umbracoEngageAnalyticsPageview pv ON pvabtv.pageviewId = pv.id
JOIN umbracoEngageAnalyticsSession s ON pv.sessionId = s.id
JOIN umbracoEngageAnalyticsVisitor v ON s.visitorId = v.id
WHERE v.externalId = '11111111-1111-1111-1111-111111111111';
```

[**13.5.1**](https://www.nuget.org/packages/Umbraco.Engage/13.5.1) **(June 30th 2025)**

* Resolved Data Generation issue involving duplicate primary keys in the  `umbracoEngageReportingDimCampaign` table.
* Resolved Visitor Segment Settings being created for invalid or unknown visitors.
* Removed legacy `umbracoEngage.analytics.ga-bridge.js` script.

[**13.5.0**](https://www.nuget.org/packages/Umbraco.Engage/13.5.0) **(June 24th 2025)**

* Resolved incorrect Analytics Goals date picker display.
* Resolved incorrect Analytics Locations dropdown with unknown province and/or country.
* Resolved incorrect Analytics data when Group by Day is selected in a narrow timeframe.
* Resolved client-side form submissions causing incorrect profiles to get marked as Identified. Now requires \`Engage.Forms\` add-on.
* Resolved outbound clicks not showing up on the Cockpit as being tracked.
* Restructured Reporting data generation tasks to prevent database modification schema locking.
* Added database preparations for future deploy support.
* Added automatic cockpit injection to the frontend.
  * Can be disabled by setting ‘Engage:Cockpit:EnableInjection’ configuration to false.

#### [13.4.0](https://www.nuget.org/packages/Umbraco.Engage/13.4.0) (March 31st 2025)

* Optimized the Profile Overview & Export performance by using reporting instead of real-time data.
* Added the ‘Visited page(s)’ segment parameter to allow segmentation based on a visitor's activity history.
* Added the ability to set Implicit Scoring on Goals.
* Set the default goal type to ‘Macro’ when creating a new goal.
* Updated the Analytics Locations to allow a drill-down into State/Province and County.
* Updated the GA4 Bridging Script to bridge the following GA4 events too:
  * file\_download
  * form\_start
  * form\_submit
  * view\_search\_results
* Optimized the report generation performance for A/B testing performance.
* Optimized various client-side scripts performance & compatibility.

#### [13.3.1](https://www.nuget.org/packages/Umbraco.Engage/13.3.1) (March 10th 2025)

* Bumped Umbraco.Licenses version to resolve an issue with keys in environment variables.

#### [**13.3.0**](https://www.nuget.org/packages/Umbraco.Engage/13.3.0) **(February 21st 2025)**

* Added the ability to [set a CSP Nonce](getting-started/for-developers/content-security-policy-nonce-configuration.md) to all scripts injected by Engage.
* Resolved various bugs & issues:
  * Resolved chunked cookie handling for the cockpit.
  * Resolved an issue when choosing a 100% control group size for A/B Tests.
  * Resolved the styling of the A/B Test performance table.
  * Resolved an error when generating reporting tables involving Sessions.
  * Resolved the redirection of Split URL Tests without cookie consent.
  * Resolved the parsing of request Headers on a RawPageview object.

#### [**13.2.0**](https://www.nuget.org/packages/Umbraco.Engage/13.2.0) **(January 21st 2025)**

* Added Razor Class Library support for Engage, removing physical backoffice, views, and assets files from development projects.
* Resolved the issue where accessing the backoffice through domains with "www." would display as invalid on the start dashboard.
* Resolved the issue where logging into Umbraco Cloud through an Identity Provider would reset the Engage analytics cookie.
* Resolved the issue that would display incorrect goal performances in A/B Tests.
* Improved error indication in case Engage fails to install.

#### [**13.1.0**](https://www.nuget.org/packages/Umbraco.Engage/13.1.0) **(December 9th 2024)**

* Introduced the Last Attribution Model when assigning pageviews to campaigns.
* Optimized A/B Testing Dashboard performance by making use of reporting instead of real-time data.
* Resolved the issue where Customer Journey Step Scores were incorrectly assigned.
* Added validation for triggering custom goals on supported pageviews.

#### [**13.0.0**](https://www.nuget.org/packages/Umbraco.Engage/13.0.0) **(November 7th 2024)**

* Rebranded uMarketingSuite to Umbraco Engage.
* Upgraded all dependencies to the latest versions.
