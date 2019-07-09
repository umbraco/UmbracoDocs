# Migrate Umbraco 7 Cloud project to Umbraco 8

This article will provide detailed steps on how to migrate an Umbraco 7 Cloud project to Umbraco 8.

## Prerequisites

* An Umbraco 7 Cloud project running **at least Umbraco 7.14.**
* A clean Umbraco 8.1+ Cloud project with **at least 2 environments**

:::note
We strongly recommend having at least 2 environments on the Umbraco 8.1+ Cloud project.

Should something fail during the migration, the Development environment can always be removed and re-added in order to start over on a clean slate.
:::

## Step 1: Content migration

* Clone down the Umbraco 7 Cloud site
* Run the project locally and **restore** Content and Media

* Clone down the Umbraco 8 Cloud site

* Copy `~/App_Data/Umbraco.sdf` / `~/App_Data/Umbraco.mdf` from the cloned Umbraco 7 Cloud site
* Paste the file into `~/App_Data` on the Umbraco 8 Cloud site
* Open `web.config` from the Umbraco 8 Cloud site
* Locate the `Umbraco.Core.ConfigurationStatus` key
* Replace the value `8.1.x` with the version your Umbraco 7 Cloud site is running - eg. `7.15.0`

* Run the Umbraco 8 Cloud site locally
* The migration will need to be authorized - Cloud credentials is used for this

![Authorize upgrade](images/upgrade-to-8_1.png)

* Click **Continue** to start the migration
* When the migration is done, login to the backoffice and verify that everything is there

:::note
The frontend will **not** work at this point, as none of the Templates have been updated to match Umbraco 8 yet.
:::

## Step 2: Files migration

* The following files / folders needs to be copied into the Umbraco 8 Cloud project
    * `~/Views` - do **not** overwrite the default Macro and Partial view macro files, unless changes have been made to these
    * `~/Media`
    * Any files / folders related to Stylesheets and JavaScripts
    * Any custom files / folders the Umbraco 7 Cloud project uses, that isn't in the `~/Config` or `~/bin`
* Config files needs to be carefully merged, to ensure any custom settings are migrating while none of the default configuration for Umbraco 8 is changed

* Run the Umbraco 8 Cloud site locally
    * It **will** give you a YSOD / error screen as none of the Template files have been updated yet

* Open CMD in the `~/data` folder on the Umbraco 8 Cloud project
* Generate UDA files by running the following command: `echo > deploy-export`
* Once a `deploy-complete` marker is added to the `~/data` folder, it's complete
* Check `~/data/revision` to ensure all the UDA files have been generated
* Run `echo > deploy` to make sure everything checks out with the UDA files just generated
* This check will result in either of the two:
    * `deploy-failed`
        * Something failed during the check
        * Run `echo > deploy-clearsignatures` followed by `echo > deploy` to clear up the error
    * `deploy-complete`
        * Everything checks out: Move on to the next step

## Step 3: Setup Template files for Umbraco 8

In Umbraco 8 we've changed how published content is rendered through Template files. Due to this, it will be necessary to update all Template files (`.cshtml`) to reflect these changes.

Read more about these changes in the [IPublishedContent section of the Documentation](../../Reference/Querying/IPublishedContent/).

* Go through the Template files one by one and make the necessary changes
* Go through Partial View Macro files and make the necessary changes

### Example of changes that needs to be made

* Template files need to inherit from `Umbraco.Web.Mvc.UmbracoViewPage<ContentModels.HomePage>` instead of `Umbraco.Web.Mvc.UmbracoTemplatePage<ContentModels.HomePage>`
* Template files need to use `ContentModels = Umbraco.Web.PublishedModels` instead of `ContentModels = Umbraco.Web.PublishedContentModels`

* `@Model.Value("propertyAlias")` replaces `@Umbraco.Field("propertyAlias")`
* `@Model.PropertyAlias` replaces `@Model.Content.PropertyAlias`

## Step 4: Deploy and test on Umbraco Cloud

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

## Step 5: Post-migration checks and going live

