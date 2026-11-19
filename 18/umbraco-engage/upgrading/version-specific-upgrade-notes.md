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

### 18.3.0 — Consent and the original referrer

#### Call `consentGranted()` after a visitor grants consent

If your site reloads the page after a visitor grants analytics consent, replace that reload with a call to `umbracoEngage.analytics.consentGranted()`. A reload replaces the original referrer with the site's own URL, so the visit is recorded without its real source.

`consentGranted()` stores the original referrer in a short-lived `ue-consent-referrer` cookie and then reloads the page. Engage reads the referrer from the cookie, and removes it. The cookie is only written for visitors who grant consent. Pass `{ reload: false }` to store the referrer and handle the navigation yourself.

Sites that do not reload the page after consent are not affected.

See [How to become GDPR compliant using Cookiebot](../security-and-privacy/gdpr/how-to-become-gdpr-compliant-using-cookiebot.md) for how to call it from a consent callback.

### 18.0.0 (Umbraco Engage v18 Launch)

Engage 18 adds support for Umbraco CMS 18. The main upgrade consideration is that the database schema alignment introduced in 17.2.0 is now **required** before you can upgrade.

#### Database Schema Alignment is now enforced

In 17.2.0, the schema alignment ran as an automatic on-boot migration (`AlignSchema`). It was followed by a **manual** script (`CompleteAlignSchema.sql`) to run during a maintenance window. Running the manual script was strongly recommended but not enforced — Engage continued to run with the schema left in the intermediate `Aligned` state.

Starting with Engage 18, completing this alignment is **mandatory**. This guarantees data integrity and performance going forward. The foreign keys, indexes, and constraints added by the alignment can no longer be treated as optional. A guard at the head of the v18 migrations reads the `Umbraco.Engage+DatabaseSchemaStatus` value in the `umbracoKeyValue` table. It **blocks the upgrade** unless the alignment has been completed. When the upgrade is blocked, Engage throws an error at startup and the migration does not proceed. The error message states which state the database is in and what to do next:

| `DatabaseSchemaStatus` | Result | What to do |
| --- | --- | --- |
| `Complete` | Upgrade proceeds | No action needed. |
| _(no value)_ | Upgrade proceeds | Fresh installs are unaffected. |
| `Aligned` | **Upgrade blocked** | The automatic alignment ran, but `CompleteAlignSchema.sql` was never completed. Run it during a maintenance window, then retry the upgrade. |
| `Pending` | **Upgrade blocked** | A previous run of `CompleteAlignSchema.sql` started but did not finish. The script cannot be re-run from this state — the partial state must be investigated and recovered manually. |
| _(any other value)_ | **Upgrade blocked** | The schema is in an unexpected state. Expected `Complete` on existing installs, or no value on fresh installs. |

{% hint style="warning" %}
If you upgraded through 17.2.x but never completed the manual schema alignment, your installation is most likely in the `Aligned` state. You must complete the schema alignment **before** upgrading to Engage 18, otherwise Engage will not start.
{% endhint %}

Follow the [Schema Alignment Guide](schema-alignment-guide.md) to complete the alignment. Once its steps are finished and the `DatabaseSchemaStatus` is `Complete`, the upgrade to Engage 18 proceeds normally.
