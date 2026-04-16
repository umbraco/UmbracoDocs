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

#### [17.2.0-rc1](https://www.nuget.org/packages/Umbraco.Engage/17.2.0-rc1) (April 2nd 2026)

* Rewritten analytics data cleanup with improved scheduling and performance:
  * Cleanup now processes all eligible records without a batch size limit (the `NumberOfRows` setting is no longer used).
  * New configuration settings: `Enabled`, `FirstRunTime` (crontab), `StartupDelay`, `Interval`, `CommandTimeout` — replacing deprecated `StartAfterSeconds`, `IntervalInSeconds`, `NumberOfRows`. See [configuration](developers/settings/configuration.md) for details.
  * Configurable first-run scheduling via crontab expression (`"0 2 * * *"` for 2 AM daily).
* Database schema alignment bringing existing installations in line with clean installs:
  * Adds missing foreign keys with `ON DELETE CASCADE`, indexes, and constraints.
  * Requires running the `EnsureDataConsistency.sql` script first to clean up any orphaned data, followed by the `CompleteAlignSchema.sql` script to add the constraints. Both scripts should be run during a maintenance window after upgrading (see below).
  * **Important**: Until the script is executed, only anonymization and visitor control group/raw data cleanup will run. Full analytics data cleanup (pageviews, sessions, visitors) requires the schema alignment to be completed.
  * Helper script included: `GetDeleteAnalyticsDataAfterDays.sql` (recommends safe initial configuration, see below).
* Added 'Database Schema Status' and 'Constraint Integrity' health checks to monitor upgrade completion.
* Aligned `culture` column length with Umbraco CMS.
* Fixed `Anonymize IP Address` setting not showing in the UI.
* Clean-up of orphaned page variants and bot visitor data.
* Fixed duplicate page variant rows being created per pageview instead of reusing existing data. A `DeduplicatePageVariants.sql` helper script is included to consolidate duplicates on existing installations (see below).
* Added wildcard domain support for licensing.
* Improved goal deserialization handling with caching and graceful error recovery.
* Security fix: server-side enforcement of `createdBy` on annotations and other entities — client-provided values are no longer trusted.
* Page variant segment nullability fixes.
* New `DeliveryApi.DisableVisitorCookie` configuration (default: `false`) — when `true`, suppresses the visitor cookie on headless API requests, requiring clients to use the `External-Visitor-Id` header instead. See [configuration](developers/settings/configuration.md) for details.
* Optimized annotation fetching using EntityService for improved performance.
* Fixed partial UTM (Urchin Tracking Module) data missing from Analytics Campaigns view.
* Fixed campaign group key management.
* Added a data cleanup log viewer in the backoffice, providing insight into cleanup job history, per-table statistics, and startpage data retention status.
* Added support for soft-deleting segments with automatic background cleanup. Deleted segments are now gracefully removed from the system without affecting historical analytics data. An `IsDeleted` column has been added to the segments table — any direct SQL queries against segment tables must filter on this column to exclude soft-deleted records.
* Added a Suspicious Activity overview in the backoffice, allowing you to identify and review visitors with unusual pageview patterns. Includes configurable pageview thresholds and the ability to provide feedback on flagged activity.
* Enforced UTC date handling across the entire codebase, preventing timezone-related issues in analytics, A/B testing, and reporting.
* Fixed analytics POST requests being broken by trailing-slash URL rewrite rules.
* Fixed campaign graph not updating correctly when switching between campaigns.
* Replaced the IP Filters system with a new **Traffic Filters** system. Traffic Filters extend filtering beyond IP addresses to include user agent, URL, and custom rule matching with conditions such as Contains, Equals, List, and Regex. IP list filters support CIDR subnet notation. A compiled regex cache with configurable timeout prevents ReDoS attacks. Existing IP filter configurations will need to be migrated to the new Traffic Filter format.
* Renamed the headless Marketing API to **Engage API**. 
* Added `EngageDataCleanupProcessors()` extension method for registering [custom data cleanup processors](developers/analytics/extending-analytics/custom-data-cleanup-processors.md).

