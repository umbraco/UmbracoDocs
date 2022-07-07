---
versionFrom: 7.0.0
---

# System Requirements

## Browsers

The Umbraco UI should work in all modern browsers:

* Firefox (Latest)
* Chrome (Latest)
* Safari (Latest)
* IE10+ (will not always work correctly in lower versions)
* Edge

## Local Development

* Microsoft Windows 7 SP1
* [Visual Studio Code](https://code.visualstudio.com/) with the [IISExpress extension](https://marketplace.visualstudio.com/items?itemName=warren-buckley.iis-express) or [Microsoft Visual Studio](https://www.visualstudio.com/) 2017 (2015 with a C# compiler plug-in may work but not painlessly)
* ASP.NET 4.5+ Full-Trust

## Hosting

* IIS 7+
* SQL CE, SQL Server 2008 and higher or MySQL (in case insensitive mode)
* ASP.NET 4.5 Full-Trust
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
