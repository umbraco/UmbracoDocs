---
title: Configure Umbraco
description: Documentation for the Nets Easy payment provider for Vendr, the eCommerce solution for Umbraco v8+
---

## Create Payment Method

In the Umbraco back-office, in the **Settings > Vendr > Stores > {Store Name} > Payment Methods** section, click the **Create Payment Method** button to create a new payment method, choosing **Nets Easy (One Time)** from the list of available payment providers.

![Create Payment Method](/media/screenshots/nets/umbraco_create_payment_method.png)

## Configure Payment Provider Settings

In the payment method editor, configure the standard payment method settings as required, then configure the Nets Easy payment provider settings as follows:

| Name | Description |
| ---- | ----------- |
| Continue URL | The URL of the page to navigate to after payment is successful - e.g. `/confirmation/` |
| Cancel URL | The URL of the page to navigate to if the customer cancels the payment - e.g. `/cart/` |
| Error URL | The URL of the page to navigate to if there is an error with the payment - e.g. `/error/` |
| Merchant ID | Merchant ID supplied by Nets during registration or can be found in Nets Easy portal. |
| Language | Language used in the payment window, e.g. da-DK or en-GB (default). |
| Accepted Payment Methods | The allowed payment methods in the payment window. |
| Terms URL | The URL to your terms and conditions. |
| Test Secret Key | Your test Nets secret key used in test mode. |
| Test Checkout Key | Your test Nets checkout key used in test mode.|
| Live Secret Key | Your live Nets secret key used in live mode. |
| Live Checkout Key | Your live Nets checkout key used in live mode. |
| Test Mode | Toggle indicating whether this provider should run in test mode. |
| Auto Capture | Toggle indicating whether to immediately capture the payment, or whether to authorize the payment for later (manual) capturing. |

The following languages can be used in Nets Easy:
[developers.nets.eu/nets-easy/en-EU/api/#localization](https://developers.nets.eu/nets-easy/en-EU/api/#localization)

![Create Payment Provider Settings](/media/screenshots/nets/umbraco_configure_nets-easy_settings.png)
