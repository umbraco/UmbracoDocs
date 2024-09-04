---
description: >-
  In this article you learn how to move a project from one region to another on
  Umbraco Cloud.
---

# Migrate between regions

When creating a project on Umbraco Cloud, you can choose to host the project in different regions: East US, EU West, South UK, or East Australia.

In some cases, you might want to migrate your project(s) from one region to another. This article will outline the steps to do this.

The East US and West EU regions will be used as examples in this article.

## Prerequisites

* Admin access and deployment rights on the project that is to be migrated.
* A clone of both East US and West EU projects.
* A local setup that can run an Umbraco instance. Learn more about this in the [Requirements](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/requirements) article.

{% hint style="info" %}
To follow this guide, it is highly recommended that you have experience with Git and running git commands through a command line tool.
{% endhint %}

## Prepare your projects

The first step in this process is to create a new Umbraco Cloud project in the region you want to migrate your existing project to. In this case that will be the East US region.

This is done by selecting **East US** from the **Region** dropdown when creating the Cloud project.

![Select the East US region](images/creationflow-chooseRegion.png)

The new project in the US region will run the latest version of Umbraco CMS, Umbraco Forms, and Umbraco Deploy. You will need to ensure that the project you are migrating is running the exact same version of each product before initiating the migration process.

Find more details on how to upgrade your project in the [Upgrades](../product-upgrades/) documentation.

## Migrate the project

The following steps will guide you through the migration process.

{% hint style="warning" %}
Make sure that your projects are [prepared for migration](migrate-between-regions.md#prepare-your-projects) before continuing the process.
{% endhint %}

{% tabs %}

### Step 1: Creating and restore database backup

{% tab title="Umbraco 10+" %}
1. Go to **Configuration** > **Backups** on the **EU West** Cloud project.
2. Create a **backup** of the projects database.
3. Download the backup to your local machine.
4. Go to the **US East** project.
5. Go to **Configuration** > **Backups**.
6. Upload the **database backup** that you created in the previous step to the project.
7. Restore the **backup** to your environment
   -  **Optional** Create a backup of the environment before restoring the backup.
8. Run a **Export Schema** and then **Update Umbraco Schema** from the **Deploy Dashboard** in the settings section of the **US East** project.

Once you have restored the database to your environment, go to the backoffice of the project you are migrating to. In the backoffice, you should now see your content in the content section, and Document Types and Data Types in the settings section.


Taking a closer look at the templates, stylesheets, scripts media, you will notice that it is not there. In the next step we will migrate those over to our new project


### step 2: Migrate files

In this step, we will migrate our files and media items from our project on the EU region. 

1. Clone down both project to your local machine.
2. Run the local US East project and restore the content.
3. Open project folders from both **EU West** and **US East**.
4. Move the view files located in the view folder from **EU West** to the view folder in the **US East** project.
   - When promted replace the existing files. 
5. Move the CSS and Script files located in the wwwroot folder from the **EU West** folder to the wwwroot folder in the **US East** project.
6. **Optional:** Move files from App_Plugins if you have extended the Umbraco Backoffice
7. Run the **US East** project locally.

Once you have started the project up, the project should show your content as it was on the **EU West** project. The only thing missing will be the media items, as they have not been migrated over yet.

### Step 3: Migrate Media Items

In the following step we will migrate our media items from our **EU West** project to our **US East** project.

1. Run the **EU West** on your local machine
2. Go to the media section on the **EU West** project.
3. Click on the 3 dots in the top of the media section.
4. Click **Export** in the side-menu.
5. Click the button to export the media items located in the media section.
6. Click **Download** to download the zip file with the media items to your local machine.
7. Run the **East US** project on your local machine.
8. Navigate to the media section.
9. Click the 3 dots in the top of the media section.
10. Click **Import** in the side menu.
11. Click **Select ZIP file**.
12. Select the ZIP file, that you downloaded from the **East US** project.
13. Click **Import**.
  
Once the import has finished refresh your media section, and when clicking on an image, you should be able to see it. Navigate to the front end of your **East US** project and the images will be shown on the front end as well now.


{% endtab %}

{% tab title="Umbraco 8" %}
1. Clone down the project that you want to migrate - the _EU project_.
2. Restore content and media through the Umbraco backoffice.
3. Clone down the new Cloud project created in the US region - the _US project_.
4. Replace the `Config/UmbracoDeploy.config` file in the _EU project_ with the one from the _US project_.

{% hint style="info" %}
The `UmbracoDeploy.config` file contains details about each environment on the Cloud project.

By replacing the one on the _EU project_ with the one from the _US project_, content, and media transfers will point to the environments on the _US project_ instead of the _EU project_.
{% endhint %}

5. Commit the change through git, but do not push it yet.
6. Use the following git commands to connect your local _EU project_ to the live environment on the _US project_:

```
git remote rm origin

git remote add origin https://scm.umbraco.io/useast01/name-of-us-live-site.git

git fetch

git branch --set-upstream-to=origin/master
```

7. Push the schema and files from the _EU project_ to the _US project_ using the following git command:

```
git push origin master -f
```

8. Verify that the schema and files have been merged into the live environment on the _US project_.
9. Transfer content and media from the local _EU project_ to the _US project_.
10. Verify that all the content and media have been transferred to the _US project_.
{% endtab %}
{% endtabs %}

Once you have verified that all schema and files as well as content and media have successfully been deployed and transferred to your new _US project_ the migration process is complete.

It is highly recommended to thoroughly go through everything on the migrated site to ensure that everything works as expected.

## Post-migration tasks

Following the steps above you have migrated your Umbraco project from one Cloud environment to another.

The following will need to be reconfigured on the new project after the initial migration:

* All **Team Members** added through the Cloud Portal on the _EU project_ also need to be invited to the _migrated project_
* **Hostnames**, **certificates,** and other related settings must be re-added and reconfigured on the _migrated project_.

Once everything has been configured and set up you can safely delete the _EU project_ which will also cancel the running subscription on the project.

If you need help or have any questions regarding this process, please contact our support using [contact@umbraco.com](mailto:contact@umbraco.com).

## Related articles

* [Manage hostnames](../set-up/project-settings/manage-hostnames/)
* [Team Members](../set-up/project-settings/team-members/)
* [Certificates](../set-up/project-settings/manage-hostnames/security-certificates.md)
