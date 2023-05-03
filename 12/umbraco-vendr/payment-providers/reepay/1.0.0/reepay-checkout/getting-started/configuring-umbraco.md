---
title: Configuring Umbraco
description: Documentation for the Reepay Checkout (One Time) payment provider for Vendr, the eCommerce solution for Umbraco v8+
---

## Create Payment Method

In the Umbraco back-office, in the **Settings > Vendr > Stores > {Store Name} > Payment Methods** section, click the **Create Payment Method** button to create a new payment method, choosing **Reepay Checkout (One Time)** from the list of available payment providers.

![Create Payment Method](/media/screenshots/reepay/umbraco_create_payment_method.png)

## Configure Payment Provider Settings

In the payment method editor, configure the standard payment method settings as required, then configure the Reepay payment provider settings as follows:

| Name | Description |
| ---- | ----------- |
| Continue URL | The URL of the page to navigate to after payment is successful - e.g. `/confirmation/` |
| Cancel URL | The URL of the page to navigate to if the customer cancels the payment - e.g. `/cart/` |
| Error URL | The URL of the page to navigate to if there is an error with the payment - e.g. `/error/` |
| Billing Company Property Alias | The alias of the property containing company name - e.g. company |
| Billing Address (Line 1) Property Alias | The alias of the property containing line 1 of the billing address - e.g. billingAddressLine1 |
| Billing Address (Line 2) Property Alias | The alias of the property containing line 2 of the billing address - e.g. billingAddressLine2 |
| Billing Address City Property Alias | The alias of the property containing the city of the billing address - e.g. billingCity |
| Billing Address ZipCode Property Alias | The alias of the property containing the zip code of the billing address - e.g. billingZipCode |
| Billing Address State Property Alias | The alias of the property containing the state of the billing address - e.g. billingState |
| Billing Address Phone Property Alias | The alias of the property containing the phone of the billing address - e.g. billingPhone |
| Private Key | The Reepay private key |
| Webhook Secret | The Reepay webhook secret |
| Locale | The locale/language used in the payment window |
| Accepted Payment Methods | Specify payment methods available in the payment window |
| Auto Capture | Toggle indicating whether to immediately capture the payment, or whether to authorize the payment for later (manual) capturing |

![Create Payment Provider Settings](/media/screenshots/reepay/umbraco_configure_reepay_settings.png)