See the [Schema Alignment Guide](upgrading/schema-alignment-guide.md) for detailed post-upgrade steps and script downloads.

#### [17.1.0](https://www.nuget.org/packages/Umbraco.Engage/17.1.0) (March 4th 2026)

* Added the ability to explicitly lock persona and customer journey scores for individual visitor profiles. This allows manual overriding of calculated scores, with optional expiration, managed from the profile insights view.
* Added the ability to reorder personas via drag-and-drop in the backoffice.
* Redesigned the reporting star schema by introducing a new `FctSessionNode` fact table, replacing the previous `DimNodeAncestor` table and pre-computed `withSubpages` approach. This reduces star generation time and TempDB usage for large datasets.
* Added the ability to view heatmaps for 'Other' (unknown) device types.
* Added an 'All cultures' option to the Pageview Goal picker, defaulting to all cultures when creating new pageview goals.
* Improved path handling for CM/CD server configurations in the Headless package, ensuring correct content retrieval based on specified culture.
* Refactored cockpit to prevent CSS leaks using custom elements, adopting UUI CSS for fonts, sizes, and colors.
* Refactored and simplified scoring UI elements, reducing network requests and centralizing populator logic.
* Resolved an issue where the `pagehide` event listener was not correctly handling page visibility changes in the analytics tracking script.
* Fixed extraction of the Membership Provider Key, resolving cases where the key was not correctly retrieved from the HTTP context.
* Fixed `HttpContext.Request` corruption in `UrlUmbracoPageVariantExtractor`, ensuring request state is preserved for downstream middleware.
* Resolved multiple UI interaction bugs in the analytics dashboard affecting chart rendering, table prefabs, and A/B testing save-and-publish visibility conditions.
* Fixed incorrect sum calculation by excluding `pageSessionsWithSubpages` from the analytics table aggregation.
* Resolved other smaller bugs and UI fixes.

#### [Engage Forms 17.1.2](https://www.nuget.org/packages/Umbraco.Engage.Forms/17.1.2) (April 2nd 2026)

* Fixed broken migration step regarding Goals table name misalignment.
* Fixed broken swagger documentation generation.

#### [Engage Forms 17.1.1](https://www.nuget.org/packages/Umbraco.Engage.Forms/17.1.1) (February 19th 2026)

* Fixed a security issue ([GHSA-86vq-ccwf-rm62](https://github.com/umbraco/Umbraco.Engage.Issues/security/advisories/GHSA-86vq-ccwf-rm62)).

#### [17.0.4](https://www.nuget.org/packages/Umbraco.Engage/17.0.4) (January 8th 2026)

* Resolved an issue where the YouTube IFrame Player was being overridden when already initialized on the page. The analytics script now reuses an existing YT Player instance instead of creating a new one, preventing conflicts with sites that have their own YouTube player initialization.
* Resolved Swagger schema generation issues when used in combination with the Umbraco.DeliveryApiExtensions addon.
* Resolved cookie retention when using the headless `/trackpageview/server` endpoint ([Issue #42](https://github.com/umbraco/Umbraco.Engage.Issues/issues/42)).
* Resolved broken Pageview Goals migration when updating from Engage 13.x to 17.x ([Issue #43](https://github.com/umbraco/Umbraco.Engage.Issues/issues/43)).

#### [Engage Forms 17.1.0](https://www.nuget.org/packages/Umbraco.Engage.Forms/17.1.0) (January 8th 2026)

* Resolved Form Submission Goal Type migration when migrating from version 13.x.

#### [17.0.3](https://www.nuget.org/packages/Umbraco.Engage/17.0.3) (December 16th 2025)

* Implements additional validation checks before assigning the visitor cookie, improving cookie handling reliability across different request scenarios.
* Resolved an issue where headless API responses returned absolute URLs instead of relative paths for URL paths.
* Resolved multiple bugs regarding A/B Test UI, including the editing and previewing of segments and validation around enabled segmentation on content.
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

This release includes many automatic migrations and changes to the database structure. See [version-specific-upgrade-notes.md](upgrading/version-specific-upgrade-notes.md "mention") for more information.
