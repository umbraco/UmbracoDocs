---
title: Changelog
description: Changelog for the Mollie Payment Provider for Vendr.
---

# Changelog

## v2.0.2

**Date:** 2023-03-28\
**Description:** Patch release with minor bug fixes/enhancements

* Added refund, cancel and capture support via the back office.
* Added Mollie's order ID and selected payment method to the transaction metadata log.
* Upgraded `Mollie.Api` to 2.2.0.4.
* Fixed issue where pending orders are not being finalized because Mollie doesn't send a webhook request until payment is confirmed. Order is now finalized during the redirect routine.

## v2.0.1

**Date:** 2022-01-27\
**Description:** Patch release with minor bug fixes/enhancements

* Fixed issue with webhooks updating orders that haven't actually been finalized due to Mollie sending notifications in a weird way ([#6](https://github.com/vendrhub/vendr-payment-provider-mollie/issues/6)).

## v2.0.0

**Date:** 2021-10-07\
**Description:** Initial release of the Mollie Payment Provider
