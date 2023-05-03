---
title: Changelog
description: Changelog for the Mollie Payment Provider for Vendr, the eCommerce solution for Umbraco v8+
---

## v2.0.2   
**Date:** 2023-03-28   
**Description:** Patch release with minor bug fixes / enhancements 

---  

<changelog>
<changelog-group category="Added">  

    
* Added refund, cancel and capture support via the back office.
* Added Mollie order ID and selected payment method to transaction meta data log.


</changelog-group>
<changelog-group category="Changed">  

    
* Upgraded `Mollie.Api` to 2.2.0.4.


</changelog-group>
<changelog-group category="Fixed">  

    
* Fixed pending orders not being finalized because Mollie doesn't send a webhook request until payment is confirmed. Order is now finalized during the redirect routine.


</changelog-group>
</changelog>

## v2.0.1   
**Date:** 2022-01-27   
**Description:** Patch release with minor bug fixes / enhancements 

---  

<changelog>
<changelog-group category="Fixed">  

    
* Fixed issue with webhooks updating orders that haven't actually finalized due to Mollie sending notifications in a weird way ([#6](https://github.com/vendrhub/vendr-payment-provider-mollie/issues/6)).


</changelog-group>
</changelog>

## v2.0.0  
**Date:** 2021-10-07  
**Description:** Initial release of the Mollie Payment Provider  
