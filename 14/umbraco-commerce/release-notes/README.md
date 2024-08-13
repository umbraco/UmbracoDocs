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

#### 14.0.0-rc3 (12th August 2024)

* Added warning on store dashboard/analytics section if the store has multiple currencies when no currency exchange rate service is configured.
* Added nullable type support to payment provider/shipping provider settings models.
* Added `UcStoreContext` to exported NPM package.
* Added background task licenses resolver to allow Umbraco Commerce to run background tasks without error.
* Added delete support to carts and orders.
* Updated store create dialog to redirect to store editor on create.
* Fixed error on store dashboard when using SQL Server due to group by issue in SQL statement [#547](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/547).
* Fixed errors in v14 migrations when using a seperate table for Umbraco Commerce.
* Fixed error in v14 migrations where data types are not correctly migrated.
* Fixed store tree not updating when a new store is created.
* Fixed shipping provider advanced settings now showing in an advanced dropdown editor UI.
* Fixed broken localzation keys.

#### 14.0.0-rc2 (29th July 2024)

* Fixed issue in rc1 DB migration script.

#### 14.0.0-rc1 (29th July 2024)

* Added sort modals to all sortable entities.
* Added basic text search across all entity collection views.
* Added cart status filter option to carts collection view.
* Added advanced properties support to payment/shipping provider settings.
* Added order activity log funcationality back in.
* Added commerce section dashboard.
* Added async pipeline implementation.
* Added front end NPM package for UI extension points.
* Localized all hard coded strings.
* Replaced `Newtonsoft.Json` with `System.Text.Json` throughout.
* Removed `ExchangeRateHost` as the default exchange rate service as it now requires an API key.
* Fixed validation error for Region code not matching the description example.
* Fixed bug in payment provider URL generation containing a rogue `$` symbol.

#### 14.0.0-beta1 (16th July 2024)

* Added Product Attributes section
* Added Product Attribute Presets section
* Added Variants property editor to create complex product variants
* Fixed issues with property editor value converters
* Fixed issue with stock synchronization

#### 14.0.0-alpha4 (3rd July 2024)

* Added Carts section with ability to create/edit customer carts
* Refactored order endpoints to use a defined model for customer/billing/shipping details rather than using order properties collection
* Merged in v13 bug fixes

#### 14.0.0-alpha3 (24th June 2024)

* Added Analytics section
* Added Create Country modal to allow creating countries from ISO 3166 presets
* Added license warning component throughout the commerce section
* Updated Regions workspace app to now be hidden until the country is persisted
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
