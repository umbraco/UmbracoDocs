---
description: >-
  This article provides steps on how to migrate a project from Umbraco
  8 to Umbraco 10.
---

# Migrate from Umbraco 8 to Umbraco 10

{% hint style="warning" %}
It is currently not possible to upgrade directly from Umbraco 8 to the latest version. Umbraco Cloud also only allows new projects to be created on versions within their active [support phase](https://umbraco.com/products/knowledge-center/long-term-support-and-end-of-life/).

This guide covers upgrading from Umbraco 8 to Umbraco 10 locally, since Umbraco 10 contains the [database migrations](https://github.com/umbraco/Umbraco-CMS/blob/release-10.0.0/src/Umbraco.Infrastructure/Migrations/Upgrade/UmbracoPlan.cs#L66-L73) that must be upgraded from Umbraco 8. From there, continue upgrading locally using the [Major Upgrades](../major-upgrades.md) guide until the project reaches a version Umbraco Cloud can currently create a project on.
{% endhint %}

Since the underlying framework going from Umbraco 8 to Umbraco 10 has changed, there is no direct upgrade path. That said, it is possible to re-use the database from your Umbraco 8 project on your new project in order to maintain the content.

It is not possible to migrate the custom code as the underlying web framework has been updated from ASP.NET to ASP.NET Core. All templates and custom code will need to be reimplemented.

You also need to make sure that the packages that you are using are available on the latest version.

{% hint style="info" %}
This guide works whether your Umbraco 8 project is on Umbraco Cloud or local. Steps that differ depending on where your Umbraco 8 project lives are marked below.
{% endhint %}

## Prerequisites

* A Umbraco 8 project running the latest version of Umbraco 8, either on Umbraco Cloud or local.
* A local [Umbraco 10](https://www.nuget.org/packages/Umbraco.Templates/) project.
* A backup of your Umbraco 8 project database, or direct access to it if the project is local.

{% hint style="info" %}
If your Umbraco 8 site is using Umbraco Forms, ensure you configure it to save data in the database, before starting this tutorial. For more information on migrating Umbraco Forms data to the database, see the[Umbraco Forms in the Database](https://docs.umbraco.com/umbraco-forms/developer/forms-in-the-database) article.
{% endhint %}

## Video Tutorial

{% embed url="https://www.youtube-nocookie.com/embed/wD9SGeRQR7o" %}
A video tutorial guiding you through the steps of upgrading from version 8 to version 10 on Umbraco Cloud.
{% endembed %}

{% hint style="info" %}
The video tutorial was recorded when a Cloud project could be created directly on Umbraco 10 and used as the migration target.
{% endhint %}

## Step 1: Content Migration

{% hint style="warning" %}
If you use Umbraco Forms, make sure to have [`StoreUmbracoFormsInDbset`](https://docs.umbraco.com/umbraco-forms/developer/forms-in-the-database#enable-storing-forms-definitions-in-the-database)to `True` before **step 1**.
{% endhint %}

1. Obtain the Umbraco 8 database:
   * If your Umbraco 8 project is on Umbraco Cloud, create a backup using the [database backup guide](../../../../build-and-customize-your-solution/set-up-your-project/databases/backups.md). Alternatively, you can clone the environment down and take a backup of the local Database after restoring. Make sure to restore both content and media from your Cloud environment after cloning it down.
   * If your Umbraco 8 project is local, you already have direct access to its database. Skip ahead to point 3 below (setting up the local Umbraco 10 project).
2. Import the database backup into SQL Server Management Studio.
3. Set up a new local Umbraco 10 project using the [Umbraco.Templates](https://www.nuget.org/packages/Umbraco.Templates/) NuGet package:
4. Test the project and make sure to log in to the backoffice.
5. Update the connection string in the Umbraco 10 projects `appsettings.json` file so that it connects to the Umbraco 8 database:

```json
"ConnectionStrings": {
    "umbracoDbDSN": "Server=YourLocalSQLServerHere;Database=NameOfYourDatabaseHere;User Id=NameOfYourUserHere;Password=YourPasswordHere;TrustServerCertificate=True",
}
```

{% hint style="info" %}
You can add the 'umbracoDbDSN_ProviderName' attribute to set the .NET Framework data provider name for the DataSource control's connection. For more information on the data providers included in the .Net Framework, see the [Microsoft Documentation](https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.sqldatasource.providername?#remarks).
{% endhint %}

6. Enable [Unattended Upgrades](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/upgrading#enable-the-unattended-upgrade-feature) to authorize the database upgrade.
7. Run the project and login to authorize the upgrade.
8. Select "Continue" when the upgrade wizard appears.
9. After it has finished upgrading, stop the site and disable the unattended upgrade.
10. Run the site and log in using Umbraco ID to verify if your project has been upgraded to the new version.

{% hint style="success" %}
This is **only content migration** and the database will be migrated.

You need to manually upgrade the view files and custom code implementation. For more information, see [Step 3](#step-3-custom-code-in-umbraco-10) of this guide.
{% endhint %}

## Step 2: File Migration

1. The following files/folders need to be copied from the Umbraco 8 project into the Umbraco 10 project folder:
   * `~/Views` - **Do not** overwrite the default Macro and Partial View Macro files unless changes have been made to these.
   * Any files/folders related to Stylesheets and JavaScript.
2. Copy the `~/Media` folder from the Umbraco 8 project into the `wwwroot/media` folder of the Umbraco 10 project:
   * If your Umbraco 8 project is on Umbraco Cloud, connect to [Azure Storage Explorer](../../../../build-and-customize-your-solution/handle-deployments-and-environments/media/azure-blob-storage/connect-to-azure-storage-explorer.md) from the Umbraco 8 project and download the media folder.
   * If your Umbraco 8 project is local, copy its local `~/Media` folder directly.
3. Migrate custom configuration from the Umbraco 8 configuration files (`.config`) into the `appsettings.json` file on the Umbraco 10 project.
   * As of Umbraco version 9, the configuration no longer lives in the `Web.Config` file and has been replaced by the `appsettings.json` file.
4. [Migrate Umbraco Forms data to the database](https://docs.umbraco.com/umbraco-forms/developer/forms-in-the-database), if relevant.
   * As of Umbraco Forms version 9, it is only possible to store Forms data in the database. If Umbraco Forms was used on the Umbraco 8 project, the files need to be migrated to the database.
5. Run the Umbraco 10 project.
   * It **will** give you an error screen on the frontend as none of the Template files have been updated. Follow **Step 3** to resolve the errors.

## Step 3: Custom Code in Umbraco 10

Umbraco 10 is different from Umbraco 8 in many ways. With all the files and data migrated, it is now time to rewrite and re-implement all custom code and templates.

### Examples of changes

One of the changes is how published content is rendered through Template files. Due to this, it will be necessary to update **all** the Template files (`.cshtml`) to reflect these changes.

Read more about these changes in the [IPublishedContent](https://docs.umbraco.com/umbraco-cms/reference/querying/ipublishedcontent) section of the Umbraco CMS documentation.

* Template files need to inherit from `Umbraco.Cms.Web.Common.Views.UmbracoViewPage<ContentModels.HomePage>` instead of `Umbraco.Web.Mvc.UmbracoViewPage<ContentModels.HomePage>`
* Template files need to use `ContentModels = Umbraco.Cms.Web.Common.PublishedModels` instead of `ContentModels = Umbraco.Web.PublishedModels`

{% hint style="info" %}
For more information on the correct namespaces or custom code, you can find the references in the [API Documentation](https://docs.umbraco.com/umbraco-cms/reference/api-documentation).
{% endhint %}

Depending on the extent of the project and the amount of custom code and implementations, this step is going to require a lot of work.

## Continuing after the migration

At this point, the project runs on Umbraco 10 locally. Umbraco 10 is no longer a supported version, and Umbraco Cloud only allows new projects to be created on versions within their active support phase.

Continue upgrading the project locally, one major version at a time. Follow the [Major Upgrades](../major-upgrades.md) guide, until it reaches a version Umbraco Cloud can currently create a project on. See the [Long-Term Support and End-of-Life page](https://umbraco.com/products/knowledge-center/long-term-support-and-end-of-life/) for which versions are currently available.

## Related Information

* [Major Upgrades](../major-upgrades.md)
* [Issue tracker for known issues with Content Migration](https://github.com/umbraco/UmbracoDocs/issues)
* [Forms on Umbraco Cloud](../../../../expand-your-projects-capabilities/cloud-extensions/umbraco-forms-on-cloud.md)
* [Working locally with Umbraco Cloud](../../../../build-and-customize-your-solution/handle-deployments-and-environments/working-locally/)
