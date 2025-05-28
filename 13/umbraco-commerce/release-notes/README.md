---
description: Get an overview of the changes and fixes in each version of Umbraco Commerce.
---

# Release Notes

In this section, we have summarized the changes to Umbraco Commerce that were released in each version. Each version has a link to the [Commerce issue tracker](https://github.com/umbraco/Umbraco.Commerce.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, check the breaking changes in the [Version Specific Upgrade Notes](../upgrading/version-specific-upgrades.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Commerce 13 including all changes for this version.

#### [13.2.1](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.2.1) (Mar 31st 2025)

* Fixed an issue in the previous migration that increased the monetary column precision [#681](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/681).

#### [13.2.0](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.2.0) (Mar 3rd 2025)

* Updated Umbraco.Licenses dependency to fix issue with license resolution in Azure environments.
* Fixed custom headers missing from display in carts list [#672](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/672).
* Fixed the `OrderHasCustomerEmailAddress` query specification performing the wrong comparison (essentially inverted).
* Fixed issue where a recalculation of an order with a shipping method that no longer meets it's eligability criteria rolls back the Unit of Work even if the failure can be automatically rectified.

#### [13.1.19](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.19) (Feb 19th 2025)

* Fixed regression from 13.1.18 where a Unit of Work was not populating the ambient reference when using `uow.Create` [#670](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/670).
* Fixed bug in commerce section dashboard showing the wrong order total value + order total count [#601](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/601).
* Fixed bug in "Placed On Order After / Before" advanced filters UI loosing the selected dates when re-opening modal [#515](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/515).
* Fixed bug that deleting a country would throw exception [#477](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/477).
* Fixed bug where deleting a region didn't update Shipping / Payment Method allowed country regions [#669](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/669).
* Fixed bug where error is thrown if saving a shipping / payment method without an SKU by adding client side required field validation [#384](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/384).
* Fixed bug with `applyToCurrentOrder` not applying changes to default currency [#278](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/278).
* Fixed bug where changing a gift card code alias would cause error for orders using that gift card [#149](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/149).
* Added code to retry requests that result in a `DBConcurrencyException`.

#### 13.1.18 (February 11th 2025)

* Fixed issue with shipping / payment calculators executing for order with zero line items.
* Fixed issue in unit of work causing child units of work to run their own retry policy. Now limited to only the outer unit of work that executes one.

#### [13.1.17](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.17) (January 28th 2025)

* Fixed issue with stock cache refresher no refreshing due to incorrect cache key [#612](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/612).

#### 13.1.16 (January 13th 2025)

* Updated Umbraco.Licenses dependency with latest changes.

#### 13.1.15 (January 8th 2025)

* Fixed issue with inconsistent payment validation incorrectly identifying some payments as inconsistent.

#### 13.1.14 (December 12th 2024)

* Added support for test licenses.

#### [13.1.13](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.13) (November 11th 2024)

* Fixed Rounding issue between Umbraco Commerce and Stripe payment gateway [#580](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/580).

#### [13.1.12](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.12) (November 1st 2024)

**Important** If you are running on version 13 of Umbraco Commerce it is advised to upgrade to this version as soon as possible. Changes in .NET 8.0.8 cause an error in our `EntityCache` which have been resolved in this release. With some hosting providers automatically applying .NET patch releases, upgrading should be proritised to avoid any unintentional breakages.

* Fixed Exception on GetOrCreateCurrentOrder in SessionManager [#581](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/581).

#### [13.1.11](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.11) (October 25th 2024)

* Fixed regressions due to updates from 13.1.6 not getting merged back into main project [#576](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/576).
* Fixed bug in group discounts provider based on the issue described in [#574](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/574).

#### [13.1.10](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.10) (October 23rd 2024)

* Fixed regression in bug fix for [#571](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/571) preventing order details being returned from search queries [#575](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/575).

#### [13.1.9](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.9) (October 23rd 2024)

* Fixed regression in EntityCache updates from 13.1.7/13.1.8 failing under load [#573](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/573).
* Fixed bug in Order search API throwing ORDER BY clause exception [#571](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/571).
* Fixed bug in Country create dialog failing if Regions exist within another store instance [#568](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/568).
* Fixed Price Adjustments applied to bundle sub order line not reflected in the bundle unit price [#564](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/564).

#### [13.1.8](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.8) (October 17th 2024)

* Belt and brace updates to EntityCache and added a logger to log if an attempt is made to set a `NULL` key [#565](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/565).

#### [13.1.7](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.7) (October 10th 2024)

* Fixed issue where the EntityCache fail after the .NET Software Development Kit (SDK) update [#565](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/565).
* Check the config for being undefined in order's edit properties dialog.

#### [13.1.6](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.6) (July 11th 2024)

* Fixed issue with the Storefront API hosted checkout not rendering form attributes [#532](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/532).
* Fixed issue with 13.1.5 migration scripts using too new a feature [#539](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/539).
* Fixed issue with stock synchronizer prematurely looking up a store [#536](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/536).
* Updated pessimistic locking on the payment provider callback endpoints to lock from the start of the request, not when processing the callback.

#### [13.1.5](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.5) (July 3rd 2024)

* Added new `IRoundingService` to allow overriding the default rounding behavior [#506](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/506).
* Added pessimistic locking to the payment provider callback endpoint to prevent concurrency issues if the endpoint is called too many times at once [#533](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/533).
* Fixed issue with malformed script tags in the Storefront API hosted checkout pay endpoint [#532](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/532).
* Fixed percentage discounts not taking the stores rounding method into account during calculation [#506](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/506).
* Fixed issue where order lines with a zero value would cause a concurrency exception due to the fact their prices aren't frozen but the order recalculation process was attempting to refreeze them.
* Fixed error with realtime shipping rates provider where the rate cache duration was zero.
* Updated `MemoryCache` usages to fallback to a default implementation if one isn't found in the DI container.
* Updated Order properties to trim whitespace around values to prevent unexpected behavior [#528](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/528).
* Updated all currency database tables to support 8 decimal places to prevent rounding issues with order quantities above 1000 [#506](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/506).

#### [13.1.4](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.4) (April 23rd 2024)

* Fixed error in `SearchOrder` when searching with date ranges [#496](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/496).

#### [13.1.3](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.3) (April 8th 2024)

* Fixed properties set in the background from an entity action lost when resaving the entity from the UI after the action (wasn't fully fixed in 13.1.2) [#472](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/472).
* Fixed orderline properties not showing in orderline summary by default due to regression from strongly typing UI config files in 13.1.0 [#494](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/494).
* Added support for localhost sub domains in dev license [#493](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/493).
* Added a `WithUmbracoBuilder` extension for `IUmbracoCommerceBuilder` to allow access to the Umbraco configuration within an Umbraco Commerce registration.

#### [13.1.2](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.2) (March 27th 2024)

* Fixed properties set in the background from an entity action lost when resaving the entity from the UI after the action [#472](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/472).
* Fixed unable to override cart editor view like you can the order editor view [#474](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/474).
* Fixed regression where launching the shipping method country prices dialog caused JavaScript errors [#480](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/480).
* Fixed regression with order list configs not deserializing correctly [#485](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/485).
* Fixed `Order.ProductVariantReference` mapping to the wrong field in Storefront API.
* Fixed `CountryRegionTaxRate.Country` mapping to the wrong field in Storefront API.
* Added better validation error messages when saving locations missing required fields [#481](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/481).

#### [13.1.1](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.1) (March 3rd 2024)

* Fixed regression where custom order/cart editor view stopped working [#469](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/469).
* Fixed issue with Locations not deleting [#470](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/470).
* Fixed issue with date range order searches not working correctly [#468](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/468).

#### 13.1.0 (February 21st 2024)

* Minor release closing off the RC period.
* Fixed null exceptions when creating shipping methods with empty config.
* Added helper methods to `FixedRateShippingCalculationConfig` to make it's API closer to the older fixed rate price lookup API.

#### 13.1.0-rc3 (February 15th 2024)

* Fixed missing SQL Server migrations.
* Fixed realtime shipping rates cache not taking shipping country/region changes into account.
* Fixed realtime shipping rates cache not taking store default location changes into account.
* Fixed error in SafeLazy not taking null into account and so causing errors when an entity cache entry is evicted [#466](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/466).
* Updated `Umbraco.Licenses` version dependency to the latest.
* Made `WithUmbracoCommerceBuilder` extension public to allow accessing the `IUmbracoCommerceBuilder` instance outside of the `AddUmbracoCommerce` call.

#### 13.1.0-rc2 (February 8th 2024)

* Fixed RC1 regression where discount/gift card tree icons were broken.
* Fixed RC1 regression where localized translations were broken.
* Fixed issue in dynamic shipping subtotal range provider not taking the current calculation context into account and so was selecting the wrong range.

#### 13.1.0-rc1 (February 6th 2024)

Read the [v13.1.0-RC release post](v13.1.0-rc.md) for further background on this release.

* Adds dynamic shipping rate calculation option.
* Adds real-time shipping rate calculation option via Shipping Providers.
* Adds store locations for shipping calculations.
* Adds store Measurement System setting.
* Adds Measurements property editor for capturing product measurements for shipping calculations.
* Adds shipping package factory concept for calculating packages for shipments.
* Updates the shipping method create-flow to require selecting a shipping provider and a shipping calculation mode.
* Updates API for calculating shipping prices as payment methods can now return multiple rates.
* Updates the order API for setting the shipping method to accept a `ShippingOption` for shipping methods that can supply multiple rates.
* Updates the order editor to display the selected shipping option.
* Updates the cart editor to allow selecting a shipping option from real-time shipping methods.
* Updates the cart editor to calculate shipping rates/payment fees based on the current in-memory cart state.
* Updates storefront API to incorporate new shipping rates endpoints.

#### 13.0.2 (February 15th 2024)

* Fixed error in SafeLazy not taking null into account and so causing errors when an entity cache entry is evicted [#466](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/466).

#### 13.0.1 (February 6th 2024)

* Reset request stream before passing to payment providers.
* Added licensing fallback to use any previously validated license within the last 7 days.
* Updated `Umbraco.Licenses` version dependency to the latest.
* Made `WithUmbracoCommerceBuilder` extension public to allow accessing the `IUmbracoCommerceBuilder` instance outside of the `AddUmbracoCommerce` call.

#### [13.0.0](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) (December 13th 2023)

* Upgraded to run again Umbraco v13 and .NET 8
* Upgraded all 3rd party dependencies
* Fixed Cross-site scripting (XSS) issue in email/print templates

## Legacy release notes

You can find the release notes for **Vendr** in the [Change log file on GitHub](../../../10/umbraco-commerce/changelog-archive/Vendr-core.md).
