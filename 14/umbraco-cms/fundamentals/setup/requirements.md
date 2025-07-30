# Requirements

## Browsers

The Umbraco UI works in all modern browsers:

* Chrome (Latest)
* Edge (Chromium)
* Firefox (Latest)
* Safari (Latest)

## Local Development

Below you can find the minimum requirements to run Umbraco 14 on your machine:

* [.NET 8.0 and higher](https://dotnet.microsoft.com/en-us/download/dotnet/8.0)
* One of the [.NET 8 - Supported OS versions](https://github.com/dotnet/core/blob/main/release-notes/8.0/supported-os.md#net-8---supported-os-versions)
* One of the following .NET Tools or Editors:
  * [Visual Studio Code](https://code.visualstudio.com/) with the [IISExpress extension](https://marketplace.visualstudio.com/items?itemName=warren-buckley.iis-express)
  * [Microsoft Visual Studio](https://www.visualstudio.com/) 2022 version 17.8 or higher.
    * Optional: [JetBrains Rider](https://www.jetbrains.com/rider) version 2022.3 and higher
  * [.NET Core CLI](install/install-umbraco-with-templates.md)
* [SQL connection string (SQL Server)](../../reference/configuration/connectionstringssettings.md)
* [Node.js version 20.11.0](https://nodejs.org/en/download/prebuilt-installer) and higher

{% hint style="info" %}
When using Visual Studio as your primary Integrated Development Environment (IDE) we recommend [finding and downloading the Software Development Kits (SDKs) for Visual Studio](https://dotnet.microsoft.com/en-us/download/visual-studio-sdks).
{% endhint %}

## Hosting

### Recommendation requirements to run Umbraco

As Umbraco releases are aligned to the .NET release cadence, it's also aligned with Microsoft's Long-term support policy for the underlying framework. For the best experience, we would recommend that you ensure to be on the latest and supported Microsoft versions to run and host Umbraco CMS:

* [Windows Supported releases](https://learn.microsoft.com/en-us/dotnet/core/install/windows?tabs=net70#supported-releases)
* [MacOs Supported releases](https://learn.microsoft.com/en-us/dotnet/core/install/macos#supported-releases)
* [Ubuntu Supported distributions](https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#supported-distributions) and other [Linux Packages](https://learn.microsoft.com/en-us/dotnet/core/install/linux#packages)
* [.NET Supported releases](https://dotnet.microsoft.com/en-us/platform/support/policy)
* [IIS Supported releases](https://learn.microsoft.com/en-us/lifecycle/products/internet-information-services-iis)
* [SQL Server Supported releases](https://learn.microsoft.com/en-us/sql/sql-server/end-of-support/sql-server-end-of-support-overview?view=sql-server-ver16#lifecycle-dates)
* [SQLite](https://www.sqlite.org/index.html)

_For more information, see the_ [_Host and deploy ASP.NET Core applications_](https://learn.microsoft.com/en-us/aspnet/core/host-and-deploy/?view=aspnetcore-7.0) _article in the Microsoft documentation._

{% hint style="success" %}
You can use [Umbraco Cloud](https://umbraco.com/products/umbraco-cloud/) to manage the hosting infrastructure. All Umbraco Cloud plans are hosted on Microsoft Azure, which gives your site a proven and solid foundation.
{% endhint %}

### Other recommendation

* Ability to set file permissions to include create/read/write (or better) for the user that "owns" the Application Pool for your site. This would typically be **NETWORK SERVICE**.

## Database Account Roles

The database account used in the connection string will need permission to read and write from tables. It will also require permission to create schema during installs and upgrades:

* The `db_owner` role has full permissions on the database.
* To use an account with more restricted permissions, the `db_datareader` and `db_datawriter` roles will be needed for normal use to read from and write to the database. The `db_ddladmin` role, which can modify the database schema, is required for installs and upgrades of the CMS and/or any packages that create database tables.

For more information on the Database-level roles, see the [Microsoft documentation](https://docs.microsoft.com/en-us/sql/relational-databases/security/authentication-access/database-level-roles?view=sql-server-ver16#fixed-database-roles).

{% hint style="info" %}
For more information on how to create a database user via SQL, you can check the [Microsoft documentation](https://learn.microsoft.com/en-us/sql/relational-databases/security/authentication-access/database-level-roles?view=sql-server-ver16#a--adding-a-user-to-a-database-level-role).
{% endhint %}
