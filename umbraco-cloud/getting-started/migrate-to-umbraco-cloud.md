---
description: A guide to help you migrate your Umbraco CMS site to Umbraco Cloud.
---

# Migrate to Umbraco Cloud

One way to start your Umbraco Cloud journey is to migrate an existing Umbraco CMS project to the platform. There are some requirements that this project needs to meet as well as some specific steps to follow.

In this article, you can find all the information you need to migrate your existing Umbraco CMS project to Umbraco Cloud.

## Requirements

To properly migrate your Umbraco CMS project to Umbraco Cloud it is important to ensure that your project meets the requirements.

Each requirement outlined below is presented with recommended suggestions when a project does not meet the requirements.

<details>

<summary>Use a supported version of Umbraco CMS</summary>

The project needs to run one of the currently supported versions of Umbraco CMS.

One of the first steps in this migration guide is to create a new project on Umbraco Cloud. You can only create Umbraco Cloud projects that use supported versions of Umbraco CMS, which requires you to upgrade your project accordingly.

**Recommendation**

* Upgrade the project to **the latest Long-Term Supported (LTS) version of Umbraco CMS**.
  * Find more details on upgrading in the [Umbraco CMS documentation](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/upgrading).

If you prioritize new features over long-term support, you can upgrade to the latest support Short-Term Supported (STS) version instead.

