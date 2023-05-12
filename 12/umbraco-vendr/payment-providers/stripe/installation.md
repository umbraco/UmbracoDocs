---
title: Installation
description: Documentation for the Stripe Checkout payment provider for Vendr, the eCommerce solution for Umbraco v8+
---

There are currently two ways to install the Stripe payment provider for Vendr into your solution. Using the Umbraco package distribution, installed via the Umbraco backoffice, or using our NuGet packages, installed directly into your projects code base via the NuGet Package Manager. Where possible, it is our recommendation to use the NuGet packages as these allow a great level of ease/control when upgrading later on.

## Umbraco Package Installation

To install the Stripe payment provider Umbraco package, you will need to download the package file manually from the Vendr package page on the [Umbraco Developer Portal](https://our.umbraco.com/packages/website-utilities/vendr/). On this page, scroll down to the **Package Files** section and locate the Stripe payment provider package, clicking it to initiate a download.

![Umbraco package files list](../media/package-files-list.png)

Once downloaded you should manually install the package by uploading it to the **local package installer** located in your backoffice **Packages > Install Local** section. Once uploaded, follow the on-screen instructions provided to complete the install.


![Installing an Umbraco Package via Local Umbraco Package](../media/umbraco_local_package_install.png)

## NuGet Package Installation

To install the Stripe payment provider via NuGet you can run the following command directly in the NuGet Manager Console window:

```bash
PM> Install-Package Vendr.PaymentProviders.Stripe
```

Alternatively, you can also find and install the NuGet package via the NuGet Package Manager.

![Installing Vendr via the NuGet Package Manager](../media/nuget_package_manager_gui.png)

## Upgrading

{% hint style="info" %}
Before upgrading, it is always advisable to take a complete backup of your site/database. Every effort has been made to ensure that Vendr will upgrade gracefully, but there is always a risk that something may not install as expected.
{% endhint %}

Vendr uses Umbraco Migrations to install all of it's features meaning upgrades follow the exact same process as the installation processes detailed above, installing the latest version of a package over the top of the existing package installation. Vendr is then clever enough to detect the current state of your site and only install the features that are missing.