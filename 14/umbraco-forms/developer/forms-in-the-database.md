# Umbraco Forms in the Database

In Umbraco Forms, it is _only_ possible to store Form data in the database.

If you are upgrading to Umbraco 9 or later and using Forms, you should first migrate the Forms to the database using Forms 8. As of Umbraco Forms version 8.5.0 it is possible to persist all Forms data in the Umbraco database. This includes definitions for each Form and their fields, as well as workflow definitions and prevalues.

{% hint style="info" %}
**Custom file system providers**

If [custom file system providers are used on your project for storing Umbraco Forms data](https://docs.umbraco.com/umbraco-cms/extending/filesystemproviders#custom-providers), the migration will not be able to run.

To persist your Umbraco Forms data in the database, you will need to revert to a **standard Umbraco Forms configuration**. Use the default provider to store the Forms definition files in the default location.

You need to ensure that your Forms definition files are moved from their previous location. This is a non-default file path, blob storage, or similar to the default location, `App_Data/UmbracoForms`, that Forms will now be using.

Your configuration is now considered a standard configuration and you can perform the steps required for a normal migration.
{% endhint %}

## Enable storing Forms definitions in the database

To persist Umbraco Forms definitions in the database, follow these steps:

1. Upgrade to at least Umbraco Forms version 8.5.2.
2. Open the configuration file `App_Plugins\UmbracoForms\UmbracoForms.config`.
3. Locate the `StoreUmbracoFormsInDb` key in the `<settings>` section, and make sure it has the following value:

    ```xml
    <setting key="StoreUmbracoFormsInDb" value="True" />
    ```

4. Save the file.

If you are working with a Umbraco Cloud project, make sure you follow the migration steps outlined in the [Umbraco Forms on Cloud](https://docs.umbraco.com/umbraco-cloud/deployments/umbraco-forms-on-cloud) article.

{% hint style="warning" %}
Enabling the persisting of Umbraco Forms in the database is irreversible. Once you've made the change, reverting to the file approach will not be an option.
{% endhint %}

When you save the file, the site will restart and run a migration step, migrating the files to the Umbraco database.

## Migrating Forms in files into a site

You can force Forms to rerun the migration of the file-format Forms if you have a Umbraco 8 site storing Forms in the database.

First of all, you should ensure that you have enabled the setting that persists Forms in the database, as the migration requires this (`StoreUmbracoFormsInDb`) key. We highly recommend testing this on a local setup before applying it to your live site.

1. Copy over the Forms, workflows, prevaluesources, and datasource files to the site into `~\App_Data\UmbracoForms\Data`.
2. Go to the database and find the `[umbracoKeyValue]` table.
3. Find the Form's row and check that the value is `1d084819-84ba-4ac7-b152-2c3d167d22bc` (if not you are not currently working with Forms in the database, changing the setting should be enough).
4. Change that value to `{forms-init-complete}`.
5. Restart the site.

The site will now try to migrate the Forms files into the database. In the umbracoTraceLog, you can follow the progress. It will throw errors if anything goes wrong. Additionally, it will log out "The Umbraco Forms DB table {TableName} already exists" for the 4 Forms tables before starting the migration.
