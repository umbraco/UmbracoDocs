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

This section contains the release notes for Umbraco Commerce 13 including all changes for this version.

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

Read the [v13.1.0-RC release post](./v13.1.0-rc.md) for further background on this release.

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

You can find the release notes for **Vendr** in the [Change log file on Github](changelog-archive/Vendr-core.md).
