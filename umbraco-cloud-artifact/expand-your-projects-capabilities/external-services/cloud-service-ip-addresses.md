---
description: >-
  The static IP ranges Umbraco Cloud's own services use when connecting to your
  systems. Allowlist them to let Cloud services through IP-based firewalls.
---

# Umbraco Cloud Service IP Addresses

{% hint style="info" %}
This page covers the IP addresses used by **Umbraco Cloud's own services** that connect to your environment. Allowlist these in your firewall to enable Umbraco Cloud services to keep reaching your site.

Are you looking for your project's own outbound IP addresses to share with an external service? See [External Services](README.md).
{% endhint %}

The IPs listed in this article are used when Umbraco Cloud’s services connect to your projects. They are not your project’s IPs.

## Allowlisting IP Addresses

To ensure uninterrupted access and functionality, allowlist the global and regional services IP addresses. Use the regional IP addresses from the region where your website is hosted.

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

**Sweden**
```
20.240.239.160/28
```

**United Kingdom**
```
20.68.233.144/28
```

**United States**
```
4.227.135.208/28
```

Ensure that these IP ranges are added to your firewall's allowlist to maintain seamless connectivity with Umbraco Cloud services.

## Related Information

For information about product upgrades and their impact on your Cloud services, see [Product Upgrades](../../optimize-and-maintain-your-site/manage-product-upgrades/product-upgrades/).
