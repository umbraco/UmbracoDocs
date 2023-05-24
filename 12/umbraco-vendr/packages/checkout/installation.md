---
description: >-
  Detailed instructions on how to install and configure Checkout into your
  Umbraco Vendr implementation.
---

# Installation

The Checkout package can be installed directly into your project's code base using NuGet packages.

## NuGet Package Installation

To install the Vendr Checkout package via NuGet run the following command directly in the NuGet Manager Console window in Visual Studio:

```bash
PM> Install-Package Vendr.Checkout
```

Alternatively, you can also find and install the NuGet package via the NuGet Package Manager.

![Installing Vendr Checkout via the NuGet Package Manager](../media/checkout/nuget\_package.png)

## Content Installation

When the Checkout package is installed, all relevant database configurations automatically occur via Umbraco Migrations. There are a series of content creation steps that need to be triggered manually as these types of migrations are not supported by Umbraco.

To install the relevant Checkout content follow these steps:

1. Access the Umbraco CMS backoffice.
2. Navigate to the **Settings** section.
3. Locate the **Checkout Dashboard**.

![The Checkout Dashboard in the Settings section of the Umbraco backoffice.](../media/checkout/install\_dashboard.png)

4. Click the **Install** button.
5. Select your site's root node which is configured with a Vendr store.
6. Click **Install**.

![The dialog that appears when installing content through the Checkout dashboard.](../media/checkout/install\_dashboard\_dialog.png)

During this install, Vendr checkout will perform the following tasks:

* [x] Create the Vendr Checkout Data Types (Colour picker and checkout step picker).
* [x] Create the Vendr Checkout Document Types (Checkout page and checkout step page).
* [x] Create the Vendr Checkout content nodes beneath the select site root node (unpublished).
* [x] Configure the Vendr store with custom Vendr Checkout email templates and required payment providers.

## Upgrading

{% hint style="info" %}
Before upgrading, it is always advisable to take a complete backup of your site/database.
{% endhint %}

The Checkout package uses a combination of database migrations and a manual install dashboard for both installs and upgrades. Upgrading is generally a case of installing the latest version over the existing package and running through the installation steps.
