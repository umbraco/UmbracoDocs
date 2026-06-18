---
description: >-
  How to move from uMarketingSuite to Umbraco Engage 18 by first migrating to
  Umbraco Engage 17.
---

# Migrate from uMarketingSuite

You cannot migrate directly from uMarketingSuite to Umbraco Engage 18. uMarketingSuite runs on Umbraco 13, so the move to Umbraco Engage 18 is done in two separate stages.

{% hint style="warning" %}
Migrate from uMarketingSuite to Umbraco Engage **17** first. Only then upgrade from Umbraco Engage 17 to 18. Do not attempt to move from uMarketingSuite to Umbraco Engage 18 in a single step.
{% endhint %}

## Migration path

1. **Migrate from uMarketingSuite to Umbraco Engage 17.** Follow the [Migrate from uMarketingSuite](https://docs.umbraco.com/umbraco-engage/17.latest/upgrading/migrate-from-umarketingsuite) guide in the Umbraco Engage 17 documentation. It covers the full process, including the prerequisite checks, package and namespace changes, and database migration scripts.
2. **Upgrade from Umbraco Engage 17 to 18.** Once your site is running on Umbraco Engage 17, follow the [Version Specific Upgrade Notes](version-specific-upgrade-notes.md) to complete the upgrade to Umbraco Engage 18.

{% hint style="info" %}
The upgrade from Umbraco Engage 17 to 18 requires the database schema alignment to be completed. See the [Version Specific Upgrade Notes](version-specific-upgrade-notes.md) for details.
{% endhint %}
