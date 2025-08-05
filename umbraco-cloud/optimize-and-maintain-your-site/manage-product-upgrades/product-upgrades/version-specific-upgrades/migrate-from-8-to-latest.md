---
description: >-
  This article will provide steps on how to migrate a Cloud project from Umbraco
  8 to Umbraco 10.
---

# Migrate from Umbraco 8 to the latest version

{% hint style="warning" %}
It is currently not possible to upgrade directly from Umbraco 8 to the latest version.

The recommended approach for upgrading from version 8 to the latest version is to use this guide to upgrade from _Umbraco 8 to Umbraco 10_ . Umbraco 10 contains the [database migrations](https://github.com/umbraco/Umbraco-CMS/blob/release-10.0.0/src/Umbraco.Infrastructure/Migrations/Upgrade/UmbracoPlan.cs#L66-L73) that must be upgraded from Umbraco 8. You can then use the [Major Upgrades](../major-upgrades.md) steps to upgrade from _Umbraco 10 to the latest version_.
{% endhint %}

Since the underlying framework going from Umbraco 8 to the latest version has changed, there is no direct upgrade path. That said, it is possible to re-use the database from your Umbraco 8 project on your new project in order to maintain the content.

It is not possible to migrate the custom code as the underlying web framework has been updated from ASP.NET to ASP.NET Core. All templates and custom code will need to be reimplemented.

You also need to make sure that the packages that you are using are available on the latest version.

## Prerequisites

* A Umbraco 8 Cloud project running **the latest version of Umbraco 8**.
* A clean Cloud project running the latest version of Umbraco with **at least two environments**.
* A backup of your Umbraco 8 project database.

It is recommended to have at least **two environments** on the new Umbraco project.

{% hint style="info" %}
If your Umbraco 8 site is using Umbraco Forms, make sure to configure it to store data in the database, before beginning this tutorial [Follow the guide for migrating Umbraco Forms data to the database.](https://docs.umbraco.com/umbraco-forms/developer/forms-in-the-database)

Should something fail during the migration, the left-most environment can be removed and re-added to start over on a clean slate.
{% endhint %}

## Video Tutorial

{% embed url="https://www.youtube-nocookie.com/embed/wD9SGeRQR7o" %}
A video tutorial guiding you through the steps of upgrading from version 8 to the latest version on Umbraco Cloud
{% endembed %}

## Step 1: Content Migration

{% hint style="warning" %}
If you use Umbraco Forms, make sure to have [`StoreUmbracoFormsInDbset`](https://docs.umbraco.com/umbraco-forms/developer/forms-in-the-database#enable-storing-forms-definitions-in-the-database)to `True` before **step 1**.
{% endhint %}

1. Create a backup of the database from your Umbraco 8 project using the [database backup guide](../../../../build-and-customize-your-solution/set-up-your-project/databases/backups.md).
   * Alternatively, you can clone the environment down and take a backup of the local Database after restoring. Make sure to restore both content and media from your Cloud environment after cloning it down.
2. Import the database backup into SQL Server Management Studio.
3. Clone down the **left-most** mainline environment from the **new** Cloud project.
4. Test the project and make sure to log in to the backoffice.

{% hint style="info" %}
As you are cloning down a brand new Cloud project there is nothing the restore. Select the "**Skip restore and open Umbraco**" link when starting up the project locally to go directly to the backoffice.
{% endhint %}

5. Update the connection string in the new Cloud projects `appsettings.json` file so that it connects to the Umbraco 8 database:

```json
"ConnectionStrings": {
    "umbracoDbDSN": "Server=YourLocalSQLServerHere;Database=NameOfYourDatabaseHere;User Id=NameOfYourUserHere;Password=YourPasswordHere;TrustServerCertificate=True",
}
```

{% hint style="info" %}
You can add the 'umbracoDbDSN\_ProviderName' attribute to set the .NET Framework data provider name for the DataSource control's connection. For more information on the data providers included in the .Net Framework, see the [Microsoft Documentation](https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.sqldatasource.providername?#remarks).
{% endhint %}

6. Enable [Unattended Upgrades](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/upgrading#enable-the-unattended-upgrade-feature) to authorize the database upgrade.
7. Run the new Cloud project locally and login to authorize the upgrade.
8. Select "Continue" when the upgrade wizard appears.
9. After it has finished upgrading, stop the site and disable the unattended upgrade.
10. Run the site and log in using Umbraco ID to verify if your project has been upgraded to the new version.

{% hint style="success" %}
This is **only content migration** and the database will be migrated.

You need to manually upgrade the view files and custom code implementation. For more information, see Step 3 of this guide.
{% endhint %}

## Step 2: File Migration

1. The following files/folders need to be copied from the Umbraco 8 folder into the new Cloud project folder:
   * `~/Views` - **Do not** overwrite the default Macro and Partial View Macro files unless changes have been made to these.
   * Any files/folders related to Stylesheets and JavaScript.
2. `~/Media` folder from v8 needs to be copied over into the `wwwroot - media` folder:
   * Connect to [Azure Storage Explorer](../../../../build-and-customize-your-solution/handle-deployments-and-environments/media/azure-blob-storage/connect-to-azure-storage-explorer.md) from the v8 project
   * Download the media folder from Azure Storage Explorer
   * Add the downloaded media folder from v8 to the Azure Storage Explorer of the new project.
3. Migrate custom configuration from the Umbraco 8 configuration files (`.config`) into the `appsettings.json` file on the new Cloud project.
   * As of Umbraco version 9, the configuration no longer lives in the `Web.Config` file and has been replaced by the `appsettings.json` file.
4. [Migrate Umbraco Forms data to the database](https://docs.umbraco.com/umbraco-forms/developer/forms-in-the-database), if relevant.
   * As of Umbraco Forms version 9, it is only possible to store Forms data in the database. If Umbraco Forms was used on the Umbraco 8 project, the files need to be migrated to the database.
5. Run the new Cloud project locally.
   * It **will** give you an error screen on the frontend as none of the Template files have been updated. Follow **Step 3** to resolve the errors.
6. Go to the backoffice of the project.
7. Navigate to the **Settings** section and open the **Deploy** dashboard.
8. Click on `Export Schema to Data Files` in the **Deploy Operations** section in order to generate the UDA files.
   * Once the operation is completed, the status will change to `Last deployment operation completed`.
9. Check `~\umbraco\Deploy\Revision` folder to ensure all the UDA files have been generated.
10. Return to the **Deploy** dashboard.
11. Click on `Update Umbraco Schema from Data Files` in the **Deploy Operations** section to make sure everything checks out with the UDA files that were generated.

## Step 3: Custom Code in the latest version

The latest version of Umbraco is different from Umbraco 8 in many ways. With all the files and data migrated, it is now time to rewrite and re-implement all custom code and templates.

### Examples of changes

One of the changes is how published content is rendered through Template files. Due to this, it will be necessary to update **all** the Template files (`.cshtml`) to reflect these changes.

Read more about these changes in the [IPublishedContent](https://docs.umbraco.com/umbraco-cms/reference/querying/ipublishedcontent) section of the Umbraco CMS documentation.

* Template files need to inherit from `Umbraco.Cms.Web.Common.Views.UmbracoViewPage<ContentModels.HomePage>` instead of `Umbraco.Web.Mvc.UmbracoViewPage<ContentModels.HomePage>`
* Template files need to use `ContentModels = Umbraco.Cms.Web.Common.PublishedModels` instead of `ContentModels = Umbraco.Web.PublishedModels`

{% hint style="info" %}
For more information on the correct namespaces or custom code, you can find the references in the [API Documentation](https://docs.umbraco.com/umbraco-cms/reference/api-documentation).
{% endhint %}

Depending on the extent of the project and the amount of custom code and implementations, this step is going to require a lot of work.

## Step 4: Deploy and Test on Umbraco Cloud

After the project runs locally without errors, deploy and test it on the Cloud's left-most mainline environment.

1. Push the migration and changes to the Umbraco Cloud **left-most** mainline environment.

{% hint style="info" %}
The deployment might take a bit longer than normal as a lot of changes have been made.
{% endhint %}

2. Go to the backoffice of the **left-most** mainline environment once everything has been pushed.
3. Go to **Settings** and open the **Deploy** Dashboard.
4. Click on `Export Schema to Data Files` in the **Deploy Operations** section.
   * The deployment will result in either of the two:
     * `Last deployment operation failed` - something failed during the check.
       * Select `Clear Signatures` from the **Deploy Operations** section.
       * Select `Update Umbraco Schema` from the **Deploy Operations** section to clear up the error.
     * `Last deployment operation completed`
       * Everything checks out: The left-most environment has been upgraded.
5. Transfer Content and Media from the local clone to the **left-most** mainline environment.
   * To transfer members make sure that the following Deploy settings are configured in the `appsettings.json`: [`AllowMembersDeploymentOperations` and `TransferMemberGroupsAsContent`](https://docs.umbraco.com/umbraco-deploy/deploy-settings#allowmembersdeploymentoperations-and-transfermembergroupsascontent).
6. Test **everything** in the **left-most** mainline environment.
7. Deploy to the **Live** environment.

## Step 5: Going live

1. Test **everything** in the **left-most** mainline environment until it runs without any errors.
2. Setup rewrites on the new Cloud project if relevant.
3. Assign hostnames to the project if relevant.

{% hint style="info" %}
Hostnames are unique and can only be added to one Cloud project at a time.
{% endhint %}

## Related Information

* [Issue tracker for known issues with Content Migration](https://github.com/umbraco/UmbracoDocs/issues)
* [Forms on Umbraco Cloud](../../../../expand-your-projects-capabilities/cloud-extensions/umbraco-forms-on-cloud.md)
* [Working locally with Umbraco Cloud](../../../../build-and-customize-your-solution/handle-deployments-and-environments/working-locally/)
