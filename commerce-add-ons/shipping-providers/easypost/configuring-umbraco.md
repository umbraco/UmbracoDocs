---
title: Configuring Umbraco
description: >-
  Learn how to configure the Umbraco backoffice for enabling the use of
  EasyPost as a shipping method.
---

# Configure Umbraco

This article will give you details about how to configure Umbraco to start using the EasyPost shipping method with your Umbraco Commerce implementation.

## Step 1: Create a Shipping Method

The following steps are all handled through the Umbraco backoffice.

1. Navigate to **Settings > Commerce > Stores > {Store Name} > Shipping Methods** section.
2. Select the **Create Shipping Method** button to create a new shipping method.
3. Choose **EasyPost** from the list of available shipping providers.
3. Choose **Realtime** from the list of shipping method calculation modes.

## Step 2: Configure Shipping Provider Settings

The following steps are handled within the shipping method editor in the Umbraco backoffice.

1. Configure the standard shipping method settings as required.
2. Configure the EasyPost shipping provider settings as follows:

| Name | Description |
| ---- | ----------- |
| Test API Key | The Test API Key from the EasyPost portal. |
| Live API Key | The Live API Key from the EasyPost portal. |
| Test Mode | Set whether to run in test mode. |

3. Optionally configure the advanced EasyPost shipping provider settings as follows:

| Name | Description |
| ---- | ----------- |
| Carrier Accounts | Comma-separated list of carriers to limit which services to fetch rates for. |
