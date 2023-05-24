---
description: >-
  Learn how to install and add payment providers to your Umbraco Commerce
  implementation.
---

# Install payment providers

When you need to install a payment provider into your Umbraco Commerce implementation it is done via NuGet.

The installation can be handled in one of two ways as explained below.

## Install via the NuGet Manager Console

1. Open the NuGet Manage Console.
2. Type in the following command:

```bash
PM> Install-Package Vendr.PaymentProviders.PROVIDER
```

Use the [table of available Payment Providers](install-payment-providers.md#available-payment-providers) to ensure you get the correct package name for the provider you want to install.

## Install via the NuGet Package Manager

1. Open the NuGet Package Manager.
2. Search for the Payment Provider you want to install.
3. Ensure the "Browse" tab is selected.
4. Install the package into your solution.

Alternatively, you can also find and install the NuGet package via the NuGet Package Manager.

![Installing Vendr via the NuGet Package Manager](media/nuget-package-manager-gui.png)

## Available Payment Providers

| Payment Provider | NuGet Package name                 |
| ---------------- | ---------------------------------- |
| Invoicing        | `Vendr.PaymentProviders.Invoicing` |
| Klarna           | `Vendr.PaymentProviders.Klarna`    |
| Mollie           | `Vendr.PaymentProviders.Mollie`    |
| Nets             | `Vendr.PaymentProviders.Nets`      |
| Paypal           | `Vendr.PaymentProviders.PayPal`    |
| QuickPay         | `Vendr.PaymentProviders.QuickPay`  |
| Stripe           | `Vendr.PaymentProviders.Stripe`    |

## Upgrading

{% hint style="info" %}
Before upgrading, it is always advisable to take a complete backup of your site/database. Every effort has been made to ensure that Vendr will upgrade gracefully, but there is always a risk that something may not install as expected.
{% endhint %}

Vendr uses Umbraco Migrations to install all of its features. Install the latest version of a package over the top of the existing package installation. Vendr is then clever enough to detect the current state of your site and only install the features that are missing.
