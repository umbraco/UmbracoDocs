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

Below are the release notes for Umbraco Engage 19, detailing all changes in this version.

#### [19.0.0-rc2](https://www.nuget.org/packages/Umbraco.Engage/19.0.0-rc2) (November 25th 2026)

This release candidate adds breaking changes that were not in 19.0.0-rc1. See [version-specific-upgrade-notes.md](upgrading/version-specific-upgrade-notes.md "mention") before you upgrade.

**A/B testing and personalization**

* Pages whose segmented properties exist only inside blocks can now be personalized and A/B tested. Block List, Block Grid, Rich Text, and Single Block properties are supported at any depth.
* Legacy segment names are removed. A migration renames `umarketingsuite_ab-testing_<id>` and `umarketingsuite_personalization_<id>` segments to `engage_ab-testing_<id>` and `engage_personalization_<id>`. The `UseLegacySegmentNames` setting is removed.
* An A/B test variant without a name now blocks the save. The **Edit**, **CSS/JS**, and **Preview** buttons are disabled until the variant has a name.
* Completing an A/B test now refreshes the advice block, the test list, and the document.
* Fixed personalization scores expiring at the wrong time for groups that expire by session. Groups set to never expire no longer drop their scores. A migration corrects the session number of existing scores.
* Fixed personalized pages failing until a restart after a single failed cache load.
* Fixed the Engage document tabs not opening after split view is closed.
* Fixed the Cockpit being injected twice when the Cockpit partial is already in the layout.

**Analytics and reporting**

* The **Segment insights** view in the Personalization insights now reads from reporting data. Deleted segments are no longer listed.
* A reporting analytics query that the data cannot answer now returns a `400` response instead of a `500` response.
* `RequireAnalyticsPermissionForMemberTracking` now defaults to `true`.
* Engage now inserts injected content, such as the analytics script and the Cockpit, directly into the response. Only `text/html` responses are modified.
* Fixed the analytics script failing to start on pages with a form whose first input is wrapped in another element.
* Fixed memory growing with every visitor. A/B test assignments that can never be stored are now dropped, and idle visitors are removed from the in-memory caches.
* Fixed pageview pings for unknown pageviews staying in memory.
* Fixed the goal value rendering on the Engage section dashboard. The dashboard period now defaults to the last 30 days.

**Permissions and licensing**

* The Cockpit no longer receives data for features that the license does not include. A/B test variant details also require the `Engage.AbTesting.Read` verb.
* The reporting status on the Engage section dashboard and the data generation logs are now available with the `Engage.Reporting.Read` verb.
* Added `ILicensedFeatureService.IsFeatureLicensed`, so other packages can check whether a license feature is available.

#### [19.0.0-rc1](https://www.nuget.org/packages/Umbraco.Engage/19.0.0-rc1) (November 17th 2026)

Umbraco Engage 19 adds support for Umbraco CMS 19 and .NET 11.

See [version-specific-upgrade-notes.md](upgrading/version-specific-upgrade-notes.md "mention") for breaking changes.

**Backoffice UI**

* The Engage section now uses a sidebar menu instead of tabs, with three groups: **Insights**, **Optimization**, and **Configuration**. Each area opens as a workspace from the sidebar.
* **Goals**, **Block traffic**, and **Suspicious Activity** are now top-level items in the **Configuration** group.
* Persona and Customer Journey groups are now collections with a table view and a routed workspace (General, Advanced, and Info).
* The **Open cockpit** button is now at the top of the Engage sidebar.
* The Start page is now the Engage section dashboard. It shows an overview with a period picker, a status block with license, reporting data and regeneration information, and a get-started checklist.
* The Analytics section, the Reporting charts and goal table, and the Profiles growth chart now use the Umbraco Analytics UI components.
* The Engage Cockpit has been rewritten with Lit and no longer uses Vue.

**A/B testing and personalization**

* Engage segments are now added to the document workspace by an Engage front-end segment provider. The CMS `GET /segment` endpoint no longer returns Engage segments.
* Previewing a personalization or an A/B test variant now shows the variant without a visitor cookie. Previously, the editor saw the default content unless the browser already had the Engage visitor cookie. Preview no longer creates a visitor cookie or profile.
* Fixed the **Save** and **Submit** buttons not being enabled in the "Create personalized variant" dialog.
* Added the `cockpitSegmentRuleProvider` extension type, so third-party packages can register their own segment rules. The Cockpit reads the registered segment rule manifests instead of a fixed list.

**Analytics and reporting**

* Nightly reporting data generation is now spread across a time window. `DataGenerationTime` now defaults to empty. When it is empty, the processing server picks a random time between 01:00 and 05:00 in the reporting time zone. The server keeps that time across restarts.
* An explicit `DataGenerationTime` is now scheduled in the reporting time zone instead of the server time zone. The Reporting settings panel shows the resolved time, marked "(automatic)" when it was chosen automatically.
* After a restart, a missed automatic run for the current night runs once if it is still before 06:00 in the reporting time zone.
* Average columns in Analytics tables no longer show a total.
* Video playtime averages are now weighted by the number of plays.

**Permissions**

* Access to the Engage backoffice API is now granted through Umbraco user group permission verbs, such as `Engage.Analytics.Read` and `Engage.AbTesting.Write`. A migration moves existing per-group settings to the new verbs.
* The Engage Cockpit now follows the user's access to the Engage section and the Read verbs of their user groups.
