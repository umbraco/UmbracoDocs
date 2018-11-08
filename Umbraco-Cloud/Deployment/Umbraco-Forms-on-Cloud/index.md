# Umbraco Forms on Cloud

In this article you can learn about how Umbraco Forms is handled on Umbraco Cloud, read about the workflow and best practices.

Umbraco Forms is a package that is included with your Umbraco Cloud project. It gives you a nice integrated UI where you can create forms for your website. The package is built specifically for Umbraco and is maintained by Umbraco HQ.

Read more about the product in the [Umbraco Forms section](../../Add-ons/UmbracoForms).

## How are Forms handled on Cloud?

Umbraco Forms is currently handled as metada, and will be deployed along with the rest of your metadata and structure files, e.g. Document Types, Templates and Stylesheets.

When you create a Form on your Umbraco Cloud project, a UDA file will be generated. This UDA file will containing all the metadata from your form. 

## Recommended workflow

As with all other metadata and structure files, we always recommend that you work with these on your local or Development environment, following the [left-to-right deployment model](../../Deployment).

:::warning
When you have more than 1 Cloud environment, you should never make changes to your Forms on Staging/Live, as these will be overwritten on the next deployment.
:::

## Common issues with Forms on Cloud

### The Forms tree is missing

