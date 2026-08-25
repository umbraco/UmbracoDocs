---
description: >-
  Detailed instructions on how to install and configure Checkout into your
  Umbraco Commerce implementation.
---

# Installation

The Checkout package can be installed directly into your project's code base using NuGet packages.

## NuGet Package Installation

To install the Umbraco Commerce Checkout package via NuGet run the following command directly in the NuGet Manager Console window in Visual Studio:

```bash
PM> Install-Package Umbraco.Commerce.Checkout
```

Alternatively, you can also find and install the NuGet package via the NuGet Package Manager.

![Installing Umbraco Commerce Checkout via the NuGet Package Manager.](<../media/checkout/15_nuget_package_manager.png>)

## Content Installation

When the Checkout package is installed, all relevant database configurations automatically occur via Umbraco Migrations. There are a series of content creation steps that need to be triggered manually as these types of migrations are not supported by Umbraco.

To install the relevant Checkout content follow these steps:

1. Access the Umbraco CMS backoffice.
2. Navigate to the **Settings** section.
3. Locate the **Checkout Dashboard**.

![The Checkout Dashboard in the Settings section of the Umbraco backoffice.](<../media/checkout/15_dashboard.png>)

4. Click the **Install** button.
5. Select your site's root node which is configured with a Umbraco Commerce store.
6. Click **Install**.

![The dialog that appears when installing content through the Checkout dashboard.](<../media/checkout/15_install_modal.png>)

During this install, Umbraco Commerce checkout will perform the following tasks:

* [x] Create the Umbraco Commerce Checkout Data Types (Colour picker and checkout step picker).
* [x] Create the Umbraco Commerce Checkout Document Types (Checkout page and checkout step page).
* [x] Create the Umbraco Commerce Checkout content nodes beneath the select site root node (unpublished).
* [x] Configure the Umbraco Commerce store with custom Umbraco Commerce Checkout email templates and required payment providers.

## Upgrading

{% hint style="info" %}
Before upgrading, it is always advisable to take a complete backup of your site/database.
{% endhint %}

The Checkout package uses a combination of database migrations and a manual install dashboard for both installs and upgrades. Upgrading is generally a case of installing the latest version over the existing package and running through the installation steps.
