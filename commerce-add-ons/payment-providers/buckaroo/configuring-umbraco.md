---
title: Configuring Umbraco
description: >-
  Learn how to configure the Umbraco backoffice for enabling the use of Buckaroo
  as a payment method.
---

# Configure Umbraco

## Step 1: Create Payment Method

The following steps are all handled through the Umbraco backoffice.

1. Navigate to **Settings > Commerce > Stores > {Store Name} > Payment Methods** section.
2. Select the **Create Payment Method** button to create a new payment method.
3. Choose **Buckaroo One Time Payment** from the list of available payment providers.

![The "Create Payment Method" dialog in the Commerce section of the Umbraco CMS backoffice.](../media/buckaroo/umbraco/create-new-payment-method.png)

## Step 2: Configure Payment Provider Settings

The following steps are handled within the payment method editor in the Umbraco backoffice.

1. Configure the standard payment method settings as required.
2. Configure the Buckaroo payment provider settings as follows:

| Name                                    | Description                                                                                                                                                                    |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Continue URL                            | The URL of the page to navigate to after payment is successful - e.g. `/confirmation/`                                                                                         |
| Cancel URL                              | The URL of the page to navigate to if the customer cancels the payment - e.g. `/cart/`                                           |
| Error URL                               | The URL of the page to navigate to if there is an error with the payment - e.g. `/error/`                                             |
| Secret key for test mode                | **Required** when `Enable test mode` is checked  |
| Website key for test mode               | **Required** when `Enable test mode` is checked  |
| Secret Key                              | The live Buckaroo secret key, **Required** when `Enable test mode` is unchecked. Can be found in your Buckaroo Plaza dashboard. |
| Secret Key                              | The live Buckaroo website key, **Required** when `Enable test mode` is unchecked. Can be found in your Buckaroo Plaza dashboard. |
| Enable test mode                        | Toggle indicating whether this provider should run in test mode. |
