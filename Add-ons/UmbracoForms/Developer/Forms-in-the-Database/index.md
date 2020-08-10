---
versionFrom: 8.0.0
---

# Umbraco Forms in the database

As of Umbraco Forms version 8.5.0 all forms meta data is saved to the Umbraco database. This includes definitions for each form and their fields, as well as workflow definitions and prevalues.

If your site has been upgraded to Umbraco Forms 8.5.0+ from an older version, you now have the option to opt-in on making use of persisting Umbraco Forms definitions in the Umbraco database.

In this article you will find instructions on how to switch to persision Umbraco Forms definitions in the database.

## How to enable storing Forms definitions in the database

:::warning
Please be aware that enabling the persistance of Umbraco Forms in the database is irreversable. Once you've made the change, reverting to the file approach will not be an option.
:::

Follow these steps, in order to perstist Umbraco Forms definitions in the database:

1. Open the configuration file `App_Plugins\UmbracoForms\UmbracoForms.config`
2. In the `<settings>` section of the configuration, add

    ```code
    <setting key=“StoreUmbracoFormsInDb” value=“True” />
    ```

3. Save the file

When you save the file, the site will restart and run a migration step, migrating the files to the database.
