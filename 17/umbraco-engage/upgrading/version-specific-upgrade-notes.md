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

### 17.0.0 (Umbraco Engage v17 Launch)

With the introduction of Engage version 17, breaking changes have been introduced to accommodate the transition between multiple major versions of the core CMS.

#### Database Changes

Three database structure changes have been introduced in the transition from Engage v16 to v17. The first is the migration to userKeys instead of userIds. All references to Umbraco users in Engage tables have now been updated to use the unique key of that user instead.

The same applies to all references to Umbraco user groups in Engage tables. They have also been updated to use the unique key of that user group instead.

The last update involves a change to the `[umbracoEngageAbTestingAbTestVariant]` table, which now contains a new column `[redirectNodeKey]` , which contains a NodeKey used for Split URL A/B Tests.

#### Public Services

Engage v17 introduces new overloads of public-facing service methods to allow the use of keys where previously numeric IDs were expected, resolving [issue #23](https://github.com/umbraco/Umbraco.Engage.Issues/issues/23). These overloads have been added to the following services:

* IAbTestingVisitorService
* IGoalService
* IPersonaService
* ICustomerJourneyService

This means that these services work without the use of magic numbers that are environment-dependent, and instead allow for the use of a key that is shared between environments. This also marks the introduction of `Engage.Deploy` for Engage v17 to allow for the transferring of goals, personas, customer journeys, and A/B tests, adding even more use cases to these service changes.

#### Nullability

Engage v17 enables strict nullable reference types across all projects. This may cause compilation warnings/errors if you're extending or implementing Engage interfaces.&#x20;
