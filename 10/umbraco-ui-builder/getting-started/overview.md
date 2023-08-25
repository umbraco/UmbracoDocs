---
description: Getting Started with Konstrukt, the backoffice UI builder for Umbraco.
---

# Getting Started

In this section we will guide you through the key steps necessary to get you started with Konstrukt.

It is assumed that before we begin that you already have an Umbraco v10+ website configured, ready to install Konstrukt into. If you are unsure how to setup a basic Umbraco install, you should review the [Getting Started](https://our.umbraco.com/documentation/getting-started/) documentation on the main Umbraco developer portal and return once you have this in place.

## System Requirements
At this time, the minimum requirements for using Konstrukt are as follows:
* **Umbraco 10.0+**
* **SQL Server Database** (SQLite is fine for testing, but not recommend for live deployments)

## Versioning
It's important to understanding Konstrukt's versioning strategy so that you can perform informed upgrades during the life of a project. For Konstrukt, our version numbers can be interpreted as follows **Product.Feature.Patch**.

* **Product** - A distinct version of the Konstrukt product which has significant breaking changes from the product version before it.
* **Feature** - A version with one or more new features that have been added. The release could be breaking or non-breaking so it is important to review the changelog before upgrading to a new feature release.
* **Patch** - A version consisting of minor, non-breaking bug fixes.

{% hint style="info" %}
**A note about SemVer:** It is common within the development community that version numbers should follow the [SemVer](https://semver.org/) specification, however we don't feel that SemVer fits with how we wish to portray our versioning information. It is important then that developers understand the differences, especially when upgrading to a Feature/Minor release where the SemVer expectation would be for it to be non-breaking which may not be the case.
{% endhint %}