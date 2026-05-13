---
description: >-
  Step-by-step guide for completing the database schema alignment introduced in
  Engage 13.8.0, including the rewritten analytics data cleanup system.
---

# Schema Alignment Guide

Engage 13.8.0 introduces a rewritten analytics data cleanup system and a database schema alignment. This guide walks you through the required post-upgrade steps.

## Analytics data cleanup changes

The analytics data cleanup has been fully rewritten. It now processes all eligible records in a single pass rather than working in fixed-size batches.

### New configuration settings

The cleanup schedule is configured under `Engage:Analytics:DataCleanup` in your `appsettings.json`:

{% code title="appsettings.json" %}
```json
{
  "Engage": {
    "Analytics": {
      "DataCleanup": {
        "Enabled": true,
        "FirstRunTime": null,
        "StartupDelay": "00:05:00",
        "Interval": "1.00:00:00",
        "CommandTimeout": 1200
      }
    }
  }
}
```
{% endcode %}

| Setting | Description | Default |
| --- | --- | --- |
| `Enabled` | Whether the data cleanup process runs at all. | `true` |
| `FirstRunTime` | Optional crontab expression to schedule the first cleanup run. When set, the calculated delay must still be at least `StartupDelay`. | `null` |
| `StartupDelay` | Minimum time after application startup before the first cleanup run. Used directly as the delay when `FirstRunTime` is not set. | `00:05:00` (5 minutes) |
| `Interval` | Interval between cleanup runs. | `1.00:00:00` (24 hours) |
| `CommandTimeout` | Database command timeout in seconds. | `1200` (20 minutes) |

{% hint style="info" %}
The previous settings `StartAfterSeconds`, `IntervalInSeconds`, and `NumberOfRows` are deprecated and should no longer be used.
{% endhint %}

### How the cleanup pipeline works

The cleanup runs as a background job on a recurring schedule. Each run executes three phases in order:

1. **Anonymize** — Replaces personally identifiable information with anonymized values for data that has exceeded the `AnonymizeAnalyticsDataAfterDays` retention period.
2. **Delete analytics data** — Deletes pageviews, control group data, and raw data that has exceeded its respective retention period (`DeleteAnalyticsDataAfterDays`, `DeleteControlGroupDataAfterDays`, `DeleteRawDataAfterDays`).
3. **Delete orphaned data** — Removes records no longer referenced by any analytics data, such as sessions, visitors, and devices without pageviews.

{% hint style="warning" %}
Until the schema alignment below is completed, only the anonymization and visitor control group/raw data cleanup phases will run. Full cleanup of pageviews, sessions, and visitors requires the schema alignment to be complete.
{% endhint %}

## Database schema alignment

The schema alignment brings existing installations in line with a clean install by adding missing foreign keys (with `ON DELETE CASCADE`), indexes, and constraints. This is a **manual post-upgrade step** that requires running SQL scripts during a maintenance window.

### Why this is needed

Older installations may have accumulated orphaned records over time. The new foreign key constraints with `ON DELETE CASCADE` require that all existing data satisfies these relationships. Running the scripts ensures your database is consistent before the constraints are added.

### Post-upgrade steps

After upgrading to 13.8.0, follow these steps during a **maintenance window**:

{% stepper %}
{% step %}
#### 1. Determine a safe DeleteAnalyticsDataAfterDays value

Run the `GetDeleteAnalyticsDataAfterDays.sql` script against your database. This analyzes your data volume and recommends a safe initial value for the `DeleteAnalyticsDataAfterDays` setting.

Update your `appsettings.json` with the recommended value before proceeding. This ensures the first cleanup run does not attempt to delete an excessive number of records at once.

{% hint style="info" %}
This step is optional but recommended. It prevents the first cleanup run from processing a large backlog of data, which could cause long-running queries and lock contention.
{% endhint %}
{% endstep %}

{% step %}
#### 2. Ensure data consistency

Run the `EnsureDataConsistency.sql` script against your database. This script cleans up orphaned records across all Engage tables. It removes or nullifies rows that reference non-existent parent records, and then re-validates all existing foreign key constraints.

This step is **required** before running the schema alignment script. Without it, the `CompleteAlignSchema.sql` script will fail if orphaned data violates the new constraints.
{% endstep %}

{% step %}
#### 3. Complete the schema alignment

Run the `CompleteAlignSchema.sql` script against your database. This re-creates all foreign keys with `ON DELETE CASCADE` and re-enables any disabled or untrusted constraints. It also adds any missing indexes to align your schema with a clean install.

{% hint style="warning" %}
The script contains 6 numbered batches separated by `GO` statements (besides validation and completion steps). Ensure each batch has completed successfully by inspecting the returned/printed messages.
{% endhint %}
{% endstep %}
{% endstepper %}

### Monitoring

Two new Engage health checks are available in the Umbraco Health Check dashboard:

* **Database Schema Status** — Verifies the `Umbraco.Engage+DatabaseSchemaStatus` key is set to `Complete`.
* **Constraint Integrity** — Validates that all expected foreign keys and indexes are present.

### Downloading the scripts

{% file src="../scripts/GetDeleteAnalyticsDataAfterDays.sql" %}
Recommends a safe initial `DeleteAnalyticsDataAfterDays` value based on your data.
{% endfile %}

{% file src="../scripts/EnsureDataConsistency.sql" %}
Run during a maintenance window **before** `CompleteAlignSchema.sql` to clean up orphaned data and verify all foreign key constraints.
{% endfile %}

{% file src="../scripts/CompleteAlignSchema.sql" %}
Run during a maintenance window **after** `EnsureDataConsistency.sql` to add missing foreign keys, indexes, and constraints.
{% endfile %}
