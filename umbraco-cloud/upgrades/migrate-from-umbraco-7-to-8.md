---
description: "This article will provide detailed steps on how to migrate a Umbraco 7 Cloud project to Umbraco 8."
---

# Migrate from Umbraco 7 to Umbraco 8 on Umbraco Cloud

{% hint style="warning" %}
Due to [a known issue](https://github.com/umbraco/Umbraco-CMS/issues/7914), it is **not possible to directly migrate your Umbraco 7 project to the latest Umbraco 8**.

As a workaround, you can either

* Migrate to **version 8.5** as a first step, and then, post-migration, carry out a normal Umbraco upgrade to the latest version of Umbraco 8, or
* Install the following community Nuget Package: [ProWorks Umbraco 8 Migrations](https://www.nuget.org/packages/ProWorks.Umbraco8.Migrations) into your V8 project before running the migration (no configuration required). [Learn more about how to use this package on Prowork's blog](https://www.proworks.com/blog/archive/how-to-upgrade-umbraco-version-7-to-version-8).

The package mentioned above patches the migration process. This means you can migrate directly from the latest Umbraco 7 to the latest Umbraco 8 version without encountering issues. The package is currently not tested on Umbraco Cloud.
{% endhint %}

Read the [general article about Content migration](../../umbraco-cms/fundamentals/setup/upgrading/version-specific/migrate-content-to-umbraco-8.md#what-are-the-limitations) to learn more about limitations and other things related to migrating your Umbraco site from 7 to 8.

## Video tutorial

<iframe width="800" height="450" title="Migrate an Umbraco Cloud project from 7 to 8: Introduction" src="https://www.youtube.com/embed/wNIDdgdAt8s?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

You can find the full playlist here: [Migrate an Umbraco Cloud project from 7 to 8](https://www.youtube.com/playlist?list=PLgX62vUaGZsGceCXveMkprlDV5a3K94db)

## Prerequisites

* A Umbraco 7 Cloud project running **the latest version of Umbraco 7**
* Make sure Umbraco Forms data is not handled as content
  * See [Umbraco Forms on Cloud](../deployment/umbraco-forms-on-cloud.md#how-forms-are-handled-on-umbraco-cloud) for more details on how to check the setting
* A clean Cloud project running the latest version of Umbraco 8 with **at least 2 environments**

{% hint style="info" %}
We strongly recommend having at least 2 environments on the Umbraco 8 project.

Should something fail during the migration, the Development environment can always be removed and re-added in order to start over on a clean slate.
{% endhint %}

## Step 1: Content migration

* Clone down the Umbraco 7 Cloud project.
* Run the project locally and **restore** Content and Media.
* Clone down the Development environment from the Umbraco 8 Cloud project.
* Copy `~/App_Data/Umbraco.sdf` or `~/App_Data/Umbraco.mdf` from the cloned Umbraco 7 project.
* Paste the file into `~/App_Data` on the clone of the Umbraco 8 project.
* Open `web.config` from the Umbraco 8 project.
* Locate the `Umbraco.Core.ConfigurationStatus` key.
* Replace the value `8.6` with the version your Umbraco 7 project is running - eg. `7.15.4`.
* Run the Umbraco 8 project locally
* Authorize the migration - Cloud credentials are used for this.

{% hint style="info" %}
If your login does not work, try the following approach:

* Copy the `UsersMembershipProvider` attributes from your Umbraco 7 web.config, to the Umbraco 8 web.config.
* Try to login again.

Below is an example of how the attribute can look:

```xml
<add name="UsersMembershipProvider" 
     type="Umbraco.Web.Security.Providers.UsersMembershipProvider, Umbraco" 
     minRequiredNonalphanumericCharacters="0" 
     minRequiredPasswordLength="8" 
     useLegacyEncoding="true" 
     enablePasswordRetrieval="false" 
     enablePasswordReset="true" 
     requiresQuestionAndAnswer="false" 
     passwordFormat="Hashed" />
```

{% endhint %}

![Authorize upgrade](images/upgrade-to-8_1.png)

* Click **Continue** to start the migration.
* Log in to the backoffice and verify that everything is there once the migration is complete.

{% hint style="info" %}
Please be aware that this is **only a content migration**.

The database will be migrated, but updating view files, custom code, and implementation is a manual process.

See [Step 3](#step-3-setup-custom-code-for-umbraco-8) of this guide, for more detail on this.
{% endhint %}

## Step 2: Files migration

* The following files/folders need to be copied into the Umbraco 8 project:
  * `~/Views` - do **not** overwrite the default Macro and Partial View Macro files, unless changes have been made to these.
  * `~/Media`
  * Any files/folders related to Stylesheets and JavaScripts.
  * Any custom files/folders the Umbraco 7 project uses, that aren't in the `~/Config` or `~/bin`.

* If Umbraco Forms is used on the Umbraco 7 project:
  * Copy `~/App_Data/UmbracoForms` into the Umbraco 8 project.
* Merge the configuration files carefully -this ensures any custom settings are migrating while none of the default configurations for Umbraco 8 is changed.
* Run the Umbraco 8 project locally
  * It **will** give you an error on the frontend as none of the Template files have been updated yet.
* Open the commandline tool in the `~/data` folder on the Umbraco 8 project.
* Generate UDA files by running the following command: `echo > deploy-export`.
  * Once a `deploy-complete` marker is added to the `~/data` folder, it is done.
* Check `~/data/revision` to ensure all the UDA files have been generated.
* Run `echo > deploy` in the `~/data` folder to make sure everything checks out with the UDA files that were generated.

Running `echo > deploy` command will generate a new marker. Move forward with the migration based on the marker:

* `deploy-failed`
  * Something failed during the check
  * Run `echo > deploy-clearsignatures` followed by `echo > deploy` to clear up the error
* `deploy-complete`
  * Everything checks out: Move on to the next step

## Step 3: Setup custom code for Umbraco 8

Umbraco 8 is different from Umbraco 7 in many ways. This means that in this step, all custom code, controllers, and models need to be reviewed and rewritten for Umbraco 8.

{% hint style="info" %}
Documentation for building and working with Umbraco 8 can be found on [Our.Umbraco.com](https://our.umbraco.com/Documentation/).
{% endhint %}

### Example of changes that need to be made

One of the changes made, is how published content is rendered through Template files. Due to this, it will be necessary to update **all** Template files (`.cshtml`) to reflect these changes.

Read more about these changes in the [IPublishedContent section of the Documentation](../../umbraco-cms/reference/querying/ipublishedcontent/README.md).

* Template files need to inherit from `Umbraco.Web.Mvc.UmbracoViewPage<ContentModels.HomePage>` instead of `Umbraco.Web.Mvc.UmbracoTemplatePage<ContentModels.HomePage>`.
* Template files need to use `ContentModels = Umbraco.Web.PublishedModels` instead of `ContentModels = Umbraco.Web.PublishedContentModels`.
* `@Model.Value("propertyAlias")` replaces `@Umbraco.Field("propertyAlias")`.
* `@Model.PropertyAlias` replaces `@Model.Content.PropertyAlias`.

Depending on the size of the project and amount of custom code and implementations, this step is going to require a lot of work.

## Step 4: Deploy and test on Umbraco Cloud

Once the Umbraco 8 project runs without errors on the local setup, the next step is to deploy and test on the Cloud Development environment.

* Push the migration and changes to the Umbraco Cloud Development environment

{% hint style="info" %}
The deployment might take a bit longer than normal.

To track the process, keep an eye on the deploy markers in `site/wwwroot/data` using KUDU.
{% endhint %}

* Progress through the steps based on the deployment result:
  * `deploy-failed`
    * Something failed during the check.
    * Run `echo > deploy-clearsignatures` followed by `echo > deploy` to clear up the error.
  * `deploy-complete`
    * Everything checks out: The Development environment has been upgraded.
* Transfer Content and Media from the local clone to the Development environment.
* Test **everything** on the Development environment.
* Deploy to the Live environment.

## Step 5: Going live

Once the migration is complete, and the Live environment is running without errors, the site is ready for launch.

* Setup rewrites on the Umbraco 8 site.
* Assign hostnames to the project.
  * Hostnames are unique, and can only be added to one Cloud project at a time.

## Related information

* [Content Migration for Umbraco CMS - 7 to 8](../../umbraco-cms/fundamentals/setup/upgrading/version-specific/migrate-content-to-umbraco-8.md)
* [Issue tracker for known issues with Content Migration](https://github.com/umbraco/UmbracoDocs/issues)
* [Forms on Umbraco Cloud](../deployment/umbraco-forms-on-cloud.md)
* [Working locally with Umbraco Cloud](../set-up/working-locally.md)
* [KUDU on Umbraco Cloud](../set-up/power-tools/README.md)
