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

This section contains the release notes for Umbraco Commerce 16 including all changes for this version.

#### [16.3.0](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.3.0) (Sep 5th 2025)

* Added ability to disable payment/shipping providers without loosing data [#659](https://github.com/umbraco/Umbraco.Commerce.Issues/discussions/659).
* Added a country discount rule [#656](https://github.com/umbraco/Umbraco.Commerce.Issues/discussions/656).
* Added `processing` and `failed` states to carts to be able to easily identify carts having payment processing difficulties [#664](https://github.com/umbraco/Umbraco.Commerce.Issues/discussions/664).
* Added frozen prices cache refresher to ensure frozen prices invalid in load balanced environments [#649](https://github.com/umbraco/Umbraco.Commerce.Issues/discussions/649).
* Updated the `HasOrderLineWithProduct` query specification to support a `StringComparisonType` [#660](https://github.com/umbraco/Umbraco.Commerce.Issues/discussions/660).
* Fixed issue with stock synscronization logic ignoring the stock property editors store configuration [#741](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/741).
* Fixed issue with carts list view not calling back to the manifest entries label [#749](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/749).
* Fixed issue with backoffice not allowing the adding of products to cart with an explicit '0' price value [#747](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/747).
* Fixed issue with notes text areas trimming whitespace between keystrokes [#746](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/746).
* Fixed exception thrown when a stores "Use Cookies" setting was disabled [#745](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/745).
* Fixed an `OrderLines` naming inconsisency in payment refunds API [#742](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/742).

#### [16.2.2](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.2.2) (Aug 14th 2025)

* Fixed a rounding issue in order calculations [#744](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/744).
* Fixed issue when using MultipleTextstring as property editor for provider setting resulting in malformed data [#743](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/743).
* Fixed issue with date formatting / parsing due to server culture differences [#738](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/738).

#### 16.2.1 (29th Jul 2025)

* Fixed regression in 16.2.0 not containing updates from 16.1.1.
  
#### 16.2.0 (29th Jul 2025)

* Added `TryCalculatePriceWithAdjustmentsAsync` methods to allow calculating product prices with discounts up-front.
* Added Email Template Testing feature to allow testing email templates directly from the backoffice.

#### [16.1.1](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Acomponent%2Fcommerce+label%3Arelease%2F16.1.1) (18th Jul 2025)

* Updated order/orderline property label fallback behaviour to be constant in all usages [#733](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/733).
* Fixed location picker value being null in models builder model [#726](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/726).
* Fixed discount editor resetting start/end dates due to UTC data format mishandling [#728](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/728).
* Fixed issue where the product picker breaks when a product has no price defined [#730](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/730).
* Fixed issue when using MultipleTextstring as property editor for provider setting resulting in malformed data [#734](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/734).
* Fixed error in StorefrontAPI when trying to expand shipping/payment method models [#736](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/736).
* Fixed issue with StorefrontAPI displaying the payment method pricing for the shipping method [#736](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/736).
* Fixed issue with amount based discount rules not persisting decimal values.

#### [16.1.0](https://github.com/umbraco/Umbraco.Commerce.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Acomponent%2Fcommerce+label%3Arelease%2F16.1.0) (11th Jul 2025)

* Added store theming options to store settings.
* Added abandoned cart notifier service to send emails & webhooks when carts become abandoned.
* Fixed regression with not being able to refund a payment [#710](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/710).
* Fixed bug in Safari browsers not persisting price property updates [#713](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/713).
* Fixed bug with gift cards not persisting remaining amount [#729](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/729).

#### 16.0.0 (12th Jun 2025)

* Version 16 final release.
* Fixed bug in property editors with store config not resolving the correct store [#721](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/721).
* Fixed stock input allowing stock levels below zero [#714](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/714).
* Fixed bug in price property editor not honoring extra decimal places config [#712](https://github.com/umbraco/Umbraco.Commerce.Issues/issues/712).
  
#### 16.0.0-rc1 (28th May 2025)

Initial release candidate for Umbraco v16. This release doesn't contain any new features; rather, it's a v16 compatibility release.

* Updated to Umbraco CMS v16.
* Upgraded all third-party dependencies.
* Removed all obsolete code flagged for removal in v16.
