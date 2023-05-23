---
title: Changelog
description: Changelog for the Klarna Payment Provider for Vendr.
---

# Changelog

## v2.0.3

**Date:** 2022-08-31\
**Description:** Patch release with minor bug fixes/enhancements

* Fixed a bug where discounts/surcharges assumed the tax rate was that of the order resulting in a Klarna error. The tax rate is now dynamically calculated based on the cumulative adjustment amount.

## v2.0.2

**Date:** 2022-08-22\
**Description:** Patch release with minor bug fixes/enhancements

* Fixed a bug where hard-coded strings were not translatable. Strings are now advanced options in the payment provider settings.

## v2.0.1

**Date:** 2022-07-06\
**Description:** Patch release with minor bug fixes/enhancements

* Fixed bug where the cart would error if there was a 100% discount on shipping price.

## v2.0.0

**Date:** 2021-10-07\
**Description:** Major new release with breaking changes

* Rebuilt for Vendr 2.0.0.

## v0.2.0

**Date:** 2020-12-10\
**Description:** Breaking change update targeting Vendr 1.4.0

* Payment provider now uses new `TransactionAmount` from Vendr 1.4.0.

## v0.1.0

**Date:** 2020-08-14\
**Description:** Initial pre-release of the Klarna Payment Provider
