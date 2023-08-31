---
description: Installing Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Installation

Umbraco UI Builder is installed via the NuGet package manager by issuing the following command in your web project.

```bash
dotnet add package Konstrukt
```

If you wish to install Umbraco UI Builder into a class library without the UI elements, you can add a reference to the `Konstrukt.Startup` package instead.

```bash
dotnet add package Konstrukt.Startup
```

Alternatively, you can also find and install the NuGet package via the NuGet Package Manager graphical user interface (GUI)  in Visual Studio.

## Upgrading

Upgrading means installing the latest version of a package over the top of the existing package installation.

{% hint style="info" %}
**NB:** Before upgrading, it is always advisable to take a complete backup of your site/database. Every effort has been made to ensure that Umbraco UI Builder will upgrade gracefully. However, there is always a risk that something may not install as expected.
{% endhint %}

Umbraco UI Builder uses Umbraco Migrations to install all of its features meaning upgrades follow the same process as the installation processes detailed above.  Umbraco UI Builder is then clever enough to detect the current state of your site and only install the features that are missing.

## Installing a License

Once you have purchased a license you can install it by dropping the license file directly into your site's `umbraco\Licenses` folder. Umbraco UI Builder will automatically scan this directory for any valid licenses.

There is also an alternative directory you can use to store your license if needed. You can change where Umbraco UI Builder looks for licenses by setting a `Konstrukt.Licensing.LicensesDirectory` app setting with a path to the alternative location.

{% hint style="info" %}
**When do i need a license?**

Umbraco UI Builder is fully functional during development, and whilst it is hosted on a local server (`localhost` or `.local` domains).

Hosting in a public domain without a license will be restricted to the management of a single collection. To manage more than one collection it will require a full and valid license for the admin domain to be installed.

If you require an unrestricted staging environment, all licenses support two methods of allowing this:  

* `staging.client.com` - Licenses allow unlimited subdomains so you can host the staging site on a subdomain of the licensed domain  
* `clientcom.agency.com` - Licenses allow a concatenation of the licensed domain as a subdomain of any other domain  

If you wish to host the site on any other URL, then an additional license file will be required for that domain.  
{% endhint %}
