# Requirements

## Browsers

The Umbraco UI works in all modern browsers:

* Chrome (Latest)
* Edge (Chromium)
* Firefox (Latest)
* Safari (Latest)

## Local Development

* Either OS:
  * Microsoft Windows 10 or 11
  * MacOS High Sierra 10.13
  * Linux (Ubuntu, Alpine, CentOS, Debian, Fedora, openSUSE and other major distributions)
* One of the following .NET Tools or Editors:
  * [Visual Studio Code](https://code.visualstudio.com/) with the [IISExpress extension](https://marketplace.visualstudio.com/items?itemName=warren-buckley.iis-express)
  * [Microsoft Visual Studio](https://www.visualstudio.com/) 2022 v17.4
  * [JetBrains Rider](https://www.jetbrains.com/rider) **version 2022.3 and higher**
  * .NET Core CLI
* .NET 7.0
* SQL connection string (SQL Server)

{% hint style="info" %}
When using Visual Studio as your primary Integrated Development Environment (IDE) we recommend [finding and downloading the Software Development Kits (SDKs) for Visual Studio](https://dotnet.microsoft.com/en-us/download/visual-studio-sdks).
{% endhint %}

## Hosting

### Recommendation

For the best experience, we would recommend that you ensure your hosting environment has the following to run Umbraco CMS:

* Windows Server 2019 and higher
* IIS 10 and higher
* SQL Server 2019 and higher
* .NET 7.0
* Ability to set file permissions to include create/read/write (or better) for the user that "owns" the Application Pool for your site (NETWORK SERVICE, typically)

{% hint style="success" %}
You can use [Umbraco Cloud](https://umbraco.com/products/umbraco-cloud/) to manage the hosting infrastructure. All Umbraco Cloud plans are hosted on Microsoft Azure, which gives your site a proven and solid foundation.
{% endhint %}

### Miminium requirements to run Umbraco

Umbraco can run on an environment with the minimum requirements stated below:

* Windows Server 2012 R2 and higher
* IIS 8.5 and higher
* SQL Server 2012 and higher / SQLite 3.38.0 or higher
* .NET 7.0
* Ability to set file permissions to include create/read/write (or better) for the user that "owns" the Application Pool for your site (NETWORK SERVICE, typically)

_For more information, see the_ [_Host and deploy ASP.NET Core applications_](https://learn.microsoft.com/en-us/aspnet/core/host-and-deploy/?view=aspnetcore-7.0) _article in the Microsoft documentation._

## Database Account Roles

The database account used in the connection string will need permissions to read and write from tables. It will also require permission to create schema during installs and upgrades:

* The `db_owner` role has full permissions on the database.
* To use an account with more restricted permissions, the `db_datareader` and `db_datawriter` roles will be needed for normal use to read from and write to the database. The `db_ddladmin` role, which can modify the database schema, is required for installs and upgrades of the CMS and/or any packages that create database tables.

For more information on the Database-level roles, see the [Microsoft documentation](https://docs.microsoft.com/en-us/sql/relational-databases/security/authentication-access/database-level-roles?view=sql-server-ver16#fixed-database-roles).
