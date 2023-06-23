---
description: >-
  Learn the steps needed in order to install Umbraco Commerce into your Umbraco
  CMS website.
---

# Installation

Learn how to install Umbraco Commerce into your Umbraco CMS implementation.

You can also find information about how to upgrade and how to install and activate your Umbraco Commerce license.

## NuGet Package Installation

Umbraco Commerce is available via [NuGet.Org](https://www.nuget.org/packages/Umbraco.Commerce/).

To install Umbraco Commerce via NuGet you can run the following command directly in the NuGet Manager Console window:

```bash
PM> dotnet add package Umbraco.Commerce
```

Alternatively, you can also find and install the NuGet package via the NuGet Package Manager in Visual Studio. You will see a number of packages available, however, you will want to install the main **Umbraco Commerce** package.

![Installing Umbraco Commerce via the NuGet Package Manager](../media/nuget\_package\_manager\_gui.png)

For most sites using a single solution, the above will be all you need to install Umbraco Commerce into your project. When you have a more complex solution structure consisting of multiple projects, Umbraco Commerce is available in multiple sub-packages with varying dependencies.

<table><thead><tr><th width="282">Sub-package</th><th>Description</th></tr></thead><tbody><tr><td><strong>Umbraco.Commerce.Common</strong></td><td>A shared project of common, non-Vendr-specific patterns and helpers.</td></tr><tr><td><strong>Umbraco.Commerce.Core</strong></td><td>Core Vendr functionality that doesn't require any infrastructure-specific dependencies.</td></tr><tr><td><strong>Umbraco.Commerce.Infrastructure</strong></td><td>Infrastructure-specific project containing implementations of core Vendr functionality.</td></tr><tr><td><strong>Umbraco.Commerce.Persistence.SqlServer</strong></td><td>Persistence-specific project containing implementations of core Vendr persistence functionality for SQL Server.</td></tr><tr><td><strong>Umbraco.Commerce.Persistence.Sqllite</strong></td><td>Persistence-specific project containing implementations of core Vendr persistence functionality for SQLite.</td></tr><tr><td><strong>Umbraco.Commerce.Web</strong></td><td>Core Vendr functionality that requires a web context.</td></tr><tr><td><strong>Umbraco.Commerce.Cms</strong></td><td>Core Vendr functionality that requires an Umbraco dependency.</td></tr><tr><td><strong>Umbraco.Commerce.Cms.Web</strong></td><td>The Vendr functionality for the Umbraco presentation layer.</td></tr><tr><td><strong>Umbraco.Commerce.Cms.Web.UI</strong></td><td>The static Vendr assets for the Umbraco presentation layer.</td></tr><tr><td><strong>Umbraco.Commerce.Cms.Startup</strong></td><td>The Vendr functionality for registering Vendr with Umbraco.</td></tr><tr><td><strong>Umbraco.Commerce</strong></td><td>The main Vendr package entry point package.</td></tr></tbody></table>

## Upgrading

{% hint style="warning" %}
Before upgrading, it is always advisable to take a complete backup of your site and database.
{% endhint %}

Umbraco Commerce uses Umbraco Migrations to install all of its features. Upgrades follow the same process as the installation processes detailed above, by installing the latest version over the top of the existing package installation. By using this process the installation will only install new features and features that are missing.

## Installing a License

Once you have purchased a license it needs to be installed on your site.

1. Open the root directory for your project files.
2. Locate and open the `appSettings.json` file.
3. Add your Umbraco Commerce license key to `Umbraco:Licenses:Umbraco.Commerce`:

```json
"Umbraco": {
  "Licenses": {
    "Umbraco.Commerce": "YOUR_LICENSE_KEY"
  }
}
```

{% hint style="info" %}
You only need to install your license when you are ready to go live.

Umbraco Commerce is fully functional during development, and whilst it is hosted on a local server (`localhost` or `.local` domains).

Hosting on any other public domain without a license will be limited to a maximum of 20 orders.

If you require an unrestricted staging environment, all licenses support two methods of allowing this:

* `staging.client.com` - Licenses allow unlimited subdomains, meaning you can host the staging site on a subdomain of the licensed domain.
* `clientcom.agency.com` - Licenses allow a concatenation of the licensed domain as a subdomain of any other domain.

If you wish to host the site on any other URL like a public development domain, reach out to [suits@umbraco.com](mailto:suits@umbraco.com) for a test license.
{% endhint %}
