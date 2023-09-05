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

{% hint style="warning" %}
Before upgrading, it is always advisable to take a complete backup of your site and database.
{% endhint %}

Umbraco UI Builder uses Umbraco Migrations to install all of its features. Upgrades follow the same process as the installation processes detailed above, by installing the latest version over the top of the existing package installation. By using this process the installation will only install new features and features that are missing.

## Installing a License

See the [Licensing page](licensing-model.md#installing-your-license) for details on how to install a license.
