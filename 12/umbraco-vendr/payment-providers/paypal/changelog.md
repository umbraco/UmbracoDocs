---
title: Changelog
description: Changelog for the PayPal Payment Provider for Vendr, the eCommerce solution for Umbraco v8+
---

## v2.0.1   
**Date:** 2022-01-27   
**Description:** Patch release with minor bug fixes / enhancements 

---  

<changelog>
<changelog-group category="Added">  

    
* Added order line descriptions.


</changelog-group>
<changelog-group category="Fixed">  

    
* Fixed issue with Webhook parser looking for request headers in the wrong location.


</changelog-group>
</changelog>

## v2.0.0   
**Date:** 2021-10-07   
**Description:** Major new release with breaking changes

---  

<changelog>
<changelog-group category="Breaking">  

    
* Rebuilt for Vendr 2.0.0.


</changelog-group>
</changelog>

## v1.1.1  
**Date:** 2021-07-22    
**Description:** Patch release with minor bug fixes / enhancements 

---  

<changelog>
<changelog-group category="Fixed">  

    
* Fixed decimal parsing issue by adding invariant culture to parser  ([#3](https://github.com/vendrhub/vendr-payment-provider-paypal/issues/3)).


</changelog-group>
</changelog>

## v1.1.0   
**Date:** 2020-12-10    
**Description:** Breaking change update targeting Vendr 1.4.0 

---  

<changelog>
<changelog-group category="Breaking">  

    
* Payment provider now uses new `TransactionAmount` from Vendr 1.4.0.


</changelog-group>
</changelog>

## v1.0.3  
**Date:** 2020-07-10  
**Description:** Patch release with minor bug fixes / enhancements 

--- 

<changelog>
<changelog-group category="Added">  

    
* Added support for listening for all Payment related webhooks to ensure the payment status is kept in sync.


</changelog-group>
<changelog-group category="Fixed">  

    
* Fixed bug where cancel action was capturing payment.


</changelog-group>
</changelog>

## v1.0.2  
**Date:** 2020-04-24  
**Description:** Patch release with minor bug fixes / enhancements 

--- 

<changelog>
<changelog-group category="Added">  

    
* Added check to ensure currency code is ISO4217 compatible.
* Added required meta data to Umbraco package file.


</changelog-group>
</changelog>

## v1.0.1  
**Date:** 2020-04-09  
**Description:** Change of PayPal settings  

--- 

<changelog>
<changelog-group category="Breaking">  

    
* Removed the mode dropdown in favour of a "Sandbox Mode" checkbox as this is the standard we have been implementing in other providers.


</changelog-group>
</changelog>

## v1.0.0  
**Date:** 2020-03-30  
**Description:** Initial Vendr PayPal Payment Provider release  
