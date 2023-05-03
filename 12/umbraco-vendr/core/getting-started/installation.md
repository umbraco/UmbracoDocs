---
title: Installation
description: Installing Vendr, the eCommerce solution for Umbraco
---

A change in Umbraco v10 from earlier versions is that it now [only supports NuGet packages](https://umbraco.com/blog/packages-in-umbraco-9-via-nuget/) and so this is the only way Vendr for v10 can be installed.

## NuGet Package Installation

Vendr is also available via [NuGet.Org](https://www.nuget.org/packages/Vendr/).

To install Vendr via NuGet you can run the following command directly in the NuGet Manager Console window:

```bash
PM> dotnet add package Vendr
```

Alternatively, you can also find and install the NuGet package via the NuGet Package Manager GUI. You will see a number of packages available, however you will want to install the main **Vendr** package.

![Installing Vendr via the NuGet Package Manager GUI](../media/nuget_package_manager_gui.png)

For most basic sites using a single solution/project, this should be all you need to install Vendr into your project. If you have a more complex solution structure however, consisting of multiple projects, Vendr is available in multiple sub-packages with varying dependencies.

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

<message-box type="warn" heading="Before you upgrade">

Before upgrading, it is always advisable to take a complete backup of your site/database. Every effort has been made to ensure that Vendr will upgrade gracefully, but there is always a risk that something may not install as expected.

</message-box>

Vendr uses Umbraco Migrations to install all of it's features meaning upgrades follow the exact same process as the installation processes detailed above, installing the latest version of a package over the top of the existing package installation. Vendr is then clever enough to detect the current state of your site and only install the features that are missing.

## Installing a License 

Once you have purchased a license you can install it by dropping the license file directly into your sites `umbraco\Licenses` folder. Vendr will automatically scan this directory for any valid licenses.

If you need to store your licenses in an alternative directory, you can change where Vendr looks for licenses by setting a `Vendr.Licensing.LicensesDirectory` app setting with a path to the alternative location. 

<message-box type="info" heading="When do i need a license?">

You only need to install a license when you are ready to go live. 

Vendr is fully functional during development, and whilst it is hosted on a local server (`localhost` or `.local` domains).

You can also host a staging site on a `*.azurewebsite.net` or `*.umbraco.io` domain without the need of a license. 

Hosting on any other public domains without a license will be limited to a maximum of 20 orders.

If you require an unrestricted staging environment, all licenses support two methods of allowing this:  

* `staging.client.com` - Licenses allow unlimited subdomains so you can host the staging site on a subdomain of the licensed domain  
* `clientcom.agency.com` - Licenses allow a concatenation of the licensed domain as a subdomain of any other domain  

If you wish to host the site on any other URL, then an additional license file will be required for that domain.  

</message-box>
