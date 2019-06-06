---
versionFrom: 8.1.0
---
# Migrating content to Umbraco 8

Umbraco 8 contains a lot of breaking changes and a lot of code has been cleaned up compared to Umbraco 7. Due to this, it will not be possible to do a simple upgrade from Umbraco 7 to Umbraco 8. Instead you will need to **migrate your content** from your Umbraco 7 site into your Umbraco 8 site and then recreate the rest in the new version.

A content migration tool has been implemented in Umbraco 8.1.0, to help you with the transition.

In this guide you can read more about the tool, it's limitations and how to use it in practice.

## Limitations

### Versions supported

The content migration tool is a database migration, which is made for the database schema of Umbraco 7.14+. This means that in order to do the migration the first step is to ensure your Umbraco 7 site is running at least Umbraco 7.14.

### Database types supported

As Umbraco 8 doesn't support MySQL databases the migration will not work when moving from an Umbraco 7 site using MySQL to Umbraco 8 on SQL server for example.
The database types that are supported are SQL Server and SQL CE.

### Third party property editors

The migration will transfer the data stored in third party editors as well, however it will simply be stored as it was in Umbraco 7. If the structure has changed for Umbraco 8 or the property editor doesn't exist you will still be able to find the data in the database, but you would not see it in the backoffice.

## How does it work?

In the following guide we will try to migrate the content of an Umbraco 7.13.1 site to Umbraco 8.1.0.

### Step 1: Upgrading to 7.14

Before the content migration can start the site has to be 7.14+. A good idea would be to **always take a database backup** before doing an upgrade, and then check the [version specific upgrade instructions](version-specific.md).

The site in this example is an Umbraco 7.13.1 site, and we will use Nuget to update it.

It is a fairly simple site, with a bit of content:

![v7 site with content](images/v7-content.png)

Following the [general upgrade instructions](general.md) we will now upgrade via Nuget until we get to this point:

![Upgrading to v7.14](images/upgrading-7.14.png)

Once it is upgraded and you have verified everything is working, move on to step 2.

### Step 2: Migrating content to Umbraco 8

:::note
Before migrating the content it is adviseable to create a backup of the database, so if anything goes wrong you can start over with the original data.
:::

First thing to do is spin up a fresh new Umbraco 8.1+ site. Make sure it all works and that no content is there (_hint:_ choose not to install starter kit).

![Fresh 8.1 site](images/fresh-8.1-site.png)

Now you should go to the **Umbraco 7.14 site**, grab the connectionstring and add that to the **Umbraco 8.1 site**. Do note that if you are running SQL CE, you will have to copy the database over to the new site as well.

Once the connection string is set, the final step is to change the Umbraco version number in the web.config on the **Umbraco 8.1 site**, to say 7.14.0. This will mean that it thinks there is an upgrade as the Umbraco dlls are 8.1 but the config says 7.14 it needs to run the upgrade.

![Set Umbraco version in the web.config](images/set-umbraco-version.png)

When you start the site it will ask you to login and then show you this screen:

![Upgrade database to 8.1](images/upgrade-to-8.1.png)

That is all! Now the automatic migration will take over, and after a little bit you can log in and see your content:

![Content is on 8.1](images/content-on-8.1.png)

:::note
Please be aware this is just a content migration. If you go to the frontend after doing this nothing will work. You will need to do all templates and implementation work again!
:::
