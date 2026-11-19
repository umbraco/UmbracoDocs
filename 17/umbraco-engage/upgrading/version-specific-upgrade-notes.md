---
description: >-
  Version-specific documentation for upgrading to new major versions of Umbraco
  Engage.
---

# Version specific Upgrade Notes

This article provides specific upgrade instructions and breaking changes introduced when migrating from major version 13 of Umbraco Engage to version 17.

{% hint style="info" %}
When upgrading to a new minor or patch version, learn about the changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Breaking changes

### 17.6.0 (user group access moved to Umbraco permissions)

Access to Engage features is now granted through the permissions of each Umbraco user group. The **User group permissions** screen under **Engage** > **Configuration** has been removed. The Engage backoffice API now checks the permissions on the server.

A migration copies the previous settings:

* A user group with no saved Engage settings gets every Engage permission.
* A user group with saved Engage settings gets Read, Write, and Export for each feature the user group was allowed to use.

After you upgrade, check that your user groups have the access you expect. Each permission is checked on its own, so a user group needs both Read and Write to view and change a feature. Learn more in the [Permissions](../marketers-and-editors/settings/permissions.md) article.

The Engage Cockpit now requires access to the Engage section, and the Read permission for each feature the Cockpit shows.

`Engage:Reporting:DataGenerationTime` now defaults to empty instead of `04:00`. When it is empty, Engage picks a random time between 01:00 and 05:00 in the reporting time zone. An explicit time is now scheduled in the reporting time zone instead of the server time zone. If your server and reporting time zones differ, check that the time is still what you want.

### 17.4.0 (behavior changes)

* **Pageview goals**: Pageview goals saved on 17.2.4, 17.3.0, or 17.3.1 hold values that cannot be recovered. Re-pick the pages of these goals after upgrading.
* **Preview URLs**: The `EngagePreviewVariantId` and `engagePreviewAppliedPersonalization` query string parameters, and the endpoint that generated preview URLs from them, have been removed. Bookmarked or hand-built preview URLs no longer work. Preview now uses the Umbraco preview segment switcher.
* **Invariant A/B tests and personalizations**: Invariant A/B tests and personalizations are now applied on culture-specific pages. Configurations that were inert before start serving variants after upgrading.
* **Minimal deviation**: The default minimal deviation for persona and customer journey scoring changed from 0 to 1. A persona or customer journey step that leads by no points no longer wins.

### 17.2.0 — Database Schema Alignment

Engage 17.2.0 introduces a rewritten analytics data cleanup system and a database schema alignment. This is a **manual post-upgrade step** that requires running SQL scripts during a maintenance window.

See the [Schema Alignment Guide](schema-alignment-guide.md) for full details on the cleanup changes, configuration settings, and step-by-step post-upgrade instructions.

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

This means that these services work without the use of magic numbers that are environment-dependent, and instead allow for the use of a key that is shared between environments. This also marks the introduction of the [Deploy](../add-ons/deploy.md) add-on (`Umbraco.Engage.Deploy`) for Engage v17. It allows for the transferring of goals, personas, customer journeys, and A/B tests, adding even more use cases to these service changes.

#### Nullability

Engage v17 enables strict nullable reference types across all projects. This may cause compilation warnings/errors if you're extending or implementing Engage interfaces.&#x20;
