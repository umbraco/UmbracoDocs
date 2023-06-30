---
title: Configuring Umbraco
description: >-
  Learn how to configure the Umbraco backoffice for enabling the use of
  Invoicing as a payment method.
---

# Configure Umbraco

This article will give you details about how to configure Umbraco to start using the Invoicing payment method with your Umbraco Commerce implementation.

## Step 1: Create a Payment Method

The following steps are all handled through the Umbraco backoffice.

1. Navigate to **Settings > Commerce > Stores > {Store Name} > Payment Methods** section.
2. Select the **Create Payment Method** button to create a new payment method.
3. Choose **Invoicing** from the list of available payment providers.

![The "Create Payment Method" dialog in the Commerce section of the Umbraco CMS backoffice.](../media/invoicing/umbraco\_create\_payment\_method.png)

## Step 2: Configure Payment Provider Settings

The following steps are handled within the payment method editor in the Umbraco backoffice.

1. Configure the standard payment method settings as required.
2. Configure the Invoice payment provider settings as follows:

| Name         | Description                                                              |
| ------------ | ------------------------------------------------------------------------ |
| Continue URL | The URL of the page to navigate to after payment - e.g. `/confirmation/` |
