---
title: Configuring Umbraco
description: >-
  Learn how to configure the Umbraco backoffice for enabling the use of Mollie
  (One Time) as a payment method.
---

# Configure Umbraco

{% hint style="warning" %}
#### Configure Order Rounding Settings

This payment provider will only work when Order Rounding settings are configured to round at the `order line level` level.&#x20;

You can configure this in your Store Settings by setting the **Order Rounding Method** to **Line**.
{% endhint %}

## Step 1: Create a Payment Method

The following steps are all handled through the Umbraco backoffice.

1. Navigate to **Settings > Commerce > Stores > {Store Name} > Payment Methods** section.
2. Select the **Create Payment Method** button to create a new payment method.
3. Choose **Mollie (One Time)** from the list of available payment providers.

![The "Create Payment Method" dialog in the Commerce section of the Umbraco CMS backoffice.](../media/mollie/umbraco\_create\_payment\_method.png)

## Step 2: Configure Payment Provider Settings

The following steps are handled within the payment method editor in the Umbraco backoffice.

1. Configure the standard payment method settings as required.
2. Configure the Mollie (One Time) payment provider settings as follows:

| Name                                    | Description                                                                                    |
| --------------------------------------- | ---------------------------------------------------------------------------------------------- |
| Continue URL                            | The URL of the page to navigate to after payment is successful - e.g. `/confirmation/`. Without a value set, buyers will receive a null exception after they finish paying. |
| Cancel URL                              | The URL of the page to navigate to if the customer cancels the payment - e.g. `/cart/`         |
| Error URL                               | The URL of the page to navigate to if there is an error with the payment - e.g. `/error/`      |
| Billing Address (Line 1) Property Alias | **\[Mandatory\]** The alias of the property containing line 1 of the billing address. See default aliases [in the Umbraco Commerce documentation](https://docs.umbraco.com/umbraco-commerce/key-concepts/properties#order-property-map).                                                                              |
| Billing Address City Property Alias     | **\[Mandatory\]** The alias of the property containing the city of the billing address. See default aliases [in the Umbraco Commerce documentation](https://docs.umbraco.com/umbraco-commerce/key-concepts/properties#order-property-map).                                                                              |
| Billing Address State Property Alias    | The alias of the property containing the state of the billing address - for example state.     |
| Billing Address Zip Code Property Alias | **\[Mandatory\]** The alias of the property containing the zip code of the billing address. See default aliases [in the Umbraco Commerce documentation](https://docs.umbraco.com/umbraco-commerce/key-concepts/properties#order-property-map).                                                                              |
| Test API Key                            | The test Mollie API key                                                                        |
| Live API Key                            | The live Mollie API key                                                                        |
| Test Mode                               | Toggle indicating whether this provider should run in test mode                                |

In addition to these core settings, there are also a number of optional advanced settings you can configure as follows:

| Name                                       | Description                                                                                                                                                                                                                                                                                                                               |
| ------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Locale                                     | The locale to display the payment provider portal in.                                                                                                                                                                                                                                                                                     |
| Payment Methods                            | A comma-separated list of payment methods to limit the payment method selection screen. Can be 'applepay', 'bancontact', 'banktransfer', 'belfius', 'creditcard', 'directdebit', 'eps', 'giftcard', 'giropay', 'ideal', 'kbc', 'klarnapaylater', 'klarnasliceit', 'mybank', 'paypal', 'paysafecard', 'przelewy24', 'sofort' or 'voucher'. |
| Order Line Product Type Property Alias     | The order line property alias containing a Mollie product type for the order line. Can be either 'physical' or 'digital'.                                                                                                                                                                                                                 |
| Order Line Product Category Property Alias | The order line property alias containing a Mollie product category for the order line. Can be 'meal', 'eco' or 'gift'.                                                                                                                                                                                                                    |

![Overview of the available  Payment Provider Settings in the Umbraco CMS backoffice.](../media/mollie/umbraco\_configure\_mollie\_settings.png)