Learn more about the versioning strategy including which versions are currently supported in the [Long-Term Support and End-Of-Life article](https://umbraco.com/products/knowledge-center/long-term-support-and-end-of-life/).

</details>

<details>

<summary>Ensure all packages and add-ons are compatible</summary>

In case the project uses packages or add-ons, these will need to be compatible with both Umbraco Cloud and the Umbraco CMS version used.

Most packages and add-ons are compatible with Umbraco Cloud. It is recommended, however, to verify the compatibility for each package and add-on used, before continuing the migration. This is especially true for packages and add-ons that store data in the Umbraco project.

**Recommendations**

* Use the [Umbraco Marketplace](https://marketplace.umbraco.com/) to verify compatibility for each package/add-on used on your Umbraco CMS project.
  * **Verify version compatibility** for all packages and add-ons used.
  * **Verify Umbraco Cloud compatibility** for all packages and add-ons used.
    * Contact the package/add-on owner if in doubt.
    * All Umbraco HQ packages and add-ons are compatible with Umbraco Cloud.
* **Remove any packages and add-ons not compatible** with Umbraco Cloud or the Umbraco CMS version.

Optionally, look for alternative packages to replace any incompatible packages used on the project.

</details>

<details>

<summary>Avoid legacy code</summary>

Due to incompatible legacy code in old Umbraco CMS versions, we **strongly recommend** avoiding migrating projects upgraded from versions older than version 7.

Was the project created using Umbraco 6 or older versions, both the source code and the database can contain legacy code. This code is incompatible with modern versions of Umbraco CMS and Umbraco Cloud and cannot be migrated.

**Recommendation**

* Build a new project using a supported Umbraco CMS version, instead of migrating.
* Reach out to our support team to discuss recommendations moving forward from here.

</details>

## Prepare your project

Before initiating the migration, the project should be cleared of unnecessary files and data. This includes emptying recycle bins in the Umbraco backoffice and deleting temporary files in the project repository.

{% hint style="info" %}
Follow the cleanup steps on the local environment/clone of the Umbraco CMS project.
{% endhint %}

1. Run the project.
2. Access the Umbraco Backoffice.
3. Empty the **Recycle bin** in the Content section.
4. Empty the **Recycle bin** in the Media section.
5. Stop the project.
6. Delete the following folders from the project directory:
   * `umbraco/Data/TEMP`
   * `umbraco/Logs`

## Create a database backup file

The data from the Umbraco CMS project will be migrated to Umbraco Cloud by uploading a database `.bacpac` file. The next steps will guide you through creating a `.bacpac` file from the project database.

{% hint style="warning" %}
Creating a `bacpac` file requires that the project use an SQL Server database. If the project is using an SQLite database a couple of different options are available:

* Find an external tool to convert the SQLite database to SQL Server.
* Migrate your content and data to Umbraco Cloud using [Umbraco Deploy](https://docs.umbraco.com/umbraco-deploy/deployment-workflow/import-export).
{% endhint %}

1. Use [_Microsoft SQL Server Management Studio_](https://learn.microsoft.com/en-us/sql/relational-databases/data-tier-applications/export-a-data-tier-application?view=sql-server-ver16) or a similar tool to export a `.bacpac` file of your project database.
2. Save the `.bacpac` file on your machine.

## Create a new project on Umbraco Cloud

When migrating a project to Umbraco Cloud it is important to do so with a **clean project**. Using a clean project ensures that no unknown factors can come into play during the migration.

You can create a new Umbraco Cloud project in one of the two ways:

* Create an [Umbraco Cloud Trial project](https://try.umbraco.com/cloud).
  * The project will be free for 14 days, whereafter a subscription is required.
* Create a new Umbraco Cloud project from the Umbraco Cloud Portal.
  * Follow the setup instructions detailed below.

<figure><img src="../.gitbook/assets/image (5).png" alt=""><figcaption><p>Use the "Create project" option in the Umbraco Cloud Portal to create a new Umbraco Cloud project.</p></figcaption></figure>

### Create a new project

1. Click **Create project** in the Umbraco Cloud Portal.
2. Choose **Umbraco Cloud** as the Type.
3. Choose a **plan** that enables you to add an extra mainline environment.
4. Select the **version** that matches the project you want to migrate.
5. Give the project a **name**.
6. Choose from which **Region** the site should be hosted.
7. Select a project **owner**.
8. Ensure a **Technical contact** is added.
9. Click **Continue**.
10. Verify all the information is correct.
11. Check the "Terms and conditions" box.
12. Click **Create Project**.

Once the project is set up:

1. Select **Configure environments**.
2. Add an new **mainline environment**.
    * Throughout this guide we will refer to this environment as the **Development environment**

Having more than one environment on your project, will enable you to start over with the migration process should it be needed.

{% hint style="info" %}
Many processes happen in the background when a new Cloud environment is set up. It might take some time before the environments are ready to use.
{% endhint %}

With the Cloud project set up and ready, the migration can start in the next step.

## Upload the database to Umbraco Cloud

The database is uploaded to the Umbraco Cloud project via the Umbraco Cloud Portal.

Follow the **Upload Database** and **Restore Database** sections in the [Database Backups](../databases/backups.md) article to complete this step in the migration.

{% hint style="warning" %}
You will not be able to view the front end of the website yet, as the project files have yet to be migrated.
{% endhint %}

The Umbraco Cloud project is now ready for the next step where the two projects will be merged.

## Merge the projects

To continue the migration the next step is to clone down the Umbraco Cloud environment to merge it with the Umbraco CMS project.

Follow the steps outlined in the [Working with a Local Clone](../set-up/working-locally.md#cloning-an-umbraco-cloud-project) article to clone down the Development environment on the project.

{% hint style="info" %}
Do not run the project after cloning it down.
{% endhint %}

In the following steps, the Umbraco CMS project will be merged into the Umbraco Cloud project.

1. Move the following files from the Umbraco CMS project into the cloned Cloud project:
   * View files in `~/Views` (`.cshtml`)
   * Controllers and Models
   * CSS files and scripts in `~/wwwroot`
2. Merge the relevant configuration files.
   * Use a tool like [_DiffMerge_](https://sourcegear.com/diffmerge/downloads.html) to identify which configurations to merge.
   * Do not merge the following configuration keys in `appSettings.json`:
     * `Umbraco:CMS:Global:`**`Id`**
     * `Umbraco:CMS:Global:`**`UseHttps`**
     * `Umbraco:CMS:Global:`**`NoNodesViewPath`**
     * `ConnectionStrings:`**`umbracoDbDSN`**
     * `ConnectionStrings:`**`umbracoDbDSN_ProviderName`**
3. Merge custom code in the `Program.cs` file.
4. Open the `appSettings.json` file.
5. Connect the Cloud clone to the Umbraco CMS project database by adding a new connection string:

```json
"ConnectionStrings": {
    "umbracoDbDSN": "Server=myServerAddress;Database=myDataBase;User Id=myUsername;Password=myPassword;TrustServerCertificate=true;",
    "umbracoDbDSN_ProviderName": "System.Data.SqlClient"
  }
```

6. Run the project locally.

All data, content, and configuration have been merged into the cloned Cloud environment.

{% hint style="warning" %}
There will be **no images or media files** in the project. These will be migrated later in the process.
{% endhint %}

The next step in the migration is to generate data files needed to synchronize with the Cloud project.

## Generate data files

1. Access the backoffice of the local Cloud clone using **Umbraco ID**.

<figure><img src="../.gitbook/assets/image (6).png" alt=""><figcaption><p>Use the Umbraco ID signin option when accessing the backoffice on a clone Cloud environment.</p></figcaption></figure>

2. Navigate to the **Deploy** dashboard in the **Settings** section.
3. Locate the **Export Schema to Data Files** in the Deploy Operation section.
4. Click **Export Schema** to initiate the export.

<figure><img src="../.gitbook/assets/image (78).png" alt=""><figcaption><p>Use the "Export schema" option to generate Data Files based on schema in the database.</p></figcaption></figure>

5. Use the **Deploy Status** section at the top to determine when the export is complete.

<figure><img src="../.gitbook/assets/image (79).png" alt=""><figcaption><p>The Deploy Status section showing a status of "Last deployment operation completed".</p></figcaption></figure>

6. Stop the project.
7. Add and commit the changes through Git.
   * Learn more about working with a local Cloud clone in the [Deploying Changes](../deployment/local-to-cloud.md) article.
8. Push the migration to the Cloud environment.

All content, data, and configuration, except for the media files, have been migrated to the Cloud project.

The next step will be to add the media files to the Cloud project using Azure Blob Storage.

## Migrate media files

All media on Umbraco Cloud projects are stored in a dedicated Azure Blob Storage container.

{% hint style="info" %}
**Do you use Azure Blob Storage to store the media files that need to be migrated?**

We recommend following the [Copy blobs between Azure accounts](https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-blobs-copy) guide in the official Microsoft Documentation.
{% endhint %}

Follow the guide in the [Connect to Azure Storage Explorer](../set-up/azure-blob-storage/connect-to-azure-storage-explorer.md) article to access the Azure Blob Storage container connected to the Development environment.

1. Locate the media files for your Umbraco CMS project.
2. Copy the `~/wwwroot/media` folder into the Azure Storage Explorer.

<figure><img src="../.gitbook/assets/image (80).png" alt=""><figcaption><p>Media folder added to the "media" folder using Azure Storage Explorer.</p></figcaption></figure>

3. Reload the front end and backoffice of the Umbraco Cloud project to verify that the images have been added correctly.

The Umbraco CMS project has now been migrated to an Umbraco Cloud project.

## Verify the migration

Verifying the migration by cloning the Development environment to your local machine is recommended.

This needs to be **a new clone**. The clone used throughout the migration steps can be deleted.

Follow the steps outlined in the [Working with a Local Clone](../set-up/working-locally.md#cloning-an-umbraco-cloud-project) article to clone down, restore, and run the **Development environment** locally.

{% hint style="info" %}
You might need to do a **Workspace restore** from the **Media** section in the Umbraco backoffice to restore the media files.
{% endhint %}

## Next steps

The Umbraco CMS project has now been migrated onto Umbraco Cloud.

### [Deploy the migration to the Live environment](../deployment/cloud-to-cloud.md)

Following this guide, the Umbraco CMS project has been migrated to the Umbraco Cloud Development environment. For the migration to be complete, it should be deployed to the Umbraco Cloud Live environment.

### [Publish the website](../set-up/project-settings/manage-hostnames/)

To publish the website to the web, attach a hostname to the Live environment.
