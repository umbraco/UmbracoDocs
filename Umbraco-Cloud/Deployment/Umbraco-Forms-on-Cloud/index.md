---
versionFrom: 7.0.0
---

# Umbraco Forms on Cloud

In this article you can learn about how Umbraco Forms is handled on Umbraco Cloud and read about the workflow and best practices.

Umbraco Forms is a package that is included with your Umbraco Cloud project. It gives you a nice integrated UI, where you can create forms for your website. The package is built specifically for Umbraco and is maintained by Umbraco HQ.

Read more about the product in the [Umbraco Forms section](../../../Add-ons/UmbracoForms).

## How forms are handled on Umbraco Cloud

Forms are handled like content and media. This means that you can transfer your forms between environments, using the same workflow you use for content and media.

Definitions for each specific form, its fields, workflows and prevalues are all stored in the Umbraco database.

Entries submitted are not transferred to the next environment, as they are *environment specific*. If you need to move entries from one environment to another, you need to run an export/import script on the databases.

## Recommended workflow

You can work with forms on the environment of your choice.

When you need to test or use your forms on another environment you can:

* Transfer the forms to the next environment using **Queue for transfer** or
* **Restore** the forms on an environment lower in the workflow

For more information on how to handle content transfer/restores on Umbraco Cloud, checkout the following articles:

* [Transfer content, media and forms](../Content-Transfer)
* [Restoring content](../Restoring-content)

## Upgrades

Umbraco Forms is part of the [auto-upgrades on Umbraco Cloud](../../Upgrades). Whenever a new patch is ready for release, we will automatically apply it to your Cloud project. There will be a message in the Umbraco Cloud Portal at least 5 days before we roll out new versions.

To avoid having the auto-upgrades overwrite any of your custom settings, we strongly encourage that you use [config transforms](../../Set-Up/Config-Transforms) when you need custom configuration, and [Themes](../../../Add-ons/UmbracoForms/Developer/Themes) when you need to customize your forms.

### Version specific changes

In this section you can find information about version specific changes that might affect the way Umbraco Forms works on your project.

#### Version 8.5.0

Prior to Umbraco 8.5.0 all forms data was saved to both `.UDA` files in the `data/revision` directive as well as `.json` files in the `App_Data/UmbracoFormsData` directive.

We highly recommend that you switch to persisting all definitions for Umbraco Forms data in the Umbraco database.

Follow these steps to make the switch:

1. Clone down you Development/Live environment
2. Open the configuration file `App_Plugins\UmbracoForms\UmbracoForms.config` from you local clone
3. In the `<settings>` section of the configuration, add

    ```code
    <setting key=“StoreUmbracoFormsInDb” value=“True” />
    ```

4. Save the file
5. Spin up your local clone and verify that everything works as expected
6. Push the change back to the Cloud environments

Please note that the change here is made to a config file, which means that the environments will restart as the changes are applied. This can take a few minutes, depending on the scale of your project.

## Common issues with Umbraco Forms on Cloud

### The Forms tree is missing

Some times you might experience that you loose the tree in the Forms section in the backoffice after a deployment.

![Missing tree from Forms section](images/missing-forms-tree.png)

In order to get the tree back, all you need to do is **restart the environment** from the Umbraco Cloud Portal.
