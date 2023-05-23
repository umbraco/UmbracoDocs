---
title: Installation
description: Installing Vendr Checkout, an add-on package for Vendr, the eCommerce solution for Umbraco v8+
---

The Vendr Checkout package can be installed directly into your projects code base using our NuGet packages.

## NuGet Package Installation

To install the Vendr Checkout package via NuGet you can run the following command directly in the NuGet Manager Console window:

```bash
PM> Install-Package Vendr.Checkout
```

Alternatively, you can also find and install the NuGet package via the NuGet Package Manager.

![Installing Vendr Checkout via the NuGet Package Manager](../media/checkout/nuget_package.png)

## Content Installation

When Vendr Checkout is installed, all relevant database configurations automatically occur via Umbraco Migrations, however there are a series of content creation steps that need to be triggered manually as these types of migrations are not supported by the Umbraco migrations system. 

To install the relevant Vendr Checkout content (mainly the checkout content doc types + pages and updates to the Vendr store configuration) navigate to the **Settings** section and locate the Vendr Checkout dashboard in the root of the section.

![Vendr Checkout Dashboard](../media/checkout/install_dashboard.png)

On this dashboard, click the **Install** button then in the dialog select your site root node which is configured with a Vendr store picker linked to a Vendr store and then click **Install**

![Vendr Checkout Dashboard](../media/checkout/install_dashboard_dialog.png)

During this install, Vendr checkout will perform the following tasks:

1. Create the Vendr Checkout Data Types (Colour picker and checkout step picker)
2. Create the Vendr Checkout Document Types (Checkout page and checkout step page)
3. Create the Vendr Checkout content nodes beneath the select site root node (unpublished)
4. Configure the Vendr store with custom Vendr Checkout email templates and required payment providers

## Upgrading

{% hint style="info" %}
Before upgrading, it is always advisable to take a complete backup of your site/database. Every effort has been made to ensure that Vendr Checkout will upgrade gracefully, but there is always a risk that something may not install as expected.
{% endhint %}

Vendr Checkout uses a combination of database migrations and a manual install dashboard for both installs and upgrades. Upgrading is generally a case of installing the latest version over the top of the existing package and running through the installation steps again.