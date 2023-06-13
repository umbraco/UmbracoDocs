---
description: Changelog for the Checkout package for Vendr.
---

# Changelog

## v3.1.0

**Date:** 2023-03-08\
**Description:** Minor version release

* Vendr Checkout composer is now set to compose after the Vendr composer.
* Vendr Checkout is now compiled against Umbraco v11 and .NET 7
* Vendr Checkout confirmation email showing payment/shipping fees with tax when all other prices are without tax.
* The Vendr Checkout confirmation email incorrectly shows the payment country in place of the shipping country.

## v3.0.0

**Date:** 2022-10-05\
**Description:** Major version release

***

* Updated to use Vendr v3 APIs.

## v2.1.2

**Date:** 2022-08-05\
**Description:** Patch release with minor bug fixes

***

* Fixed bug in Umbraco v10 when triggering an install causes an exception due to the base interface of the `IContentService` changing.

## v2.1.1

**Date:** 2022-03-01\
**Description:** Patch release with minor bug fixes

***

* Fixed issue with `IsAjaxRequest` reading `Request.Form` without checking the current request has form data and thus causing an error.
* Updated maximum supported Umbraco version to v10.

## v2.1.0

**Date:** 2022-03-01\
**Description:** Minor release with some core refactoring

***

* Added required validation to shipping fields when the shipping address is different from the billing address.
* Added placeholders to country and region dropdowns so no value is auto-selected.
* Switched from an externally hosted Tailwind CSS file to a locally built and purged file of only the CSS used.
* Updated to the latest Tailwind CSS color scheme.
* Removed the use of font-awesome in favor of some embedded SVGs instead.
* Removed the use of `SSM.js` for responsive JavaScript as it wasn't really necessary.
* Removed the use of jQuery entirely in favor of vanilla JavaScript so that no external JS dependency is required.
* Switched the logo picker on the checkout Document Type to an Image Media Picker.
* Updated order summary to use the `TransactionAmount` value rather than `TotalPrice` which doesn't show gift card adjustments.
* Updated order summary to show address regions when present.
* Updated shipping/payment method selection screens to take regions into account when looking up options.

## v2.0.1

**Date:** 2021-10-22\
**Description:** Patch release with minor bug fixes

***

* Fixed bug with doc types pipeline task failing due to changes in the Document Type structure due to the tabs update.

## v2.0.0

**Date:** 2021-10-07\
**Description:** Major new release with breaking changes

***

* Updated to work with Vendr 2.0.0 the dual-targeted v8/v9 release.

## v1.2.0

**Date:** 2020-12-10\
**Description:** Breaking change update targeting Vendr 1.4.0

***

* Updated to use new price/amount adjustments from Vendr 1.4.0.

## 1.1.8

**Date:** 2020-11-27\
**Description:** Patch release with minor bug fixes

***

* Discount code errors now display next to the discount code field [#11](https://github.com/vendrhub/vendr-checkout/issues/11).

## 1.1.7

**Date:** 2020-10-13\
**Description:** Patch release with minor bug fixes/enhancements

***

* Added support for JSON-based requests on the API controllers.
* Added support for bypassing Vendr Checkout logic if a template is provided on the checkout Document Type.
* Added support for optional `VendrCheckout:ResetPaymentMethodOnShippingMethodChange` app setting to display resetting payment method on shipping method change.

## 1.1.6

**Date:** 2020-09-21\
**Description:** Patch release with minor bug fixes/enhancements

***

* Added ability to display regions if there are available for country [#8](https://github.com/vendrhub/vendr-checkout/issues/8).
* Updated payment method/shipping method selection screens to only show options allowed in the payment/shipping country [#7](https://github.com/vendrhub/vendr-checkout/issues/7).
* Updated payment method/shipping method selection screens to auto-select the default method of the payment/shipping country.
* Fixed error when installing Umbraco.Commerce.Checkout into a second store in the same instance [#9](https://github.com/vendrhub/vendr-checkout/issues/9).

## 1.1.5

**Date:** 2020-07-10\
**Description:** Patch release with minor bug fixes/enhancements

* Added redirect to the back page if there is no current order.
* Fixed broken image link on the install dashboard.

## 1.1.4

**Date:** 2020-06-12\
**Description:** Path release with minor bug fixes/enhancements

* Fixed more null reference exceptions in the SyncZeroValuePaymentProviderContinueUrl logic.

## 1.1.3

**Date:** 2020-06-10\
**Description:** Patch release with minor bug fixes/enhancements

***

* Removed the use of instant.pages as it's not relevant for the checkout process.

## 1.1.2

**Date:** 2020-06-05\
**Description:** Patch release with minor bug fixes/enhancements

* Added anti-forgery tokens to HTTP post requests.
* Added IP Address to order properties.
* Added the ability to customize the root path of the view helper so that you can change where views are searched for.
* Fixed some null reference exceptions in the SyncZeroValuePaymentProviderContinueUrl logic.

## 1.1.1

**Date:** 2020-06-02\
**Description:** Patch release with minor bug fixes/enhancements

* Fixed issue with the 1.1.0 release having the wrong Vendr NuGet dependency.

## 1.1.0

**Date:** 2020-06-02\
**Description:** Minor release with new features and some minor bug fixes/enhancements

* Added gift card support.
* Improved install script to try and add any missing Document Type properties if the Document Type already exists.
* Improved install script to try and add any missing Data Type settings if the Data Type already exists.

## 1.0.0

**Date:** 2020-05-08\
**Description:** Initial release of the Vendr Checkout Package
