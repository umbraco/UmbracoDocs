---
versionFrom: 8.0.0
---

# Umbraco Forms in the database

As of Umbraco Forms version 8.5.0 it is possible to persist all forms data in the Umbraco database. This includes definitions for each form and their fields, as well as workflow definitions and prevalues.

In this article you will find instructions on how to migrate your Umbraco Forms data to the database.

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
