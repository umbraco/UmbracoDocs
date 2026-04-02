---
description: Version-specific documentation for upgrading to new major versions of Umbraco Engage.
---

# Version Specific Upgrade Notes

This article provides specific upgrade instructions for migrating to major version of Umbraco Engage

{% hint style="info" %}
When upgrading to a new minor or patch version, learn about the changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Breaking changes

### v13.8.0 — Database Schema Alignment

Engage 13.8.0 introduces a database schema alignment that brings existing installations in line with clean installs by adding missing foreign keys (with `ON DELETE CASCADE`), indexes, and constraints. This is a **manual post-upgrade step** that requires running two SQL scripts during a maintenance window.

#### What changed

The analytics data cleanup has been rewritten with new configuration settings. The previous settings `StartAfterSeconds`, `IntervalInSeconds`, and `NumberOfRows` are deprecated and replaced by `Enabled`, `FirstRunTime`, `StartupDelay`, `Interval`, and `CommandTimeout`. See the [configuration](../developers/settings/configuration.md) page for details.

To support the new `ON DELETE CASCADE` foreign keys, the database schema must be aligned. This requires that all existing data satisfies the new constraints — which is not guaranteed on older installations that may have accumulated orphaned records over time.

#### Post-upgrade steps

After upgrading to 13.8.0, follow these steps during a **maintenance window**:

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

#### v13.2.0 (Umbraco Engage) & v13.1.0 (Umbraco Engage Forms)
Introduced Razor Class Library support to serve static files for Engage, removing physical backoffice, views, and assets files from development projects.

While this is not considered a breaking change, it is recommended that such folders be removed from the project to avoid conflicts in the future.

The following folders should be manually removed from your project upon updating Umbraco Engage:

  * `App_Plugins\Umbraco.Engage`
  * `Assets\Umbraco.Engage`
  * `Views\Partials\Umbraco.Engage`

The same changes apply to the Forms add-on `Umbraco.Engage.Forms`.

The following folder should be manually removed from your project upon updating Umbraco Engage Forms:

  * `App_Plugins\Umbraco.Engage.Forms`

Health checks have been added to verify whether these folders are present in your project. If they are, you will receive a warning in the Health Check dashboard.

#### v13.0.0 (Umbraco Engage Launch)

Umbraco Engage contains a number of breaking changes from the previous uMarketingSuite product.

See the [Migrate from uMarketingSuite](migrate-from-umarketingsuite.md) for full details.
