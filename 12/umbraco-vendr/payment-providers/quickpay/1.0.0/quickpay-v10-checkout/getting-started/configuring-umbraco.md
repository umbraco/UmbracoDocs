---
title: Configuring Umbraco
description: Documentation for the QuickPay V10 (One Time) payment provider for Vendr, the eCommerce solution for Umbraco v8+
---

## Create Payment Method

In the Umbraco back-office, in the **Settings > Vendr > Stores > {Store Name} > Payment Methods** section, click the **Create Payment Method** button to create a new payment method, choosing **QuickPay V10 (One Time)** from the list of available payment providers.

![Create Payment Method](/media/screenshots/quickpay/umbraco_create_payment_method.png)

## Configure Payment Provider Settings

In the payment method editor, configure the standard payment method settings as required, then configure the QuickPay payment provider settings as follows:

| Name | Description |
| ---- | ----------- |
| Continue URL | The URL of the page to navigate to after payment is successful - e.g. `/confirmation/` |
| Cancel URL | The URL of the page to navigate to if the customer cancels the payment - e.g. `/cart/` |
| Error URL | The URL of the page to navigate to if there is an error with the payment - e.g. `/error/` |
| API Key | The QuickPay API key |
| Private Key | The QuickPay private key |
| Merchant ID | The Merchant ID for the QuickPay account |
| Agreement ID | The Agreement ID for the QuickPay account |
| Language | The language shown in the payment window |
| Accepted Payment Methods | Specify payment methods available in the payment window |
| Auto Fee |Toggle indicating whether to automatically calculate and apply the fee from the acquirer |
| Auto Capture | Toggle indicating whether to immediately capture the payment, or whether to authorize the payment for later (manual) capturing |

![Create Payment Provider Settings](/media/screenshots/quickpay/umbraco_configure_quickpay_settings.png)
