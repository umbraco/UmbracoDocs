---
description: >-
  Umbraco Cloud services access external applications with static outbound IP addresses.
  This enables you to whitelist cloud services in IP based firewalls.
---

# Static Outbound IP Addresses for Umbraco Cloud

Umbraco Cloud services access external applications with static outbound IP addresses. This enables you to allow-list cloud services in IP based firewalls. This is particularly useful if you wish to control access to your website based on IP addresses.

## Whitelisting IP Addresses

To ensure uninterrupted access and functionality allow-list the global and regional services IP addresses. Use the regional IP addresses from the region where your website is hosted.

### Global Services

```
4.180.158.192/28
```

### Regional Services

Below are the static outbound IP address ranges for regions:

**Europe**
```
4.180.157.208/28
```

**Australia**
```
4.197.15.208/28
```

**Canada**
```
20.220.219.208/28
```

**United Kingdom**
```
20.68.233.144/28
```

**United States**
```
4.227.135.208/28
```

Ensure that these IP ranges are added to your firewall's allow list to maintain seamless connectivity with Umbraco Cloud services.

## Related Information

For information about product upgrades and their impact on your Cloud services, see [Product Upgrades](../../optimize-and-maintain-your-site/manage-product-upgrades/product-upgrades/).
