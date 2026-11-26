---
title: Configuring Umbraco
description: >-
  Learn how to configure the Umbraco backoffice for enabling the use of
  DHL as a shipping method.
---

# Configure Umbraco

This article will give you details about how to configure Umbraco to start using the DHL shipping method with your Umbraco Commerce implementation.

## Step 1: Create a Shipping Method

The following steps are all handled through the Umbraco backoffice.

1. Navigate to **Settings > Commerce > Stores > {Store Name} > Shipping Methods** section.
2. Select the **Create Shipping Method** button to create a new shipping method.
3. Choose **DHL** from the list of available shipping providers.
3. Choose **Realtime** from the list of shipping method calculation modes.

## Step 2: Configure Shipping Provider Settings

The following steps are handled within the shipping method editor in the Umbraco backoffice.

1. Configure the standard shipping method settings as required.
2. Configure the DHL shipping provider settings as follows:

| Name | Description |
| ---- | ----------- |
| Account Number | Your DHL account number |
| Shipping Timeframe | The number of days after an order is placed you generally ship by. 0 = same day, 1 = next day, etc |
| Next Business Day Fallback | When set to true and there are no products available within the shipping timeframe then products available for the next possible pickup date are returned. |
| Test Username | The Test Username from the DHL portal. |
| Test Password | The Test Password from the DHL portal. |
| Live Username | The Live Username from the DHL portal. |
| Live Password | The Live Password from the DHL portal. |
| Test Mode | Set whether to run in test mode. |

3. Optionally configure the advanced DHL shipping provider settings as follows:

| Name | Description |
| ---- | ----------- |
| Product Codes | Comma-separated list of product codes to limit the rates to. |
