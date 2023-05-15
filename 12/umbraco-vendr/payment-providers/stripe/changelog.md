---
title: Changelog
description: Changelog for the Stripe Payment Provider for Vendr, the eCommerce solution for Umbraco v8+
---

## v2.1.0   
**Date:** 2022-03-06   
**Description:** Minor update with Stripe Software Development Kit (SDK) dependency upgrade

---  

<changelog>
<changelog-group category="Added">  

    
* Added Locale to Stripe order for localizing Stripe UI / emails.


</changelog-group>
<changelog-group category="Changed">  

*  Updated Stripe SDK dependency to v41 ([#12](https://github.com/vendrhub/vendr-payment-provider-stripe/pull/12)).

</changelog-group>
</changelog>

## v2.0.1   
**Date:** 2021-10-18   
**Description:** Bug fixes and minor enhancements 

---  

<changelog>
<changelog-group category="Fixed">  

    
* Fixed regression due to search and replace in meta data fields sent to Stripe.


</changelog-group>
<changelog-group category="Changed">  

*  Changed the webhook processing to parse the request as stream so it can be reset before attempting to read.

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

## v1.2.1   
**Date:** 2021-03-24    
**Description:** Bug fixes and minor enhancements 

---  

<changelog>
<changelog-group category="Added">  

    
* Added ability to configure the Stripe payment method types to use ([#6](https://github.com/vendrhub/vendr-payment-provider-stripe/issues/6)).


</changelog-group>
<changelog-group category="Fixed">  

    
* Fixed issue when using subscriptions not taking tax into account. A Stripe Tax Rate is now created based on the subscription items order line tax rate.


</changelog-group>
</changelog>

## v1.2.0   
**Date:** 2020-12-10    
**Description:** Breaking change update targeting Vendr 1.4.0 

---  

<changelog>
<changelog-group category="Breaking">  

    
* Payment provider now uses new `TransactionAmount` from Vendr 1.4.0.


</changelog-group>
</changelog>

## v1.1.0   
**Date:** 2020-06-23  
**Description:** Minor release with Subscription payments support  

---  

<changelog>
<changelog-group category="Added">  

    
* Added new Stripe Checkout payment provider that supports both one time and subscription payments.


</changelog-group>
<changelog-group category="Changed">  

* Deprecated the Stripe Checkout (One time) payment provider as the new payment provider can handle both one time and subscription checkouts.

</changelog-group>
</changelog>

## v1.0.0  
**Date:** 2020-03-30  
**Description:** Initial release of the Stripe Payment Provider  
