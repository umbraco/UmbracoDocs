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

### 17.2.0 — Database Schema Alignment

Engage 17.2.0 introduces a database schema alignment that brings existing installations in line with clean installs by adding missing foreign keys (with `ON DELETE CASCADE`), indexes, and constraints. This is a **manual post-upgrade step** that requires running two SQL scripts during a maintenance window.

#### What changed

The analytics data cleanup has been rewritten with new configuration settings. The previous settings `StartAfterSeconds`, `IntervalInSeconds`, and `NumberOfRows` are deprecated and replaced by `Enabled`, `FirstRunTime`, `StartupDelay`, `Interval`, and `CommandTimeout`. See the [configuration](../developers/settings/configuration.md) page for details.

To support the new `ON DELETE CASCADE` foreign keys, the database schema must be aligned. This requires that all existing data satisfies the new constraints — which is not guaranteed on older installations that may have accumulated orphaned records over time.

#### Post-upgrade steps

After upgrading to 17.2.0, follow these steps during a **maintenance window**:

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

### 17.0.0 (Umbraco Engage v17 Launch)

With the introduction of Engage version 17, breaking changes have been introduced to accommodate the transition between multiple major versions of the core CMS.

#### Database Changes

Three database structure changes have been introduced in the transition from Engage v16 to v17. The first is the migration to userKeys instead of userIds. All references to Umbraco users in Engage tables have now been updated to use the unique key of that user instead.

The same applies to all references to Umbraco user groups in Engage tables. They have also been updated to use the unique key of that user group instead.

The last update involves a change to the `[umbracoEngageAbTestingAbTestVariant]` table, which now contains a new column `[redirectNodeKey]` , which contains a NodeKey used for Split URL A/B Tests.

#### Regenerate Reporting Data

After upgrading to Engage v17 from an older major version, you need to manually regenerate the reporting data to ensure Analytics works correctly.

To regenerate the reporting data:

1. Go to the **Settings** section in the Umbraco backoffice.
2. Navigate to **Engage** > **Configuration**.
3. Select the **Reporting** tab.
4. Click the **Regenerate** button.

{% hint style="warning" %}
Until the reporting data is regenerated, Analytics dashboards may show incomplete or missing data.
{% endhint %}

#### Public Services

Engage v17 introduces new overloads of public-facing service methods to allow the use of keys where previously numeric IDs were expected, resolving [issue #23](https://github.com/umbraco/Umbraco.Engage.Issues/issues/23). These overloads have been added to the following services:

* IAbTestingVisitorService
* IGoalService
* IPersonaService
* ICustomerJourneyService

This means that these services work without the use of magic numbers that are environment-dependent, and instead allow for the use of a key that is shared between environments. This also marks the introduction of `Engage.Deploy` for Engage v17 to allow for the transferring of goals, personas, customer journeys, and A/B tests, adding even more use cases to these service changes.

#### Nullability

Engage v17 enables strict nullable reference types across all projects. This may cause compilation warnings/errors if you're extending or implementing Engage interfaces.&#x20;
