---
title: Configuring Umbraco
description: >-
  Learn how to configure the Umbraco backoffice for enabling the use of Stripe
  as a payment method.
---

# Configure Umbraco

## Step 1: Create Payment Method

The following steps are all handled through the Umbraco backoffice.

1. Navigate to **Settings > Commerce > Stores > {Store Name} > Payment Methods** section.
2. Select the **Create Payment Method** button to create a new payment method.
3. Choose **Stripe Checkout** from the list of available payment providers.

![The "Create Payment Method" dialog in the Commerce section of the Umbraco CMS backoffice.](../.gitbook/assets/umbraco_create_payment_method2.png)

## Step 2: Configure Payment Provider Settings

The following steps are handled within the payment method editor in the Umbraco backoffice.

1. Configure the standard payment method settings as required.
2. Configure the Stripe payment provider settings as follows:

| Name                                    | Description                                                                                                                                                                                                                                                                                      |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Continue URL                            | The URL of the page to navigate to after payment is successful. For example: `/confirmation/`                                                                                                                                                                                                    |
| Cancel URL                              | The URL of the page to navigate to if the customer cancels the payment. For example: `/cart/`                                                                                                                                                                                                    |
| Error URL                               | The URL of the page to navigate to if there is an error with the payment. For example: `/error/`                                                                                                                                                                                                 |
| Billing Address (Line 1) Property Alias | The alias of the property containing line 1 of the billing address. For example: addressLine1. Passed to Stripe for Radar verification. See default aliases [in the Umbraco Commerce documentation](https://docs.umbraco.com/umbraco-commerce/key-concepts/properties#order-property-map).       |
| Billing Address (Line 2) Property Alias | The alias of the property containing line 2 of the billing address. For example: addressLine1. Passed to Stripe for Radar verification. See default aliases [in the Umbraco Commerce documentation](https://docs.umbraco.com/umbraco-commerce/key-concepts/properties#order-property-map).       |
| Billing Address City Property Alias     | The alias of the property containing the city of the billing address. For example: addressLine1. Passed to Stripe for Radar verification. See default aliases [in the Umbraco Commerce documentation](https://docs.umbraco.com/umbraco-commerce/key-concepts/properties#order-property-map).     |
| Billing Address State Property Alias    | The alias of the property containing the state of the billing address. For example: addressLine1. Passed to Stripe for Radar verification. See default aliases [in the Umbraco Commerce documentation](https://docs.umbraco.com/umbraco-commerce/key-concepts/properties#order-property-map).    |
| Billing Address Zip Code Property Alias | The alias of the property containing the zip code of the billing address. For example: addressLine1. Passed to Stripe for Radar verification. See default aliases [in the Umbraco Commerce documentation](https://docs.umbraco.com/umbraco-commerce/key-concepts/properties#order-property-map). |
| Test Secret Key                         | The test Stripe secret API key                                                                                                                                                                                                                                                                   |
| Test Public Key                         | The test Stripe public API key                                                                                                                                                                                                                                                                   |
| Test Webhook Signing Secret             | The test Stripe webhook signing secret                                                                                                                                                                                                                                                           |
| Live Secret Key                         | The live Stripe secret API key                                                                                                                                                                                                                                                                   |
| Live Public Key                         | The live Stripe public API key                                                                                                                                                                                                                                                                   |
| Live Webhook Signing Secret             | The live Stripe webhook signing secret                                                                                                                                                                                                                                                           |
| Capture                                 | Toggle indicating whether to immediately capture the payment, or whether to authorize the payment for later (manual) capturing. Only applicable to non-recurring transactions.                                                                                                                   |
| Send Stripe Receipt                     | Toggle indicating whether to send a Stripe based receipt                                                                                                                                                                                                                                         |
| Test Mode                               | Toggle indicating whether this provider should run in test mode                                                                                                                                                                                                                                  |

In addition to these core settings, there are a number of optional advanced settings you can configure:

| Name                   | Description                                                                                                                                  |
| ---------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| Order Heading          | A heading to display above the order line in the Stripe checkout                                                                             |
| Order Image            | The URL of an image to display against the order line in the Stripe checkout                                                                 |
| One-Time Items Heading | A heading to display for the total one-time payment items order line when the order consists of both subscription and one-time payment items |
| Order Properties       | A comma separated list of order properties to copy to the transactions meta data                                                             |

![Overview of the available  Payment Provider Settings in the Umbraco CMS backoffice.](../.gitbook/assets/umbraco_configure_stripe_settings2.png)
