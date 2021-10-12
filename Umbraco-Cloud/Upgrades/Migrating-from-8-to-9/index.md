# Migrate Umbraco 8 Cloud project to Umbraco 9

This article will provide steps on how to migrate an Umbraco 8 Cloud project to Umbraco 9.

Because the underlying framework going from Umbraco 8 to 9, means that there are no direct upgrade path, however there have been few changes to the Database schema, meaning that you can re-use the database from your Umbraco 8 project and use it on your new Umbraco 9 Cloud project, so that you have your content from Umbarco 8.

It is not possible to migrate the custom code, as the underlying web framework updated from ASP.NET to ASP.NET Core and you will need to re-implement it.

You also need to make sure that the packages that you are using is available for Umbraco 9.

<!--Removed for now, might move it back as we create a article for V8-9
Read the [general article about Content migration](../../../Getting-Started/Setup/Upgrading/migrating-to-v8#limitations) to learn more about limitations and other things that can come into play when migrating your Umbraco site from 7 to 8.
-->

<!--Needs V9 update
## Video tutorial

<iframe width="800" height="450" src="https://www.youtube.com/embed/videoseries?list=PLG_nqaT-rbpxrVkhlMedRKL9frAVIHlve" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
-->

## Prerequisites

* An Umbraco 8 Cloud project running **the latest version of Umbraco 8**

* A clean Cloud project running the latest version of Umbraco 9 with **at least 2 environments**

* A backup of your Umbraco 8 projects database

:::note
We strongly recommend having at least 2 environments on the Umbraco 9 project.

Should something fail during the migration, the Development environment can always be removed and re-added in order to start over on a clean slate.
:::

## Step 1: Content migration

* Create a backup of the database from your Umbraco 8 project, this can be done by using the [database backup guide](..\..\Databases\Backups) or by cloning down the V8 project and make a backup of the local Database(Make sure to restore the content from your cloud environment)

* Import the database backup into SQL Server Management Studio

* Clone down the Development environment from the Umbraco 9 Cloud project, test the project and make sure to login to the backoffice

* Update the connection string in the Umbraco 9 AppSetting.Json file so that it connects to the Umbraco 8 database

* To be able to authorize the database upgrade, you need to enable [Unattended Upgrades](https://our.umbraco.com/Documentation/Reference/V9-Config/UnattendedSettings/#upgrade-unattended)

* Run the Umbraco 9 project locally

* Wait for the site to finish upgrading

* Stop the site and disable unattended upgrade

* Run the site and Login using Umbraco ID

:::note
Please be aware that this is **only a content migration**.

The database will be migrated, but upgrading view files and custom code and implementation will need to be done manually.

See [Step 3](#Step-3-setup-custom-code-for-umbraco-9) of this guide, for more detail on this.
:::

## Step 2: File migration

* The following files / folders needs to be copied into the Umbraco 9 project
    * `~/Views` - do **not** overwrite the default Macro and Partial View Macro files, unless changes have been made to these
    * `~/Media`
    * Any files / folders related to Stylesheets and JavaScripts

* In Umbraco 9 Config files no longer lives in a Web.Config and is instead in the `AppSettings.Json` file. You will need to make sure that you update the AppSettings with any custom settings that you had in your Umbraco 8 project to match with the[V9 configs](../../../Reference/V9-Config/index.md).

* In Umbraco Forms version 9.0.0+, it is only possible to store Form data in the database. If Umbraco Forms is used on the Umbraco 8 project:

    * Make sure to first migrate the Forms to the database using [Umbraco forms 8](../../../Add-ons/UmbracoForms/Developer/Forms-in-the-Database/)

* Run the Umbraco 9 project locally
    * It **will** give you a YSOD / error screen on the frontend as none of the Template files have been updated yet

* Go to the backoffice of your project and navigate to the Settings section and find the deploy dashboard

* Generate UDA files by running the following command: `Extract Schema To Data Files` from the dashboard

* Once the `Operation` is done the status will change to `Last deployment operation completed`

* Check `~\umbraco\Deploy\Revision` to ensure all the UDA files have been generated

* Run `Schema Deployment From Data Files` from the deploy dashboard to make sure everything checks out with the UDA files that was generated

## Step 3: custom code for Umbraco 9

Umbraco 9 is different from Umbraco 8 in many ways. This means that in this step, all custom code, controllers, and models need to be rewritten for Umbraco 9.

:::note
Many of the changes have been documented, and the articles are listed here: [Umbraco Documentation Status](/../../../Umbraco9Articles).

Found something that has not yet been documented? Please [report it on our issue tracker](https://github.com/umbraco/UmbracoDocs/issues).
:::

### Example of changes that need to be made

One of the changes made is how published content is rendered through Template files. Due to this, it will be necessary to update **all** Template files (`.cshtml`) to reflect these changes.

Read more about these changes in the [IPublishedContent section of the Documentation](../../../Reference/Querying/IPublishedContent/).

* Template files need to inherit from `Umbraco.Cms.Web.Common.Views.UmbracoViewPage<ContentModels.HomePage>` instead of `Umbraco.Web.Mvc.UmbracoViewPage<ContentModels.HomePage>`

* Template files need to use `ContentModels = Umbraco.Cms.Web.Common.PublishedModels` instead of `ContentModels = Umbraco.Web.PublishedModels`

Depending on the size of the project that is being migrated and the amount of custom code and implementations, this step is going to require a lot of work.

## Step 4: Deploy and test on Umbraco Cloud

Once the Umbraco 9 project runs without errors on the local setup, the next step is to deploy and test on the Cloud Development environment.

* Push the migration and changes to the Umbraco Cloud Development environment

:::note
The deployment might take a bit longer than normal.
:::

Once everything has been pushed, go to the Deploy Dashboard and trigger a `Schema Deployment From Data Files`

* The deployment will result in either of the two:
    * `Last deployment operation failed`
        * Something failed during the check
        * Run `Clear Cached Signatures` followed by `Schema Deployment From Data Filesy` to clear up the error
    * `Last deployment operation completed`
        * Everything checks out: The Development environment has been upgraded

* Transfer Content and Media from the local clone to the Development environment

* Test **everything** on the Development environment

* Deploy to the Live environment

## Step 5: Going live

Once the migration is complete, and the Live environment is running without errors, the site is ready for launch.

* Setup [rewrites](../../../Reference\Routing\IISRewriteRules) on the Umbraco 9 site
* Assign hostnames to the project
    * Note that hostnames are unique, and can only be added to one Cloud project at a time

## Related information

* [Issue tracker for known issues with Content Migration](https://github.com/umbraco/UmbracoDocs/issues)
* [Umbraco 9 Documentation status](../../../Umbraco9Articles)
* [Forms on Umbraco Cloud](../../Deployment/Umbraco-Forms-on-Cloud)
* [Working locally with Umbraco Cloud](../../Set-Up/Working-Locally/)
* [KUDU on Umbraco Cloud](../../Set-Up/Power-Tools/)
