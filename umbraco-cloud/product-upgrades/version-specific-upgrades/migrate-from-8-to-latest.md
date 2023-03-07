---
description: >-
  This article will provide steps on how to migrate a Cloud project from Umbraco 8 to the latest version of Umbraco.
---

# Migrate from Umbraco 8 to the latest version

Since the underlying framework going from Umbraco 8 to the latest version has changed, there is no direct upgrade path. That said, it is possible to re-use the database from your Umbraco 8 project on your new project in order to maintain the content.

It is not possible to migrate the custom code as the underlying web framework has been updated from ASP.NET to ASP.NET Core. All templates and custom code will need to be reimplemented.

You also need to make sure that the packages that you are using are available on the latest version.

## Prerequisites

* A Umbraco 8 Cloud project running **the latest version of Umbraco 8**.
* A clean Cloud project running the latest version of Umbraco with **at least 2 environments**.
* A backup of your Umbraco 8 project database.

{% hint style="info" %}
We strongly recommend having at least **2 environments** on the new Umbraco project.

Should something fail during the migration, the Development environment can be removed and re-added to start over on a clean slate.
{% endhint %}

## Step 1: Content Migration

1. Create a backup of the database from your Umbraco 8 project using the [database backup guide](../../databases/backups.md).
    * Alternatively you can clone the environment down and take a backup of the local Database.
    * Make sure to **restore both content and media** from your Cloud environment.
2. Import the database backup into SQL Server Management Studio.
3. Clone down the **Development** environment from the new Cloud project.
4. Test the project and make sure to log in to the backoffice.
5. Update the connection string in the new Cloud projects `appsettings.json` file so that it connects to the Umbraco 8 database:

```json
"ConnectionStrings": {
    "umbracoDbDSN": "Server=YourLocalSQLServerHere;Database=NameOfYourDatabaseHere;Integrated Security=true"
}
```

6. Enable [Unattended Upgrades](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/upgrading#enable-the-unattended-upgrade-feature) to authorize the database upgrade.
7. Run the new Cloud project locally.
8. Wait for the site to finish upgrading.
9. Stop the site and disable the unattended upgrade.
10. Run the site and log in using Umbraco ID.

{% hint style="info" %}
This is **only content migration** and the database will be migrated.

You need to manually upgrade the view files and custom code implementation. For more information, see Step 3 of this guide.
{% endhint %}

## Step 2: File Migration

1. The following files/folders need to be copied from the Umbraco 8 folder into the new Cloud project folder:
    * `~/Views` - **Do not** overwrite the default Macro and Partial View Macro files unless changes have been made to these.
    * `~/Media`
    * Any files/folders related to Stylesheets and JavaScript.
2. Migrate custom configuration from the Umbraco 8 configuration files (`.config`) into the `appsettings.json` file on the new Cloud project.
    * As of Umbraco version 9, the configuration no longer lives in the `Web.Config` file and has been replaced by the `appsettings.json` file.
3. [Migrate Umbraco Forms data to the database](../../deployment/umbraco-forms-on-cloud.md), if relevant.
    * As of Umbraco Forms version 9, it is only possible to store Forms data in the database. If Umbraco Forms was used on the Umbraco 8 project, the files need to be migrated to the database.
4. Run the new Cloud project locally.
    * It **will** give you a Yellow Screen of Death (YSOD)/error screen on the frontend as none of the Template files have been updated yet.
5. Go to the backoffice of the project.
6. Navigate to the **Settings** section and open the **Deploy** dashboard.
7. Click on `Export Schema` in the **Deploy Operations** section in order to generate the UDA files.
    * Once the operation is completed, the status will change to `Last deployment operation completed`.
8. Check `~\umbraco\Deploy\Revision` folder to ensure all the UDA files have been generated.
9. Return to the **Deploy** dashboard.
10. Click on `Update Umbraco Schema` in the **Deploy Operations** section to make sure everything checks out with the UDA files that were generated.

## Step 3: Custom Code in the latest version

The latest version of Umbraco is different from Umbraco 8 in many ways. With all the files and data migrated, it is now time to rewrite and re-implement all custom code and templates.

### Examples of changes

One of the changes is how published content is rendered through Template files. Due to this, it will be necessary to update **all** the Template files (`.cshtml`) to reflect these changes.

Read more about these changes in the [IPublishedContent](https://docs.umbraco.com/umbraco-cms/reference/querying/ipublishedcontent) section of the Umbraco CMS documentation.

* Template files need to inherit from `Umbraco.Cms.Web.Common.Views.UmbracoViewPage<ContentModels.HomePage>` instead of `Umbraco.Web.Mvc.UmbracoViewPage<ContentModels.HomePage>`
* Template files need to use `ContentModels = Umbraco.Cms.Web.Common.PublishedModels` instead of `ContentModels = Umbraco.Web.PublishedModels`

Depending on the extent of the project and the amount of custom code and implementations, this step is going to require a lot of work.

## Step 4: Deploy and Test on Umbraco Cloud

Once the new Cloud project runs without errors on the local setup, the next step is to deploy and test on the Cloud **Development** environment.

1. Push the migration and changes to the Umbraco Cloud **Development** environment.

{% hint style="info" %}
The deployment might take a bit longer than normal as a lot of changes have been made.
{% endhint %}

2. Go to the backoffice of the **Development** environment once everything has been pushed.
3. Go to **Settings** and open the **Deploy** Dashboard.
4. Click on `Export Schema` in the **Deploy Operations** section.
    * The deployment will result in either of the two:
      * `Last deployment operation failed` - something failed during the check.
        * Select `Clear Signatures` from the **Deploy Operations** section.
        * Select `Update Umbraco Schema` from the **Deploy Operations** section to clear up the error.
      * `Last deployment operation completed`
        * Everything checks out: The Development environment has been upgraded.
5. Transfer Content and Media from the local clone to the **Development** environment.
    * To transfer members make sure that the following Deploy settings are configured in the `appsettings.json`: [`AllowMembersDeploymentOperations` and `TransferMemberGroupsAsContent`](https://docs.umbraco.com/umbraco-deploy/deploy-settings).
6. Test **everything** in the **Development** environment.
7. Deploy to the **Live** environment.

## Step 5: Going live

1. Test **everything** in the **Development** environment until it runs without any errors.
2. Setup rewrites on the Umbraco 10 site.
3. Assign hostnames to the project.

{% hint style="info" %}
Hostnames are unique and can only be added to one Cloud project at a time.
{% endhint %}

## Related Information

* [Issue tracker for known issues with Content Migration](https://github.com/umbraco/UmbracoDocs/issues)
* [Forms on Umbraco Cloud](../../deployment/umbraco-forms-on-cloud.md)
* [Working locally with Umbraco Cloud](../../set-up/working-locally.md)
