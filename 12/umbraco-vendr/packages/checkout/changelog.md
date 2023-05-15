---
title: Changelog
description: Changelog for the Checkout package for Vendr, the eCommerce solution for Umbraco v8+
---

## v3.1.0

**Date:** 2023-03-08  
**Description:** Minor version release

---  

<changelog>
<changelog-group category="Updated">  

* Vendr Checkout composer is now set to compose after the Vendr composer.
* Vendr Checkout now compiled against Umbraco v11 and .NET 7

</changelog-group>
<changelog-group category="Fixed">  

* Vendr Checkout confirmation email showing payment/shipping fees with tax when all other prices are without tax.
* Vendr Checkout confirmation email incorrectly showing payment country in place of shipping country.

</changelog-group>
</changelog>

## v3.0.0  
**Date:** 2022-10-05  
**Description:** Major version release

---  

<changelog>
<changelog-group category="Updated">  

* Updated to use Vendr v3 APIs.

</changelog-group>
</changelog>

## v2.1.2  
**Date:** 2022-08-05  
**Description:** Patch release with minor bug fixes 

---  

<changelog>
<changelog-group category="Fixed">  

* Fixed bug in Umbraco v10 when triggering an install causes an exception due to the base interface of the `IContentService` changing.

</changelog-group>
</changelog>

## v2.1.1   
**Date:** 2022-03-01  
**Description:** Patch release with minor bug fixes 

---  

<changelog>
<changelog-group category="Fixed">  

* Fixed issue with `IsAjaxRequest` reading `Request.Form` without checking the current request has form data and thus causing an error.
* Updated maximum supported Umbraco versiont to v10.

</changelog-group>
</changelog>

## v2.1.0   
**Date:** 2022-03-01  
**Description:** Minor release with some core refactoring

---  

<changelog>
<changelog-group category="Added">  

* Added required validation to shipping fields when shipping address is different to billing address.
* Added placeholders to country and region dropdowns so no value is auto selected.

</changelog-group>
<changelog-group category="Changed">  

* Switched from an externally hosted Tailwind CSS file to a locally built and purged file of only the CSS used.
* Updated to the latest Tailwind CSS colour scheme.
* Removed the use of font-awesome in favour of a some embedded SVGs instead.
* Removed the use of `SSM.js` for responsive javascript as it wasn't really necesarry.
* Removed the use of jQuery entirely in favour of vanilla javascript so that no external JS dependency is required.
* Switched the logo picker on the checkout doc type to be an Image Media Picker.
* Updated order summary to use the `TransactionAmount` value rather than `TotalPrice` which doesn't show gift card adjustments.
* Updated order summary to show address regions when present.
* Updated shipping / payment method selection screens to take regions into account when looking up options.

</changelog-group>
</changelog>

## v2.0.1   
**Date:** 2021-10-22  
**Description:** Patch release with minor bug fixes 

---  

<changelog>
<changelog-group category="Fixed">  

* Fixed bug with doc types pipeline task failing due to changes in the doc type structure due to the tabs update.

</changelog-group>
</changelog>

## v2.0.0   
**Date:** 2021-10-07   
**Description:** Major new release with breaking changes

---  

<changelog>
<changelog-group category="Breaking">  

* Updated to work with Vendr 2.0.0 the dual targeted v8/v9 release.

</changelog-group>
</changelog>


## v1.2.0   
**Date:** 2020-12-10    
**Description:** Breaking change update targeting Vendr 1.4.0 

---  

<changelog>
<changelog-group category="Breaking">  

    
* Updated to use new price / amount adjustments from Vendr 1.4.0.


</changelog-group>
</changelog>

## 1.1.8 
**Date:** 2020-11-27  
**Description:** Patch release with minor bug fixes 

---
<changelog>
<changelog-group category="Fixed">  

* Discount code errors now display next to the discount code field [#11](https://github.com/vendrhub/vendr-checkout/issues/11).

</changelog-group>
</changelog>

## 1.1.7 
**Date:** 2020-10-13  
**Description:** Patch release with minor bug fixes / enhancements

---
<changelog>
<changelog-group category="Added">  

* Added support for JSON based requests on the API controllers.
* Added support for bypassing Vendr Checkout logic if a template is provided on the checkout document type.
* Added support for optional `VendrCheckout:ResetPaymentMethodOnShippingMethodChange` app setting to display resetting payment method on shipping method change.

</changelog-group>
</changelog>

## 1.1.6 
**Date:** 2020-09-21  
**Description:** Patch release with minor bug fixes / enhancements  

---

<changelog>
<changelog-group category="Added">  

* Added ability to display regions if there are available for a country [#8](https://github.com/vendrhub/vendr-checkout/issues/8).  

</changelog-group>
<changelog-group category="Changed">  

* Updated payment method / shipping method selection screens to only show options allowed in the payment / shipping country [#7](https://github.com/vendrhub/vendr-checkout/issues/7).
* Updated payment method / shipping method selection screens to auto select the default method of the payment / shipping country.

</changelog-group>
<changelog-group category="Fixed">  

* Fixed error when installing Vendr.Checkout into a second store in the same instance [#9](https://github.com/vendrhub/vendr-checkout/issues/9).

</changelog-group>
</changelog>

## 1.1.5 
**Date:** 2020-07-10  
**Description:** Patch release with minor bug fixes / enhancements 

---  

<changelog>
<changelog-group category="Added">  

* Added redirect to back page if there is no current order.

</changelog-group>
<changelog-group category="Fixed">  

* Fixed broken image link on install dashboard.

</changelog-group>
</changelog>

## 1.1.4 
**Date:** 2020-06-12  
**Description:** Path release with minor bug fixes / enhancements 

---  

<changelog>
<changelog-group category="Changed">  

* Fixed more null reference exceptions in the SyncZeroValuePaymentProviderContinueUrl logic.

</changelog-group>
</changelog>

## 1.1.3 
**Date:** 2020-06-10  
**Description:** Patch release with minor bug fixes / enhancements 

---  

<changelog>
<changelog-group category="Changed">  

* Removed the use of instant.pages as it's not relevant for the checkout process.

</changelog-group>
</changelog>

## 1.1.2 
**Date:** 2020-06-05  
**Description:** Patch release with minor bug fixes / enhancements 

---  

<changelog>
<changelog-group category="Added">  

* Added anti-forgery tokens to http post requests.
* Added IP Address to order properties.
* Added the ability to customize the root path of the view helper so that you can change where views are searched for.

</changelog-group>
<changelog-group category="Fixed">  

* Fixed some null reference exceptions in the SyncZeroValuePaymentProviderContinueUrl logic.

</changelog-group>
</changelog>

## 1.1.1 
**Date:** 2020-06-02  
**Description:** Patch release with minor bug fixes / enhancements 

---  

<changelog>
<changelog-group category="Fixed">  

* Fixed issue with 1.1.0 release having the wrong Vendr NuGet dependency.

</changelog-group>
</changelog>

## 1.1.0 
**Date:** 2020-06-02  
**Description:** Minor release with new features and some minor bug fixes / enhancements 

---  

<changelog>
<changelog-group category="Added">  

* Added gift cards support.

</changelog-group>
<changelog-group category="Changed">  

* Improved install script to try and add any missing doc type properties if the doc type already exists.
* Improved install script to try and add any missing data type settings if the data type already exists.

</changelog-group>
</changelog>

## 1.0.0 
**Date:** 2020-05-08  
**Description:** Initial release of the Vendr Checkout Package  