---
description: >-
  Learn how to configure the Umbraco backoffice for enabling the use of QuickPay
  as a payment method.
---

# Configure Umbraco

## Step 1: Create Payment Method

The following steps are all handled through the Umbraco backoffice.

1. Navigate to **Settings > Commerce > Stores > {Store Name} > Payment Methods** section.
2. Select the **Create Payment Method** button to create a new payment method.
3. Choose **QuickPay V10** from the list of available payment providers.

![The "Create Payment Method" dialog in the Commerce section of the Umbraco CMS backoffice.](<../.gitbook/assets/umbraco_create_payment_method (3).png>)

## Step 2: Configure Payment Provider Settings

The following steps are handled within the payment method editor in the Umbraco backoffice.

1. Configure the standard payment method settings as required.
2. Configure the QuickPay payment provider settings as follows:

| Name                     | Description                                                                                                                    |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------ |
| Continue URL             | The URL of the page to navigate to after payment is successful - e.g. `/confirmation/`                                         |
| Cancel URL               | The URL of the page to navigate to if the customer cancels the payment - e.g. `/cart/`                                         |
| Error URL                | The URL of the page to navigate to if there is an error with the payment - e.g. `/error/`                                      |
| API Key                  | The QuickPay API key                                                                                                           |
| Private Key              | The QuickPay private key                                                                                                       |
| Merchant ID              | The Merchant ID for the QuickPay account                                                                                       |
| Agreement ID             | The Agreement ID for the QuickPay account                                                                                      |
| Language                 | The language shown in the payment window                                                                                       |
| Accepted Payment Methods | Specify payment methods available in the payment window                                                                        |
| Auto Fee                 | Toggle indicating whether to automatically calculate and apply the fee from the acquirer                                       |
| Auto Capture             | Toggle indicating whether to immediately capture the payment, or whether to authorize the payment for later (manual) capturing |

![Overview of the available  Payment Provider Settings in the Umbraco CMS backoffice.](../.gitbook/assets/umbraco_configure_quickpay_settings.png)
