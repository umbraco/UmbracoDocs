---
title: Changelog
description: Changelog for the Klarna Payment Provider for Vendr, the eCommerce solution for Umbraco v8+
---

## v2.0.3   
**Date:** 2022-08-31   
**Description:** Patch release with minor bug fixes / enhancements 

---  

<changelog>
<changelog-group category="Fixed">  

    
* Fixed bug where discounts/surcharges assumed the tax rate was that of the order resulting in a Klarna error. Tax rate is now dynamically calculated based on the cumulative adjustment amount.


</changelog-group>
</changelog>

## v2.0.2   
**Date:** 2022-08-22   
**Description:** Patch release with minor bug fixes / enhancements 

---  

<changelog>
<changelog-group category="Fixed">  

    
* Fixed bug where hard coded strings were not translatable. Strings are now advanced options in the payment provider settings.


</changelog-group>
</changelog>

## v2.0.1   
**Date:** 2022-07-06   
**Description:** Patch release with minor bug fixes / enhancements 

---  

<changelog>
<changelog-group category="Fixed">  

    
* Fixed bug where cart would error if there was a 100% discount on shipping price.


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

## v0.2.0   
**Date:** 2020-12-10    
**Description:** Breaking change update targeting Vendr 1.4.0 

---  

<changelog>
<changelog-group category="Breaking">  

    
* Payment provider now uses new `TransactionAmount` from Vendr 1.4.0.


</changelog-group>
</changelog>

## v0.1.0  
**Date:** 2020-08-14   
**Description:** Initial pre-release of the Klarna Payment Provider 