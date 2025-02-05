---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco Commerce.
---

# Release Notes

In this section, we have summarized the changes to Umbraco Commerce released in each version. Each version is presented with a link to the [Commerce issue tracker](https://github.com/umbraco/Umbraco.Commerce.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

Any breaking changes or important issues to consider when upgrading are also mentioned in this article.

{% hint style="info" %}
If you are upgrading to a new major version, check the breaking changes in the [Version Specific Upgrade Notes](../upgrading/version-specific-upgrades.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Commerce 14 including all changes for this version.

#### [14.3.1](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.3.1) (January 28th 2025)

* Fixed issue with stock cache refresher no refreshing due to incorrect cache key [#612](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/612).

#### 14.3.0 (January 13th 2025)

* Added Funnel group match type to Discount rule builder and made All / Any implementations more logical.
* Updated Umbraco.Licenses dependency with latest changes.

#### 14.2.1 (January 8th 2025)

* Fixed issue with inconsistent payment validation incorrectly identifying some payments as inconsistent.
* Fixed error in migration script.

#### 14.2.0 (November 12th 2024)
* Added telemetry support as detailed [here](/14/umbraco-commerce/reference/telemetry/README.md).
* Added a cart-to-order feature that will facilitate admin users to finalize an order directly from the BackOffice cart workspace.

#### [14.1.8](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.8) (November 11th 2024)

* Fixed Rounding issue between Umbraco Commerce and Stripe payment gateway [#580](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/580).

#### [14.1.7](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.7) (November 1st 2024)

**Important** If you are running on version 14 of Umbraco Commerce it is advised to upgrade to this version as soon as possible. Changes in .NET 8.0.8 cause an error in our `EntityCache` which have been resolved in this release. With some hosting providers automatically applying .NET patch releases, upgrading should be proritised to avoid any unintentional breakages.

* Fixed Exception on GetOrCreateCurrentOrder in SessionManager [#581](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/581).

#### [14.1.6](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.6) (October 25th 2024)

* Fixed bug in group discounts provider based on the issue described in  [#574](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/574).
* Fixed UDI parsing error when using product related discount rules due to missing UDI Json Converter. Fixed by backporting PocoFactory from v15.

#### [14.1.5](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.5) (October 23rd 2024)

* Fixed regression in bug fix for [#571](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/571) preventing order details being returned from search queries [#575](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/575).

#### [14.1.4](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.4) (October 23rd 2024)

* Fixed regression in EntityCache updates from 13.1.7/13.1.8 failing under load [#573](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/573).
* Fixed bug in Order search API throwing ORDER BY clause exception [#571](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/571).
* Fixed bug in Country create dialog failing if Regions exist within another store instance [#568](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/568).
* Fixed Price Adjustments applied to bundle sub order line not reflected in the bundle unit price [#564](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/564).

#### [14.1.3](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.3) (17th October 2024)
* Belt and brace updates to EntityCache and added a logger to log if an attempt is made to set a `NULL` key [#565](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/565).

#### [14.1.2](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.1.2) (10th October 2024)

* Fixed issue where the EntityCache fail after the .NET Software Development Kit (SDK) update [#565](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/565).

#### 14.1.1 (27th September 2024)

* Fixed issue with malformed SQL Server migration ([#561](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/561)).

#### 14.1.0 (25th September 2024)

* Added [Sales Tax Provider](../key-concepts/sales-tax-providers.md) support.
* Added Tax Calculation Method to allow for calculated tax rates.
* Updated Countries to accept a tax calculation method.
* Updated Tax Classes to support tax codes.

#### 14.0.1 (24th September 2024)

* Fixed broken migration causing exception on upgrade.
* Fixed issue where price inputs wouldn't allow an explicit `0.00` value for free products ([#555](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/555))

#### 14.0.0 (23rd August 2024)

Read the [v14.0.0 release post](./v14.0.0.md) for more information about this release.

* Added "No results" messages to collection views
* Upgraded Umbraco CMS dependency to v14.2.0

#### 14.0.0-rc3 (12th August 2024)

* Added warning on store dashboard/analytics section if the store has multiple currencies when no currency exchange rate service is configured.
* Added nullable type support to payment provider/shipping provider settings models.
* Added `UcStoreContext` to exported NPM package.
* Added background task licenses resolver to allow Umbraco Commerce to run background tasks without error.
* Added delete support to carts and orders.
* Updated store create dialog to redirect to store editor on create.
* Fixed error on store dashboard when using SQL Server due to group by issue in SQL statement [#547](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/547).
* Fixed errors in v14 migrations when using a separate table for Umbraco Commerce.
* Fixed error in v14 migrations where data types are not correctly migrated.
* Fixed store tree not updating when a new store is created.
* Fixed shipping provider advanced settings now showing in an advanced dropdown editor UI.
* Fixed broken localization keys.

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

You can find the release notes for **Vendr** in the [Change log file on GitHub](changelog-archive/Vendr-core.md).
