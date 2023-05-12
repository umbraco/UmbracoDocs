---
title: Overview
description: Getting Started with the Invoicing payment provider for Vendr, the eCommerce solution for Umbraco v8+
---

## About this Payment Provider

The Invoicing payment provider is a "pass through" payment provider that doesn't capture any payment information itself, rather it allows orders to go through in an `Authorized` state where it assumed that payments will be captured manually in an external system. Once captured, orders can then by updated to the `Captured` payment status via the backoffice.

## [Install Invoice payment](../install-payment-providers)

{% hint style="info" %}
The invoice payment method is install with Umbraco Commerce by default. Follow the installation instruction if for some reason the package has been removed from your implementation.
{% endhint %}

## In this Section

In this section we will guide you through the key steps necessary to get you started with the Invoicing payment provider for Vendr.

It is assumed that before we begin that you already have an Umbraco v8+ website configured, with Vendr installed. If you are not at this stage yet, please read the [core Vendr documentation](../../../../../core/) to learn how to get started with Vendr and return to this section once you have these requirements in place.

## Using These Docs

**These docs are aimed at developers** looking to implement basic invoice payments in a Vendr eCommerce store. It is expected that you have at least a basic understanding of [Umbraco](https://umbraco.com), as well the [Vendr core product](../../../../core/).
