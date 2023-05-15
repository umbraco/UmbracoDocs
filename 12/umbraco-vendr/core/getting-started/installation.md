---
description: Installing Vendr, the eCommerce solution for Umbraco.
---

# Installation

Learn how to install Umbraco Vendr into your Umbraco CMS implementation.

You can also find information about how to upgrade and how to install and activate your Umbraco Vendr license.

## NuGet Package Installation

Vendr is available via [NuGet.Org](https://www.nuget.org/packages/Vendr/).

To install Vendr via NuGet you can run the following command directly in the NuGet Manager Console window:

```bash
PM> dotnet add package Vendr
```

Alternatively, you can also find and install the NuGet package via the NuGet Package Manager in Visual Studio. You will see a number of packages available, however you will want to install the main **Vendr** package.

![Installing Vendr via the NuGet Package Manager](../media/nuget_package_manager_gui.png)

For most sites using a single solution, the above will be all you need to install Vendr into your project. When you have a more complex solution structure consisting of multiple projects, Vendr is available in multiple sub-packages with varying dependencies.

* **Vendr.Common** A shared project of common, non Vendr specific patterns and helpers.
* **Vendr.Core** The core Vendr functionality that doesn't require any infrastructure specific dependencies.
* **Vendr.Infrastructure** Infrastructure specific project containing implementations of core Vendr functionality.
* **Vendr.Persistence** Persistence specific project containing implementations of core Vendr persistence functionality.
* **Vendr.Persistence.SqlServer** Persistence specific project containing implementations of core Vendr persistence functionality for SQL Server.
* **Vendr.Persistence.Sqllite** Persistence specific project containing implementations of core Vendr persistence functionality for SQLite.
* **Vendr.Web** The core Vendr functionality that requires a web context.
* **Vendr.Umbraco** The Vendr functionality that requires an Umbraco dependency.
* **Vendr.Umbraco.Web** The Vendr functionality for the Umbraco presentation layer.
* **Vendr.Umbraco.Web.UI** The static Vendr assets for the Umbraco presentation layer.
* **Vendr.Umbraco.Startup** The Vendr functionality for registering Vendr with Umbraco.
* **Vendr** The main Vendr package entry point package.

## Upgrading

{% hint style="warning" %}
Before upgrading, it is always advisable to take a complete backup of your site anddatabase.
{% endhint %}

Vendr uses Umbraco Migrations to install all of it's features. Upgrades follow the same process as the installation processes detailed above, by installing the latest version over the top of the existing package installation. By using this process the installation will only install new features and features that are missing.

## Installing a License

Once you have purchased a license you can install it by dropping the license file directly into your sites `umbraco\Licenses` folder. Vendr will automatically scan this directory for any valid licenses.

When you need to store your licenses in an alternative directory, you can change where Vendr looks for licenses. This is done by setting a `Vendr.Licensing.LicensesDirectory` appSetting with a path to the alternative location.

{% hint style="info" %}
You only need to install your license when you are ready to go live.

Vendr is fully functional during development, and whilst it is hosted on a local server (`localhost` or `.local` domains).

You can also host a staging site on a `*.azurewebsite.net` or `*.umbraco.io` (Umbraco Cloud) domain without the need of a license.

Hosting on any other public domains without a license will be limited to a maximum of 20 orders.

If you require an unrestricted staging environment, all licenses support two methods of allowing this:  

* `staging.client.com` - Licenses allow unlimited subdomains, meaning you can host the staging site on a subdomain of the licensed domain.
* `clientcom.agency.com` - Licenses allow a concatenation of the licensed domain as a subdomain of any other domain.

If you wish to host the site on any other URL, then an additional license file will be required for that domain.

Learn more about the licensing model in the [Licensing article]().
{% endhint %}
