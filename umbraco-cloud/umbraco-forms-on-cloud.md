# Umbraco Forms on Cloud

In this article, you can learn about how Umbraco Forms is handled on Umbraco Cloud and read about the workflow and best practices.

Umbraco Forms is a package that is included with your Umbraco Cloud project. It gives you a nice integrated UI, where you can create Forms for your website. The package is built specifically for Umbraco and is maintained by Umbraco HQ.

Read more about the product in the [Umbraco Forms](https://docs.umbraco.com/umbraco-forms/) documentation.

## How Forms are handled on Umbraco Cloud

Forms are handled like content and media. This means that you can transfer your Forms between environments, using the same workflow you use for content and media.

Definitions for each specific Form, its fields, workflows, and prevalues are all stored in the Umbraco database.

Entries submitted are not transferred to the next environment, as they are _environment-specific_. If you need to move entries from one environment to another, you need to run an export/import script on the databases.

## Recommended workflow

You can work with Forms in an environment of your choice. When you need to test or use your Forms in another environment you can:

* Transfer the Forms to the next environment using **Queue for transfer** or
* **Restore** the Forms on an environment lower in the workflow.

For more information on how to handle content transfer/restores on Umbraco Cloud, check out the following articles:

* [Transfer content, media and forms](broken-reference)
* [Restoring content](restoring-content.md)

## Upgrades

Umbraco Forms is part of the [auto-upgrades on Umbraco Cloud](product-upgrades/). Whenever a new patch is ready for release, we will automatically apply it to your Cloud project. There will be a notification in the Umbraco Cloud Portal at least 5 days before we roll out new versions.

To avoid having the auto-upgrades overwrite any of your custom settings, we strongly encourage that you use [config transforms](project-settings/config-transforms.md) when you need custom configuration. Additionally, use [Themes](https://docs.umbraco.com/umbraco-forms/developer/themes) when you need to customize your forms.

Whenever a new minor version of Umbraco Forms is ready, eg. 10.x or 11.x, you will get the option to apply the upgrade to your project. When your project is eligible to receive the new version, you will see an "_Upgrade available!_" label on your left-most environment.

### Version-specific changes

In this section, you can find information about version-specific changes that might affect the way Umbraco Forms works on your project.

### Version 9+

In Umbraco Forms version 9.0.0+, it is only possible to store Form data in the database.

If you want to upgrade to Umbraco 9 and are using Forms, you should first migrate the Forms to the database using Forms 8. See the [Umbraco Forms in the Database](https://docs.umbraco.com/umbraco-forms/developer/forms-in-the-database) article.

#### Version 8.5.0

Prior to Umbraco 8.5.0, all forms data was saved as `.json` files in the `App_Data/UmbracoForms` directory in the file system.

As of Umbraco 8.5.0, you have the option to persist all Forms data directly in the database. This behavior defaults to all new sites created on Umbraco Cloud since September 2020. If your Cloud project was created before, you will need to upgrade the Umbraco Forms version. Additionally, apply a setting to perform the migration of the Umbraco Forms data.

To switch to persisting all definitions for Umbraco Forms data in the Umbraco database, follow these steps:

1. Make sure all environments are upgraded to **at least Umbraco Forms version 8.5.2 and Deploy 3.5.0**.
2. Make sure your Forms are in sync between all your Cloud environments.
3. Clone down your left-most environment.
4. Restore content and Forms to the local clone.
5. Open the configuration file `App_Plugins\UmbracoForms\UmbracoForms.config` from your local clone.
6.  Add the following key in the `<settings>` section and make sure the value is set to `True`:

    ```xml
    <setting key="StoreUmbracoFormsInDb" value="True" />
    ```
7. Save the file.
8. Spin up your local clone and verify that everything works as expected.

Now it is time to deploy the setting to your Cloud environments.

Follow the steps outlined below **for each environment** for the migration to run on each of them.

1. Access **KUDU**.
2. Navigate to `site/wwwroot/App_Data`.
3. Delete the `UmbracoForms` directory.
4. Push the updated setting to the environment.
5. To run the migration, **restart the environment** from the Cloud portal.
6. From the Umbraco Backoffice, **Queue and transfer** the Forms to the environment.
7. Repeat steps 1-5 for each of your Cloud environments.

**Did you create your project before June 2018?**

Then your Umbraco Forms data might still be handled as metadata.

You will need to follow the steps below to persist Umbraco Forms data in the Umbraco database.

1. Find and open `Config\UmbracoDeploy.settings.config` on your local machine.
2.  Update the `transferFormsAsContent` value to `true`:

    ```xml
    <?xml version="1.0" encoding="utf-8"?>
    <settings xmlns="urn:umbracodeploy-settings">
       <forms transferFormsAsContent="true" />
    </settings>
    ```
3. Remove all existing `data\revision\forms-form__*.uda` files, so it's not possible to accidentally revert to this state (removing `UDA` files won't remove the actual form on deploy).
4. Push the change back to the Cloud environment.
   * If you have more than one Cloud environment, make sure to deploy the change through to all of them.
5. You are now able to queue your Forms for transfer between the Cloud environments, like content and media.

If you do not have the `transferFormsAsContent` setting in the `UmbracoDeploy.settings.config` file, you do not need to make any further changes.

## Common issues with Umbraco Forms on Cloud

### The Forms tree is missing

Sometimes you might experience that you lose the tree in the Forms section in the backoffice after a deployment. To get the tree back, all you need to do is **restart the environment** from the Umbraco Cloud Portal.
