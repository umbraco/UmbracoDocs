---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco
  Commerce.
---

# Release Notes

In this section, we have summarized the changes to Umbraco Commerce released in each version. Each version is presented with a link to the [Commerce issue tracker](https://github.com/umbraco/Umbraco.Commerce.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, check the breaking changes in the [Version Specific Upgrade Notes](../upgrading/version-specific-upgrades.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Commerce 17 including all changes for this version.

#### [17.1.7](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.1.7) (15th Jul 2026)
* Fix cart conversion "Reached Checkout" and "Purchased" totals drifting for past periods [#835](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/835)
* Fix the product picker in the discount rule editor losing store context
* Tolerate legacy member group names in discount rule settings [#839](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/839)
* Raise `CartAbandonedNotification` from the abandoned cart pipeline [#805](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/805)
* Guard against a null content node in `StockPropertyValueConverter` [#848](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/848)
* Fix a crash in the variant picker when a variant has no price [#829](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/829)
* Fix a `NULL dateTimeUtc` error in the transaction activity migration [#831](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/831)
* Preserve the original stack trace on errors surfaced by `PollyExecutionStrategyBase` [#815](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/815)
* Fix `DateTime` settings failing to parse space-separated values
* Reset (rather than cancel) the transaction when a customer abandons checkout [#789](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/789)
* Fix order transaction, export authorization, and top-buyers analytics bugs
* Use the CMS scope in `StoreTelemetryRepository` to avoid querying CMS tables against the Commerce database

#### [17.1.6](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.1.6) (8th Jul 2026)
* Fix a false-positive "transaction amount changed" exception in `BeginPaymentFormAsync`
* Fix a `NullReferenceException` when using dynamic shipping with no product measurements or no store location
* Fix a `NullReferenceException` when a dynamic shipping rate range provider alias cannot be resolved

#### [17.1.5](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.1.5) (28th May 2026)
* Fix payment form generation throwing "Order has changed and needs recalculating" exception when a customer is auto-assigned on payment start [#832](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/832)
* Preserve an existing customer reference on the order when a member logs in (only auto-assign when no reference is set)
* Surface `OrderCalculation` on `ShippingProviderContext` so realtime shipping providers can read in-progress totals during recalc [#850](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/850)
* Fix store dashboard order counts and revenue not matching the Analytics page [#840](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/840)

#### [17.1.4](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.1.4) (14th May 2026)
* Added search notifications events for orders, carts and gift cards [#824](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/824), [#827](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/827)

#### 17.1.3 (26th Feb 2026)
* Make `DiscountRuleContext` and `DiscountRewardContext` constructors public for custom `DiscountsPriceAdjuster` implementations
* Fix transaction fee not being tracked on `AuthorizeTransactionActivity`

#### [17.1.2](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.1.2) (19th Feb 2026)
* Updated the hashing depth of the realtime shipping rates calculator
* Fixed passing transaction fee on payment authorisation
* Add searching to Gift Cards [#765](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/765)
* Enable cachebusting for backoffice JavaScript assets [#793](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/793)
* Fix shipping and payment buttons in Cart order details [#820](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/820)
* Fix order CSV export [#822](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/822)


#### [17.1.1](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.1.1) (29th Jan 2026)

* Allow decimal input for percentage property editor [#817](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/817)
* Make `CompactSortableOrderNumberGenerator` and `INodeIdAccessor` public [#819](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/819)

#### 17.1.0 (22nd Jan 2026)

* 17.1.0 stable release

#### 17.1.0-rc1 (8th Jan 2026)

* Implemented new order caching layer with version based expiry for better load balancing support.
* Added support for a refund reason when refunding an order.
* Added Refund Rate analytics widget.
* Added Top 50 Buyers analytics widget.
* Added Low Stock analytics widget.
* Added browser titles to workspaces.
* Added UFM view template support to editable model properties.
* Fixed print templates not rendering if you don't have Settings section permission.
* Fixed variants content endpoints not returning data.

#### 17.0.0 (27th Nov 2025)

* Version 17 final release.

#### 17.0.0-rc1 (04th Nov 2025)

Initial release candidate for Umbraco v17. This release doesn't contain any new features; rather, it's a v17 compatibility release.

* Updated to Umbraco CMS v17.
* Upgraded all third-party dependencies.
* Removed all obsolete code flagged for removal in v17.
