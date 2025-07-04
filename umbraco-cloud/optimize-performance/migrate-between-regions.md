---
description: >-
  In this article you learn how to move a project from one region to another on
  Umbraco Cloud.
---

# Migrate between regions

Creating a project on Umbraco Cloud, you can choose to host the project in different regions: East US, West EU, South UK, or East Australia.

In some cases, you might want to migrate your project(s) from one region to another. This article will outline the steps to do this.

The East US and West EU regions will be used as examples in this article.

## Prerequisites

* Admin access and deployment rights on the project that is to be migrated.
* A clone of both East US and West EU projects.
* A local setup that can run an Umbraco instance. Learn more about this in the [Requirements](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/requirements) article.

{% hint style="info" %}
If you want to migrate an Umbraco 8 project, you will need to upgrade to the latest supported [Long-Term-Supported (LTS)](https://umbraco.com/products/knowledge-center/long-term-support-and-end-of-life/) version of Umbraco CMS.
{% endhint %}

## Prepare your projects

The first step in this process is to create a new Umbraco Cloud project in the region you want to migrate your existing project to. In this case that will be the East US region.

This is done by selecting **East US** from the **Region** dropdown when creating the Cloud project.

![Select the East US region](../getting-started/images/creationflow-chooseRegion.png)

The new project in the US region will run the latest version of Umbraco CMS, Umbraco Forms, and Umbraco Deploy. You will need to ensure that the project you are migrating is running the exact same version of each product before initiating the migration process.

Find more details on how to upgrade your project in the [Upgrades](../optimize-and-maintain-your-site/manage-product-upgrades/product-upgrades/) documentation.

## Migrate the project

The following steps will guide you through the migration process.

{% hint style="warning" %}
Make sure that your projects are [prepared for migration](migrate-between-regions.md#prepare-your-projects) before continuing the process.
{% endhint %}

### Step 1: Create and Restore Database Backup

1. Go to **Configuration** > **Backups** on the **West EU** Cloud project.
2. Create a **backup** of the projects database.
3. Download the backup to your local machine.
4. Go to the **East US** project.
5. Go to **Configuration** > **Backups**.
6. Upload the **database backup** that you created in the previous step to the project.
7. Restore the **backup** to your environment
   * **Optional:** Create a backup of the environment before restoring the backup.
8. Run **Export Schema** from the **Deploy Dashboard** in the **Settings** section of the **East US** project.
9. Run **Update Umbraco Schema** from the **Deploy Dashboard** in the **Settings** section of the **East US** project.

Once you have restored the database to your environment, go to the backoffice of the project you are migrating to. In the backoffice, you should now see your content in the Content section, Document Types, and Data Types in the Settings section.

Taking a closer look at the templates, stylesheets, scripts and media, you will notice that it is not there. In the next step we will migrate those over to our new project

### Step 2: Migrate Files

In this step, we will migrate our files and media items from our project in the EU region.

1. Clone down both the projects to your local machine.
2. Run the local **East US** project and restore the content.
3. Open both the project folders for **West EU** and **East US**.
4. Move the **view** files located in the view folder from **West EU** to the view folder in the **East US** project.
   * When prompted replace the existing files.
5. Move the **CSS** and **Script** files located in the **wwwroot** folder from the **West EU** folder to the **wwwroot** folder in the **East US** project.
   * **Optional:** Move files from **App\_Plugins** if you have extended the Umbraco Backoffice
6. Move custom code (Models, Controllers and other relevant code) from the **West EU** to the **East US** project
7. Run the **East US** project locally.

Once you have started the project, it should show your content as it was on the **West EU** project. The only thing missing is the media items, as they have not been migrated yet. Before we can migrated our media items, we need to push the migrated files to the Cloud project.

### Step 3: Push the Migrated Project to Cloud

In the following steps, we will push the migrated local **East US** project back up to the project on Cloud.

1. Follow the [Deploying Changes](https://docs.umbraco.com/umbraco-cloud/deployments/local-to-cloud) article to push the Views, CSS and JavaScript files to the Cloud environment.
2. Follow the [Transferring Content, Media, Members, and Forms](https://docs.umbraco.com/umbraco-cloud/deployments/content-transfer#media-items)article to transfer the media items to the cloud project.

Verify that all schemas, files, and content have been successfully deployed to your new _US project_ after the transfer.

### Step 4: Migrate Media Items

In the following steps, we will migrate media items from the **West EU** blob storage container to the **East US** blob storage container using **AzCopy**.

#### Download AzCopy Portable Binary

1. Download AzCopy Portable Binary from the [official Microsoft AzCopy page](https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10#download-azcopy).
2. Extract the binary to a directory on your local machine and ensure you can run it from the command line.

#### Locate the Shared Access Signature (SAS) URLs

1. Access the Umbraco Cloud Portal for the West EU project.
2. Open the **Connections** page found under **Configuration**.
3. Locate the SAS URLs.
4. Ensure the SAS tokens can read from the **West EU** container.
5. Access the Umbraco Cloud Portal for the East US project.
6. Open the **Connections** page.
7. Locate the SAS URLs and ensure the tokens can write to the **East US** container.

#### Copy the Media Files

Use the following AzCopy command to transfer the media files from the **West EU** container to the **East US** container:

`azcopy copy "<West-EU-SAS-URL>" "<East-US-SAS-URL>" --recursive`

* Replace `<West-EU-SAS-URL>` with the SAS URL of the **West EU** blob storage container.
* Replace `<East-US-SAS-URL>` with the SAS URL of the **East US** blob storage container.
* The `--recursive` flag ensures that all files and subfolders are copied.

#### Verify the File Transfer

1. Verify the files in the **East US** container using AzCopy: `azcopy list "<East-US-SAS-URL>"`
2. Check that all expected media files have been successfully transferred.
3. Reload the front end and backoffice of the **East US** project to confirm the images are displayed correctly.

The migration process is complete when the media files have been migrated to the **East US** environment.

{% hint style="info" %}
**Recommendation** It is highly recommended that the migrated site be thoroughly reviewed to ensure all media items function as expected.
{% endhint %}

\## Post-migration tasks

Following the steps above you have migrated your Umbraco project from one Cloud environment to another.

The following will need to be reconfigured on the new project after the initial migration:

* All **Team Members** added through the Cloud Portal on the _EU project_ also need to be invited to the _migrated project_
* **Hostnames**, **certificates,** and other related settings must be re-added and reconfigured on the _migrated project_.

Once everything has been configured and set up you can safely delete the _EU project_ which will also cancel the running subscription on the project.

If you need help or have any questions regarding this process, please contact our support using [contact@umbraco.com](mailto:contact@umbraco.com).

## Related articles

* [Manage hostnames](../go-live/manage-hostnames/)
* [Team Members](../project-overview/team-members/)
* [Certificates](../go-live/manage-hostnames/security-certificates.md)
