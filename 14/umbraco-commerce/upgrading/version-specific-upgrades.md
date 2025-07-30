---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco Commerce.
---

# Version Specific Upgrade Notes

This page covers specific upgrade documentation for when migrating to major 14 of Umbraco Commerce.

{% hint style="info" %}
If you are upgrading to a new minor or patch version, you can find information about the breaking changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

#### 14.1.0

* Tax Classes now have Country Region Tax Classes rather than Country Region Tax Rates so that tax codes can be assigned to products. Developers should update any references for Country Region Tax Rates to Country Region Tax Classes.

#### 14.0.0

* UI Config file configurations will need to use the new UI Extensions API

#### Umbraco Commerce Launch

Umbraco Commerce contains a number of breaking changes from the previous Vendr product.

See the [Migrate from Vendr to Umbraco Commerce guide](migrate-from-vendr-to-umbraco-commerce/) for full details.

## Legacy version specific upgrade notes

You can find the version specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/tree/umbraco-eol-versions).&#x20;
