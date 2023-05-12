---
title: Configuring Umbraco
description: Documentation for the DIBS D2 payment provider for Vendr, the eCommerce solution for Umbraco v8+
---

## Create Payment Method

In the Umbraco backoffice, in the **Settings > Vendr > Stores > {Store Name} > Payment Methods** section, click the **Create Payment Method** button to create a new payment method, choosing **DIBS D2** from the list of available payment providers.

![Create Payment Method](../media/dibs/d2/umbraco_create_payment_method.png)

## Configure Payment Provider Settings

In the payment method editor, configure the standard payment method settings as required, then configure the DIBS D2 payment provider settings as follows:

| Name | Description |
| ---- | ----------- |
| Continue URL | The URL of the page to navigate to after payment is successful - e.g. `/confirmation/` |
| Cancel URL | The URL of the page to navigate to if the customer cancels the payment - e.g. `/cart/` |
| Error URL | The URL of the page to navigate to if there is an error with the payment - e.g. `/error/` |
| Merchant ID | The Merchant ID can be found in DIBS administration |
| Language | Language of the payment window presented to the customer |
| MD5 Key 1 | Find it in DIBS administration **Integration -> MD5 Keys** |
| MD5 Key 2 | Find it in DIBS administration **Integration -> MD5 Keys** |
| API Username | Find it in DIBS administration **Setup -> User Setup -> API users** |
| API Password | Find it in DIBS administration **Setup -> User Setup -> API users** |
| Accepted Pay Types | A comma separated list of payment methods to accept |
| Decorator | Specifies which of the pre-built decorators to use. Possible values are "default", "basal", "rich" and "responsive" |
| Capture | Toggle indicating whether to immediately capture the payment, or whether to authorize the payment for later (manual) capturing |
| Calculate Fee |Whether the transaction fees are paid by the customer |
| Test Mode | Toggle indicating whether this provider should run in test mode |

![Create Payment Provider Settings](../media/dibs/d2/umbraco_configure_dibs-d2_settings.png)
