---
versionFrom: 8.0.0
---

# Minimum System Requirements

## Browsers

The Umbraco UI should work in all modern browsers:

* Chrome (Latest)
* Edge (Chromium)
* Firefox (Latest)
* Safari (Latest)

## Local Development

* Microsoft Windows 7 SP1
* [Visual Studio Code](https://code.visualstudio.com/) with the [IISExpress extension](https://marketplace.visualstudio.com/items?itemName=warren-buckley.iis-express) or [Microsoft Visual Studio](https://www.visualstudio.com/) 2017 **version 15.9.6 and higher**
* ASP.NET 4.7.2

## Hosting

* IIS 8 and higher
* SQL CE, SQL Server 2012 and higher
* ASP.NET 4.7.2
* Ability to set file permissions to include create/read/write (or better) for the user that "owns" the Application Pool for your site (NETWORK SERVICE, typically)

:::tip
You can use Umbraco Cloud to manage the hosting infrastructure. All Umbraco Cloud plans are hosted on Microsoft Azure, which gives your site a proven and solid foundation.
:::

:::note
Umbraco will not run on ASP.NET Core
:::

## Database Account Roles

The database account used in the connection string will need permissions to read and write from tables as well as create schema during installs and upgrades:

* The `db_owner` role has full permissions on the database.

* To use an account with more restricted permissions, the `db_datareader` and `db_datawriter` roles will be needed for normal use to read from and write to the database. The `db_ddladmin` role, which can modify the database schema, is required for installs and upgrades of the CMS and/or any packages that create database tables.

For more information on the Database-level roles, see the [Microsoft documentation](https://docs.microsoft.com/en-us/sql/relational-databases/security/authentication-access/database-level-roles?view=sql-server-ver16#fixed-database-roles).
