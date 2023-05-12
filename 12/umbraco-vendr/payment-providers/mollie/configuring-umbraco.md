---
title: Configuring Umbraco
description: Documentation for the Mollie (One Time) payment provider for Vendr, the eCommerce solution for Umbraco v8+
---

## Configure Order Rounding Settings

Before you create a payment method for Mollie, it's important to know that this payment provider will only work when order rounding settings are set to round at the **order lin level** level. You can configure this is your store settings by setting the **Order Rounding Method** to **Line**.

## Create Payment Method

In the Umbraco backoffice, in the **Settings > Vendr > Stores > {Store Name} > Payment Methods** section, click the **Create Payment Method** button to create a new payment method, choosing **Mollie (One Time)** from the list of available payment providers.

![Create Payment Method](../media/mollie/umbraco_create_payment_method.png)

## Configure Payment Provider Settings

In the payment method editor, configure the standard payment method settings as required, then configure the Mollie payment provider settings as follows:

| Name | Description |
| ---- | ----------- |
| Continue URL | The URL of the page to navigate to after payment is successful - e.g. `/confirmation/` |
| Cancel URL | The URL of the page to navigate to if the customer cancels the payment - e.g. `/cart/` |
| Error URL | The URL of the page to navigate to if there is an error with the payment - e.g. `/error/` |
| Billing Address (Line 1) Property Alias | The alias of the property containing line 1 of the billing address - for example addressLine1. |
| Billing Address City Property Alias | The alias of the property containing the city of the billing address - for example city. |
| Billing Address State Property Alias | The alias of the property containing the state of the billing address - for example state. |
| Billing Address Zip Code Property Alias | The alias of the property containing the zip code of the billing address - for example zip. |
| Test API Key | The test Mollie API key |
| Live API Key | The live Mollie API key |
| Test Mode | Toggle indicating whether this provider should run in test mode |

An addition to these core settings, there are also a number of optional advanced settings you can configure as follows:

| Name | Description |
| ---- | ----------- |
| Locale | The locale to display the payment provider portal in. |
| Payment Methods | A comma separated list of payment methods to limit the payment method selection screen by. Can be 'applepay', 'bancontact', 'banktransfer', 'belfius', 'creditcard', 'directdebit', 'eps', 'giftcard', 'giropay', 'ideal', 'kbc', 'klarnapaylater', 'klarnasliceit', 'mybank', 'paypal', 'paysafecard', 'przelewy24', 'sofort' or 'voucher'. |
| Order Line Product Type Property Alias | The order line property alias containing a Mollie product type for the order line. Can be either 'physical' or 'digital'. |
| Order Line Product Category Property Alias | The order line property alias containing a Mollie product category for the order line. Can be 'meal', 'eco' or 'gift'. |

![Create Payment Provider Settings](../media/mollie/umbraco_configure_mollie_settings.png)
