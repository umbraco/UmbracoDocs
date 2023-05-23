---
title: Changelog
description: Changelog for the Stripe Payment Provider for Vendr.
---

# Changelog

## v2.1.0

**Date:** 2022-03-06\
**Description:** Minor update with Stripe Software Development Kit (SDK) dependency upgrade

* Added Locale to Stripe order for localizing Stripe UI / emails.
* Updated Stripe SDK dependency to v41 ([#12](https://github.com/vendrhub/vendr-payment-provider-stripe/pull/12)).

## v2.0.1

**Date:** 2021-10-18\
**Description:** Bug fixes and minor enhancements

* Fixed regression due to search and replace in metadata fields sent to Stripe.
* Changed the webhook processing to parse the request as a stream so it can be reset before attempting to read.

## v2.0.0

**Date:** 2021-10-07\
**Description:** Major new release with breaking changes

* Rebuilt for Vendr 2.0.0.

## v1.2.1

**Date:** 2021-03-24\
**Description:** Bug fixes and minor enhancements

* Added ability to configure the Stripe payment method types to use ([#6](https://github.com/vendrhub/vendr-payment-provider-stripe/issues/6)).
* Fixed issue when using subscriptions not taking tax into account. A Stripe Tax Rate is now created based on the subscription items' order line tax rate.

## v1.2.0

**Date:** 2020-12-10\
**Description:** Breaking change update targeting Vendr 1.4.0

* Payment provider now uses new `TransactionAmount` from Vendr 1.4.0.

## v1.1.0

**Date:** 2020-06-23\
**Description:** Minor release with Subscription payments support

* Added a new Stripe Checkout payment provider that supports both one-time and subscription payments.
* Deprecated the Stripe Checkout (One time) payment provider as the new payment provider can handle both one-time and subscription checkouts.

## v1.0.0

**Date:** 2020-03-30\
**Description:** Initial release of the Stripe Payment Provider
