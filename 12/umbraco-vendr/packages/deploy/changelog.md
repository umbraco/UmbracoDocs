---
title: Changelog
description: Changelog for the Deploy package for Vendr, the eCommerce solution for Umbraco.
---

## v3.1.0   
**Date:** 2023-01-16    
**Description:** Minor release targeted with some breaking changes

---  

<changelog>
<changelog-group category="Added">  

* Added ability to ignore payment provider settings on import as well as export.

</changelog-group>
<changelog-group category="Breaking">  

* Retargeted for Umbraco v11+

</changelog-group>
</changelog>

## v3.0.0   
**Date:** 2022-09-29    
**Description:** Major release targeted for Vendr v3

---  

<changelog>
<changelog-group category="Added">  

* Added ability to deploy Product Attributes + Product Attribute Presets through the transfer queue.

</changelog-group>
<changelog-group category="Changed">  

* Most dependency checks now just check if the entity exists rather than for exact matches.

</changelog-group>
<changelog-group category="Breaking">  

* Dropped Umbraco v8 and v9 support
* Retargeted for Umbraco v10+

</changelog-group>
</changelog>

## v2.0.2   
**Date:** 2022-06-29    
**Description:** Minor release containing feature updates and bug fixes 

---  

<changelog>
<changelog-group category="Added">  

* Added support for app settings config to ignore certain payment method settings from being transfered.

</changelog-group>
</changelog>

## v2.0.1   
**Date:** 2021-12-01    
**Description:** Minor release containing feature updates and bug fixes 

---  

<changelog>
<changelog-group category="Added">  

* Registered UDI types for Umbraco v9

</changelog-group>
</changelog>


## v2.0.0   
**Date:** 2021-10-07    
**Description:** Major release with breaking changes

---  

<changelog>
<changelog-group category="Breaking">  

* Updated Umbraco dependency of 9.0.0
* Updated Vendr dependency of 2.0.0.

</changelog-group>
</changelog>

## v0.3.0   
**Date:** 2021-05-10   
**Description:** Minor release containing feature updates and bug fixes 

---  

<changelog>
<changelog-group category="Added">  

* Added export templates support.

</changelog-group>
<changelog-group category="Breaking">  

* Updated Vendr dependency of 1.8.0.

</changelog-group>
</changelog>

## v0.2.1   
**Date:** 2021-04-12   
**Description:** Minor patch release containing bug fixes 

---  

<changelog>
<changelog-group category="Fixed">  

* Fixed bug with Product Attributes not being transferred with Product Variants.

</changelog-group>
</changelog>

## v0.2.0   
**Date:** 2021-04-08   
**Description:** Minor release containing feature updates and bug fixes 

---  

<changelog>
<changelog-group category="Added">  

* Added print templates support.
* Added variants editor value connector to support deploying connected Product Attributes.

</changelog-group>
<changelog-group category="Breaking">  

* Updated Vendr dependency of 1.6.0.

</changelog-group>
</changelog>

## v0.1.0   
**Date:** 2020-12-21    
**Description:** Minor patch release containing bug fixes 

---  

<changelog>
<changelog-group category="Fixed">  

    
* Fixed issue with `EmailTemplateServiceConnector` not serializing/deserializing `SendToCustomer` flag.


</changelog-group>
</changelog>

## v0.1.0 
**Date:** 2020-09-28  
**Description:** Initial release of the Vendr Deploy Package  