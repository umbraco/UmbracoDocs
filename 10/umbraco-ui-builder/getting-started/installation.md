---
description: Installing Konstrukt, the backoffice UI builder for Umbraco.
---

# Installation

Konstrukt is installed via the NuGet package manager by issuing the following command in your web project.

```bash
dotnet add package Konstrukt
```

If you wish to install Konstrukt into a class library without the UI elements, you can add a reference to the `Konstrukt.Startup` package instead.

```bash
dotnet add package Konstrukt.Startup
```

Alternatively, you can also find and install the NuGet package via the NuGet Package Manager GUI in Visual Studio.

## Upgrading

{% hint style="info" %}
**NB:** Before upgrading, it is always advisable to take a complete backup of your site/database. Every effort has been made to ensure that Konstrukt will upgrade gracefully, but there is always a risk that something may not install as expected.
{% endhint %}

Konstrukt uses Umbraco Migrations to install all of its features meaning upgrades follow the exact same process as the installation processes detailed above, installing the latest version of a package over the top of the existing package installation. Konstrukt is then clever enough to detect the current state of your site and only install the features that are missing.

## Installing a License 

Once you have purchased a license you can install it by dropping the license file directly into your sites `umbraco\Licenses` folder. Konstrukt will automatically scan this directory for any valid licenses.

If you need to store your licenses in an alternative directory, you can change where Konstrukt looks for licenses by setting a `Konstrukt.Licensing.LicensesDirectory` app setting with a path to the alternative location. 

{% hint style="info" %}
**When do i need a license?**

Konstrukt is fully functional during development, and whilst it is hosted on a local server (`localhost` or `.local` domains).

Hosting on a public domain without a license will be restricted to the management of a single collection. To manage more than one collection will require a full and valid license for the admin domain to be installed.

If you require an unrestricted staging environment, all licenses support two methods of allowing this:  

* `staging.client.com` - Licenses allow unlimited subdomains so you can host the staging site on a subdomain of the licensed domain  
* `clientcom.agency.com` - Licenses allow a concatenation of the licensed domain as a subdomain of any other domain  

If you wish to host the site on any other URL, then an additional license file will be required for that domain.  
{% endhint %}
