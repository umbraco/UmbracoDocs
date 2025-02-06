---
description: Learn how to configure a cart cleanup routine.
---

# Configuring Cart Cleanup

{% hint style="info" %}
Available from Umbraco Commerce 15.1.0
{% endhint %}

By default Umbraco Commerce will keep all created carts indefinately. Over time this can obviously become an issue. To assist with this is it possible to configure a cart cleanup routine to delete carts older than a pre-configured time interval.

This service can be enabled and configured in the `appSettings.json`

```json
{
    "Umbraco" : {
        "Commerce": {
            "CartCleanupPolicy": {
                "EnableCleanup": true,
                "KeepCartsForDays": 800,
                // Below settings are optional
                "FirstRunTime": string; the time to first run the scheduled cleanup task, in crontab format
                "Period": string; how often to run the task, in timespan format
                // Configure diffrent policies per store
                "PerStorePolicies": {
                    "StoreAlias": {
                        "KeepCartsForDays": 800,
                    }
                }
            }
        }
    }
}
```

## Cart Conversion Rates Widget

When enabling the cart cleanup service, it's important to know that this can affect the cart conversion rates widget in the analytics section. If the widget is configured to show a time period that exceeds the cleanup policies time frame then a warning will be displayed.

![Cart Conversion Rate date range exceeds the cart cleanup policy configuration warning](../media/v14/cart-conversion-rates-warning.png)



