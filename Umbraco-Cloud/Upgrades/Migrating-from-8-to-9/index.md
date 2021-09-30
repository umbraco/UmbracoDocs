# Migrate Umbraco 7 Cloud project to Umbraco 8

This article will provide steps on how to migrate an Umbraco 8 Cloud project to Umbraco 8.

Because the underlying framework going from Umbraco 8 to 9, means that there are no direct upgrade path, however there have been few changes to the Database schema, meaning that you can re-use the database from your Umbraco 8 project and use it on your new Umbraco 9 Cloud project, so that you have your content from Umbarco 8.

It is not possible to migrate the custom code, as the underlying web framework updated from ASP.NET to ASP.NET Core and you will need to re-implement it.

You also need to make sure that the packages that you are using is available for Umbraco 9.

Read the [general article about Content migration](../../../Getting-Started/Setup/Upgrading/migrating-to-v8#limitations) to learn more about limitations and other things that can come into play when migrating your Umbraco site from 7 to 8.

## Video tutorial

<iframe width="800" height="450" src="https://www.youtube.com/embed/videoseries?list=PLG_nqaT-rbpxrVkhlMedRKL9frAVIHlve" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

## Prerequisites

* An Umbraco 8 Cloud project running **the latest version of Umbraco 8**

* A clean Cloud project running the latest version of Umbraco 9 with **at least 2 environments**

* A backup of your Umbraco 8 projects database

:::note
We strongly recommend having at least 2 environments on the Umbraco 9 project.

Should something fail during the migration, the Development environment can always be removed and re-added in order to start over on a clean slate.
:::

## Step 1: Content migration

* Create a backup of the database from your Umbraco 8 project, this can be done by using the [database backup guide](..\..\Databases\Backups) or by cloning down the V8 project and make a backup of the local Database(Make sure to restore the content from your cloud environment).

* Import the database backup into SQL Server Management Studio

* Clone down the Development environment from the Umbraco 9 Cloud project

* Update the connection string in the Umbraco 9 AppSetting.Json file so that it connects to the Umbraco 8 database

* Run the Umbraco 9 project locally and make sure it runs

* The migration will need to be authorized - Your Umbraco ID credentials will be used for that


![Authorize upgrade](images/upgrade-to-8_1.png)

* Click **Continue** to start the migration
* When the migration is done, login to the backoffice and verify that everything is there

:::note
Please be aware that this is **only a content migration**.

The database will be migrated, but upgrading view files and custom code and implementation will need to be done manually.

See [Step 3](#Step-3-setup-custom-code-for-umbraco-8) of this guide, for more detail on this.
:::

## Step 2: Files migration

* The following files / folders needs to be copied into the Umbraco 8 project
    * `~/Views` - do **not** overwrite the default Macro and Partial View Macro files, unless changes have been made to these
    * `~/Media`
    * Any files / folders related to Stylesheets and JavaScripts
    * Any custom files / folders the Umbraco 7 project uses, that isn't in the `~/Config` or `~/bin`

* If Umbraco Forms is used on the Umbraco 7 project:
    * Copy `~/App_Data/UmbracoForms` into the Umbraco 8 project

* Config files needs to be carefully merged, to ensure any custom settings are migrating while none of the default configuration for Umbraco 8 is changed

* Run the Umbraco 8 project locally
    * It **will** give you a YSOD / error screen on the frontend as none of the Template files have been updated yet

* Open CMD in the `~/data` folder on the Umbraco 8 project

* Generate UDA files by running the following command: `echo > deploy-export`

* Once a `deploy-complete` marker is added to the `~/data` folder, it is done

* Check `~/data/revision` to ensure all the UDA files have been generated

* Run `echo > deploy` in the `~/data` folder to make sure everything checks out with the UDA files that was generated

* This check will result in either of the two:
    * `deploy-failed`
        * Something failed during the check
        * Run `echo > deploy-clearsignatures` followed by `echo > deploy` to clear up the error
    * `deploy-complete`
        * Everything checks out: Move on to the next step

## Step 3: custom code for Umbraco 9

Umbraco 8 is different from Umbraco 7 in many ways. This means that in this step, all custom code, controllers and models needs to be reviewed and rewritten for Umbraco 8.

:::note
Many of the changes have been documented, and the articles are listed here: [Umbraco Documentation Status](../../../Umbraco9Articles).

Found something that has not yet been documented? Please [report it on our issue tracker](https://github.com/umbraco/UmbracoDocs/issues).
:::

### Example of changes that needs to be made

One of the changes made, is how published content is rendered through Template files. Due to this, it will be necessary to update **all** Template files (`.cshtml`) to reflect these changes.

Read more about these changes in the [IPublishedContent section of the Documentation](../../../Reference/Querying/IPublishedContent/).

* Template files need to inherit from `Umbraco.Web.Mvc.UmbracoViewPage<ContentModels.HomePage>` instead of `Umbraco.Web.Mvc.UmbracoTemplatePage<ContentModels.HomePage>`

* Template files need to use `ContentModels = Umbraco.Web.PublishedModels` instead of `ContentModels = Umbraco.Web.PublishedContentModels`

* `@Model.Value("propertyAlias")` replaces `@Umbraco.Field("propertyAlias")`

* `@Model.PropertyAlias` replaces `@Model.Content.PropertyAlias`

Depending on the size of the project that is being migrated and the amount of custom code and implementations, this step is going to require a lot of work.

## Step 4: Deploy and test on Umbraco Cloud

Once the Umbraco 9 project runs without errors on the local setup, the next step is to deploy and test on the Cloud Development environment.

* Push the migration and changes to the Umbraco Cloud Development environment

:::note
The deployment might take a bit longer than normal.

To track the process, keep an eye on the deploy markers in `site/wwwroot/data` using KUDU.
:::

* The deployment will result in either of the two:
    * `deploy-failed`
        * Something failed during the check
        * Run `echo > deploy-clearsignatures` followed by `echo > deploy` to clear up the error
    * `deploy-complete`
        * Everything checks out: The Development environment has been upgraded

* Transfer Content and Media from the local clone to the Development environment

* Test **everything** on the Development environment

* Deploy to the Live environment

## Step 5: Going live

Once the migration is complete, and the Live environment is running without errors, the site is ready for launch.

* Setup rewrites on the Umbraco 8 site
* Assign hostnames to the project
    * Note that hostnames are unique, and can only be added to one Cloud project at a time

## Related information

* [Content Migration for Umbraco CMS - 7 to 8](../../../Getting-Started/Setup/Upgrading/migrating-to-v8)
* [Issue tracker for known issues with Content Migration](https://github.com/umbraco/UmbracoDocs/issues)
* [Umbraco 8 Documentation status](../../../v8documentation)
* [Forms on Umbraco Cloud](../../Deployment/Umbraco-Forms-on-Cloud)
* [Working locally with Umbraco Cloud](../../Set-Up/Working-Locally/)
* [KUDU on Umbraco Cloud](../../Set-Up/Power-Tools/)
