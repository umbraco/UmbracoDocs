---
description: >-
  Learn how to install and add sales tax providers to your Umbraco Commerce
  implementation.
---

# Install Sales Tax Providers

When you need to install a payment provider into your Umbraco Commerce implementation it is done via NuGet.

You can install a payment provider in one of two ways:

## Install via the NuGet Manager Console

1. Open the **NuGet Manager Console**.
2. Enter the following command:

```bash
Install-Package Umbraco.Commerce.SalesTaxProviders.PROVIDER
```

3. Use the available [Sales Tax Providers](install-sales-tax-providers.md#available-sales-tax-providers) table below to find the correct package name for the provider you want to install.

## Install via the NuGet Package Manager

1. Open the NuGet Package Manager.
2. Browse for the Sales Tax Provider you want to install.
3. Install the package into your solution.

Alternatively, you can also find and install the NuGet package via the NuGet Package Manager.

![Installing Umbraco Commerce via the NuGet Package Manager](media/nuget-package-manager-gui-latest.png)

## Available Sales Tax Providers

<table><thead><tr><th width="181">Sales Tax Provider</th><th>NuGet Package name</th></tr></thead><tbody>

<tr><td>TaxJar</td><td><code>Umbraco.Commerce.SalesTaxProviders.TaxJar</code></td></tr>

</tbody></table>

## Upgrading

{% hint style="warning" %}
Before upgrading, always backup your site and database.
{% endhint %}

Umbraco Commerce uses Umbraco Migrations to install all of its features.  To upgrade, install the latest version over the existing package. This process will add new features and update any missing components.
