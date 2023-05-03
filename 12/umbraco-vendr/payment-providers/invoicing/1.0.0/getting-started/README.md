---
title: Overview
description: Getting Started with the Invoicing payment provider for Vendr, the eCommerce solution for Umbraco v8+
---

## About this Payment Provider

The Invoicing payment provider is a "pass through" payment provider that doesn't capture any payment information itself, rather it allows orders to go through in an `Authorized` state where it assumed that payments will be captured manually in an external system. Once captured, orders can then by updated to the `Captured` payment status via the back-office.

## In this Section

In this section we will guide you through the key steps necessary to get you started with the Invoicing payment provider for Vendr.

It is assumed that before we begin that you already have an Umbraco v8+ website configured, with Vendr installed. If you are not at this stage yet, please read the [core Vendr documentation](../../../../../core/) to learn how to get started with Vendr and return to this section once you have these requirements in place.