---
title: Configuring Umbraco
description: >-
  Learn how to configure the Umbraco backoffice for enabling the use of DIBS D2
  as a payment method.
---

# Configure Umbraco

## Step 1: Create a Payment Method

The following steps are all handled through the Umbraco backoffice.

1. Navigate to **Settings > Vendr > Stores > {Store Name} > Payment Methods** section.
2. Select the **Create Payment Method** button to create a new payment method.
3. Choose **DIBS D2** from the list of available payment providers.

![The "Create Payment Method" dialog in the Commerce section of the Umbraco CMS backoffice.](../media/dibs/d2/umbraco\_create\_payment\_method.png)

## Step 2: Configure Payment Provider Settings

The following steps are handled within the payment method editor in the Umbraco backoffice.

1. Configure the standard payment method settings as required.
2. Configure the DIBS D2 payment provider settings as follows:

| Name               | Description                                                                                                                    |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------ |
| Continue URL       | The URL of the page to navigate to after payment is successful - e.g. `/confirmation/`                                         |
| Cancel URL         | The URL of the page to navigate to if the customer cancels the payment - e.g. `/cart/`                                         |
| Error URL          | The URL of the page to navigate to if there is an error with the payment - e.g. `/error/`                                      |
| Merchant ID        | The Merchant ID can be found in DIBS administration                                                                            |
| Language           | Language of the payment window presented to the customer                                                                       |
| MD5 Key 1          | Find it in DIBS administration **Integration -> MD5 Keys**                                                                     |
| MD5 Key 2          | Find it in DIBS administration **Integration -> MD5 Keys**                                                                     |
| API Username       | Find it in DIBS administration **Setup -> User Setup -> API users**                                                            |
| API Password       | Find it in DIBS administration **Setup -> User Setup -> API users**                                                            |
| Accepted Pay Types | A comma separated list of payment methods to accept                                                                            |
| Decorator          | Specifies which of the pre-built decorators to use. Possible values are "default", "basal", "rich" and "responsive"            |
| Capture            | Toggle indicating whether to immediately capture the payment, or whether to authorize the payment for later (manual) capturing |
| Calculate Fee      | Whether the transaction fees are paid by the customer                                                                          |
| Test Mode          | Toggle indicating whether this provider should run in test mode                                                                |

![Overview of the available  Payment Provider Settings in the Umbraco CMS backoffice.](../media/dibs/d2/umbraco\_configure\_dibs-d2\_settings.png)
