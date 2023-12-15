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

<figure><img src="../.gitbook/assets/create-new-payment-method.png" alt=""><figcaption><p>The "Create Payment Method" dialog in the Commerce section of the Umbraco CMS backoffice.</p></figcaption></figure>

## Step 2: Configure Payment Provider Settings

The following steps are handled within the payment method editor in the Umbraco backoffice.

1. Configure the standard payment method settings as required.
2. Configure the Buckaroo payment provider settings as follows:

| Name                       | Description                                                                                                                                                                                                                                                                                                                                           |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Continue URL               | The URL of the page to navigate to after payment is successful - e.g. `/continue/`                                                                                                                                                                                                                                                                    |
| Cancel URL                 | The URL of the page to navigate to if the customer cancels the payment - e.g. `/cart/`                                                                                                                                                                                                                                                                |
| Error URL                  | The URL of the page to navigate to if there is an error with the payment - e.g. `/error/`                                                                                                                                                                                                                                                             |
| Secret Key                 | **\[Required]** The Buckaroo secret key, can be found in your Buckaroo Plaza dashboard.                                                                                                                                                                                                                                                               |
| Secret Key                 | **\[Required]** The Buckaroo website key, can be found in your Buckaroo Plaza dashboard.                                                                                                                                                                                                                                                              |
| Webhook hostname overwrite | The hostname where the buyer does checkout is a part of Buckaroo's payload signature. If you rewrite the host header for some reasons and make the hostname that your server sees different from the hostname where the buyer does checkout, you need to set this to the hostname where the buyer does checkout. Enter hostname only - e.g. `umbraco` |
| Enable test mode           | Toggle indicating whether this provider should run in test mode.                                                                                                                                                                                                                                                                                      |
