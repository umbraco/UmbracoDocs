---
description: >-
  Umbraco Cloud services access external applications with static outbound IP addresses.
  This enables you to allowlist Cloud services in IP-based firewalls.
---

# Static Outbound IP Addresses for Umbraco Cloud

Umbraco Cloud services access external applications using static outbound IP addresses. This enables you to allowlist Cloud services in IP-based firewalls. This is particularly useful if you wish to control access to your website based on IP addresses.

{% hint style="warning" %}

Changing plans (topology changes)
When you change your Umbraco Cloud project's plan — for example, moving from Shared to Dedicated or between Dedicated tiers — the static outbound IP addresses may temporarily not be applied. During the transition, outbound traffic from your project can originate from an IP address that is not in your project's static outbound IP range.
If your solution connects to external services that whitelist traffic by IP address (such as external SQL databases or third-party APIs), this can cause connection failures during and briefly after the plan change.
To avoid downtime, we recommend temporarily opening your external firewall rules to allow traffic from any source before initiating the plan change, and then restricting back to the static outbound IPs once the transition is complete and you have verified connectivity.

{% endhint %}

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
