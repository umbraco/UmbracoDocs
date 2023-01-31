---
versionFrom: 7.0.0
versionTo: 8.0.0
meta.RedirectLink: "/v/10.x-lts/umbraco-cloud/upgrades/migrating-from-8-10"
---

# Migrating Umbraco 7 Cloud project to Umbraco 8

This article will provide detailed steps on how to migrate a Umbraco 7 Cloud project to Umbraco 8.

:::warning
Due to [a known issue](https://github.com/umbraco/Umbraco-CMS/issues/7914), it is currently **not possible to perform a direct migration of your Umbraco 7 Cloud project to the latest Umbraco 8**.

We are working on resolving the issue to make the migration possible again.

As a workaround, you can either

* Migrate to **version 8.5** as a first step, and then post-migration, carry out a normal Umbraco upgrade to the latest version of Umbraco 8, or
* Install the following community Nuget Package: [ProWorks Umbraco 8 Migrations](https://www.nuget.org/packages/ProWorks.Umbraco8.Migrations) into your V8 project before running the migration (no configuration required). [Learn more about how to use this package on Prowork's blog](https://www.proworks.com/blog/archive/how-to-upgrade-umbraco-version-7-to-version-8).

The package mentioned above patches the migration process so you can migrate directly from the latest Umbraco 7 to the latest Umbraco 8 version without encountering issues. Do note that the package is currently **not tested on Umbraco Cloud**.
:::

Read the [general article about Content migration](../../../Getting-Started/Setup/Upgrading/migrating-to-v8#limitations) to learn more about limitations and other things that can come into play when migrating your Umbraco site from 7 to 8.

## Video tutorial

<iframe width="800" height="450" title="Migrate an Umbraco Cloud project from 7 to 8: Introduction" src="https://www.youtube.com/embed/wNIDdgdAt8s?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

You can find the full playlist here: [Migrate an Umbraco Cloud project from 7 to 8](https://www.youtube.com/playlist?list=PLgX62vUaGZsGceCXveMkprlDV5a3K94db)

## Prerequisites

* A Umbraco 7 Cloud project running **the latest version of Umbraco 7**

* Make sure Umbraco Forms data is not handled as content
    * See [Umbraco Forms on Cloud](../../Deployment/Umbraco-Forms-on-Cloud/#did-you-create-your-project-before-june-2018) for more details on how to check the setting

* A clean Cloud project running the latest version of Umbraco 8 with **at least 2 environments**

:::note
We strongly recommend having at least 2 environments on the Umbraco 8 project.

Should something fail during the migration, the Development environment can always be removed and re-added in order to start over on a clean slate.
:::

## Step 1: Content migration

* Clone down the Umbraco 7 Cloud project

* Run the project locally and **restore** Content and Media

* Clone down the Development environment from the Umbraco 8 Cloud project

* Copy `~/App_Data/Umbraco.sdf` or `~/App_Data/Umbraco.mdf` from the cloned Umbraco 7 project

* Paste the file into `~/App_Data` on the clone of the Umbraco 8 project

* Open `web.config` from the Umbraco 8 project

* Locate the `Umbraco.Core.ConfigurationStatus` key

* Replace the value `8.6` with the version your Umbraco 7 project is running - eg. `7.15.4`

* Run the Umbraco 8 project locally

* The migration will need to be authorized - Cloud credentials are used for this

:::note
If your login doesn't seem to be working, try the following approach:

* Copy the `UsersMembershipProvider` attributes from your Umbraco 7 web.config, to the Umbraco 8 web.config
* Try again

Below is an example of how the attribute can look.

```xml
<add name="UsersMembershipProvider" type="Umbraco.Web.Security.Providers.UsersMembershipProvider, Umbraco" minRequiredNonalphanumericCharacters="0" minRequiredPasswordLength="8" useLegacyEncoding="true" enablePasswordRetrieval="false" enablePasswordReset="true" requiresQuestionAndAnswer="false" passwordFormat="Hashed" />
```

:::

![Authorize upgrade](images/upgrade-to-8_1.png)

* Click **Continue** to start the migration
* When the migration is done, log in to the backoffice and verify that everything is there

:::note
Please be aware that this is **only a content migration**.

The database will be migrated, but upgrading view files and custom code and implementation is a manual process.

See [Step 3](#Step-3-setup-custom-code-for-umbraco-8) of this guide, for more detail on this.
:::

## Step 2: Files migration

* The following files/folders need to be copied into the Umbraco 8 project
    * `~/Views` - do **not** overwrite the default Macro and Partial View Macro files, unless changes have been made to these
    * `~/Media`
    * Any files/folders related to Stylesheets and JavaScripts
    * Any custom files/folders the Umbraco 7 project uses, that aren't in the `~/Config` or `~/bin`

* If Umbraco Forms is used on the Umbraco 7 project:
    * Copy `~/App_Data/UmbracoForms` into the Umbraco 8 project

* Config files need to be carefully merged, to ensure any custom settings are migrating while none of the default configurations for Umbraco 8 is changed

* Run the Umbraco 8 project locally
    * It **will** give you a YSOD / error screen on the frontend as none of the Template files have been updated yet

* Open CMD in the `~/data` folder on the Umbraco 8 project

* Generate UDA files by running the following command: `echo > deploy-export`

* Once a `deploy-complete` marker is added to the `~/data` folder, it is done

* Check `~/data/revision` to ensure all the UDA files have been generated

* Run `echo > deploy` in the `~/data` folder to make sure everything checks out with the UDA files that were generated

* This check will result in either of the two:
    * `deploy-failed`
        * Something failed during the check
        * Run `echo > deploy-clearsignatures` followed by `echo > deploy` to clear up the error
    * `deploy-complete`
        * Everything checks out: Move on to the next step

## Step 3: Setup custom code for Umbraco 8

Umbraco 8 is different from Umbraco 7 in many ways. This means that in this step, all custom code, controllers, and models need to be reviewed and rewritten for Umbraco 8.

:::note
Many of the changes have been documented, and the articles are listed here: [Umbraco 8 Documentation Status](../../../v8documentation).

Found something that has not yet been documented? Please [report it on our issue tracker](https://github.com/umbraco/UmbracoDocs/issues).
:::

### Example of changes that need to be made

One of the changes made is how published content is rendered through Template files. Due to this, it will be necessary to update **all** Template files (`.cshtml`) to reflect these changes.

Read more about these changes in the [IPublishedContent section of the Documentation](../../../Reference/Querying/IPublishedContent/).

* Template files need to inherit from `Umbraco.Web.Mvc.UmbracoViewPage<ContentModels.HomePage>` instead of `Umbraco.Web.Mvc.UmbracoTemplatePage<ContentModels.HomePage>`

* Template files need to use `ContentModels = Umbraco.Web.PublishedModels` instead of `ContentModels = Umbraco.Web.PublishedContentModels`

* `@Model.Value("propertyAlias")` replaces `@Umbraco.Field("propertyAlias")`

* `@Model.PropertyAlias` replaces `@Model.Content.PropertyAlias`

Depending on the size of the project that is being migrated and the amount of custom code and implementations, this step is going to require a lot of work.

## Step 4: Deploy and test on Umbraco Cloud

Once the Umbraco 8 project runs without errors on the local setup, the next step is to deploy and test on the Cloud Development environment.

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
