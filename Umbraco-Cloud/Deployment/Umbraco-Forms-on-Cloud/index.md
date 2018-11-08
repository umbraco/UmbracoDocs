# Umbraco Forms on Cloud

In this article you can learn about how Umbraco Forms are handled on Umbraco Cloud and read about the workflow and best practices.

Umbraco Forms is a package that is included with your Umbraco Cloud project. It gives you a nice integrated UI where you can create forms for your website. The package is built specifically for Umbraco and is maintained by Umbraco HQ.

Read more about the product in the [Umbraco Forms section](../../../Add-ons/UmbracoForms).

## How are Forms handled on Cloud?

Umbraco Forms are currently handled as metada, and will be deployed along with the rest of your metadata and structure files, e.g. Document Types, Templates and Stylesheets.

When you create a Form on your Umbraco Cloud project, a UDA file will be generated. This UDA file will contain all the metadata from your form, and be very similar to the `JSON` file that is also generated when you create a new form - this file can be found in `~/App_Data/UmbracoForms/Data/forms`.

Once you deploy a form, the engine behind Cloud will use the UDA file to extract the form on the next environment in the workflow.

Entries submitted are not transferred to the next environment, as they are *environment specific*. If you need to move entries from one environment to another, you need to run an export/import script on the databases.

## Recommended workflow

As with all other metadata and structure files, we always recommend that you work with these on your local or Development environment, following the [left-to-right deployment model](../../Deployment).

:::warning
When you have more than 1 Cloud environment, you should never make changes to your forms on your Live environment, as these will be overwritten on the next deployment.
:::

## Upgrades

Umbraco Forms is part of the [auto-upgrades on Umbraco Cloud](../../Upgrades). Whenever a new patch is ready for release, we will automatically apply it to your Cloud project. There will be a message in the Umbraco Cloud Portal at least 5 days before we roll out new versions.

To avoid that the auto-upgrades overwrite any of your custom settings, we strongly encourage that you use [config transforms](../../Set-Up/Config-Transforms) when you need custom configuration, and [Themes](../../../Add-ons/UmbracoForms/Developer/Themes) when you need to customize your forms.

## Common issues with Forms on Cloud

### The Forms tree is missing

Some times you might experience that you loose the tree in the Forms section in the backoffice after a deployment.

![Missing tree from Forms section](images/missing-forms-tree.png)

In order to get the tree back, all you need to do is **restart the environment** from the Umbraco Cloud Portal.
