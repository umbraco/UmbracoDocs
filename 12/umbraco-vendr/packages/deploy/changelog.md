---
title: Changelog
description: >-
  Changelog for the Deploy package for Vendr, the eCommerce solution for
  Umbraco.
---

# Changelog

## v3.1.0

**Date:** 2023-01-16\
**Description:** Minor release targeted with some breaking changes

* Added ability to ignore payment provider settings on import as well as export.
* Retargeted for Umbraco v11+

## v3.0.0

**Date:** 2022-09-29\
**Description:** Major release targeted for Vendr v3

* Added ability to deploy Product Attributes + Product Attribute Presets through the transfer queue.
* Most dependency checks now just check if the entity exists rather than for exact matches.
* Dropped Umbraco v8 and v9 support
* Retargeted for Umbraco v10+

## v2.0.2

**Date:** 2022-06-29\
**Description:** Minor release containing feature updates and bug fixes

* Added support for app settings config to ignore certain payment method settings from being transfered.

## v2.0.1

**Date:** 2021-12-01\
**Description:** Minor release containing feature updates and bug fixes

* Registered UDI types for Umbraco v9

## v2.0.0

**Date:** 2021-10-07\
**Description:** Major release with breaking changes

* Updated Umbraco dependency of 9.0.0
* Updated Vendr dependency of 2.0.0.

## v0.3.0

**Date:** 2021-05-10\
**Description:** Minor release containing feature updates and bug fixes

* Added export templates support.
* Updated Vendr dependency of 1.8.0.

## v0.2.1

**Date:** 2021-04-12\
**Description:** Minor patch release containing bug fixes

* Fixed bug with Product Attributes not being transferred with Product Variants.

## v0.2.0

**Date:** 2021-04-08\
**Description:** Minor release containing feature updates and bug fixes

* Added print templates support.
* Added variants editor value connector to support deploying connected Product Attributes.
* Updated Vendr dependency of 1.6.0.

## v0.1.0

**Date:** 2020-12-21\
**Description:** Minor patch release containing bug fixes

* Fixed issue with `EmailTemplateServiceConnector` not serializing/deserializing `SendToCustomer` flag.

## v0.1.0

**Date:** 2020-09-28\
**Description:** Initial release of the Vendr Deploy Package
