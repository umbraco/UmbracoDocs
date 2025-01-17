---
description: >-
  Learn how to configure the Umbraco backoffice for enabling the use of Klarna
  as a payment method.
---

# Configure Umbraco

## Step 1: Create a Payment Method

The following steps are all handled through the Umbraco backoffice.

1. Navigate to **Settings > Commerce > Stores > {Store Name} > Payment Methods** section.
2. Select the **Create Payment Method** button to create a new payment method.
3. Choose **Klarna (HPP)** from the list of available payment providers.

![The "Create Payment Method" dialog in the Commerce section of the Umbraco CMS backoffice.](../media/klarna/umbraco\_create\_payment\_method.png)

## Step 2: Configure Payment Provider Settings

The following steps are handled within the payment method editor in the Umbraco backoffice.

1. Configure the standard payment method settings as required.
2. Configure the Klarna payment provider settings as follows:

| Name                                    | Description                                                                                                                                    |
| --------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| Continue URL                            | The URL of the page to navigate to after payment is successful - for example: `/confirmation/`                                                 |
| Cancel URL                              | The URL of the page to navigate to if the customer cancels the payment - for example: `/cart/`                                                 |
| Error URL                               | The URL of the page to navigate to if there is an error with the payment - for example: `/error/`                                              |
| Billing Address (Line 1) Property Alias | The alias of the property containing line 1 of the billing address - for example: addressLine1. Passed to Klarna for Radar verification. See default aliases [in the Umbraco Commerce documentation](https://docs.umbraco.com/umbraco-commerce/key-concepts/properties#order-property-map).                                                                                                                                      |
| Billing Address (Line 2) Property Alias | The alias of the property containing line 2 of the billing address - for example: addressLine1. Passed to Klarna for Radar verification. See default aliases [in the Umbraco Commerce documentation](https://docs.umbraco.com/umbraco-commerce/key-concepts/properties#order-property-map).                                                                                                                                      |
| Billing Address City Property Alias     | The alias of the property containing the city of the billing address - for example: addressLine1. Passed to Klarna for Radar verification. See default aliases [in the Umbraco Commerce documentation](https://docs.umbraco.com/umbraco-commerce/key-concepts/properties#order-property-map).                                                                                                    |
| Billing Address State Property Alias    | The alias of the property containing the state of the billing address - for example: addressLine1. Passed to Klarna for Radar verification. See default aliases [in the Umbraco Commerce documentation](https://docs.umbraco.com/umbraco-commerce/key-concepts/properties#order-property-map).                                                                                                    |
| Billing Address Zip Code Property Alias | The alias of the property containing the zip code of the billing address - for example: addressLine1. Passed to Klarna for Radar verification. See default aliases [in the Umbraco Commerce documentation](https://docs.umbraco.com/umbraco-commerce/key-concepts/properties#order-property-map).                                                                                                    |
| API Region                              | The Region in which your account is under. Can be either `Europe`, `NorthAmerica` or `Oceana`                                                  |
| Test API Username                       | The Username to use when connecting to the test Klarna API                                                                                     |
| Test API Password                       | The Password to use when connecting to the test Klarna API                                                                                     |
| Live API Username                       | The Username to use when connecting to the live Klarna API                                                                                     |
| Live API Password                       | The Password to use when connecting to the live Klarna API                                                                                     |
| Capture                                 | Toggle indicating whether to immediately capture the payment, or whether to authorize the payment for later (manual) capturing                 |
| Test Mode                               | Toggle indicating whether this provider should run in test mode                                                                                |

In addition to these core settings, there are also a number of optional advanced settings you can configure as follows:

| Name                        | Description                                                                                                                                                                                                                      |
| --------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Payment Page Logo Url       | Fully qualified URL of a logo image to display on the payment page                                                                                                                                                               |
| Payment Page Page Title     | A custom title to display on the payment page                                                                                                                                                                                    |
| Product Type Property Alias | The order line property alias containing the type of the product. Property value can be one of either `physical` or `digital`                                                                                                    |
| Payment Method Categories   | Comma separated list of payment method categories to show on the payment page. If empty, all allowable options will be presented. Options are `DIRECT_DEBIT`, `DIRECT_BANK_TRANSFER`, `PAY_NOW`, `PAY_LATER` and `PAY_OVER_TIME` |
| Payment Method Category     | The payment method category to show on the payment page. Options are `DIRECT_DEBIT`, `DIRECT_BANK_TRANSFER`, `PAY_NOW`, `PAY_LATER` and `PAY_OVER_TIME`                                                                          |
| Enable Fallbacks            | Set whether to fallback to other payment options if the initial payment attempt fails before redirecting back to the site                                                                                                        |

![Overview of the available  Payment Provider Settings in the Umbraco CMS backoffice.](../media/klarna/umbraco\_configure\_provider\_settings.png)
