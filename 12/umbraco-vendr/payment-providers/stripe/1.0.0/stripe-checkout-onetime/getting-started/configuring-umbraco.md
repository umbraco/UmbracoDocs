---
title: Configuring Umbraco
description: Documentation for the Stripe Checkout (One Time) payment provider for Vendr, the eCommerce solution for Umbraco v8+
---

## Create Payment Method

In the Umbraco back-office, in the **Settings > Vendr > Stores > {Store Name} > Payment Methods** section, click the **Create Payment Method** button to create a new payment method, choosing **Stripe Checkout (One Time)** from the list of available payment providers.

![Create Payment Method](/media/screenshots/stripe/umbraco_create_payment_method.png)

## Configure Payment Provider Settings

In the payment method editor, configure the standard payment method settings as required, then configure the Stripe payment provider settings as follows:

| Name | Description |
| ---- | ----------- |
| Continue URL | The URL of the page to navigate to after payment is successful - e.g. `/confirmation/` |
| Cancel URL | The URL of the page to navigate to if the customer cancels the payment - e.g. `/cart/` |
| Error URL | The URL of the page to navigate to if there is an error with the payment - e.g. `/error/` |
| Billing Address (Line 1) Property Alias | The alias of the property containing line 1 of the billing address - e.g. addressLine1. Passed to Stripe for Radar verification. |
| Billing Address (Line 2) Property Alias | The alias of the property containing line 2 of the billing address - e.g. addressLine2. Passed to Stripe for Radar verification. |
| Billing Address City Property Alias | The alias of the property containing the city of the billing address - e.g. city. Passed to Stripe for Radar verification. |
| Billing Address State Property Alias | The alias of the property containing the state of the billing address - e.g. state. Passed to Stripe for Radar verification. |
| Billing Address Zip Code Property Alias | The alias of the property containing the zip code of the billing address - e.g. zip. Passed to Stripe for Radar verification. |
| Test Secret Key | The test Stripe secret API key |
| Test Public Key | The test Stripe public API key |
| Test Webhook Signing Secret | The test Stripe webhook signing secret |
| Live Secret Key | The live Stripe secret API key |
| Live Public Key | The live Stripe public API key |
| Live Webhook Signing Secret | The live Stripe webhook signing secret |
| Capture | Toggle indicating whether to immediately capture the payment, or whether to authorize the payment for later (manual) capturing |
| Send Stripe Receipt | Toggle indicating whether to send a Stripe based receipt |
| Test Mode | Toggle indicating whether this provider should run in test mode |

An addition to these core settings, there are also a number of optional advanced settings you can configure as follows:

| Name | Description |
| ---- | ----------- |
| Order Heading | A heading to display above the order line in the Stripe checkout |
| Order Image | The URL of an image to display against the order line in the Stripe checkout |

![Create Payment Provider Settings](/media/screenshots/stripe/umbraco_configure_stripe_settings.png)
