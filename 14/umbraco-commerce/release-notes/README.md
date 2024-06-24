---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco Commerce.
---

# Release Notes

In this section, we have summarized the changes to Umbraco Commerce released in each version. Each version is presented with a link to the [Commerce issue tracker](https://github.com/umbraco/Umbraco.Commerce.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, check the breaking changes in the [Version Specific Upgrade Notes](upgrading/version-specific-upgrades.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Commerce 14 including all changes for this version.

#### 14.0.0-alpha3 (24th June 2024)

* Added Analytics section
* Added Create Country modal to allow creating countries from ISO 3166 presets
* Added license warning component throughout the commerce section
* Updated Regions workspace app is now hidden until the country is persisted
* Update Payment Provider / Shipping Provider label keys to convert kebab case provider aliases to camel case keys for consistency
* Fixed bug in Payment Providers section throwing error due to unmapped `sku` property
* Fixed issue due to use of `JSON_PATH_EXISTS` in migration scripts only supported in SQL Server 2022+. Resorted to just using `JSON_VALUE` queries instead [(#521)](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/521)

#### 14.0.0-alpha2 (7th June 2024)

* Added section condition to commerce section to only show it when the current user has permission to see it
* Setup Management APIs for Product Attributes, Discounts, Gift Cards and Analytics sections
* Created an new Umbraco Commerce Payment API to handle payment gateway interactions (old endpoints are depricated)
* Added a basic store dashboard with current days stats and order search
* Added Gift Cards section
* Added Discounts section
* Various bug fixes
* Backoffice resources are now lazy loaded
* Upgraded Umbraco dependency to v14 final

#### 14.0.0-alpha1 (24th May 2024)

Read the [v14.0.0-Alpha release post](./v14.0.0-alpha.md) for further background on this release.

* v14 initial alpha release

## Legacy release notes

You can find the release notes for **Vendr** in the [Change log file on Github](changelog-archive/Vendr-core.md).
