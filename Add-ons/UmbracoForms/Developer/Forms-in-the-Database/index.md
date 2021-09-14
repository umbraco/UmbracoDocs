---
versionFrom: 8.0.0
---

# Umbraco Forms in the database

As of Umbraco Forms version 8.5.0 it is possible to persist all forms data in the Umbraco database. This includes definitions for each form and their fields, as well as workflow definitions and prevalues.

In this article you will find instructions on how to migrate your Umbraco Forms data to the database.

:::note
As of Umbraco Forms version 9.0.0 it is *only* possible to store form data in the database.  As such, if upgrading to Umbraco 9 and using Forms, you should first migrate the forms to the database using Forms 8.
:::

:::note
**Custom file system providers**

If [custom file system providers are used on your project for storing Umbraco Forms data](../../../../Extending/FileSystemProviders/#custom-providers), the migration will not be able to run.

In order to be able to persist your Umbraco Forms data in the database, you will need to revert back to a **standard Umbraco Forms configuration** using the default provider storing the Forms definition files in the default location.

Then you need to ensure that your Forms definition files are moved from their previous location (this being a non-default file path, blob storage or similar) to the default location, `App_Data/UmbracoForms`, that Forms will now be using.

Your configuration is now considered a standard configuration and you are able to perform the steps required for a normal migration.
:::

## How to enable storing Forms definitions in the database

Follow these steps, in order to persist Umbraco Forms definitions in the database:

1. [Upgrade to at least Umbraco Forms version 8.5.2](../../Installation/ManualUpgrade.md)
2. Open the configuration file `App_Plugins\UmbracoForms\UmbracoForms.config`
3. Locate the `StoreUmbracoFormsInDb` key in the `<settings>` section, and make sure it has the following value:

    ```xml
    <setting key="StoreUmbracoFormsInDb" value="True" />
    ```

4. Save the file

If you are working with an Umbraco Cloud project, make sure you follow the migration steps outlined in the [Umbraco Forms on Cloud](../../../../Umbraco-Cloud/Deployment/Umbraco-Forms-on-Cloud) article.

:::warning
Please be aware that enabling the persisting of Umbraco Forms in the database is irreversable. Once you've made the change, reverting to the file approach will not be an option.
:::

When you save the file, the site will restart and run a migration step, migrating the files to the Umbraco database.

## Migrating forms in files into a site

If you have a Umbraco 8 site running that stores Forms in the database but you have the forms in file-format, you can force Forms to run the migration of those files again.

First of all, you should ensure that you have enabled the setting that persists forms in the database, as the migration requires this (`StoreUmbracoFormsInDb`). We highly recommend that you test this on a local setup before applying it to your live site.

1. Copy over the Forms, workflows, prevaluesources, and datasource files to the site into `~\App_Data\UmbracoForms\Data`.
1. Go to the database and find the `[umbracoKeyValue]` table.
1. Find the forms row and check that the value is `1d084819-84ba-4ac7-b152-2c3d167d22bc` (if not you are not currently working with forms in the database, changing the setting should be enough).
1. Change that value to `{forms-init-complete}`
1. Restart the site.

The site will now try to migrate the forms files into the database. In the umbracoTraceLog you can follow the progress. It will throw errors if anything goes wrong and it will log out "The Umbraco Forms DB table {TableName} already exists" for the 4 Forms tables prior to starting the migration.
