---
description: >-
  Explanation on how to work with an Umbraco Cloud database locally, connecting
  to your local database using Visual Studio and working with custom tables in
  the Cloud database
---

# Working with a Cloud database locally

This article covers how you can connect to the database of your local project and how you can work with custom tables on Umbraco Cloud.

## Connecting to your local Umbraco installation

When cloning down your project to work locally you might want to have a look in your database every now and then.

Since Umbraco 10, **SQL CE** is no longer supported, instead, Umbraco now comes with **SQLite** out of the box.&#x20;

When cloning down your Umbraco project and restoring its content, it will create a `Umbraco.sqlite.db` file in `~/umbraco/Data/Umbraco.sqlite.db`.

To view your local SQLite database, you will need to use a program like [DB Browser for SQLite](https://sqlitebrowser.org/) or a Visual Studio extension like [SQLite and SQL Server Compact Toolbox](https://marketplace.visualstudio.com/items?itemName=ErikEJ.SQLServerCompactSQLiteToolbox).

You can also configure your project to prefer SQL Server LocalDb when it's available on your local machine by enabling the Deploy [`PreferLocalDbConnectionString`](https://docs.umbraco.com/umbraco-deploy/deploy-settings#preferlocaldbconnectionstring) setting.

To configure your database, you can add the connection string in the 'appsettings.json' file. For more information, see the [Configure your database](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/install/unattended-install#configure-your-database) section in the [Unattended Installs](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/install/unattended-install) article.

## Using Custom Tables with Umbraco Cloud

Umbraco Cloud will ensure that your Umbraco-related data is always up to date, but it won't know anything about data in custom tables unless told. This is like any other host when it comes to non-Umbraco data.

However, you have full access to the SQL Azure databases running on Umbraco Cloud. You can create custom tables like you'd expect on any other hosting provider. The easiest way to do this is to [connect using SQL Management Studio](./#connecting-to-your-cloud-database-locally).

The recommended way of making sure custom tables are present is to use Migrations. This is to ensure that the tables will be created or altered when starting your site.&#x20;

Migrations will ensure if you add environments to your Umbraco Cloud site, the tables in the newly created databases will automatically be created for you.&#x20;

Check the [Creating a Custom Database table](https://docs.umbraco.com/umbraco-cms/extending/database) for an example of how to create and use Migrations.
