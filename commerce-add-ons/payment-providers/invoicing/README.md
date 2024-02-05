---
description: Getting Started with the Invoicing payment provider for Umbraco Umbraco Commerce.
---

# Overview

The Invoicing payment provider is a "pass-through" payment provider that doesn't capture any payment information itself. Instead, it allows orders to go through in an `Authorized` state where it is assumed that payments will be captured manually in an external system. Once captured, orders can then be updated to the `Captured` payment status via the backoffice.

## [Install Invoice payment](../install-payment-providers.md)

{% hint style="info" %}
The invoice payment method is installed with Umbraco Commerce by default. Follow the installation instruction if for some reason the package has been removed from your implementation.
{% endhint %}

## In this Section

In this section, we will guide you through the key steps necessary to get you started with the Invoicing payment provider for Umbraco Commerce.

It is assumed that before we begin you already have an Umbraco website configured and Umbraco Commerce installed. If you are not at this stage yet, please read the [core Umbraco Commerce documentation](https://docs.umbraco.com/umbraco-commerce/) to learn how to get started.
