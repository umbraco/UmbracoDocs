---
title: Changelog
description: Changelog for the PayPal Payment Provider for Vendr.
---

# Changelog

## v2.0.1

**Date:** 2022-01-27\
**Description:** Patch release with minor bug fixes/enhancements

* Added order line descriptions.
* Fixed an issue with the Webhook parser looking for request headers in the wrong location.

## v2.0.0

**Date:** 2021-10-07\
**Description:** Major new release with breaking changes

* Rebuilt for Vendr 2.0.0.

## v1.1.1

**Date:** 2021-07-22\
**Description:** Patch release with minor bug fixes/enhancements

* Fixed decimal parsing issue by adding invariant culture to the parser ([#3](https://github.com/vendrhub/vendr-payment-provider-paypal/issues/3)).

## v1.1.0

**Date:** 2020-12-10\
**Description:** Breaking change update targeting Vendr 1.4.0

* Payment provider now uses new `TransactionAmount` from Vendr 1.4.0.

## v1.0.3

**Date:** 2020-07-10\
**Description:** Patch release with minor bug fixes/enhancements

* Added support for listening for all Payment related webhooks to ensure the payment status is kept in sync.
* Fixed bug where cancel action was capturing payment.

## v1.0.2

**Date:** 2020-04-24\
**Description:** Patch release with minor bug fixes/enhancements

* Added check to ensure currency code is ISO4217 compatible.
* Added required metadata to the Umbraco package file.

## v1.0.1

**Date:** 2020-04-09\
**Description:** Change of PayPal settings

* Removed the mode dropdown in favor of a "Sandbox Mode" checkbox as this is the standard we have been implementing in other providers.

## v1.0.0

**Date:** 2020-03-30\
**Description:** Initial Vendr PayPal Payment Provider release
