---
versionFrom: 7.0.0
---

# Working with databases

:::note
The databases on your Umbraco Cloud environments are specific to their environment. This means that no matter what you have configured in the `connectionstring` in your `web.config` file, we overwrite the connectionstring to use the SQL Azure Server we provide.
:::

When working with Umbraco Cloud, the way you work with databases might differ from what you're used to. One important aspect of Umbraco Cloud is that you always work isolated to avoid interfering with colleagues or a running website. This includes the database as well.

So when you clone a site locally, Umbraco Cloud automatically creates a local database and populates it with data from your website running on the Cloud. If you don't specify anything before starting up your site locally, it'll be a SQL CE database that lives in the `/App_Data` folder. If you wish to use a local SQL Server instead, you can update the connection string in the web.config, but it's important that you do so before your site start up the first time.

## LocalDB

## SQL Management Studio

## Backups

## Moving on
Now that you've connected you can work with the databases on Umbraco Cloud, like you could on any other host. Just remember to let Umbraco Cloud do the work when it comes to the Umbraco related tables (`Umbraco*` and `CMS*` tables).
