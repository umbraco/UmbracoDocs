---
description: >-
  Version-specific documentation for upgrading to new major versions of Umbraco
  Engage.
---

# Version specific Upgrade Notes

This article provides specific upgrade instructions and breaking changes introduced when migrating from major version 13 of Umbraco Engage to version 16.

{% hint style="info" %}
When upgrading to a new minor or patch version, learn about the changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Breaking changes

### v16.3.0 — Database Schema Alignment

Engage 16.3.0 introduces a database schema alignment that brings existing installations in line with clean installs by adding missing foreign keys (with `ON DELETE CASCADE`), indexes, and constraints. This is a **manual post-upgrade step** that requires running two SQL scripts during a maintenance window.

#### What changed

The analytics data cleanup has been rewritten with new configuration settings. The previous settings `StartAfterSeconds`, `IntervalInSeconds`, and `NumberOfRows` are deprecated and replaced by `Enabled`, `FirstRunTime`, `Delay`, `Period`, and `CommandTimeout`. See the [configuration](../developers/settings/configuration.md) page for details.

To support the new `ON DELETE CASCADE` foreign keys, the database schema must be aligned. This requires that all existing data satisfies the new constraints — which is not guaranteed on older installations that may have accumulated orphaned records over time.

#### Post-upgrade steps

After upgrading to 16.3.0, follow these steps during a **maintenance window**:

{% stepper %}
{% step %}
##### 1. Determine a safe DeleteAnalyticsDataAfterDays value

Run the `GetDeleteAnalyticsDataAfterDays.sql` script against your database. This analyzes your data volume and recommends a safe initial value for the `DeleteAnalyticsDataAfterDays` configuration setting. Update your `appsettings.json` accordingly before proceeding.
{% endstep %}

{% step %}
##### 2. Ensure data consistency

Run the `EnsureDataConsistency.sql` script against your database. This script cleans up orphaned records across all Engage tables by removing or nullifying rows that reference non-existent parent records, and then re-validates all existing foreign key constraints.

This step is **required** before running the schema alignment script — without it, the `CompleteAlignSchema.sql` script will fail if orphaned data violates the new constraints.
{% endstep %}

{% step %}
##### 3. Complete the schema alignment

Run the `CompleteAlignSchema.sql` script against your database. This adds the missing foreign keys, indexes, and constraints that align your schema with a clean install.

{% hint style="warning" %}
The script contains 6 numbered batches separated by `GO` statements. Execute each batch separately and verify it completes successfully before proceeding to the next.
{% endhint %}
{% endstep %}
{% endstepper %}

{% hint style="warning" %}
**Until the schema alignment is completed**, the analytics data cleanup will only perform anonymization and visitor control group/raw data cleanup. Full cleanup of pageviews, sessions, and visitors requires the schema alignment to be complete.
{% endhint %}

All three scripts are available for download from the [release notes](../release-notes.md) page.

#### Health checks

Two new health checks have been added to help monitor the upgrade process:

- **Database Schema Status** — Reports whether the schema alignment has been completed. Also warns if analytics data cleanup is disabled.
- **Constraint Integrity** — Verifies that all foreign key constraints are trusted and valid.

These health checks are accessible from the Umbraco Health Check dashboard.

### v16.0.0 (Umbraco Engage v16 Launch)

With the introduction of Engage version 16, breaking changes have been introduced to accommodate the transitions between multiple major versions of the core CMS.

#### Clientside Analytics

Engage includes different optional scripts that can be included in the front-end, which interact with different API endpoints. Some of these endpoints have changed. If any firewall rules are in place involving the front-end reaching Umbraco APIs, the following paths need to be allowed through:

```
/umbraco/engage/pagedata/collect
/umbraco/engage/pagedata/collect-event
/umbraco/engage/pagedata/ping
```

#### Umbraco Member Detection & Storage

The detection and storage of logged-in Umbraco Members have changed between versions 13 and 16 of Engage. In older v13 versions, any login claim was detected as a valid member. This caused visitors to be marked as 'Identified' and linked to the claim ID. This has changed over minor versions of v13 to only allow for Umbraco Members to prevent other login methods from interfering with Engage.

Engage v16 will strictly enforce the storage of Umbraco Members only, attempting to update any existing pageview data that detects a logged-in member. This migration switches from integer IDs to GUID keys. It validates the GUIDs against existing Umbraco Members and enforces the datatype as a unique identifier.

This **will** result in data loss if non-Umbraco members or no longer existing members were stored in the `MembershipProviderKey` column in the `umbracoEngageAnalyticsPageview` table.

**GUIDs and Numeric IDs**

Starting with version 16, Engage is aligning with the Core CMS by transitioning from numeric IDs to GUIDs. Many internal APIs have been updated to use GUIDs instead of numeric IDs for fetching, updating, and deleting data. This transition is ongoing and will continue in version 17 and beyond, which will also include public-facing APIs.

**Extending the Backoffice**

The Engage backoffice has been rebuilt to run on Umbraco’s new Web component–based backoffice. This opens up new possibilities for extensions, which will be documented over time. However, the previous AngularJS-based extension approach (used in version 13 and earlier) is no longer supported.
