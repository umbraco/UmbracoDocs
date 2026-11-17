---
title: Configuring Umbraco
description: >-
  Learn how to configure the Umbraco backoffice for enabling the use of
  the TaxJar sale tax provider.
---

# Configure Umbraco

This article will give you details about how to configure Umbraco to start using the TaxJar sale tax provider with your Umbraco Commerce implementation.

## Step 1: Create a Sales Tax Calculation Method

The following steps are all handled through the Umbraco backoffice.

1. Navigate to **Settings > Commerce > Stores > {Store Name} > Taxes > Tax Calculation Methods** section.
2. Select the **Create Tax Calculation Method** button to create a new sale tax calculation method.
3. Choose **TaxJar** from the list of available sale tax providers.

## Step 2: Configure Sales Tax Provider Settings

The following steps are handled within the tax calculation method editor in the Umbraco backoffice.

1. Configure the standard sale tax calculation method settings as required.
2. Configure the TaxJar sale tax provider settings as follows:

| Name | Description |
| ---- | ----------- |
| Sandbox Token | The Sandbox API token from the TaxJar portal. |
| Live Token | The Live API token from the TaxJar portal. |
| Test Mode | Set whether to run in test mode. |
