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

This section contains the release notes for Umbraco Commerce 15 including all changes for this version.

#### [15.3.7](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Acomponent%2Fcommerce+label%3Arelease%2F15.3.7) (Jun 24th 2025)

* Fixed bug in property editors with store config not resolving the correct store [#721](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/721).
* Fixed stock input allowing stock levels below zero [#714](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/714).
* Fixed bug in price property editor not honoring extra decimal places config [#712](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/712).

#### [15.3.6](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Acomponent%2Fcommerce+label%3Arelease%2F15.3.6) (Jun 13th 2025)

* Fixed bug where unable to refund orders with payment methods that don't support partial refunds [#710](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/710).

#### [15.3.5](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Acomponent%2Fcommerce+label%3Arelease%2F15.3.5) (May 29th 2025)

* Fixed issue with not being able to create countries [#709](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/709).
* Fixed issue with inconsistent labeling of measurement units [#706](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/706).
* Fixed issue emails not sending due to headless language parsing [#705](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/705).

#### [15.3.4](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Acomponent%2Fcommerce+label%3Arelease%2F15.3.4) (May 6th 2025)

* Fixed issue when exporting lots of entities due to too many SQL parameters [#704](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/704).
* Fixed issue with product measurements not being copied to the orderline if any of them are zero [#702](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/702).
* Fixed method not found exception due to changes in CMS webhook API [#701](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/701).

#### 15.3.3 (May 1st 2025)

* Fixed error when triggering webhooks on order finalization due to missing method in CMS.
* Fixed product search in backoffice throwing error when adding a product to a cart.

#### [15.3.2](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Acomponent%2Fcommerce+label%3Arelease%2F15.3.2) (May 1st 2025)

* Fixed error when creating gift cards [#700](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/700).
* Fixed stock service allow stock to be updated for products that don't have a stock property editor [#699](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/699).
* Fixed issue where unable to add products to cart due to new validation handlers and using custom product adapters [#698](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/698).
* Fixed issue with property collections being case sensitive when DB indexes were not [#690](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/690).

#### [15.3.1](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Acomponent%2Fcommerce+label%3Arelease%2F15.3.1) (Apr 29th 2025)

* Fixed unknown transaction activity type ConfirmExternalSystemTransactionActivity error [#697](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/697).

#### [15.3.0](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Acomponent%2Fcommerce+label%3Arelease%2F15.3.0) (Apr 29th 2025)

* Added Payment Links feature to allow sending a payment link to customers.
* Added partial refunds feature to allow refunding part of an order.
* Fixed duplicate message when collections have no items.
* Fixed issue with store editor not displaying in Umbraco 15.4.0-RC2 [#691](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/691).
* Fixed a malformed "Shipping via" localization string [#696](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/696).

#### [15.2.2](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.2.2) (Apr 17th 2025)

* Updated grouped discount logic to be more as expected [#685](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/685).
* Fixed issue with order exports action not working [#689](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/689).
* Fixed issue with order print action not working.
* Fixed issue with pagination not working on order print action preview modal.
* Fixed Management API not returning Payment Provider meta data properties due to being saved as server side only.

#### [15.2.1](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.2.1) (Mar 31st 2025)

* Fixed an issue in the previous migration that increased the monetary column precision [#681](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/681).
* Fixed bug with Umbraco Commerce price property editor causing error when accessing content via Delivery API [#683](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/683).
* Fixed issue with order list performance being slow [#680](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/680).
* Fixed issue with stock field in multi variants editor always returning zero [#676](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/676).

#### [15.2.0](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.2.0) (Mar 3rd 2025)

* Updated Umbraco.Licenses dependency to fix issue with license resolution in Azure environments.
* Fixed issue with amount based discounts not persisting the amount value correctly [#674](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/674).
* Fixed issue with member group discounts throwing error [#675](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/675).
* Fixed the `OrderHasCustomerEmailAddress` query specification performing the wrong comparison (essentially inverted).
* Fixed issue where a recalculation of an order with a shipping method that no longer meets it's eligability criteria rolls back the Unit of Work even if the failure can be automatically rectified.
* Added "Customer Source" config option to member group discount rule to allow you choose where the customer should be resolved from. Either the order or the session.

#### [15.1.1](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F15.1.1) (19th Feb 2025)

* Fixed bug in price property editor not formatting prices correctly on load when using a non US currency format [#666](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/666).
* Fixed bug in commerce section dashboard showing the wrong order total value + order total count [#601](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/601).
* Fixed bug that deleting a country would throw exception [#477](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/477).
* Fixed bug where deleting a region didn't update Shipping / Payment Method allowed country regions [#669](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/669).
* Fixed bug where error is thrown if saving a shipping / payment method without an SKU by adding client side required field validation [#384](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/384).
* Fixed bug with `applyToCurrentOrder` not applying changes to default currency [#278](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/278).
* Fixed bug where changing a gift card code alias would cause error for orders using that gift card [#149](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/149).
* Added code to retry requests that result in a `DBConcurrencyException`.

#### 15.1.0 (14th Feb 2025)

* v15.1.0 final release

#### 15.1.0-rc1 (7th Feb 2025)

Read the [v15.1.0-rc release post](v15.1.0-rc.md) for further background on this release.

* Added cart cleanup service
* Added order line actions UI extension point

#### 15.0.1 (5th Feb 2025)

* Fixed `TranslatedValue` erroring if the language key was `null`, instead of falling back to the default value.
* Added async `WithOrderLine` extensions to allow a more fluent API.

#### 15.0.0 (23rd Jan 2025)

* v15 final release

#### 15.0.0-rc1 (24th May 2024)

Read the [v15.0.0-rc release post](v15.0.0-rc.md) for further background on this release.

* v15 initial release candidate

## Legacy release notes

You can find the release notes for **Vendr** in the [Change log file on GitHub](../../../10/umbraco-commerce/changelog-archive/Vendr-core.md).
