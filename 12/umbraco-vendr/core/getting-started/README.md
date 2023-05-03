---
title: Introduction
description: Getting Started with Vendr, the eCommerce solution for Umbraco
---

In this section we will guide you through the key steps necessary to get you started with Vendr.

It is assumed that before we begin that you already have an Umbraco 10+ website configured, ready to install Vendr into. If you are unsure how to setup a basic Umbraco install, you should review the [Getting Started](https://our.umbraco.com/documentation/getting-started/) documentation on the main Umbraco developer portal and return once you have this in place.

## System Requirements
At this time, the minimum requirements for using Vendr are as follows:
* **Umbraco 10.0+**
* **SQL Server Database** (SQLite is fine for testing, but not recommend for live deployments. See [Configuring SQLite support](../how-to-guides/configuring-sqlite-support/) for more details.)

## Versioning
It's important to understanding Vendr's versioning strategy so that you can perform informed upgrades during the life of a project. For Vendr, our version numbers can be interpreted as follows **Product.Feature.Patch**.

* **Product** - A distinct version of the Vendr product which has significant breaking changes from the product version before it.
* **Feature** - A version with one or more new features that have been added. The release could be breaking or non-breaking so it is important to review the changelog before upgrading to a new feature release.
* **Patch** - A version consisting of minor, non-breaking bug fixes.

<message-box type="warning" heading="A note about SemVer">

It is common within the development community that version numbers should follow the [SemVer](https://semver.org/) specification, however we don't feel that SemVer fits with how we wish to portray our versioning information. It is important then that developers understand the differences, especially when upgrading to a Feature/Minor release where the SemVer expectation would be for it to be non-breaking which may not be the case.

</message-box>
