---
description: Learn how to configure the abandoned cart notification.
---

# Configuring Abandoned Cart Notification

{% hint style="info" %}
Available from Umbraco Commerce 16.1.0
{% endhint %}

## Abandoned Cart Recurring Background Job

The abandoned cart recurring background job automatically sends reminder emails to customers about items left in their shopping carts. To configure it, follow these steps:
1. Go to **Store Settings** in your admin dashboard.
2. Select the store you want to configure.
3. Navigate to the **Cart Settings** section.
4. Choose your **Abandoned Cart Email Template**. If the email template is not set, no notification will be sent; however, webhooks can still be triggered.
5. Set the number of minutes that a cart must be inactive before it is considered abandoned. If the value is 0, the abandoned cart detection is disabled.
6. Enter the landing page URL where customers will be redirected when they click the links in the abandoned cart email.
7. Click the **Save** button to apply your changes.

![store notification settings](images/configuring-abandoned-cart-notification/store-notification-settings.png)


The advanced settings can be configured in the `appsettings.json`

```json
{
    "Umbraco" : {
        "Commerce": {
            "AbandonedCartNotifierService": {
                "Enable": false, // Set to true if you want to enable the background job
                "FirstRunTime": "", // Optional settings
                "Period": "1.00:00:00", // Optional settings
                "NotificationBatchSize": 20, // Optional settings
            }
        }
    }
}
```

The `appsettings.json` section supports the following keys.

| Key | Description |
| -- | -- |
| `Enable` | Enable this feature.
| `FirstRunTime` | The time to first run the scheduled cleanup task, in crontab format. If empty, runs imediately on app startup. |
| `Period` | How often to run the task, in timespan format. Defaults to every 24 hours. |
| `NotificationBatchSize` | The number of abandoned carts processed each time the job is run. |

## Abandoned Cart Webhook
A new webhook called Cart Abandoned has been added. It is triggered when the Abandoned Cart Recurring Background Job detects any abandoned carts. The POST payload will look like this:
```json
{
  "orderIds": [
    "8b2cfad6-a0eb-4b87-ad86-019768ad1308",
    "95aa34bd-8a01-45a4-9492-019768ac6c61",
    "db9a2cc5-621a-40a3-9fab-019768a79d0a"
  ]
}
```

## Abandoned Cart Conversion Rates Widget

The widget shows how many notified abandoned carts are recovered through completed purchases, reflecting your store’s abandoned cart conversion rate.

![Abandoned cart conversion rates widget](images/configuring-abandoned-cart-notification/abandoned-cart-conversion-rates-widget.png)
