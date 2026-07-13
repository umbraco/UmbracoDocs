---
description: >-
  Learn how to upgrade your Umbraco 8 project to Umbraco 10.
---

# Upgrade from Umbraco 8 to Umbraco 10

{% hint style="danger" %}
It is currently not possible to upgrade directly from **Umbraco 8 to the latest version**.

The recommended approach for upgrading from version 8 to the latest version is to use this guide to upgrade from _Umbraco 8 to Umbraco 10_. Umbraco 10 contains the [database migrations](https://github.com/umbraco/Umbraco-CMS/blob/release-10.0.0/src/Umbraco.Infrastructure/Migrations/Upgrade/UmbracoPlan.cs#L66-L73) that must be upgraded from Umbraco 8. You can then  use the [Upgrading to Major](../#upgrade-to-a-new-major) steps to upgrade from _Umbraco 10 to the latest version_.
{% endhint %}

Since the underlying framework going from Umbraco 8 to the latest version has changed, there is no direct upgrade path. That said, it is possible to re-use the database from your Umbraco 8 project on your new project in order to maintain the content.

It is not possible to migrate the custom code as the underlying web framework has been updated from ASP.NET to ASP.NET Core. All templates and custom code will need to be reimplemented.

You also need to make sure that the packages you are using are available on the latest version.

## Prerequisites

* A Umbraco 8 project running **the latest version of Umbraco 8**.
* A backup of your Umbraco 8 project database.
* A clean installation of the latest version of Umbraco.

{% hint style="info" %}
If you use Umbraco Forms, then on the clean installation of Umbraco, you will need to install `Umbraco.Forms` package as well.
{% endhint %}

## Video Tutorial

{% hint style="warning" %}
The video below shows how to complete the upgrade on an Umbraco Cloud project. Most of the process is the same, however, the video does contain some Cloud-specific elements.
{% endhint %}

{% embed url="https://www.youtube-nocookie.com/embed/wD9SGeRQR7o" %}
A video tutorial guiding you through the steps of upgrading from version 8 to the latest version on Umbraco Cloud.
{% endembed %}

## Step 1: Content Migration

{% hint style="warning" %}
If you use Umbraco Forms, make sure to have [`StoreUmbracoFormsInDbset`](https://docs.umbraco.com/umbraco-forms/developer/forms-in-the-database#enable-storing-forms-definitions-in-the-database)to `True` before **step 1**.
{% endhint %}

1. Create a backup of the database from your Umbraco 8 project (after you have upgraded to the latest version of v8). For this, you can use the [database backup guide](https://docs.umbraco.com/umbraco-cloud/databases/backups#backup-with-sql-server-management-studio).
2. Import the database backup into SQL Server Management Studio.
3. Update the connection string in the new projects `appsettings.json` file so that it connects to the Umbraco 8 database:

```json
"ConnectionStrings": {
    "umbracoDbDSN": "Server=YourLocalSQLServerHere;Database=NameOfYourDatabaseHere;User Id=NameOfYourUserHere;Password=YourPasswordHere;TrustServerCertificate=True"
}
```

{% hint style="info" %}
You can also add the connection details if you spin up a clean installation.
{% endhint %}

4. Run the new project and login to authorize the upgrade.
5. Select "Upgrade" when the upgrade wizard appears.
6. Once the upgrade has been completed, it's recommended to login to the backoffice to verify if your project is upgraded to new version.

{% hint style="success" %}
This is **only content migration** and the database will be migrated.

You need to manually update the view files and custom code implementation. For more information, see Step 3 of this guide.
{% endhint %}

## Step 2: File Migration

1. The following files/folders need to be copied from the Umbraco 8 project into the new project:
   * `~/Views` - **Do not** overwrite the default Macro and Partial View Macro files unless changes have been made to these.
   * `~/Media` - Media folder from v8 needs to be copied over into the `wwwroot - media` folder&#x20;
   * Any files/folders related to Stylesheets and JavaScript.
2. Migrate custom configuration from the Umbraco 8 configuration files (`.config`) into the `appsettings.json` file on the new project.
   * As of Umbraco version 9, the configuration no longer lives in the `Web.Config` file and has been replaced by the `appsettings.json` file. Learn more about this in the [Configuration](../../../../reference/configuration/) article.
3. [Migrate Umbraco Forms data to the database](https://docs.umbraco.com/umbraco-forms/developer/forms-in-the-database#migrating-forms-in-files-into-a-site), if relevant.
   * As of Umbraco Forms version 9, it is only possible to store Forms data in the database. If Umbraco Forms was used on the Umbraco 8 project, the files need to be migrated to the database.
4. Run the new project.
   * It **will** give you an error screen on the frontend as none of the Template files have been updated. Follow **Step 3** to resolve the errors.

## Step 3: Custom Code in the latest version

The latest version of Umbraco is different from Umbraco 8 in many ways. With all the files and data migrated it is now time to rewrite and re-implement all custom code and templates.

### Examples of changes

One of the changes is how published content is rendered through Template files. Due to this, it will be necessary to update **all** the Template files (`.cshtml`) to reflect these changes.

Read more about these changes in the [IPublishedContent](../../../../reference/querying/ipublishedcontent/) section of the Umbraco CMS documentation.

* Template files need to inherit from `Umbraco.Cms.Web.Common.Views.UmbracoViewPage<ContentModels.HomePage>` instead of `Umbraco.Web.Mvc.UmbracoViewPage<ContentModels.HomePage>`
* Template files need to use `ContentModels = Umbraco.Cms.Web.Common.PublishedModels` instead of `ContentModels = Umbraco.Web.PublishedModels`

{% hint style="info" %}
For more information on the correct namespaces or custom code, you can find the references in the [API Documentation](../../../../reference/api-documentation.md) article.
{% endhint %}

Depending on the extent of the project and the amount of custom code and implementations, this step is going to require a lot of work.

Once the new project runs without errors on a local setup it is time to deploy the website to production.

This concludes this tutorial. Find related information and further reading in the section below.

## Related Information

* [Issue tracker for known issues with Content Migration](https://github.com/umbraco/UmbracoDocs/issues)
* [Configuration in modern Umbraco](../../../../reference/configuration/)
* [Configuration in legacy Umbraco](https://our.umbraco.com/documentation/Reference/Configuration-for-Umbraco-7-and-8/)
