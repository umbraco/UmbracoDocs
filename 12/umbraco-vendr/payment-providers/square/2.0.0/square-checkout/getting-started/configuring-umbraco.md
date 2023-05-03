---
title: Configuring Umbraco
description: Documentation for the Square Checkout payment provider for Vendr, the eCommerce solution for Umbraco v8+
---

## Create Payment Method

In the Umbraco back-office, in the **Settings > Vendr > Stores > {Store Name} > Payment Methods** section, click the **Create Payment Method** button to create a new payment method, choosing **Square Checkout (One Time)** from the list of available payment providers.

![Create Payment Method](/media/screenshots/square/umbraco_create_payment_method.png)

## Configure Payment Provider Settings

In the payment method editor, configure the standard payment method settings as required, then configure the Square payment provider settings as follows:

| Name | Description |
| ---- | ----------- |
| Continue URL | The URL of the page to navigate to after payment is successful - e.g. `/confirmation/` |
| Location ID  | The ID of the business location to associate the checkout with. The default is LTN1NC5CCYASX |
| Sandbox Access Token | The access token for the Sandbox environment |
| Sandbox Webhook Signing Secret | The webhook signing secret for the Sandbox environment |
| Live Access Token | The access token for the Live environment |
| Live Webhook Signing Secret | The webhook signing secret for the Live environment |
| Sandbox Mode | Set whether to process payments in Sandbox mode |

![Create Payment Provider Settings](/media/screenshots/square/umbraco_configure_provider_settings.png)
