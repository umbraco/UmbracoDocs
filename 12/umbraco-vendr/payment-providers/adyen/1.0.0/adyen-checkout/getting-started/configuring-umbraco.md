---
title: Configuring Umbraco
description: Documentation for the Adyen Checkout (One Time) payment provider for Vendr, the eCommerce solution for Umbraco v8+
---

## Create Payment Method

In the Umbraco back-office, in the **Settings > Vendr > Stores > {Store Name} > Payment Methods** section, click the **Create Payment Method** button to create a new payment method, choosing **Adyen Checkout (One Time)** from the list of available payment providers.

![Create Payment Method](/media/screenshots/adyen/umbraco_create_payment_method.png)

## Configure Payment Provider Settings

In the payment method editor, configure the standard payment method settings as required, then configure the Adyen payment provider settings as follows:

| Name | Description |
| ---- | ----------- |
| Continue URL | The URL of the page to navigate to after payment is successful - e.g. `/confirmation/` |
| Cancel URL | The URL of the page to navigate to if the customer cancels the payment - e.g. `/cart/` |
| Error URL | The URL of the page to navigate to if there is an error with the payment - e.g. `/error/` |
| Merchant Account | The test Adyen merchant account |
| API Key | The account specific Adyen API key |
| HMAC Key | HEX encoded key for notification event |
| Notification Username | The username for the notification event |
| Notification Password | The password for the notification event |
| Accepted Payment Methods | The allowed payment methods in the payment window |
| Test Mode | Toggle indicating whether this provider should run in test mode |

![Create Payment Provider Settings](/media/screenshots/adyen/umbraco_configure_adyen_settings.png)
