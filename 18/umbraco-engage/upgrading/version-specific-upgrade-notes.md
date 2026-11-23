---
description: >-
  Version-specific documentation for upgrading to new major versions of Umbraco
  Engage.
---

# Version specific Upgrade Notes

This article provides specific upgrade instructions and breaking changes introduced when migrating to major version 18 of Umbraco Engage.

{% hint style="info" %}
When upgrading to a new minor or patch version, learn about the changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Breaking changes

### 18.3.0 (user group access moved to Umbraco permissions)

Access to Engage features is now granted through the permissions of each Umbraco user group. The **User group permissions** screen under **Engage** > **Configuration** has been removed. The Engage backoffice API now checks the permissions on the server.

A migration copies the previous settings:

* A user group with no saved Engage settings gets every Engage permission.
* A user group with saved Engage settings gets Read, Write, and Export for each feature the user group was allowed to use.

After you upgrade, check that your user groups have the access you expect. Each permission is checked on its own, so a user group needs both Read and Write to view and change a feature. Learn more in the [Permissions](../marketers-and-editors/settings/permissions.md) article.

The Engage Cockpit now requires access to the Engage section, and the Read permission for each feature the Cockpit shows.

`Engage:Reporting:DataGenerationTime` now defaults to empty instead of `04:00`. When it is empty, Engage picks a random time between 01:00 and 05:00 in the reporting time zone. An explicit time is now scheduled in the reporting time zone instead of the server time zone. If your server and reporting time zones differ, check that the time is still what you want.

### 18.1.0 (behavior changes)

* **Pageview goals**: Pageview goals saved on 18.0.0 hold values that cannot be recovered. Re-pick the pages of these goals after upgrading.
* **Preview URLs**: The `EngagePreviewVariantId` and `engagePreviewAppliedPersonalization` query string parameters, and the endpoint that generated preview URLs from them, have been removed. Bookmarked or hand-built preview URLs no longer work. Preview now uses the Umbraco preview segment switcher.
* **Invariant A/B tests and personalizations**: Invariant A/B tests and personalizations are now applied on culture-specific pages. Configurations that were inert before start serving variants after upgrading.
* **Minimal deviation**: The default minimal deviation for persona and customer journey scoring changed from 0 to 1. A persona or customer journey step that leads by no points no longer wins.

### 18.0.0 (Umbraco Engage v18 Launch)

Engage 18 adds support for Umbraco CMS 18. The main upgrade consideration is that the database schema alignment introduced in 17.2.0 is now **required** before you can upgrade.

#### Database Schema Alignment is now enforced

In 17.2.0, the schema alignment ran as an automatic on-boot migration (`AlignSchema`). It was followed by a **manual** script (`CompleteAlignSchema.sql`) to run during a maintenance window. Running the manual script was strongly recommended but not enforced — Engage continued to run with the schema left in the intermediate `Aligned` state.

Starting with Engage 18, completing this alignment is **mandatory**. This guarantees data integrity and performance going forward. The foreign keys, indexes, and constraints added by the alignment can no longer be treated as optional. At startup, Engage reads the `Umbraco.Engage+DatabaseSchemaStatus` value in the `umbracoKeyValue` table.

In 18.0.0, an incomplete alignment blocks the upgrade. Engage throws an error at startup and the migration does not proceed.

From 18.1.0, the site keeps running. Engage logs a critical message, marks its schema as unhealthy, and disables its own features until the alignment is completed. The log message states which state the database is in and what to do next:

| `DatabaseSchemaStatus` | Result | What to do |
| --- | --- | --- |
| `Complete` | Upgrade proceeds | No action needed. |
| _(no value)_ | Upgrade proceeds | Fresh installs are unaffected. |
| `Aligned` | **Engage disabled until the alignment is completed** (18.0.0: upgrade blocked) | The automatic alignment ran, but `CompleteAlignSchema.sql` was never completed. Run it during a maintenance window, then restart the site. On 18.0.0, retry the upgrade. |
| `Pending` | **Engage disabled until the alignment is completed** (18.0.0: upgrade blocked) | A previous run of `CompleteAlignSchema.sql` started but did not finish. Fix the failure reported by that run. Then run the script again during a maintenance window and restart. |
| _(any other value)_ | **Engage disabled until the alignment is completed** (18.0.0: upgrade blocked) | The schema is in an unexpected state. Expected `Complete` on existing installs, or no value on fresh installs. |

{% hint style="warning" %}
If you upgraded through 17.2.x but never completed the manual schema alignment, your installation is most likely in the `Aligned` state. Complete the schema alignment **before** upgrading to Engage 18. Otherwise Engage does not start on 18.0.0, and is disabled on 18.1.0 and later.
{% endhint %}

Follow the [Schema Alignment Guide](schema-alignment-guide.md) to complete the alignment. Once its steps are finished and the `DatabaseSchemaStatus` is `Complete`, the upgrade to Engage 18 proceeds normally.
