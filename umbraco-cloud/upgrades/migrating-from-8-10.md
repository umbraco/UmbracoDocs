# Migrating Umbraco 8 Cloud project to Umbraco 10

This article will provide steps on how to migrate a Umbraco 8 Cloud project to Umbraco 10.

{% hint style="info" %}
The steps in this article can also be used to upgrade to Umbraco version 9, however, we do recommend always upgrading to the latest version whenever possible.
{% endhint %}

Since the underlying framework going from Umbraco 8 to 10 has changed there is no direct upgrade path. However, there have been a few changes to the Database schema. You can re-use the database from your Umbraco 8 project on your new Umbraco 10 Cloud project so that you have your content from Umbraco 8.

It is not possible to migrate the custom code as the underlying web framework has been updated from ASP.NET to ASP.NET Core and you will need to re-implement it.

You also need to make sure that the packages that you are using are available for Umbraco 10.

<!--Removed for now, might move it back as we create an article for V8-9
Read the [general article about Content migration](../../../Getting-Started/Setup/Upgrading/migrating-to-v8#limitations) to learn more about limitations and other things that can come into play when migrating your Umbraco site from 7 to 8.
-->

<!--Needs V9 update
## Video tutorial

{% embed url="https://www.youtube.com/embed/videoseries?list=PLG_nqaT-rbpxrVkhlMedRKL9frAVIHlve" %}
Video example.
{% endembed %}
-->

## Prerequisites

* A Umbraco 8 Cloud project running **the latest version of Umbraco 8**.

* A clean Cloud project running the latest version of Umbraco 10 with **at least 2 environments**.

* A backup of your Umbraco 8 project database.

{% hint style="info" %}
We strongly recommend having at least **2 environments** on the Umbraco 10 project.

Should something fail during the migration, the Development environment can always be removed and re-added to start over on a clean slate.
{% endhint %}

## Step 1: Content Migration

* Create a backup of the database from your Umbraco 8 project using the [database backup guide](../databases/README.md) *OR* clone down the V8 project and take a backup of the local Database. Make sure to restore the content from your cloud environment.

* Import the database backup into SQL Server Management Studio.

* Clone down the **Development** environment from the Umbraco 10 Cloud project, test the project, and make sure to log in to the backoffice.

* Update the connection string in the Umbraco 10 `appsettings.json` file so that it connects to the Umbraco 8 database:

    ```json
    "ConnectionStrings": {
        "umbracoDbDSN": "Server=YourLocalSQLServerHere;Database=NameOfYourDatabaseHere;Integrated Security=true"
    }
    ```

* To authorize the database upgrade, enable [Unattended Upgrades](../../umbraco-cms/reference/configuration/unattendedsettings.md#upgrade-unattended).

* Run the Umbraco 10 project locally.

* Wait for the site to finish upgrading.

* Stop the site and disable unattended upgrade.

* Run the site and log in using Umbraco ID.

{% hint style="info" %}
This is **only content migration** and the database will be migrated.

You need to manually upgrade the view files and custom code implementation. For more information, see [Step 3](#Step-3-setup-custom-code-for-umbraco-9) of this guide.
{% endhint %}

## Step 2: File Migration

* The following files/folders need to be copied into the Umbraco 10 project:

  * `~/Views` - **Do not** overwrite the default Macro and Partial View Macro files unless changes have been made to these.
  * `~/Media`
  * Any files/folders related to Stylesheets and JavaScript.

* In Umbraco 10, config files no longer live in the `Web.Config` file and is instead in the `appsettings.json` file. You will need to make sure that you update the `appsettings.json` file with any custom settings that you had in your Umbraco 8 project to match with the [Configuration Files](../../umbraco-cms/reference/configuration/README.md).

* In Umbraco Forms version 9.0.0+, it is only possible to store Form data in the database. If Umbraco Forms is used on the Umbraco 8 project:
  * Make sure to first migrate the Forms to the database, see the [Umbraco Forms in the Database](../../umbraco-forms/developer/forms-in-the-database.md) article.

* Add the `global.json` in root repository folder

{% hint style="info" %}
If `global.json` does not exist in the root of your repository, you need to add it manually.

Learn more about the `global.json` in the offical [Microsoft docs](https://learn.microsoft.com/en-us/dotnet/core/tools/global-json).
{% endhint %}

* Upgrade your `global.json` to target the runtime Software Development Kit (SDK) for the latest version of [.NET 6](https://dotnet.microsoft.com/en-us/download/dotnet/6.0)

  ```json
  {
    "sdk": {
      "allowPrerelease": false,
      "version": "6.0.402",
      "rollForward": "minor"
    }
  }
  ```

* Add the `global.json` in root repository folder
:::note
If `global.json` does not exist in the root of your repository, you can read about the `global.json` [Microsoft docs](https://learn.microsoft.com/en-us/dotnet/core/tools/global-json)
:::

Upgrade your `global.json` to target the runtime sdk for the latest version of [.NET 6](https://dotnet.microsoft.com/en-us/download/dotnet/6.0)

```json
{
  "sdk": {
    "allowPrerelease": false,
    "version": "6.0.402",
    "rollForward": "minor"
  }
}
```

* Run the Umbraco 10 project locally.
  * It **will** give you a Yellow Screen of Death (YSOD)/error screen on the frontend as none of the Template files have been updated yet.

* Go to the backoffice of your project.

* Navigate to the **Settings** section and go to the **Deploy** dashboard.

* Select `Extract Schema To Data Files` from the **Deploy Operations** drop-down to generate the UDA files.

* Click **Trigger Operation**.

* Once the operation is completed, the status will change to `Last deployment operation completed`.

* Check `~\umbraco\Deploy\Revision` folder to ensure all the UDA files have been generated.

* Select `Schema Deployment From Data Files` from the **Deploy Operations** drop-down to make sure everything checks out with the UDA files that were generated.

* Click **Trigger Operation**.

## Step 3: Custom Code for Umbraco 10

Umbraco 10 is different from Umbraco 8 in many ways. This means that in this step, all custom code, controllers, and models need to be rewritten for Umbraco 10.

{% hint style="info" %}
Found something that has not yet been documented? Please [report it on our issue tracker](https://github.com/umbraco/UmbracoDocs/issues).
{% endhint %}

### Examples of changes

One of the changes is how published content is rendered through Template files. Due to this, it will be necessary to update **all** the Template files (`.cshtml`) to reflect these changes.

Read more about these changes in the [IPublishedContent section of the Documentation](../../umbraco-cms/reference/querying/ipublishedcontent/README.md).

* Template files need to inherit from `Umbraco.Cms.Web.Common.Views.UmbracoViewPage<ContentModels.HomePage>` instead of `Umbraco.Web.Mvc.UmbracoViewPage<ContentModels.HomePage>`

* Template files need to use `ContentModels = Umbraco.Cms.Web.Common.PublishedModels` instead of `ContentModels = Umbraco.Web.PublishedModels`

Depending on the size of the project that is being migrated and the amount of custom code and implementations, this step is going to require a lot of work.

## Step 4: Deploy and Test on Umbraco Cloud

Once the Umbraco 10 project runs without errors on the local setup, the next step is to deploy and test on the Cloud **Development** environment.

* Push the migration and changes to the Umbraco Cloud **Development** environment.

    {% hint style="info" %}
    The deployment might take a bit longer than normal.
    {% endhint %}

* Once everything has been pushed, go to the backoffice of the **Development** environment.

* Go to **Settings** and navigate to the **Deploy** Dashboard.

* Select `Schema Deployment From Data Files` from the **Deploy Operations** drop-down.

* Click **Trigger Operation**.

* The deployment will result in either of the two:
  * `Last deployment operation failed` - something failed during the check.
    * Select `Clear Cached Signatures` from the **Deploy Operations** drop-down.
    * Select `Schema Deployment From Data Files` from the **Deploy Operations** drop-down to clear up the error.
  * `Last deployment operation completed`
    * Everything checks out: The Development environment has been upgraded.

* Transfer Content and Media from the local clone to the **Development** environment.

* Test **everything** in the **Development** environment.

* Deploy to the **Live** environment.

## Step 5: Going live

* Test **everything** in the **Development** environment.
* Once the migration is completed, and the **Live** environment is running without errors, the site is ready for launch.
* Setup [rewrites](../../umbraco-cms/reference/routing/iisrewriterules.md) on the Umbraco 10 site.
* Assign hostnames to the project.

{% hint style="info" %}
    Hostnames are unique and can only be added to one Cloud project at a time.
{% endhint %}

## Related Information

* [Issue tracker for known issues with Content Migration](https://github.com/umbraco/UmbracoDocs/issues)
* [Forms on Umbraco Cloud](../deployment/umbraco-forms-on-cloud.md)
* [Working locally with Umbraco Cloud](../set-up/working-locally.md)
* [KUDU on Umbraco Cloud](../set-up/power-tools/README.md)
