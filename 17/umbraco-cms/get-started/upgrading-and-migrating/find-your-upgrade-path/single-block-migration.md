---
description: >-
  The single block migration from Block List single mode no longer applies.
---

# Single Block Migration for Umbraco 18

{% hint style="warning" %}
This feature was removed in Umbraco 18.4 and no longer applies.
{% endhint %}

Umbraco 17 included an early-access migration that converted Block List Data Types configured in "single" mode to the Single Block property editor. The migration was planned to run by default when upgrading to Umbraco 18.

You do not need to run this migration or implement `ITypedSingleBlockListProcessor` for custom property editors.
